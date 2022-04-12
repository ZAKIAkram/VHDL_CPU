# TAG = lh
.text
lui x4, 15
auipc x5, 0
sh x4, 0(x5)
lh x31, 0(x5)


#max_cycle 50
#pout_start
#FFFFF000
#pout_end
