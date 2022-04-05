# TAG = slti
        .text
    addi x4, x0, 0x0010 
    slti  x31, x4, 0x0001

    addi x4, x0, 0x0011 
    slti  x31, x4, 0x0101
    
    addi x4, x0, 0xF011
    slti  x31, x4, 0xF101
        #max cycle 50
        #pout_start
        #00000000
        #00000001
        #00000000
        #pout_end

