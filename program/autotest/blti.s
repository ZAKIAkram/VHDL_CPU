# TAG = blti
        .text 
    addi x4, x0, 0x0011
    addi x31, x0, 0x0000
    blti x4, 0x0111, saut_blti
    
transparent:
    addi x31, x0, 0x0001
saut_blti:
    addi x31, x31, 0x1111
        #max cycle 50
        #pout_start
        #00000000
        #00001111
        #pout_end
