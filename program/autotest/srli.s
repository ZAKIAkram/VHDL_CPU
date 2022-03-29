# TAG = srli
        .text
    addi x4, x0, 0x0010
    srli x31, x4, 0x0002

    addi x4, x0, 0x0100
    srli x31, x4, 0x0002
        #max cycle 50
        #pout_start
        #00000004
        #00000040
        #pout_end
