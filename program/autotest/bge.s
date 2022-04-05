# TAG = bge
        .text
    addi x4, x0, 0xF011 
    addi x5, x0, 0xF101
    addi x31, x0, 0x0000
    bge x4, x5, saut_bge
    
transparent:
    addi x31, x0, 0x0001
saut_bge:
    add x31, x31, x5
        #max cycle 50
        #pout_start
        #FFFFF101
        #pout_end
