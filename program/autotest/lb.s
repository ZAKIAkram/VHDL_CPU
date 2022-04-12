
# TAG = lb
.text
addi x4, x0, 255
auipc x5, 0
sw x4, 0(x5)
lb x31, 0(x5)

# max_cycle 50
# pout_start
# FFFFFFFF
# pout_end
