# TAG = slt
.text

addi x4, x0, 5
addi x5, x0, 9
slt x31, x4, x5

addi x5, x5, -11
slt x31, x4, x5

addi x5, x5, -11
slt x31, x4, x5

# max_cycle 50
# pout_start
# 00000001
# 00000000
# 00000001
# pout_end


