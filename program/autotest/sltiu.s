# TAG = sltiu
.text

# 5 => 5
addi x4, x0, 5
sltiu x31, x4, 5

# 15 => 1
addi x3, x0, 15
sltiu x31, x3, 1

# 1 < 8
addi x3, x0, 1
sltiu x31, x3, 8

# 8 < 9
addi x3, x0, 8
sltiu x31, x3, 9

# max_cycle 50
# pout_start
# 00000001
# 00000001
# 00000000
# 00000000
# pout_end
