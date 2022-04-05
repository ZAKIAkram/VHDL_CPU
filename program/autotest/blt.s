# TAG = blt
        .text 
    addi x4, x0, 0x0011
    addi x5, x0, 0x0101
    addi x31, x0, 0x0000
    blti x4, x5, saut_blt
    
transparent:
    addi x31, x0, 1
    addi x4, x4, 3
saut_blt:
    addi x31, x31, 6
        #max cycle 50
        #pout_start
        #00000000
        #00000006
        #pout_end
