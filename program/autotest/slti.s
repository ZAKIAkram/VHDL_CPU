# TAG = slti
        .text
    addi x4, x0, 0x0010 
    slti  x31, x4, 0x0001

    addi x4, x0, 0x0011 
    slti  x31, x4, 0x0101
    
    addi x4, x0, 0x7101 
    sltu  x31, x4, 0x7011


        #max cycle 50
        #pout_start
        #00000000
        #00000001
        #00000001
        #pout_end

