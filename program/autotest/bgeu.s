# TAG = bgeu
        .text
    addi x4, x0, 0x0701 
    addi x5, x0, 0x0011
    addi x31, x0, 0x0000
    bgeu x4, x5, saut_bgeu
    
transparent:
    addi x31, x0, 0x0001
saut_bgeu:
    add x31, x31, x5
        #max cycle 50
        #pout_start
        #00000000
        #00000011
        #pout_end
