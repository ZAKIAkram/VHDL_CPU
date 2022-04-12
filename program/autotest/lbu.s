# TAG = lbu
.text
addi x4, x0, 300
auipc x5, 0
sw x4, 0(x5)
lbu x31, 0(x5)

#max_cycle 100
#pout_start
#0000002C
#pout_end
