#TAG = jalr
        .text
        addi x31, x0, 0x0001
        la x5, addition
        jalr x5
        j fin
        addition:
            addi x31, x31, 0x0003
        fin:
            addi x4, x0, 0x0000
            jalr x5
        #max_cycle 50
        #pout_start
        #00000001
        #00000004
        #00000007
        #pout_end
