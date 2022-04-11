#TAG = jal

        .text
    addi x31, x0, 0x0004
    jal x31, addition
    j fin

    addition:
        addi x31, x31, 0x0004
        ret
    fin:
        addi x4, x0, 0x0000
        #max_cycle 50
        #pout_start
        #00000004
        #00000008
        #pout_end
