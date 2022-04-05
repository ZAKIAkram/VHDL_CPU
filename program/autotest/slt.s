# TAG = slt
        .text
    addi x4, x0, 0x0010 
    addi x5, x0, 0x0001
    slt  x31, x4, x5

    addi x4, x0, 0x0011 
    addi x5, x0, 0x0101
    slt  x31, x4, x5
    
    addi x4, x0, 0x7011 
    addi x5, x0, 0x7101
    slt  x31, x4, x5
        #max cycle 50
        #pout_start
        #00000000
        #00000001
        #00000000
        #pout_end


