# TAG = blti
        .text 
    addi x4, x0, 17
    addi x31, x0, 0
    blti x4, 18, saut_blti
    
transparent:
    addi x31, x0, 1
saut_blti:
    addi x31, x31, 5
        #max cycle 200
        #pout_start
        #00000000
        #00000005
        #pout_end
