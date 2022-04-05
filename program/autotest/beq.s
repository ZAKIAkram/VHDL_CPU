# TAG = beq
        .text
    addi x4, x0, 0x0011 
    addi x5, x0, 0x0011
    addi x31, x0, 0x0000
    beq x4, x5, saut_beq
    
transparent:
    addi x31, x0, 0x0001
saut_beq:
    add x31, x31, x5
        #max cycle 50
        #pout_start
        #00000011
        #pout_end

