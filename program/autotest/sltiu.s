# TAG = sltiu
.text

# 5 => 5
addi x4, x0, 5
sltiu x31, x4, 5

# 15 => 1
addi x3, x0, 15
sltiu x31, x3, 1

# 9 < 10
addi x3, x0, 9
sltiu x31, x3, 10

# 4 < 5
addi x3, x0, 4
sltiu x31, x3, 5

# max_cycle 50
# pout_start
# 00000000
# 00000000
# 00000001
# 00000001
# pout_end
