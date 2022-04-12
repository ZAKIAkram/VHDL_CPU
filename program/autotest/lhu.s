# TAG = lhu
.text
addi x4, x0, 15
auipc x5, 0
sw x4, 0(x5)
lhu x31, 0(x5)

#max_cycle 50
#pout_start
#0000000F
#pout_end
