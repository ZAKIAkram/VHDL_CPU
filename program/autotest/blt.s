# TAG = blt
        .text
    addi x4, x0, 0x7101 
    addi x5, x0, 0x7011
    addi x31, x0, 0x0000
    beq x4, x5, saut_blt
    
transparent:
    addi x31, x0, 0x0001
saut_blt:
    addi x31, x31, 0x0111
        #max cycle 50
        #pout_start
        #00000000
        #00000111
        #pout_end
