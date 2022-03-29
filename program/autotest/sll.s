# TAG = sll
        .text
    addi x4, x0, 0x0001
    sll x31, x4, x4

    addi x4, x0, 0x0001
    addi x5, x0, 0x0002
    sll x31, x4, x5
        #max cycle 50
        #pout_start
        #00000002
        #00000004
        #pout_end
