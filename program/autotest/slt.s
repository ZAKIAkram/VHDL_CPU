# TAG = slt
        .text
    addi x4, x0, 5
    addi x5, x0, 6
    slt  x31, x4, x5

    addi x4, x0, 5
    addi x5, x0, 5
    slt  x31, x4, x5
    addi x4, x0, -4
    addi x5, x0, -2
    slt x31, x4, x5
    
        #max cycle 100
        #pout_start
        #00000001
        #00000000
        #00000001
        #pout_end


