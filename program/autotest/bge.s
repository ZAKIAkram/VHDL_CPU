# TAG = bge
        .text
    addi x4, x0, 0x0111 
    addi x5, x0, 0x0101
    addi x31, x0, 0x0000
    bge x4, x5, saut_bge
    
transparent:
    addi x31, x0, 0x0001
saut_bge:
    addi x31, x31, 10
        #max cycle 100
        #pout_start
        #00000000
        #0000000A
        #pout_end
