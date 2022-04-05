# TAG = blti
        .text 
        
        
    addi x31, x0, 0
for_blti:
    addi x4, x0, 17
    addi x31, x31, 1
    blti x4, 3, for_blti
    

        #max cycle 100
        #pout_start
        #00000000
        #00000001
        #00000003
        #pout_end
