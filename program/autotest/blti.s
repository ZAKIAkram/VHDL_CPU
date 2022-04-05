# TAG = blti
        .text 
        
        
    addi x31, x0, 0
for_blti:
    addi x4, x0, 17
    addi x31, x31, 1
    blti x4, 5, for_blti
    

        #max cycle 100
        #pout_start
        #00000000
        #00000001
        #00000003
        #00000006
        #0000000A
        #pout_end
