# TAG = beq
.text
    addi x2, x0, 5
    addi x3, x0, 5
    beq x2, x3, saut_beq
    
transparent:
    addi x31, x31, 1

saut_beq:
    addi x31, x0, 7
    addi x3, x3, -1
    beq x2, x3, transparent #pas de saut ici car x3 = x2 - 1

# max_cycle 100
# pout_start
# 00000007
# pout_end
