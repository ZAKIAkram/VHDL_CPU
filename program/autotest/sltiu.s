# TAG = sltiu
        .text
    addi x4, x0, 0x0010 
    sltiu  x31, x4, 0x0001

    addi x4, x0, 0x0011 
    sltiu  x31, x4, 0x0101
    
        #max cycle 50
        #pout_start
        #00000000
        #00000001
        #pout_end

