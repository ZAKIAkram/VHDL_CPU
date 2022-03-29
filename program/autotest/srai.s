# TAG = srai
        .text
    addi x4, x0, 0x0100
    srai x31, x4, 0x0001

    addi x4, x0, 0x0100
    srai x31, x4, 0x0002
        #max cycle 50
        #pout_start
        #00000080
        #00000040
        #pout_end
