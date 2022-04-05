# TAG = slt
.text

# 5 => 5
addi x4, x0, 5
slt x31, x4, x4

# -1 < 1
addi x3, x0, -1
addi x4, x0, 1
slt x31, x3, x4

# 8 => 1
addi x3, x0, 8
addi x4, x0, 1
slt x31, x3, x4

# -10 < -8
addi x3, x0, -10
addi x4, x0, -8
slt x31, x3, x4

# max_cycle 50
# pout_start
# 00000000
# 00000001
# 00000000
# 00000001
# pout_end


