library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PKG.all;

entity CPU_CND is
    generic (
        mutant      : integer := 0
    );
    port (
        rs1         : in w32;
        alu_y       : in w32;
        IR          : in w32;
        slt         : out std_logic;
        jcond       : out std_logic
    );
end entity;

architecture RTL of CPU_CND is

    signal z, s, extension_de_signe : std_logic;

    signal entree_1, entree_2 : std_logic;
    signal resultat : unsigned(32 downto 0);
begin

    resultat <= (rs1(31) & rs1) - (alu_y(31) & alu_y) when extension_de_signe = '1' else ('0' & rs1) - ('0' & alu_y);
  
    extension_de_signe <= (IR(6) and not IR(13)) or ( not IR(12) and not IR(6));

    z <= '1' when rs1 = alu_y else '0';
    
    s <= resultat(32);

    entree_1 <= (z xor IR(12)) and not(IR(14));
    
    entree_2 <= IR(14) and (s xor IR(12));
    
    slt <= s;

    jcond <= entree_1 or entree_2;

end architecture;
