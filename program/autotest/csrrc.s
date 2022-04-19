# TAG = csrrc
	.text

	li x1, 0x42
	li x3, 0x40
	not x4, x3
	and x4, x1, x4
	li x5, -1
	slli x5, x5, 2
	and x5, x5, x4

	csrrw x0, mtvec, x1
	csrrc x0, mtvec, x3
	csrrc x2, mtvec, x0

	beq x5, x2, oui
	li x31, 1
oui:
	li x31, 2

	csrrw x0, mie, x1
	csrrc x0, mie, x3
	csrrc x2, mie, x0

	beq x4, x2, oui2
	li x31, 1
oui2:
	li x31, 3

	csrrw x0, mstatus, x1
	csrrc x0, mstatus, x3
	csrrc x2, mstatus, x0

	beq x4, x2, oui3
	li x31, 1
oui3:
	li x31, 4

	csrrw x0, mepc, x1
	csrrc x0, mepc, x3
	csrrc x2, mepc, x0

	beq x5, x2, oui4
	li x31, 1
oui4:
	li x31, 5

	# max_cycle 150
	# pout_start
    # 00000002
    # 00000003
    # 00000004
    # 00000005
	# pout_end