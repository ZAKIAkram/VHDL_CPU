# TAG = blti
        .text 
    addi x4, x0, 0xF011
    addi x31, x0, 0x0000
    blti x4, xF101, saut_blti
    
transparent:
    addi x31, x0, 0x0001
saut_blti:
    add x31, x31, x4
        #max cycle 50
        #pout_start
        #FFFFF011
        #pout_end
