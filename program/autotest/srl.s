# TAG = srl
        .text
    addi x4, x0, 0x0010
    addi x5, x0, 0x0001
    srl x31, x4, x5

    addi x4, x0, 0x0100
    addi x5, x0, 0x0002
    srl x31, x4, x5
        #max cycle 50
        #pout_start
        #00000008
        #00000040
        #pout_end
