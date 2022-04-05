# TAG = blti
        .text 
    addi x4, x0, 0x0011
    addi x31, x0, 0x0000
    blti x4, 0x0111, saut_blti
    
transparent:
    addi x31, x0, 1
saut_blti:
    addi x31, x31, 5
        #max cycle 200
        #pout_start
        #00000000
        #00000005
        #pout_end
