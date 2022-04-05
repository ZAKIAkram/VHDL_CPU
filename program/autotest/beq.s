# TAG = beq
.text
addi x2, x0, 5 # x2 = 5, x3 = , x31 = 
addi x3, x2, -4 # x2 = 5, x3 = 1, x31 = 
beq x2, x2, egalite

add x31, x2, x3 # (pas exécutée)

egalite:
addi x2, x2, 1 # x2 = 6, x3 = 1, x31 = 
beq x2, x3, pas_egalite # (pas exécutée)
add x31, x2, x3  # x2 = 6, x3 = 1, x31 = 7
add x3, x3, 4 # x2 = 6, x3 = 5, x31 = 7
beq x2, x3, fin # pas exécutée
add x31, x31, 3 # x2 = 6, x3 = 5, x31 = 10

fin:
add x31, x31, x31 # On n'arrive jamais ici

pas_egalite:
sub x31, x31, x31 # On n'arrive jamais ici



# max_cycle 100
# pout_start
# 00000007
# 0000000A
# pout_end
