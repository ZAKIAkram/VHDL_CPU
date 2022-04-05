# TAG = blti
        .text 
        

    addi x4, x0, 0
    blti x4, 1, for
sauter:
    addi x31, x0, 1
for:
    addi x31, x0, 3
    
 

        #max cycle 50
        #pout_start
        #00000003
        #pout_end
