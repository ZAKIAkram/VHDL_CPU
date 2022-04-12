# TAG = sw
	.text
	addi x4, x0, 9
	auipc x5, 0
	sw x4, 0(x5)
	lw x31, 0(x5)

	# max_cycle 100
	# pout_start
	# 00000009
	# pout_end
