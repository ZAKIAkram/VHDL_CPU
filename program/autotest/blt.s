# TAG = blt
        .text
    addi x4, x0, 0xF101 
    addi x5, x0, 0xF011
    addi x31, x0, 0x0000
    beq x4, x5, saut_blt
    
transparent:
    addi x31, x0, 0x0001
saut_blt:
    add x31, x31, x5
        #max cycle 50
        #pout_start
        #FFFFF011
        #pout_end
