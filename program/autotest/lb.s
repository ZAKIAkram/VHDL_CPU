#TAG = lb
        .text
    la x4, word
    lb x31, 0(x4)

        .data
        word: .byte 4
        #max_cycle 50
        #pout_start
        #00000020
        #pout_end
