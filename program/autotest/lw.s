# TAG = lw
.text
addi x2, x0, 9
auipc x30, 0
sw x2, 0(x30)
lw x31, 0(x30)

# max_cycle 50
# pout_start
# 00000009
# pout_end
