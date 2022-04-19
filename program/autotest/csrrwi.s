#TAG = csrrwi
        .text
    lui x1, %hi(traitant) # charge mtvec avec l’adresse du traitant
    addi x1, x1, %lo(traitant) # les deux lignes sont ´equivalentes `a li x1,traitant
    csrrw x0, mtvec, x1
    csrrwi x0, mstatus, 1 << 3 
    addi x1, x0, 1 << 2 # rend sensible `a l’interruption des poussoirs dans le PLIC
    lui x2, 0x0c002 # *(0xC002000) = 2
    sw x1, 0(x2)
    csrrwi x0, mie, 0x800
    addi x2, x0, 0
attente:
    beq x2, x0, attente # tourne tant que x2 vaut 0
    addi x31, x0, 0x5ad # indique sur pout que l’on a recu et trait´e l’interruption
    j attente # boucle infinie
traitant:
    addi x2, x0, 1 # change x2 pour sortir de la boucle infinie
    lui x3, 0x0c200 # acquitte l’interruption dans le plic
    addi x3, x3, 4 # les deux lignes sont ´equivalentes `a li x3,0x0C200004
    lw x1, 0(x3) # par lecture de l’adresse 0x0c2000004
    mret
    #max_cycle 150
    #pout_start
    #000005AD
    #000005AD
    #000005AD
    #pout_end