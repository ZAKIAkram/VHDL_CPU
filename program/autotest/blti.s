# TAG = blti
        .text 
        
    addi x4, x0, 1
    addi x31, x0, 1
    
for:
    add x31, x31, x4
    addi x4, x4, 1
    blti x4, 4, for
    
 

        #max cycle 200
        #pout_start
        #00000001 x
        #00000003 x
        #00000006 x
        #pout_end
