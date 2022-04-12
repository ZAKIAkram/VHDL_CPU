# TAG = lb
.text
addi x29, x0, 255
auipc x30, 0
sw x29, 0(x30)
lb x31, 0(x30)

# max_cycle 50
# pout_start
# FFFFFFFF
# pout_end
