# TAG = bltu
        .text 
    addi x4, x0, -8
    addi x5, x0, 5
    addi x31, x0, 0
    bltu x4, x5, saut_bltu
    
transparent:
    addi x31, x0, 1
    addi x4, x4, 3
saut_bltu:
    addi x31, x31, 6
        #max cycle 100
        #pout_start
        #00000000
        #00000006
        #pout_end
