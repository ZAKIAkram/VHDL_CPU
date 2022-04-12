#TAG = jal

        .text
        #PC est initialisée à 0x1000
    addi x31, x0, 0x0001
    jal x4, test_1 #x4 va valoir 0x1004 (PC+4)
    addi x31,x0, 0x0002
    test_1:
        addi x31, x31, 0x0001
        #max_cycle 50
        #pout_start
        #00000001
        #00000002
        #pout_end
