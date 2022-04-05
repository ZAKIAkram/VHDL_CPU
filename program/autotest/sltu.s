# TAG = sltu
        .text
    addi x4, x0, 0x0110 
    addi x5, x0, 0x0101
    sltu  x31, x4, x5

    addi x4, x0, 0x0011 
    addi x5, x0, 0x0101
    sltu  x31, x4, x5
    
    addi x4, x0, 0xF011 
    addi x5, x0, 0xF101
    sltu  x31, x4, x5
        #max cycle 50
        #pout_start
        #00000000
        #00000001
        #00000001
        #pout_end

