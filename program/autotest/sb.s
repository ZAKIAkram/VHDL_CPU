# TAG = sb
.text
addi x4, x0, 300
auipc x5, 0
sb x4, 0(x5)
lb x31, 0(x5)

#max_cycle 100
#pout_start
#0000002C
#pout_end
