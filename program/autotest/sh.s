# TAG = sh
.text
lui x4, 63
auipc x5, 0
sh x4, 0(x5)
lhu x31, 0(x5)

#max_cycle 100
#pout_start
#0000F000
#pout_end

