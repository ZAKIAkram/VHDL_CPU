library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PKG.all;


entity CPU_PC is
    generic(
        mutant: integer := 0
    );
    Port (
        -- Clock/Reset
        clk    : in  std_logic ;
        rst    : in  std_logic ;

        -- Interface PC to PO
        cmd    : out PO_cmd ;
        status : in  PO_status
    );
end entity;

architecture RTL of CPU_PC is
    type State_type is (
        S_Error,
        S_Init,
        S_Pre_Fetch,
        S_Fetch,
        S_Decode,
        S_ADDI,
        S_LUI,
        S_ADD,
        S_OR,
        S_ORI,
        S_SUB, 
        S_AUIPC,
        S_AND,
        S_ANDI,
        S_XOR,
        S_XORI,
        S_SLL,
        S_SLLI,
        S_SRA,
        S_SRAI,
        S_SRL,
        S_SRLI,
        S_BEQ,
        S_BNE,
        S_BGE,
        S_BGEU,
        S_BLT,
        S_BLTU,
        S_SLT,
        S_SLTI,
        S_SLTU,
        S_SLTIU
            );

    signal state_d, state_q : State_type;


begin

    FSM_synchrone : process(clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                state_q <= S_Init;
            else
                state_q <= state_d;
            end if;
        end if;
    end process FSM_synchrone;

    FSM_comb : process (state_q, status)
    begin

        -- Valeurs par défaut de cmd à définir selon les préférences de chacun
        cmd.ALU_op            <= UNDEFINED;
        cmd.LOGICAL_op        <= UNDEFINED;
        cmd.ALU_Y_sel         <= UNDEFINED;

        cmd.SHIFTER_op        <= UNDEFINED;
        cmd.SHIFTER_Y_sel     <= UNDEFINED;

        cmd.RF_we             <= 'U';
        cmd.RF_SIZE_sel       <= UNDEFINED;
        cmd.RF_SIGN_enable    <= 'U';
        cmd.DATA_sel          <= UNDEFINED;

        cmd.PC_we             <= 'U';
        cmd.PC_sel            <= UNDEFINED;

        cmd.PC_X_sel          <= UNDEFINED;
        cmd.PC_Y_sel          <= UNDEFINED;

        cmd.TO_PC_Y_sel       <= UNDEFINED;

        cmd.AD_we             <= 'U';
        cmd.AD_Y_sel          <= UNDEFINED;

        cmd.IR_we             <= 'U';

        cmd.ADDR_sel          <= UNDEFINED;
        cmd.mem_we            <= 'U';
        cmd.mem_ce            <= 'U';

        cmd.cs.CSR_we            <= UNDEFINED;

        cmd.cs.TO_CSR_sel        <= UNDEFINED;
        cmd.cs.CSR_sel           <= UNDEFINED;
        cmd.cs.MEPC_sel          <= UNDEFINED;

        cmd.cs.MSTATUS_mie_set   <= 'U';
        cmd.cs.MSTATUS_mie_reset <= 'U';

        cmd.cs.CSR_WRITE_mode    <= UNDEFINED;

        state_d <= state_q;

        case state_q is
            when S_Error =>
                -- Etat transitoire en cas d'instruction non reconnue 
                -- Aucune action
                state_d <= S_Init;

            when S_Init =>
                -- PC <- RESET_VECTOR
                cmd.PC_we <= '1';
                cmd.PC_sel <= PC_rstvec;
                state_d <= S_Pre_Fetch;

            when S_Pre_Fetch =>
                -- mem[PC]
                cmd.mem_we   <= '0';
                cmd.mem_ce   <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                state_d      <= S_Fetch;

            when S_Fetch =>
                -- IR <- mem_datain
                cmd.IR_we <= '1';
                state_d <= S_Decode;

            when S_Decode =>

                state_d <= S_Error;
                if status.IR(6 downto 0) = "0110111" then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_LUI;
                elsif status.IR(6 downto 0) = "0010011" and status.IR(14 downto 12) = "000" then
                    cmd .TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_ADDI;
                elsif status.IR(6 downto 0) = "0110011" and status.IR(14 downto 12) = "000" and status.IR(31 downto 25) = "0000000"  then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_ADD;
                elsif status.IR(6 downto 0) = "0110011" and status.IR(14 downto 12) = "000" and status.IR(31 downto 25) = "0100000"  then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_SUB;
                elsif status.IR(6 downto 0) = "0010111"  then
                    state_d <= S_AUIPC;
                elsif status.IR(6 downto 0) = "0110011" and status.IR(14 downto 12) = "110" and status.IR(31 downto 25) = "0000000" then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_OR;
                elsif status.IR(6 downto 0) = "0010011" and status.IR(14 downto 12) = "110" then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_ORI;
                elsif status.IR(6 downto 0) = "0110011" and status.IR(14 downto 12) = "100" and status.IR(31 downto 25) = "0000000" then 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_XOR;
                elsif status.IR(6 downto 0) = "0010011" and status.IR(14 downto 12) = "100" then 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_XORI;
                elsif status.IR(6 downto 0) = "0110011" and status.IR(14 downto 12) = "001" and status.IR(31 downto 25) = "0000000" then 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_SLL;
                elsif status.IR(6 downto 0) = "0010011" and status.IR(14 downto 12) = "001" and status.IR(31 downto 25) = "0000000" then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_SLLI;
                elsif status.IR(6 downto 0) = "0110011" and status.IR(14 downto 12) = "101" and status.IR(31 downto 25) = "0100000" then 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_SRA;
                elsif status.IR(6 downto 0) = "0010011" and status.IR(14 downto 12) = "101" and status.IR(31 downto 25) = "0100000" then 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_SRAI;
                elsif status.IR(6 downto 0) = "0110011" and status.IR(14 downto 12) = "101" and status.IR(31 downto 25) = "0000000" then 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_SRL;
                elsif status.IR(6 downto 0) = "0010011" and status.IR(14 downto 12) = "101" and status.IR(31 downto 25) = "0000000" then 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_SRLI;
                elsif status.IR(6 downto 0) = "0010011" and status.IR(14 downto 12) = "111" then 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_ANDI;
                elsif status.IR(6 downto 0) = "0110011" and status.IR(14 downto 12) = "111" and status.IR(31 downto 25) = "0000000" then 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_AND;
                elsif status.IR(6 downto 0) = "1100011" and status.IR(14 downto 12) = "000" then
                    state_d <= S_BEQ;
                elsif status.IR(6 downto 0) = "1100011" and status.IR(14 downto 12) = "001" then
                    state_d <= S_BNE;
                elsif status.IR(6 downto 0) = "1100011" and status.IR(14 downto 12) = "100" then
                    state_d <= S_BLT;
                elsif status.IR(6 downto 0) = "1100011" and status.IR(14 downto 12) = "101" then
                    state_d <= S_BGE;
                elsif status.IR(6 downto 0) = "1100011" and status.IR(14 downto 12) = "110" then
                    state_d <= S_BLTU;
                elsif status.IR(6 downto 0) = "1100011" and status.IR(14 downto 12) = "111" then
                    state_d <= S_BGEU;
                elsif status.IR(6 downto 0) = "0110011" and status.IR(14 downto 12) = "010" then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_SLT;
                elsif status.IR(6 downto 0) = "0010011" and status.IR(14 downto 12) = "010" then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_SLTI;
                elsif status.IR(6 downto 0) = "0110011" and status.IR(14 downto 12) = "011" then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_SLTU;
                elsif status.IR(6 downto 0) = "0010011" and status.IR(14 downto 12) = "011" then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                    state_d <= S_SLTIU;
                end if;
            when S_LUI =>
                    --rd <- ImmU + 0
                    cmd.PC_X_sel <= PC_X_cst_x00;
                    cmd.PC_Y_sel <= PC_Y_immU;
                    cmd.RF_we <= '1';
                    cmd.DATA_sel <= DATA_from_pc;
                    -- lecture mem[PC]
                    cmd.ADDR_sel <= ADDR_from_pc;
                    cmd.mem_ce <= '1';
                    cmd.mem_we <= '0';
                    -- next state
                    state_d <= S_Fetch;
            when S_ADDI => 
                    cmd.ALU_Y_sel <= ALU_Y_immI;
                    cmd.ALU_op <= ALU_plus;
                    cmd.DATA_sel <= DATA_from_alu;
                    -- ecriture dans le registre
                    cmd.RF_we <= '1';
                    -- lecture mem[PC]
                    cmd.mem_ce <= '1';
                    cmd.mem_we <= '0';
                    cmd.ADDR_sel <= ADDR_from_pc;
                    -- next state
                    state_d <= S_Fetch;





                -- Décodage effectif des instructions,
                -- à compléter par vos soins

---------- Instructions avec immediat de type U ----------
            when S_AUIPC => 
                -- rd <- ImmU + pc
                cmd.PC_X_sel <= PC_X_pc;
                cmd.PC_Y_sel <= PC_Y_immU;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_pc;
                cmd.PC_X_sel <= PC_X_pc;
                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                cmd.PC_we <= '1';
                cmd.PC_sel <= PC_from_pc;

                -- next state
                state_d <= S_Pre_Fetch;


---------- Instructions arithmétiques et logiques ----------
            when S_ADD =>
                -- rd <- rs1 + rs2
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                cmd.ALU_op  <= ALU_plus;
                cmd.DATA_sel <= DATA_from_alu;
                --ecriture dans le registre
                cmd.RF_we <= '1';
                --lecture mem[PC]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_SUB =>
                    -- rd <- rs1 - rs2
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                cmd.ALU_op  <= ALU_minus;
                cmd.DATA_sel <= DATA_from_alu;
                --ecriture dans le registre
                cmd.RF_we <= '1';
                 --lecture mem[PC]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_OR =>
                -- rd <- rs1 or rs2
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.LOGICAL_op <= LOGICAL_or;
                cmd.DATA_sel <= DATA_from_logical;
                --ecriture dans le registre
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_ORI => 
                -- rd <- IMMEDIATE or rs1
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.LOGICAL_op <= LOGICAL_or;
                cmd.DATA_sel <= DATA_from_logical;
                --ecriture dans le registre 
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;

            when S_AND =>
                --rd <- rs1 and rs2
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.LOGICAL_op <= LOGICAL_and;
                cmd.DATA_sel <= DATA_from_logical;
                --ecriture dans le registre 
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_ANDI => 
                    --rd <- rs1 and immediate
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.LOGICAL_op <= LOGICAL_and;
                cmd.DATA_sel <= DATA_from_logical;
                --ecriture dans le registre 
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
                    
            when S_XOR => 
                --rd <- rs1 xor rs2
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.LOGICAL_op <= LOGICAL_xor;
                cmd.DATA_sel <= DATA_from_logical;
                --ecriture dans le registre 
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_XORI =>
                --rd <- rs1 xor immediate
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.LOGICAL_op <= LOGICAL_xor;
                cmd.DATA_sel <= DATA_from_logical;
                --ecriture dans le registre 
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_SLL =>
                -- shift left : multiplication par puissance de 2
                cmd.SHIFTER_Y_sel<= SHIFTER_Y_rs2;
                cmd.SHIFTER_op <= SHIFT_ll;
                cmd.DATA_sel <= DATA_from_shifter;
                --ecriture dans le registre 
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_SLLI => 
                -- shift left logical immediate  immediate
                cmd.SHIFTER_Y_sel<= SHIFTER_Y_ir_sh;
                cmd.SHIFTER_op <= SHIFT_ll;
                cmd.DATA_sel <= DATA_from_shifter;
                --ecriture dans le registre 
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_SRA =>
                -- décalage à droite arithmetique 
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
                cmd.SHIFTER_op <= SHIFT_ra;
                cmd.DATA_sel <= DATA_from_shifter;
                --ecriture dans le registre 
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_SRAI => 
                -- décalage à droite arithmetique immediate 
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh;
                cmd.SHIFTER_op <= SHIFT_ra;
                cmd.DATA_sel <= DATA_from_shifter;
                --ecriture dans le registre 
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_SRL => 
                -- decalage à droite logique 
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
                cmd.SHIFTER_op <= SHIFT_rl;
                cmd.DATA_sel <= DATA_from_shifter;
                --ecriture dans le registre 
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_SRLI => 
                -- decalage à droite logique immediate 
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh;
                cmd.SHIFTER_op <= SHIFT_rl;
                cmd.DATA_sel <= DATA_from_shifter;
                --ecriture dans le registre 
                cmd.RF_we <= '1';
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_BEQ =>
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                -- si rs1 = rs2
                if status.JCOND = True then
                    -- PC <- PC + imm B
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                -- sinon
                else
                    -- PC <- PC + 4
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                end if;
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_BNE =>
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                -- si rs1 = rs2
                if status.JCOND = False then
                    -- PC <- PC + imm B
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                -- sinon
                else
                    -- PC <- PC + 4
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                end if;
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_BGE =>
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                -- si rs1 = rs2
                if status.JCOND = True then
                    -- PC <- PC + imm B
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                -- sinon
                else
                    -- PC <- PC + 4
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                end if;
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_BGEU =>
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                -- si rs1 = rs2
                if status.JCOND = True then
                    -- PC <- PC + imm B
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                -- sinon
                else
                    -- PC <- PC + 4
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                end if;
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_BLT =>
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                -- si rs1 = rs2
                if status.JCOND = True then
                    -- PC <- PC + imm B
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                -- sinon
                else
                    -- PC <- PC + 4
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                end if;
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_BLTU =>
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                -- si rs1 = rs2
                if status.JCOND = True then
                    -- PC <- PC + imm B
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                -- sinon
                else
                    -- PC <- PC + 4
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_WE <= '1';
                end if;
                --lecture mem[pc]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_SLT =>
                -- rd <- rs1 + rs2
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                cmd.DATA_sel <= DATA_from_slt;
                --ecriture dans le registre
                cmd.RF_we <= '1';
                --lecture mem[PC]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_SLTI =>
                -- rd <- rs1 + rs2
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                cmd.DATA_sel <= DATA_from_slt;
                --ecriture dans le registre
                cmd.RF_we <= '1';
                --lecture mem[PC]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_SLTU =>
                -- rd <- rs1 + rs2
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                cmd.DATA_sel <= DATA_from_slt;
                --ecriture dans le registre
                cmd.RF_we <= '1';
                --lecture mem[PC]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
            when S_SLTIU =>
                -- rd <- rs1 + rs2
                cmd.AlU_Y_sel <= ALU_Y_rf_rs2;
                cmd.DATA_sel <= DATA_from_slt;
                --ecriture dans le registre
                cmd.RF_we <= '1';
                --lecture mem[PC]
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                cmd.ADDR_sel <= ADDR_from_pc;
                --next state
                state_d <= S_Fetch;
                    
                    
                


---------- Instructions de saut ----------

---------- Instructions de chargement à partir de la mémoire ----------

---------- Instructions de sauvegarde en mémoire ----------

---------- Instructions d'accès aux CSR ----------

            when others => null;
        end case;

    end process FSM_comb;

end architecture;
