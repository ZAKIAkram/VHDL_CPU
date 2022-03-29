# TAG = sra
        .text
    addi x4, x0, 0x0100
    addi x5, x0, 0x0001
    sra x31, x4, x5

    addi x4, x0, 0x0100
    addi x5, x0, 0x0002
    sra x31, x4, x5
        #max cycle 50
        #pout_start
        #00000080
        #00000040
        #pout_end
