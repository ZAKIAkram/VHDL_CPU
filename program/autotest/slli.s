# TAG = slli
        .text
    addi x4, x0, 0x0001
    slli x31, x4, 0x0001

    addi x4, x0, 0x0001
    slli x31, x4, 0x0002
        #max cycle 50
        #pout_start
        #00000002
        #00000004
        #pout_end

