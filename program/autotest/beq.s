# TAG = beq
.text
    addi x2, x0, 5
    addi x3, x2, -1
    beq x2, x2, saut_beq
    
transparent:
    addi x31, x31, 1

saut beq:
    addi x31, x0, 11
    beq x2, x3, transparent #pas de saut ici car x3 = x2 - 1
    
    




# max_cycle 100
# pout_start
# 0000000B
# pout_end
