# TAG = or
        .text
    addi x4, x0, 0x0001
    or x31, x4, x0

    addi x4, x0, 0x0123
    addi x5, x0, 0x0456
    or x31, x4, x5
        #max cycle 50
        #pout_start
        #00000001
        #00000577
        #pout_end
