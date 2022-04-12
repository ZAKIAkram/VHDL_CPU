#TAG = jalr
        .text
    addi x31, x0, 0x0001
    la x4, test_2
    jalr x31, 0(x4) # x31 = PC + 4 (0x1010)
    test_1:
        addi x31, x31, 0x0003
    test_2:
        addi x31, x0, 0x0004
        #max_cycle 50
        #pout_start
        #00000001
        #00001010
        #00000004
        #pout_end
