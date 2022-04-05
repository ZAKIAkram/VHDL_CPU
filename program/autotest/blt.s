# TAG = blt
.text
addi x2, x0, 5 # x2 = 5, x3 = , x31 = 
addi x3, x0, -4 # x2 = 5, x3 = -4, x31 = 
blt x3, x2, blt_exec

add x31, x2, x3 # (pas exécutée)

blt_exec:
addi x2, x2, 1 # x2 = 6, x3 = -4, x31 = 
blt x2, x3, pas_exec # (pas exécutée)
add x31, x2, x3  # x2 = 6, x3 = -4, x31 = 2
add x3, x3, 4 # x2 = 6, x3 = 0, x31 = 2
blt x3, x3, fin # (pas exécutée) car inf strict
add x31, x31, 3 # x2 = 6, x3 = 0, x31 = 5

fin:
add x31, x31, x31 # On n'arrive jamais ici

pas_exec:
sub x31, x31, x31 # On n'arrive jamais ici



# max_cycle 100
# pout_start
# 00000002
# 00000005
# pout_end

