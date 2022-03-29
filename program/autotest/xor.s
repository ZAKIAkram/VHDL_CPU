# TAG = xor
        .text
    addi x4, x0, 0x0001
    addi x5, x0, 0x0001
    xor x31, x4, x5

    addi x4, x0, 0x0123
    addi x5, x0, 0x0456
    xor x31, x4, x5
        #max cycle 50
        #pout_start
        #00000000
        #00000575
        #pout_end
