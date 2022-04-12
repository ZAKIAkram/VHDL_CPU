#TAG = jal
        .text
        #PC est initialisée à 0x1000
    addi x31, x0, 0x0001
    jal x31, test_1 
    addi x31,x0, 0x0002
    test_1:
        jal x31, test_2
        addi x31, x31, 0x0001
    test_2:
        addi x31, x0, 0x0001
        #max_cycle 50
        #pout_start
        #00000001
        #00001008
        #00001010
        #00000001
        #pout_end
