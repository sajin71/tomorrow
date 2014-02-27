	lui	$29, 0x8000
	lui	$30, 0x8001
	lui	$3, 0x8003
	addi	$4, $3, 4
	sw	$4, 0($3)
	jal	min_caml_start
	nop
	halt
l.8609:	# 128.000000
	.long	0x43000000
l.8568:	# 0.900000
	.long	0x3f666666
l.8567:	# 0.200000
	.long	0x3e4ccccd
l.8470:	# 150.000000
	.long	0x43160000
l.8469:	# -150.000000
	.long	0xc3160000
l.8451:	# 0.100000
	.long	0x3dcccccd
l.8447:	# -2.000000
	.long	0xc0000000
l.8445:	# 0.003906
	.long	0x3b800000
l.8421:	# 20.000000
	.long	0x41a00000
l.8420:	# 0.050000
	.long	0x3d4ccccd
l.8415:	# 0.250000
	.long	0x3e800000
l.8411:	# 10.000000
	.long	0x41200000
l.8405:	# 0.300000
	.long	0x3e99999a
l.8404:	# 255.000000
	.long	0x437f0000
l.8403:	# 0.500000
	.long	0x3f000000
l.8402:	# 0.150000
	.long	0x3e19999a
l.8398:	# 3.141593
	.long	0x40490fdb
l.8397:	# 30.000000
	.long	0x41f00000
l.8396:	# 15.000000
	.long	0x41700000
l.8395:	# 0.000100
	.long	0x38d1b717
l.8330:	# 100000000.000000
	.long	0x4cbebc20
l.8326:	# 1000000000.000000
	.long	0x4e6e6b28
l.8306:	# -0.100000
	.long	0xbdcccccd
l.8293:	# 0.010000
	.long	0x3c23d70a
l.8292:	# -0.200000
	.long	0xbe4ccccd
l.8054:	# 2.000000
	.long	0x40000000
l.8020:	# -200.000000
	.long	0xc3480000
l.8018:	# 200.000000
	.long	0x43480000
l.8017:	# 0.017453
	.long	0x3c8efa35
l.7947:	# -1.000000
	.long	0xbf800000
l.7946:	# 1.000000
	.long	0x3f800000
l.7945:	# 0.000000
	.long	0x0
closure_indirect:
	jr	$27
sgn.2466:
	swc	$f0, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 0
	bne	$1, $2, beq_else.10284
	lwc	$f0, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_fispos
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 0
	bne	$1, $2, beq_else.10285
	setclv	$f0, l.7947
	jr $31
beq_else.10285:
	setclv	$f0, l.7946
	jr $31
beq_else.10284:
	setclv	$f0, l.7945
	jr $31
vecset.2474:
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	swc	$f0, 0($27)
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $1
	swc	$f1, 0($27)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	swc	$f2, 0($27)
	jr $31
vecfill.2479:
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	swc	$f0, 0($27)
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $1
	swc	$f0, 0($27)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	swc	$f0, 0($27)
	jr $31
veccpy.2484:
	set	$3, 0
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f0, 0($27)
	sll	$3, $3, 2
	add	$27, $3, $1
	swc	$f0, 0($27)
	set	$3, 1
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f0, 0($27)
	sll	$3, $3, 2
	add	$27, $3, $1
	swc	$f0, 0($27)
	set	$3, 2
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f0, 0($27)
	sll	$2, $3, 2
	add	$27, $2, $1
	swc	$f0, 0($27)
	jr $31
vecunit_sgn.2492:
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $1
	lwc	$f0, 0($27)
	sw	$2, 0($29)
	sw	$1, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	swc	$f0, 8($29)
	mov.s	$f0, $f1
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lwc	$f1, 8($29)
	add.s	$f0, $f1, $f0
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	swc	$f0, 12($29)
	mov.s	$f0, $f1
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f1, 12($29)
	add.s	$f0, $f1, $f0
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	swc	$f0, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.10289
	set	$1, 0
	lw	$2, 0($29)
	bne	$2, $1, beq_else.10291
	setclv	$f0, l.7946
	lwc	$f1, 16($29)
	div.s	$f0, $f0, $f1
	j	beq_cont.10292
beq_else.10291:
	setclv	$f0, l.7947
	lwc	$f1, 16($29)
	div.s	$f0, $f0, $f1
beq_cont.10292:
	j	beq_cont.10290
beq_else.10289:
	setclv	$f0, l.7946
beq_cont.10290:
	set	$1, 0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	mul.s	$f1, $f1, $f0
	sll	$1, $1, 2
	add	$27, $1, $3
	swc	$f1, 0($27)
	set	$1, 1
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f1, 0($27)
	mul.s	$f1, $f1, $f0
	sll	$1, $1, 2
	add	$27, $1, $3
	swc	$f1, 0($27)
	set	$1, 2
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f1, 0($27)
	mul.s	$f0, $f1, $f0
	sll	$1, $1, 2
	add	$27, $1, $3
	swc	$f0, 0($27)
	jr $31
veciprod.2495:
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $1
	lwc	$f0, 0($27)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $1
	lwc	$f1, 0($27)
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $1
	lwc	$f1, 0($27)
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	jr $31
veciprod2.2498:
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f3, 0($27)
	mul.s	$f0, $f3, $f0
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f3, 0($27)
	mul.s	$f1, $f3, $f1
	add.s	$f0, $f0, $f1
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f1, 0($27)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	jr $31
vecaccum.2503:
	set	$3, 0
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $1
	lwc	$f1, 0($27)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f2, 0($27)
	mul.s	$f2, $f0, $f2
	add.s	$f1, $f1, $f2
	sll	$3, $3, 2
	add	$27, $3, $1
	swc	$f1, 0($27)
	set	$3, 1
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $1
	lwc	$f1, 0($27)
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f2, 0($27)
	mul.s	$f2, $f0, $f2
	add.s	$f1, $f1, $f2
	sll	$3, $3, 2
	add	$27, $3, $1
	swc	$f1, 0($27)
	set	$3, 2
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $1
	lwc	$f1, 0($27)
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f2, 0($27)
	mul.s	$f0, $f0, $f2
	add.s	$f0, $f1, $f0
	sll	$2, $3, 2
	add	$27, $2, $1
	swc	$f0, 0($27)
	jr $31
vecadd.2507:
	set	$3, 0
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $1
	lwc	$f0, 0($27)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f1, 0($27)
	add.s	$f0, $f0, $f1
	sll	$3, $3, 2
	add	$27, $3, $1
	swc	$f0, 0($27)
	set	$3, 1
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $1
	lwc	$f0, 0($27)
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f1, 0($27)
	add.s	$f0, $f0, $f1
	sll	$3, $3, 2
	add	$27, $3, $1
	swc	$f0, 0($27)
	set	$3, 2
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $1
	lwc	$f0, 0($27)
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f1, 0($27)
	add.s	$f0, $f0, $f1
	sll	$2, $3, 2
	add	$27, $2, $1
	swc	$f0, 0($27)
	jr $31
vecscale.2513:
	set	$2, 0
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $1
	lwc	$f1, 0($27)
	mul.s	$f1, $f1, $f0
	sll	$2, $2, 2
	add	$27, $2, $1
	swc	$f1, 0($27)
	set	$2, 1
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $1
	lwc	$f1, 0($27)
	mul.s	$f1, $f1, $f0
	sll	$2, $2, 2
	add	$27, $2, $1
	swc	$f1, 0($27)
	set	$2, 2
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $1
	lwc	$f1, 0($27)
	mul.s	$f0, $f1, $f0
	sll	$2, $2, 2
	add	$27, $2, $1
	swc	$f0, 0($27)
	jr $31
vecaccumv.2516:
	set	$4, 0
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $1
	lwc	$f0, 0($27)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $2
	lwc	$f1, 0($27)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $3
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	sll	$4, $4, 2
	add	$27, $4, $1
	swc	$f0, 0($27)
	set	$4, 1
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $1
	lwc	$f0, 0($27)
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $2
	lwc	$f1, 0($27)
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $3
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	sll	$4, $4, 2
	add	$27, $4, $1
	swc	$f0, 0($27)
	set	$4, 2
	set	$5, 2
	sll	$5, $5, 2
	add	$27, $5, $1
	lwc	$f0, 0($27)
	set	$5, 2
	sll	$5, $5, 2
	add	$27, $5, $2
	lwc	$f1, 0($27)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	sll	$2, $4, 2
	add	$27, $2, $1
	swc	$f0, 0($27)
	jr $31
read_screen_settings.2593:
	lw	$1, 20($28)
	lw	$2, 16($28)
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$5, 4($28)
	set	$6, 0
	sw	$1, 0($29)
	sw	$3, 4($29)
	sw	$4, 8($29)
	sw	$2, 12($29)
	sw	$5, 16($29)
	sw	$6, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_read_float
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 20($29)
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	sw	$1, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_read_float
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 24($29)
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	sw	$1, 28($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_read_float
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 28($29)
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_read_float
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	setclv	$f1, l.8017
	mul.s	$f0, $f0, $f1
	swc	$f0, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_cos
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 32($29)
	swc	$f0, 36($29)
	mov.s	$f0, $f1
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_sin
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	swc	$f0, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_read_float
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	setclv	$f1, l.8017
	mul.s	$f0, $f0, $f1
	swc	$f0, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_cos
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 44($29)
	swc	$f0, 48($29)
	mov.s	$f0, $f1
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_sin
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$1, 0
	lwc	$f1, 36($29)
	mul.s	$f2, $f1, $f0
	setclv	$f3, l.8018
	mul.s	$f2, $f2, $f3
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	swc	$f2, 0($27)
	set	$1, 1
	setclv	$f2, l.8020
	lwc	$f3, 40($29)
	mul.s	$f2, $f3, $f2
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f2, 0($27)
	set	$1, 2
	lwc	$f2, 48($29)
	mul.s	$f4, $f1, $f2
	setclv	$f5, l.8018
	mul.s	$f4, $f4, $f5
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f4, 0($27)
	set	$1, 0
	sll	$1, $1, 2
	lw	$3, 8($29)
	add	$27, $1, $3
	swc	$f2, 0($27)
	set	$1, 1
	setclv	$f4, l.7945
	sll	$1, $1, 2
	add	$27, $1, $3
	swc	$f4, 0($27)
	set	$1, 2
	swc	$f0, 52($29)
	sw	$1, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fneg
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$1, 56($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 0
	lwc	$f0, 40($29)
	sw	$1, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fneg
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 52($29)
	mul.s	$f0, $f0, $f1
	lw	$1, 60($29)
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	lwc	$f0, 36($29)
	sw	$1, 64($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fneg
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lw	$1, 64($29)
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	lwc	$f0, 40($29)
	sw	$1, 68($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_fneg
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 48($29)
	mul.s	$f0, $f0, $f1
	lw	$1, 68($29)
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 16($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	set	$2, 0
	sll	$2, $2, 2
	lw	$4, 12($29)
	add	$27, $2, $4
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $3
	lwc	$f0, 0($27)
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	set	$5, 2
	sll	$5, $5, 2
	add	$27, $5, $3
	lwc	$f0, 0($27)
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $4
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	jr $31
read_light.2595:
	lw	$1, 8($28)
	lw	$2, 4($28)
	sw	$2, 0($29)
	sw	$1, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_read_int
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_read_float
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	setclv	$f1, l.8017
	mul.s	$f0, $f0, $f1
	swc	$f0, 8($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_sin
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$1, 1
	sw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 12($29)
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_read_float
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	setclv	$f1, l.8017
	mul.s	$f0, $f0, $f1
	lwc	$f1, 8($29)
	swc	$f0, 16($29)
	mov.s	$f0, $f1
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_cos
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f1, 16($29)
	swc	$f0, 20($29)
	mov.s	$f0, $f1
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_sin
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$1, 0
	lwc	$f1, 20($29)
	mul.s	$f0, $f1, $f0
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	lwc	$f0, 16($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_cos
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$1, 2
	lwc	$f1, 20($29)
	mul.s	$f0, $f1, $f0
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 0
	sw	$1, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_read_float
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 24($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	jr $31
rotate_quadratic_matrix.2597:
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f0, 0($27)
	sw	$1, 0($29)
	sw	$2, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_cos
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	swc	$f0, 8($29)
	mov.s	$f0, $f1
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_sin
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	swc	$f0, 12($29)
	mov.s	$f0, $f1
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_cos
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	swc	$f0, 16($29)
	mov.s	$f0, $f1
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_sin
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	swc	$f0, 20($29)
	mov.s	$f0, $f1
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_cos
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	swc	$f0, 24($29)
	mov.s	$f0, $f1
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_sin
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 24($29)
	lwc	$f2, 16($29)
	mul.s	$f3, $f2, $f1
	lwc	$f4, 20($29)
	lwc	$f5, 12($29)
	mul.s	$f6, $f5, $f4
	mul.s	$f7, $f6, $f1
	lwc	$f8, 8($29)
	mul.s	$f9, $f8, $f0
	sub.s	$f7, $f7, $f9
	mul.s	$f9, $f8, $f4
	mul.s	$f10, $f9, $f1
	mul.s	$f11, $f5, $f0
	add.s	$f10, $f10, $f11
	mul.s	$f11, $f2, $f0
	mul.s	$f6, $f6, $f0
	mul.s	$f12, $f8, $f1
	add.s	$f6, $f6, $f12
	mul.s	$f0, $f9, $f0
	mul.s	$f1, $f5, $f1
	sub.s	$f0, $f0, $f1
	swc	$f0, 28($29)
	swc	$f10, 32($29)
	swc	$f6, 36($29)
	swc	$f7, 40($29)
	swc	$f11, 44($29)
	swc	$f3, 48($29)
	mov.s	$f0, $f4
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fneg
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 16($29)
	lwc	$f2, 12($29)
	mul.s	$f2, $f2, $f1
	lwc	$f3, 8($29)
	mul.s	$f1, $f3, $f1
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	lwc	$f3, 0($27)
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f4, 0($27)
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f5, 0($27)
	set	$1, 0
	lwc	$f6, 48($29)
	swc	$f1, 52($29)
	swc	$f2, 56($29)
	sw	$1, 60($29)
	swc	$f5, 64($29)
	swc	$f0, 68($29)
	swc	$f4, 72($29)
	swc	$f3, 76($29)
	mov.s	$f0, $f6
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	lwc	$f1, 76($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 44($29)
	swc	$f0, 80($29)
	mov.s	$f0, $f2
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	lwc	$f1, 72($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 80($29)
	add.s	$f0, $f2, $f0
	lwc	$f2, 68($29)
	swc	$f0, 84($29)
	mov.s	$f0, $f2
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	lwc	$f1, 64($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 84($29)
	add.s	$f0, $f2, $f0
	lw	$1, 60($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	lwc	$f0, 40($29)
	sw	$1, 88($29)
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	lwc	$f1, 76($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 36($29)
	swc	$f0, 92($29)
	mov.s	$f0, $f2
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	lwc	$f1, 72($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 92($29)
	add.s	$f0, $f2, $f0
	lwc	$f2, 56($29)
	swc	$f0, 96($29)
	mov.s	$f0, $f2
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	lwc	$f1, 64($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 96($29)
	add.s	$f0, $f2, $f0
	lw	$1, 88($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	lwc	$f0, 32($29)
	sw	$1, 100($29)
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	lwc	$f1, 76($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 28($29)
	swc	$f0, 104($29)
	mov.s	$f0, $f2
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	lwc	$f1, 72($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 104($29)
	add.s	$f0, $f2, $f0
	lwc	$f2, 52($29)
	swc	$f0, 108($29)
	mov.s	$f0, $f2
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	lwc	$f1, 64($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 108($29)
	add.s	$f0, $f2, $f0
	lw	$1, 100($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 0
	setclv	$f0, l.8054
	lwc	$f2, 40($29)
	lwc	$f3, 76($29)
	mul.s	$f4, $f3, $f2
	lwc	$f5, 32($29)
	mul.s	$f4, $f4, $f5
	lwc	$f6, 36($29)
	lwc	$f7, 72($29)
	mul.s	$f8, $f7, $f6
	lwc	$f9, 28($29)
	mul.s	$f8, $f8, $f9
	add.s	$f4, $f4, $f8
	lwc	$f8, 56($29)
	mul.s	$f10, $f1, $f8
	lwc	$f11, 52($29)
	mul.s	$f10, $f10, $f11
	add.s	$f4, $f4, $f10
	mul.s	$f0, $f0, $f4
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	setclv	$f0, l.8054
	lwc	$f4, 48($29)
	mul.s	$f3, $f3, $f4
	mul.s	$f4, $f3, $f5
	lwc	$f5, 44($29)
	mul.s	$f5, $f7, $f5
	mul.s	$f7, $f5, $f9
	add.s	$f4, $f4, $f7
	lwc	$f7, 68($29)
	mul.s	$f1, $f1, $f7
	mul.s	$f7, $f1, $f11
	add.s	$f4, $f4, $f7
	mul.s	$f0, $f0, $f4
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	setclv	$f0, l.8054
	mul.s	$f2, $f3, $f2
	mul.s	$f3, $f5, $f6
	add.s	$f2, $f2, $f3
	mul.s	$f1, $f1, $f8
	add.s	$f1, $f2, $f1
	mul.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	jr $31
read_nth_object.2600:
	lw	$2, 4($28)
	sw	$2, 0($29)
	sw	$1, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_read_int
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, -1
	bne	$1, $2, beq_else.10301
	set	$1, 0
	jr $31
beq_else.10301:
	sw	$1, 8($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_read_int
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	sw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_read_int
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	sw	$1, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_read_int
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 20($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	sw	$1, 24($29)
	sw	$2, 28($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_read_float
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 28($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	sw	$1, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_read_float
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 32($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	sw	$1, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_read_float
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 36($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 3
	setclv	$f0, l.7945
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	sw	$1, 40($29)
	sw	$2, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_read_float
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 44($29)
	sll	$1, $1, 2
	lw	$2, 40($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	sw	$1, 48($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_read_float
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 48($29)
	sll	$1, $1, 2
	lw	$2, 40($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	sw	$1, 52($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_read_float
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$1, 52($29)
	sll	$1, $1, 2
	lw	$2, 40($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_read_float
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 2
	setclv	$f0, l.7945
	sw	$1, 56($29)
	mov	$1, $2
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 0
	sw	$1, 60($29)
	sw	$2, 64($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_read_float
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lw	$1, 64($29)
	sll	$1, $1, 2
	lw	$2, 60($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	sw	$1, 68($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_read_float
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lw	$1, 68($29)
	sll	$1, $1, 2
	lw	$2, 60($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 3
	setclv	$f0, l.7945
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	set	$2, 0
	sw	$1, 72($29)
	sw	$2, 76($29)
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	min_caml_read_float
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	lw	$1, 76($29)
	sll	$1, $1, 2
	lw	$2, 72($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	sw	$1, 80($29)
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	min_caml_read_float
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	lw	$1, 80($29)
	sll	$1, $1, 2
	lw	$2, 72($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	sw	$1, 84($29)
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_read_float
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	lw	$1, 84($29)
	sll	$1, $1, 2
	lw	$2, 72($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 3
	setclv	$f0, l.7945
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	set	$2, 0
	lw	$3, 20($29)
	sw	$1, 88($29)
	bne	$3, $2, beq_else.10302
	j	beq_cont.10303
beq_else.10302:
	set	$2, 0
	sw	$2, 92($29)
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_read_float
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	setclv	$f1, l.8017
	mul.s	$f0, $f0, $f1
	lw	$1, 92($29)
	sll	$1, $1, 2
	lw	$2, 88($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	sw	$1, 96($29)
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_read_float
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	setclv	$f1, l.8017
	mul.s	$f0, $f0, $f1
	lw	$1, 96($29)
	sll	$1, $1, 2
	lw	$2, 88($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	sw	$1, 100($29)
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_read_float
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	setclv	$f1, l.8017
	mul.s	$f0, $f0, $f1
	lw	$1, 100($29)
	sll	$1, $1, 2
	lw	$2, 88($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.10303:
	set	$1, 2
	lw	$2, 12($29)
	bne	$2, $1, beq_else.10304
	set	$1, 1
	j	beq_cont.10305
beq_else.10304:
	lw	$1, 56($29)
beq_cont.10305:
	set	$3, 4
	setclv	$f0, l.7945
	sw	$1, 104($29)
	mov	$1, $3
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	mov	$2, $30
	addi	$30, $30, 48
	sw	$1, 40($2)
	lw	$1, 88($29)
	sw	$1, 36($2)
	lw	$3, 72($29)
	sw	$3, 32($2)
	lw	$3, 60($29)
	sw	$3, 28($2)
	lw	$3, 104($29)
	sw	$3, 24($2)
	lw	$3, 40($29)
	sw	$3, 20($2)
	lw	$3, 24($29)
	sw	$3, 16($2)
	lw	$4, 20($29)
	sw	$4, 12($2)
	lw	$5, 16($29)
	sw	$5, 8($2)
	lw	$5, 12($29)
	sw	$5, 4($2)
	lw	$6, 8($29)
	sw	$6, 0($2)
	lw	$6, 4($29)
	sll	$6, $6, 2
	lw	$7, 0($29)
	add	$27, $6, $7
	sw	$2, 0($27)
	set	$2, 3
	bne	$5, $2, beq_else.10306
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f0, 0($27)
	set	$2, 0
	sw	$2, 108($29)
	swc	$f0, 112($29)
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	set	$2, 0
	bne	$1, $2, beq_else.10308
	lwc	$f0, 112($29)
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	sgn.2466
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	lwc	$f1, 112($29)
	swc	$f0, 116($29)
	mov.s	$f0, $f1
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	lwc	$f1, 116($29)
	div.s	$f0, $f1, $f0
	j	beq_cont.10309
beq_else.10308:
	setclv	$f0, l.7945
beq_cont.10309:
	lw	$1, 108($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f0, 0($27)
	set	$1, 1
	sw	$1, 120($29)
	swc	$f0, 124($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	set	$2, 0
	bne	$1, $2, beq_else.10310
	lwc	$f0, 124($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	sgn.2466
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	lwc	$f1, 124($29)
	swc	$f0, 128($29)
	mov.s	$f0, $f1
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	lwc	$f1, 128($29)
	div.s	$f0, $f1, $f0
	j	beq_cont.10311
beq_else.10310:
	setclv	$f0, l.7945
beq_cont.10311:
	lw	$1, 120($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f0, 0($27)
	set	$1, 2
	sw	$1, 132($29)
	swc	$f0, 136($29)
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	set	$2, 0
	bne	$1, $2, beq_else.10312
	lwc	$f0, 136($29)
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	sgn.2466
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	lwc	$f1, 136($29)
	swc	$f0, 140($29)
	mov.s	$f0, $f1
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	lwc	$f1, 140($29)
	div.s	$f0, $f1, $f0
	j	beq_cont.10313
beq_else.10312:
	setclv	$f0, l.7945
beq_cont.10313:
	lw	$1, 132($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.10307
beq_else.10306:
	set	$2, 2
	bne	$5, $2, beq_else.10314
	set	$2, 0
	lw	$5, 56($29)
	bne	$5, $2, beq_else.10316
	set	$2, 1
	j	beq_cont.10317
beq_else.10316:
	set	$2, 0
beq_cont.10317:
	mov	$1, $3
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	vecunit_sgn.2492
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	j	beq_cont.10315
beq_else.10314:
beq_cont.10315:
beq_cont.10307:
	set	$1, 0
	lw	$2, 20($29)
	bne	$2, $1, beq_else.10318
	j	beq_cont.10319
beq_else.10318:
	lw	$1, 24($29)
	lw	$2, 88($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	rotate_quadratic_matrix.2597
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
beq_cont.10319:
	set	$1, 1
	jr $31
read_object.2602:
	lw	$2, 8($28)
	lw	$3, 4($28)
	set	$4, 60
	slt	$27, $1, $4
	bne	$27, $0, ble_else.10320
	jr $31
ble_else.10320:
	sw	$28, 0($29)
	sw	$3, 4($29)
	sw	$1, 8($29)
	mov	$28, $2
	sw	$31, 12($29)
	addi	$29, $29, 16
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -16
	lw	$31, 12($29)
	set	$2, 0
	bne	$1, $2, beq_else.10322
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 4($29)
	lw	$3, 8($29)
	add	$27, $1, $2
	sw	$3, 0($27)
	jr $31
beq_else.10322:
	lw	$1, 8($29)
	addi	$1, $1, 1
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
read_net_item.2606:
	sw	$1, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_read_int
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, -1
	bne	$1, $2, beq_else.10324
	lw	$1, 0($29)
	addi	$1, $1, 1
	set	$2, -1
	j	min_caml_create_array
beq_else.10324:
	lw	$2, 0($29)
	addi	$3, $2, 1
	sw	$1, 4($29)
	mov	$1, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	read_net_item.2606
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$2, 0($29)
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $1
	sw	$3, 0($27)
	jr $31
read_or_network.2608:
	set	$2, 0
	sw	$1, 0($29)
	mov	$1, $2
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	read_net_item.2606
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	mov	$2, $1
	set	$1, 0
	sll	$1, $1, 2
	add	$27, $1, $2
	lw	$1, 0($27)
	set	$3, -1
	bne	$1, $3, beq_else.10325
	lw	$1, 0($29)
	addi	$1, $1, 1
	j	min_caml_create_array
beq_else.10325:
	lw	$1, 0($29)
	addi	$3, $1, 1
	sw	$2, 4($29)
	mov	$1, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	read_or_network.2608
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$2, 0($29)
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $1
	sw	$3, 0($27)
	jr $31
read_and_network.2610:
	lw	$2, 4($28)
	set	$3, 0
	sw	$28, 0($29)
	sw	$2, 4($29)
	sw	$1, 8($29)
	mov	$1, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	read_net_item.2606
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lw	$2, 0($27)
	set	$3, -1
	bne	$2, $3, beq_else.10326
	jr $31
beq_else.10326:
	lw	$2, 8($29)
	sll	$3, $2, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	addi	$1, $2, 1
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
read_parameter.2612:
	lw	$1, 20($28)
	lw	$2, 16($28)
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$5, 4($28)
	sw	$5, 0($29)
	sw	$4, 4($29)
	sw	$2, 8($29)
	sw	$3, 12($29)
	mov	$28, $1
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	lw	$28, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	set	$1, 0
	lw	$28, 8($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	set	$1, 0
	lw	$28, 4($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	set	$1, 0
	set	$2, 0
	sw	$1, 16($29)
	mov	$1, $2
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	read_or_network.2608
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 16($29)
	sll	$2, $2, 2
	lw	$3, 0($29)
	add	$27, $2, $3
	sw	$1, 0($27)
	jr $31
solver_rect_surface.2614:
	lw	$6, 4($28)
	sll	$7, $3, 2
	add	$27, $7, $2
	lwc	$f3, 0($27)
	sw	$6, 0($29)
	swc	$f2, 4($29)
	sw	$5, 8($29)
	swc	$f1, 12($29)
	sw	$2, 16($29)
	sw	$4, 20($29)
	swc	$f0, 24($29)
	sw	$3, 28($29)
	swc	$f3, 32($29)
	sw	$1, 36($29)
	mov.s	$f0, $f3
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.10329
	lw	$1, 36($29)
	lw	$2, 16($1)
	lw	$1, 24($1)
	lwc	$f0, 32($29)
	sw	$2, 40($29)
	sw	$1, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	lw	$3, 44($29)
	bne	$3, $2, beq_else.10330
	j	beq_cont.10331
beq_else.10330:
	set	$2, 0
	bne	$1, $2, beq_else.10332
	set	$1, 1
	j	beq_cont.10333
beq_else.10332:
	set	$1, 0
beq_cont.10333:
beq_cont.10331:
	lw	$2, 28($29)
	sll	$2, $2, 2
	lw	$3, 40($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	set	$2, 0
	bne	$1, $2, beq_else.10334
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fneg
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	j	beq_cont.10335
beq_else.10334:
beq_cont.10335:
	lwc	$f1, 24($29)
	sub.s	$f0, $f0, $f1
	lwc	$f1, 32($29)
	div.s	$f0, $f0, $f1
	lw	$1, 20($29)
	sll	$2, $1, 2
	lw	$3, 16($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	mul.s	$f1, $f0, $f1
	lwc	$f2, 12($29)
	add.s	$f1, $f1, $f2
	swc	$f0, 48($29)
	mov.s	$f0, $f1
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fabs
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 20($29)
	sll	$1, $1, 2
	lw	$2, 40($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fless
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.10336
	set	$1, 0
	jr $31
beq_else.10336:
	lw	$1, 8($29)
	sll	$2, $1, 2
	lw	$3, 16($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	lwc	$f1, 48($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 4($29)
	add.s	$f0, $f0, $f2
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fabs
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 8($29)
	sll	$1, $1, 2
	lw	$2, 40($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fless
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.10337
	set	$1, 0
	jr $31
beq_else.10337:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lwc	$f0, 48($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	jr $31
beq_else.10329:
	set	$1, 0
	jr $31
solver_rect.2623:
	lw	$28, 4($28)
	set	$3, 0
	set	$4, 1
	set	$5, 2
	swc	$f0, 0($29)
	swc	$f2, 4($29)
	swc	$f1, 8($29)
	sw	$2, 12($29)
	sw	$1, 16($29)
	sw	$28, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10338
	set	$3, 1
	set	$4, 2
	set	$5, 0
	lwc	$f0, 8($29)
	lwc	$f1, 4($29)
	lwc	$f2, 0($29)
	lw	$1, 16($29)
	lw	$2, 12($29)
	lw	$28, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10339
	set	$3, 2
	set	$4, 0
	set	$5, 1
	lwc	$f0, 4($29)
	lwc	$f1, 0($29)
	lwc	$f2, 8($29)
	lw	$1, 16($29)
	lw	$2, 12($29)
	lw	$28, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10340
	set	$1, 0
	jr $31
beq_else.10340:
	set	$1, 3
	jr $31
beq_else.10339:
	set	$1, 2
	jr $31
beq_else.10338:
	set	$1, 1
	jr $31
solver_surface.2629:
	lw	$3, 4($28)
	lw	$1, 16($1)
	sw	$3, 0($29)
	swc	$f2, 4($29)
	swc	$f1, 8($29)
	swc	$f0, 12($29)
	sw	$1, 16($29)
	mov	$27, $2
	mov	$2, $1
	mov	$1, $27
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	veciprod.2495
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	swc	$f0, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fispos
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10341
	set	$1, 0
	jr $31
beq_else.10341:
	set	$1, 0
	lwc	$f0, 12($29)
	lwc	$f1, 8($29)
	lwc	$f2, 4($29)
	lw	$2, 16($29)
	sw	$1, 24($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	veciprod2.2498
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fneg
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 20($29)
	div.s	$f0, $f0, $f1
	lw	$1, 24($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	jr $31
quadratic.2635:
	swc	$f0, 0($29)
	swc	$f2, 4($29)
	swc	$f1, 8($29)
	sw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 12($29)
	lw	$2, 16($1)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	lwc	$f1, 8($29)
	swc	$f0, 16($29)
	mov.s	$f0, $f1
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 12($29)
	lw	$2, 16($1)
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	lwc	$f1, 16($29)
	add.s	$f0, $f1, $f0
	lwc	$f1, 4($29)
	swc	$f0, 20($29)
	mov.s	$f0, $f1
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 12($29)
	lw	$2, 16($1)
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	lwc	$f1, 20($29)
	add.s	$f0, $f1, $f0
	lw	$2, 12($1)
	set	$3, 0
	bne	$2, $3, beq_else.10342
	jr $31
beq_else.10342:
	lwc	$f1, 4($29)
	lwc	$f2, 8($29)
	mul.s	$f3, $f2, $f1
	lw	$2, 36($1)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f4, 0($27)
	mul.s	$f3, $f3, $f4
	add.s	$f0, $f0, $f3
	lwc	$f3, 0($29)
	mul.s	$f1, $f1, $f3
	lw	$2, 36($1)
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f4, 0($27)
	mul.s	$f1, $f1, $f4
	add.s	$f0, $f0, $f1
	mul.s	$f1, $f3, $f2
	lw	$1, 36($1)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	jr $31
bilinear.2640:
	mul.s	$f6, $f0, $f3
	lw	$2, 16($1)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f7, 0($27)
	mul.s	$f6, $f6, $f7
	mul.s	$f7, $f1, $f4
	lw	$2, 16($1)
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f8, 0($27)
	mul.s	$f7, $f7, $f8
	add.s	$f6, $f6, $f7
	mul.s	$f7, $f2, $f5
	lw	$2, 16($1)
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f8, 0($27)
	mul.s	$f7, $f7, $f8
	add.s	$f6, $f6, $f7
	lw	$2, 12($1)
	set	$3, 0
	bne	$2, $3, beq_else.10343
	mov.s	$f0, $f6
	jr $31
beq_else.10343:
	mul.s	$f7, $f2, $f4
	mul.s	$f8, $f1, $f5
	add.s	$f7, $f7, $f8
	lw	$2, 36($1)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f8, 0($27)
	mul.s	$f7, $f7, $f8
	mul.s	$f5, $f0, $f5
	mul.s	$f2, $f2, $f3
	add.s	$f2, $f5, $f2
	lw	$2, 36($1)
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f5, 0($27)
	mul.s	$f2, $f2, $f5
	add.s	$f2, $f7, $f2
	mul.s	$f0, $f0, $f4
	mul.s	$f1, $f1, $f3
	add.s	$f0, $f0, $f1
	lw	$1, 36($1)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	add.s	$f0, $f2, $f0
	swc	$f6, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	lwc	$f1, 0($29)
	add.s	$f0, $f1, $f0
	jr $31
solver_second.2648:
	lw	$3, 4($28)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f3, 0($27)
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f4, 0($27)
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f5, 0($27)
	sw	$3, 0($29)
	swc	$f2, 4($29)
	swc	$f1, 8($29)
	swc	$f0, 12($29)
	sw	$1, 16($29)
	sw	$2, 20($29)
	mov.s	$f2, $f5
	mov.s	$f1, $f4
	mov.s	$f0, $f3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	quadratic.2635
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	swc	$f0, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10344
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f1, 0($27)
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f2, 0($27)
	lwc	$f3, 12($29)
	lwc	$f4, 8($29)
	lwc	$f5, 4($29)
	lw	$1, 16($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	bilinear.2640
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 12($29)
	lwc	$f2, 8($29)
	lwc	$f3, 4($29)
	lw	$1, 16($29)
	swc	$f0, 28($29)
	mov.s	$f0, $f1
	mov.s	$f1, $f2
	mov.s	$f2, $f3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	quadratic.2635
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 16($29)
	lw	$2, 4($1)
	set	$3, 3
	bne	$2, $3, beq_else.10345
	setclv	$f1, l.7946
	sub.s	$f0, $f0, $f1
	j	beq_cont.10346
beq_else.10345:
beq_cont.10346:
	lwc	$f1, 28($29)
	swc	$f0, 32($29)
	mov.s	$f0, $f1
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 32($29)
	lwc	$f2, 24($29)
	mul.s	$f1, $f2, $f1
	sub.s	$f0, $f0, $f1
	swc	$f0, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fispos
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.10347
	set	$1, 0
	jr $31
beq_else.10347:
	lwc	$f0, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 16($29)
	lw	$1, 24($1)
	set	$2, 0
	bne	$1, $2, beq_else.10348
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fneg
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	j	beq_cont.10349
beq_else.10348:
beq_cont.10349:
	set	$1, 0
	lwc	$f1, 28($29)
	sub.s	$f0, $f0, $f1
	lwc	$f1, 24($29)
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	jr $31
beq_else.10344:
	set	$1, 0
	jr $31
solver.2654:
	lw	$4, 16($28)
	lw	$5, 12($28)
	lw	$6, 8($28)
	lw	$7, 4($28)
	sll	$1, $1, 2
	add	$27, $1, $7
	lw	$1, 0($27)
	set	$7, 0
	sll	$7, $7, 2
	add	$27, $7, $3
	lwc	$f0, 0($27)
	lw	$7, 20($1)
	set	$8, 0
	sll	$8, $8, 2
	add	$27, $8, $7
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	set	$7, 1
	sll	$7, $7, 2
	add	$27, $7, $3
	lwc	$f1, 0($27)
	lw	$7, 20($1)
	set	$8, 1
	sll	$8, $8, 2
	add	$27, $8, $7
	lwc	$f2, 0($27)
	sub.s	$f1, $f1, $f2
	set	$7, 2
	sll	$7, $7, 2
	add	$27, $7, $3
	lwc	$f2, 0($27)
	lw	$3, 20($1)
	set	$7, 2
	sll	$7, $7, 2
	add	$27, $7, $3
	lwc	$f3, 0($27)
	sub.s	$f2, $f2, $f3
	lw	$3, 4($1)
	set	$7, 1
	bne	$3, $7, beq_else.10350
	mov	$28, $6
	lw	$27, 0($28)
	jr	$27
beq_else.10350:
	set	$6, 2
	bne	$3, $6, beq_else.10351
	mov	$28, $4
	lw	$27, 0($28)
	jr	$27
beq_else.10351:
	mov	$28, $5
	lw	$27, 0($28)
	jr	$27
solver_rect_fast.2658:
	lw	$4, 4($28)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $3
	lwc	$f3, 0($27)
	sub.s	$f3, $f3, $f0
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $3
	lwc	$f4, 0($27)
	mul.s	$f3, $f3, $f4
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $2
	lwc	$f4, 0($27)
	mul.s	$f4, $f3, $f4
	add.s	$f4, $f4, $f1
	sw	$4, 0($29)
	swc	$f0, 4($29)
	swc	$f1, 8($29)
	sw	$3, 12($29)
	swc	$f2, 16($29)
	swc	$f3, 20($29)
	sw	$2, 24($29)
	sw	$1, 28($29)
	mov.s	$f0, $f4
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fabs
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 28($29)
	lw	$2, 16($1)
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fless
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10352
	set	$1, 0
	j	beq_cont.10353
beq_else.10352:
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	lwc	$f1, 20($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 16($29)
	add.s	$f0, $f0, $f2
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fabs
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 28($29)
	lw	$2, 16($1)
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fless
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10354
	set	$1, 0
	j	beq_cont.10355
beq_else.10354:
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10356
	set	$1, 1
	j	beq_cont.10357
beq_else.10356:
	set	$1, 0
beq_cont.10357:
beq_cont.10355:
beq_cont.10353:
	set	$2, 0
	bne	$1, $2, beq_else.10358
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	lwc	$f1, 8($29)
	sub.s	$f0, $f0, $f1
	set	$1, 3
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f2, 0($27)
	mul.s	$f0, $f0, $f2
	set	$1, 0
	sll	$1, $1, 2
	lw	$3, 24($29)
	add	$27, $1, $3
	lwc	$f2, 0($27)
	mul.s	$f2, $f0, $f2
	lwc	$f3, 4($29)
	add.s	$f2, $f2, $f3
	swc	$f0, 32($29)
	mov.s	$f0, $f2
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fabs
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 28($29)
	lw	$2, 16($1)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fless
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10359
	set	$1, 0
	j	beq_cont.10360
beq_else.10359:
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	lwc	$f1, 32($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 16($29)
	add.s	$f0, $f0, $f2
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fabs
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 28($29)
	lw	$2, 16($1)
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fless
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10361
	set	$1, 0
	j	beq_cont.10362
beq_else.10361:
	set	$1, 3
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10363
	set	$1, 1
	j	beq_cont.10364
beq_else.10363:
	set	$1, 0
beq_cont.10364:
beq_cont.10362:
beq_cont.10360:
	set	$2, 0
	bne	$1, $2, beq_else.10365
	set	$1, 4
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	lwc	$f1, 16($29)
	sub.s	$f0, $f0, $f1
	set	$1, 5
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	set	$1, 0
	sll	$1, $1, 2
	lw	$3, 24($29)
	add	$27, $1, $3
	lwc	$f1, 0($27)
	mul.s	$f1, $f0, $f1
	lwc	$f2, 4($29)
	add.s	$f1, $f1, $f2
	swc	$f0, 36($29)
	mov.s	$f0, $f1
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fabs
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 28($29)
	lw	$2, 16($1)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fless
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.10366
	set	$1, 0
	j	beq_cont.10367
beq_else.10366:
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	lwc	$f1, 36($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 8($29)
	add.s	$f0, $f0, $f2
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fabs
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 28($29)
	lw	$1, 16($1)
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f1, 0($27)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fless
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.10368
	set	$1, 0
	j	beq_cont.10369
beq_else.10368:
	set	$1, 5
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.10370
	set	$1, 1
	j	beq_cont.10371
beq_else.10370:
	set	$1, 0
beq_cont.10371:
beq_cont.10369:
beq_cont.10367:
	set	$2, 0
	bne	$1, $2, beq_else.10372
	set	$1, 0
	jr $31
beq_else.10372:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lwc	$f0, 36($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 3
	jr $31
beq_else.10365:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lwc	$f0, 32($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	jr $31
beq_else.10358:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lwc	$f0, 20($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	jr $31
solver_surface_fast.2665:
	lw	$1, 4($28)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f3, 0($27)
	sw	$1, 0($29)
	swc	$f2, 4($29)
	swc	$f1, 8($29)
	swc	$f0, 12($29)
	sw	$2, 16($29)
	mov.s	$f0, $f3
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.10373
	set	$1, 0
	jr $31
beq_else.10373:
	set	$1, 0
	set	$2, 1
	sll	$2, $2, 2
	lw	$3, 16($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	lwc	$f1, 12($29)
	mul.s	$f0, $f0, $f1
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f1, 0($27)
	lwc	$f2, 8($29)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	set	$2, 3
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f1, 0($27)
	lwc	$f2, 4($29)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	jr $31
solver_second_fast.2671:
	lw	$3, 4($28)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f3, 0($27)
	sw	$3, 0($29)
	swc	$f3, 4($29)
	sw	$1, 8($29)
	swc	$f2, 12($29)
	swc	$f1, 16($29)
	swc	$f0, 20($29)
	sw	$2, 24($29)
	mov.s	$f0, $f3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10374
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	lwc	$f1, 20($29)
	mul.s	$f0, $f0, $f1
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f2, 0($27)
	lwc	$f3, 16($29)
	mul.s	$f2, $f2, $f3
	add.s	$f0, $f0, $f2
	set	$1, 3
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f2, 0($27)
	lwc	$f4, 12($29)
	mul.s	$f2, $f2, $f4
	add.s	$f0, $f0, $f2
	lw	$1, 8($29)
	swc	$f0, 28($29)
	mov.s	$f2, $f4
	mov.s	$f0, $f1
	mov.s	$f1, $f3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	quadratic.2635
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 8($29)
	lw	$2, 4($1)
	set	$3, 3
	bne	$2, $3, beq_else.10375
	setclv	$f1, l.7946
	sub.s	$f0, $f0, $f1
	j	beq_cont.10376
beq_else.10375:
beq_cont.10376:
	lwc	$f1, 28($29)
	swc	$f0, 32($29)
	mov.s	$f0, $f1
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 32($29)
	lwc	$f2, 4($29)
	mul.s	$f1, $f2, $f1
	sub.s	$f0, $f0, $f1
	swc	$f0, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fispos
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.10377
	set	$1, 0
	jr $31
beq_else.10377:
	lw	$1, 8($29)
	lw	$1, 24($1)
	set	$2, 0
	bne	$1, $2, beq_else.10378
	set	$1, 0
	lwc	$f0, 36($29)
	sw	$1, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 28($29)
	sub.s	$f0, $f1, $f0
	set	$1, 4
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	lw	$1, 40($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.10379
beq_else.10378:
	set	$1, 0
	lwc	$f0, 36($29)
	sw	$1, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 28($29)
	add.s	$f0, $f1, $f0
	set	$1, 4
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	lw	$1, 44($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.10379:
	set	$1, 1
	jr $31
beq_else.10374:
	set	$1, 0
	jr $31
solver_fast.2677:
	lw	$4, 16($28)
	lw	$5, 12($28)
	lw	$6, 8($28)
	lw	$7, 4($28)
	sll	$8, $1, 2
	add	$27, $8, $7
	lw	$7, 0($27)
	set	$8, 0
	sll	$8, $8, 2
	add	$27, $8, $3
	lwc	$f0, 0($27)
	lw	$8, 20($7)
	set	$9, 0
	sll	$9, $9, 2
	add	$27, $9, $8
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	set	$8, 1
	sll	$8, $8, 2
	add	$27, $8, $3
	lwc	$f1, 0($27)
	lw	$8, 20($7)
	set	$9, 1
	sll	$9, $9, 2
	add	$27, $9, $8
	lwc	$f2, 0($27)
	sub.s	$f1, $f1, $f2
	set	$8, 2
	sll	$8, $8, 2
	add	$27, $8, $3
	lwc	$f2, 0($27)
	lw	$3, 20($7)
	set	$8, 2
	sll	$8, $8, 2
	add	$27, $8, $3
	lwc	$f3, 0($27)
	sub.s	$f2, $f2, $f3
	lw	$3, 4($2)
	sll	$1, $1, 2
	add	$27, $1, $3
	lw	$3, 0($27)
	lw	$1, 4($7)
	set	$8, 1
	bne	$1, $8, beq_else.10380
	lw	$2, 0($2)
	mov	$1, $7
	mov	$28, $6
	lw	$27, 0($28)
	jr	$27
beq_else.10380:
	set	$2, 2
	bne	$1, $2, beq_else.10381
	mov	$2, $3
	mov	$1, $7
	mov	$28, $4
	lw	$27, 0($28)
	jr	$27
beq_else.10381:
	mov	$2, $3
	mov	$1, $7
	mov	$28, $5
	lw	$27, 0($28)
	jr	$27
solver_surface_fast2.2681:
	lw	$1, 4($28)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f0, 0($27)
	sw	$1, 0($29)
	sw	$3, 4($29)
	sw	$2, 8($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	bne	$1, $2, beq_else.10382
	set	$1, 0
	jr $31
beq_else.10382:
	set	$1, 0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 8($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	set	$2, 3
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	jr $31
solver_second_fast2.2688:
	lw	$4, 4($28)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $2
	lwc	$f3, 0($27)
	sw	$4, 0($29)
	sw	$1, 4($29)
	swc	$f3, 8($29)
	sw	$3, 12($29)
	swc	$f2, 16($29)
	swc	$f1, 20($29)
	swc	$f0, 24($29)
	sw	$2, 28($29)
	mov.s	$f0, $f3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10383
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 28($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	lwc	$f1, 24($29)
	mul.s	$f0, $f0, $f1
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lwc	$f2, 20($29)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	set	$1, 3
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lwc	$f2, 16($29)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	set	$1, 3
	sll	$1, $1, 2
	lw	$3, 12($29)
	add	$27, $1, $3
	lwc	$f1, 0($27)
	swc	$f0, 32($29)
	swc	$f1, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 36($29)
	lwc	$f2, 8($29)
	mul.s	$f1, $f2, $f1
	sub.s	$f0, $f0, $f1
	swc	$f0, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fispos
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.10384
	set	$1, 0
	jr $31
beq_else.10384:
	lw	$1, 4($29)
	lw	$1, 24($1)
	set	$2, 0
	bne	$1, $2, beq_else.10385
	set	$1, 0
	lwc	$f0, 40($29)
	sw	$1, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 32($29)
	sub.s	$f0, $f1, $f0
	set	$1, 4
	sll	$1, $1, 2
	lw	$2, 28($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	lw	$1, 44($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.10386
beq_else.10385:
	set	$1, 0
	lwc	$f0, 40($29)
	sw	$1, 48($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 32($29)
	add.s	$f0, $f1, $f0
	set	$1, 4
	sll	$1, $1, 2
	lw	$2, 28($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	lw	$1, 48($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.10386:
	set	$1, 1
	jr $31
beq_else.10383:
	set	$1, 0
	jr $31
solver_fast2.2695:
	lw	$3, 16($28)
	lw	$4, 12($28)
	lw	$5, 8($28)
	lw	$6, 4($28)
	sll	$7, $1, 2
	add	$27, $7, $6
	lw	$6, 0($27)
	lw	$7, 40($6)
	set	$8, 0
	sll	$8, $8, 2
	add	$27, $8, $7
	lwc	$f0, 0($27)
	set	$8, 1
	sll	$8, $8, 2
	add	$27, $8, $7
	lwc	$f1, 0($27)
	set	$8, 2
	sll	$8, $8, 2
	add	$27, $8, $7
	lwc	$f2, 0($27)
	lw	$8, 4($2)
	sll	$1, $1, 2
	add	$27, $1, $8
	lw	$1, 0($27)
	lw	$8, 4($6)
	set	$9, 1
	bne	$8, $9, beq_else.10387
	lw	$2, 0($2)
	mov	$3, $1
	mov	$28, $5
	mov	$1, $6
	lw	$27, 0($28)
	jr	$27
beq_else.10387:
	set	$2, 2
	bne	$8, $2, beq_else.10388
	mov	$2, $1
	mov	$28, $3
	mov	$3, $7
	mov	$1, $6
	lw	$27, 0($28)
	jr	$27
beq_else.10388:
	mov	$3, $7
	mov	$2, $1
	mov	$28, $4
	mov	$1, $6
	lw	$27, 0($28)
	jr	$27
setup_rect_table.2698:
	set	$3, 6
	setclv	$f0, l.7945
	sw	$2, 0($29)
	sw	$1, 4($29)
	mov	$1, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	sw	$1, 8($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	bne	$1, $2, beq_else.10389
	set	$1, 0
	lw	$2, 0($29)
	lw	$3, 24($2)
	set	$4, 0
	sll	$4, $4, 2
	lw	$5, 4($29)
	add	$27, $4, $5
	lwc	$f0, 0($27)
	sw	$1, 12($29)
	sw	$3, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	lw	$3, 16($29)
	bne	$3, $2, beq_else.10391
	j	beq_cont.10392
beq_else.10391:
	set	$2, 0
	bne	$1, $2, beq_else.10393
	set	$1, 1
	j	beq_cont.10394
beq_else.10393:
	set	$1, 0
beq_cont.10394:
beq_cont.10392:
	lw	$2, 0($29)
	lw	$3, 16($2)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f0, 0($27)
	set	$3, 0
	bne	$1, $3, beq_else.10395
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	j	beq_cont.10396
beq_else.10395:
beq_cont.10396:
	lw	$1, 12($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	setclv	$f0, l.7946
	set	$3, 0
	sll	$3, $3, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	lwc	$f1, 0($27)
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.10390
beq_else.10389:
	set	$1, 1
	setclv	$f0, l.7945
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.10390:
	set	$1, 1
	sll	$1, $1, 2
	lw	$3, 4($29)
	add	$27, $1, $3
	lwc	$f0, 0($27)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.10397
	set	$1, 2
	lw	$2, 0($29)
	lw	$3, 24($2)
	set	$4, 1
	sll	$4, $4, 2
	lw	$5, 4($29)
	add	$27, $4, $5
	lwc	$f0, 0($27)
	sw	$1, 20($29)
	sw	$3, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	lw	$3, 24($29)
	bne	$3, $2, beq_else.10399
	j	beq_cont.10400
beq_else.10399:
	set	$2, 0
	bne	$1, $2, beq_else.10401
	set	$1, 1
	j	beq_cont.10402
beq_else.10401:
	set	$1, 0
beq_cont.10402:
beq_cont.10400:
	lw	$2, 0($29)
	lw	$3, 16($2)
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f0, 0($27)
	set	$3, 0
	bne	$1, $3, beq_else.10403
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fneg
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	j	beq_cont.10404
beq_else.10403:
beq_cont.10404:
	lw	$1, 20($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 3
	setclv	$f0, l.7946
	set	$3, 1
	sll	$3, $3, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	lwc	$f1, 0($27)
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.10398
beq_else.10397:
	set	$1, 3
	setclv	$f0, l.7945
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.10398:
	set	$1, 2
	sll	$1, $1, 2
	lw	$3, 4($29)
	add	$27, $1, $3
	lwc	$f0, 0($27)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10405
	set	$1, 4
	lw	$2, 0($29)
	lw	$3, 24($2)
	set	$4, 2
	sll	$4, $4, 2
	lw	$5, 4($29)
	add	$27, $4, $5
	lwc	$f0, 0($27)
	sw	$1, 28($29)
	sw	$3, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	lw	$3, 32($29)
	bne	$3, $2, beq_else.10407
	j	beq_cont.10408
beq_else.10407:
	set	$2, 0
	bne	$1, $2, beq_else.10409
	set	$1, 1
	j	beq_cont.10410
beq_else.10409:
	set	$1, 0
beq_cont.10410:
beq_cont.10408:
	lw	$2, 0($29)
	lw	$2, 16($2)
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f0, 0($27)
	set	$2, 0
	bne	$1, $2, beq_else.10411
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fneg
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	j	beq_cont.10412
beq_else.10411:
beq_cont.10412:
	lw	$1, 28($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 5
	setclv	$f0, l.7946
	set	$3, 2
	sll	$3, $3, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	lwc	$f1, 0($27)
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.10406
beq_else.10405:
	set	$1, 5
	setclv	$f0, l.7945
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.10406:
	mov	$1, $2
	jr $31
setup_surface_table.2701:
	set	$3, 4
	setclv	$f0, l.7945
	sw	$2, 0($29)
	sw	$1, 4($29)
	mov	$1, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	lw	$2, 0($29)
	lw	$4, 16($2)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f1, 0($27)
	lw	$4, 16($2)
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f1, 0($27)
	lw	$3, 16($2)
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	swc	$f0, 8($29)
	sw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fispos
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.10413
	set	$1, 0
	setclv	$f0, l.7945
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.10414
beq_else.10413:
	set	$1, 0
	setclv	$f0, l.7947
	lwc	$f1, 8($29)
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	lw	$3, 0($29)
	lw	$4, 16($3)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f0, 0($27)
	div.s	$f0, $f0, $f1
	sw	$1, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 16($29)
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	lw	$3, 0($29)
	lw	$4, 16($3)
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f0, 0($27)
	lwc	$f1, 8($29)
	div.s	$f0, $f0, $f1
	sw	$1, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fneg
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 20($29)
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 3
	lw	$3, 0($29)
	lw	$3, 16($3)
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f0, 0($27)
	lwc	$f1, 8($29)
	div.s	$f0, $f0, $f1
	sw	$1, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fneg
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 24($29)
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.10414:
	mov	$1, $2
	jr $31
setup_second_table.2704:
	set	$3, 5
	setclv	$f0, l.7945
	sw	$2, 0($29)
	sw	$1, 4($29)
	mov	$1, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f1, 0($27)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f2, 0($27)
	lw	$2, 0($29)
	sw	$1, 8($29)
	mov	$1, $2
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	quadratic.2635
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 0($29)
	lw	$3, 16($1)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	swc	$f0, 12($29)
	mov.s	$f0, $f1
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 0($29)
	lw	$3, 16($1)
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	swc	$f0, 16($29)
	mov.s	$f0, $f1
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 0($29)
	lw	$3, 16($1)
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	swc	$f0, 20($29)
	mov.s	$f0, $f1
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fneg
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 8($29)
	lwc	$f1, 12($29)
	add	$27, $1, $2
	swc	$f1, 0($27)
	lw	$1, 0($29)
	lw	$3, 12($1)
	set	$4, 0
	bne	$3, $4, beq_else.10415
	set	$1, 1
	sll	$1, $1, 2
	lwc	$f2, 16($29)
	add	$27, $1, $2
	swc	$f2, 0($27)
	set	$1, 2
	sll	$1, $1, 2
	lwc	$f2, 20($29)
	add	$27, $1, $2
	swc	$f2, 0($27)
	set	$1, 3
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.10416
beq_else.10415:
	set	$3, 1
	set	$4, 2
	sll	$4, $4, 2
	lw	$5, 4($29)
	add	$27, $4, $5
	lwc	$f2, 0($27)
	lw	$4, 36($1)
	set	$6, 1
	sll	$6, $6, 2
	add	$27, $6, $4
	lwc	$f3, 0($27)
	mul.s	$f2, $f2, $f3
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $5
	lwc	$f3, 0($27)
	lw	$4, 36($1)
	set	$6, 2
	sll	$6, $6, 2
	add	$27, $6, $4
	lwc	$f4, 0($27)
	mul.s	$f3, $f3, $f4
	add.s	$f2, $f2, $f3
	swc	$f0, 24($29)
	sw	$3, 28($29)
	mov.s	$f0, $f2
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 16($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 28($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	set	$3, 2
	sll	$3, $3, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	lwc	$f0, 0($27)
	lw	$3, 0($29)
	lw	$5, 36($3)
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $5
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f1, 0($27)
	lw	$5, 36($3)
	set	$6, 2
	sll	$6, $6, 2
	add	$27, $6, $5
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	sw	$1, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 20($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 32($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 3
	set	$3, 1
	sll	$3, $3, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	lwc	$f0, 0($27)
	lw	$3, 0($29)
	lw	$5, 36($3)
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $5
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f1, 0($27)
	lw	$3, 36($3)
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	add.s	$f0, $f0, $f1
	sw	$1, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 24($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 36($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.10416:
	lwc	$f0, 12($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.10417
	set	$1, 4
	setclv	$f0, l.7946
	lwc	$f1, 12($29)
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.10418
beq_else.10417:
beq_cont.10418:
	lw	$1, 8($29)
	jr $31
iter_setup_dirvec_constants.2707:
	lw	$3, 4($28)
	set	$4, 0
	slt	$27, $2, $4
	bne	$27, $0, ble_else.10419
	sll	$4, $2, 2
	add	$27, $4, $3
	lw	$3, 0($27)
	lw	$4, 4($1)
	lw	$5, 0($1)
	lw	$6, 4($3)
	set	$7, 1
	sw	$1, 0($29)
	sw	$28, 4($29)
	bne	$6, $7, beq_else.10420
	sw	$4, 8($29)
	sw	$2, 12($29)
	mov	$2, $3
	mov	$1, $5
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	setup_rect_table.2698
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 12($29)
	sll	$3, $2, 2
	lw	$4, 8($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	j	beq_cont.10421
beq_else.10420:
	set	$7, 2
	bne	$6, $7, beq_else.10422
	sw	$4, 8($29)
	sw	$2, 12($29)
	mov	$2, $3
	mov	$1, $5
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	setup_surface_table.2701
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 12($29)
	sll	$3, $2, 2
	lw	$4, 8($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	j	beq_cont.10423
beq_else.10422:
	sw	$4, 8($29)
	sw	$2, 12($29)
	mov	$2, $3
	mov	$1, $5
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	setup_second_table.2704
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 12($29)
	sll	$3, $2, 2
	lw	$4, 8($29)
	add	$27, $3, $4
	sw	$1, 0($27)
beq_cont.10423:
beq_cont.10421:
	set	$1, 1
	sub	$2, $2, $1
	lw	$1, 0($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10419:
	jr $31
setup_startp_constants.2712:
	lw	$3, 4($28)
	set	$4, 0
	slt	$27, $2, $4
	bne	$27, $0, ble_else.10425
	sll	$4, $2, 2
	add	$27, $4, $3
	lw	$3, 0($27)
	lw	$4, 40($3)
	lw	$5, 4($3)
	set	$6, 0
	set	$7, 0
	sll	$7, $7, 2
	add	$27, $7, $1
	lwc	$f0, 0($27)
	lw	$7, 20($3)
	set	$8, 0
	sll	$8, $8, 2
	add	$27, $8, $7
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	sll	$6, $6, 2
	add	$27, $6, $4
	swc	$f0, 0($27)
	set	$6, 1
	set	$7, 1
	sll	$7, $7, 2
	add	$27, $7, $1
	lwc	$f0, 0($27)
	lw	$7, 20($3)
	set	$8, 1
	sll	$8, $8, 2
	add	$27, $8, $7
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	sll	$6, $6, 2
	add	$27, $6, $4
	swc	$f0, 0($27)
	set	$6, 2
	set	$7, 2
	sll	$7, $7, 2
	add	$27, $7, $1
	lwc	$f0, 0($27)
	lw	$7, 20($3)
	set	$8, 2
	sll	$8, $8, 2
	add	$27, $8, $7
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	sll	$6, $6, 2
	add	$27, $6, $4
	swc	$f0, 0($27)
	set	$6, 2
	sw	$1, 0($29)
	sw	$28, 4($29)
	sw	$2, 8($29)
	bne	$5, $6, beq_else.10426
	set	$5, 3
	lw	$3, 16($3)
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $4
	lwc	$f0, 0($27)
	set	$6, 1
	sll	$6, $6, 2
	add	$27, $6, $4
	lwc	$f1, 0($27)
	set	$6, 2
	sll	$6, $6, 2
	add	$27, $6, $4
	lwc	$f2, 0($27)
	sw	$4, 12($29)
	sw	$5, 16($29)
	mov	$1, $3
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	veciprod2.2498
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 16($29)
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.10427
beq_else.10426:
	set	$6, 2
	slt	$27, $6, $5
	bne	$27, $0, ble_else.10428
	j	ble_cont.10429
ble_else.10428:
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $4
	lwc	$f0, 0($27)
	set	$6, 1
	sll	$6, $6, 2
	add	$27, $6, $4
	lwc	$f1, 0($27)
	set	$6, 2
	sll	$6, $6, 2
	add	$27, $6, $4
	lwc	$f2, 0($27)
	sw	$4, 12($29)
	sw	$5, 20($29)
	mov	$1, $3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	quadratic.2635
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$1, 3
	set	$2, 3
	lw	$3, 20($29)
	bne	$3, $2, beq_else.10430
	setclv	$f1, l.7946
	sub.s	$f0, $f0, $f1
	j	beq_cont.10431
beq_else.10430:
beq_cont.10431:
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
ble_cont.10429:
beq_cont.10427:
	set	$1, 1
	lw	$2, 8($29)
	sub	$2, $2, $1
	lw	$1, 0($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10425:
	jr $31
setup_startp.2715:
	lw	$2, 12($28)
	lw	$3, 8($28)
	lw	$4, 4($28)
	sw	$1, 0($29)
	sw	$3, 4($29)
	sw	$4, 8($29)
	mov	$27, $2
	mov	$2, $1
	mov	$1, $27
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	veccpy.2484
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	set	$2, 1
	sub	$2, $1, $2
	lw	$1, 0($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
is_rect_outside.2717:
	swc	$f2, 0($29)
	swc	$f1, 4($29)
	sw	$1, 8($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fabs
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$1, 8($29)
	lw	$2, 16($1)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fless
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	bne	$1, $2, beq_else.10433
	set	$1, 0
	j	beq_cont.10434
beq_else.10433:
	lwc	$f0, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fabs
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$1, 8($29)
	lw	$2, 16($1)
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fless
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	bne	$1, $2, beq_else.10435
	set	$1, 0
	j	beq_cont.10436
beq_else.10435:
	lwc	$f0, 0($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fabs
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$1, 8($29)
	lw	$2, 16($1)
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fless
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
beq_cont.10436:
beq_cont.10434:
	set	$2, 0
	bne	$1, $2, beq_else.10437
	lw	$1, 8($29)
	lw	$1, 24($1)
	set	$2, 0
	bne	$1, $2, beq_else.10438
	set	$1, 1
	jr $31
beq_else.10438:
	set	$1, 0
	jr $31
beq_else.10437:
	lw	$1, 8($29)
	lw	$1, 24($1)
	jr $31
is_plane_outside.2722:
	lw	$2, 16($1)
	sw	$1, 0($29)
	mov	$1, $2
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	veciprod2.2498
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	lw	$1, 0($29)
	lw	$1, 24($1)
	sw	$1, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	lw	$3, 4($29)
	bne	$3, $2, beq_else.10439
	j	beq_cont.10440
beq_else.10439:
	set	$2, 0
	bne	$1, $2, beq_else.10441
	set	$1, 1
	j	beq_cont.10442
beq_else.10441:
	set	$1, 0
beq_cont.10442:
beq_cont.10440:
	set	$2, 0
	bne	$1, $2, beq_else.10443
	set	$1, 1
	jr $31
beq_else.10443:
	set	$1, 0
	jr $31
is_second_outside.2727:
	sw	$1, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	quadratic.2635
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	lw	$1, 0($29)
	lw	$2, 4($1)
	set	$3, 3
	bne	$2, $3, beq_else.10444
	setclv	$f1, l.7946
	sub.s	$f0, $f0, $f1
	j	beq_cont.10445
beq_else.10444:
beq_cont.10445:
	lw	$1, 24($1)
	sw	$1, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	lw	$3, 4($29)
	bne	$3, $2, beq_else.10446
	j	beq_cont.10447
beq_else.10446:
	set	$2, 0
	bne	$1, $2, beq_else.10448
	set	$1, 1
	j	beq_cont.10449
beq_else.10448:
	set	$1, 0
beq_cont.10449:
beq_cont.10447:
	set	$2, 0
	bne	$1, $2, beq_else.10450
	set	$1, 1
	jr $31
beq_else.10450:
	set	$1, 0
	jr $31
is_outside.2732:
	lw	$2, 20($1)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f3, 0($27)
	sub.s	$f0, $f0, $f3
	lw	$2, 20($1)
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f3, 0($27)
	sub.s	$f1, $f1, $f3
	lw	$2, 20($1)
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f3, 0($27)
	sub.s	$f2, $f2, $f3
	lw	$2, 4($1)
	set	$3, 1
	bne	$2, $3, beq_else.10451
	j	is_rect_outside.2717
beq_else.10451:
	set	$3, 2
	bne	$2, $3, beq_else.10452
	j	is_plane_outside.2722
beq_else.10452:
	j	is_second_outside.2727
check_all_inside.2737:
	lw	$3, 4($28)
	sll	$4, $1, 2
	add	$27, $4, $2
	lw	$4, 0($27)
	set	$5, -1
	bne	$4, $5, beq_else.10453
	set	$1, 1
	jr $31
beq_else.10453:
	sll	$4, $4, 2
	add	$27, $4, $3
	lw	$3, 0($27)
	swc	$f2, 0($29)
	swc	$f1, 4($29)
	swc	$f0, 8($29)
	sw	$2, 12($29)
	sw	$28, 16($29)
	sw	$1, 20($29)
	mov	$1, $3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	is_outside.2732
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10454
	lw	$1, 20($29)
	addi	$1, $1, 1
	lwc	$f0, 8($29)
	lwc	$f1, 4($29)
	lwc	$f2, 0($29)
	lw	$2, 12($29)
	lw	$28, 16($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10454:
	set	$1, 0
	jr $31
shadow_check_and_group.2743:
	lw	$3, 28($28)
	lw	$4, 24($28)
	lw	$5, 20($28)
	lw	$6, 16($28)
	lw	$7, 12($28)
	lw	$8, 8($28)
	lw	$9, 4($28)
	sll	$10, $1, 2
	add	$27, $10, $2
	lw	$10, 0($27)
	set	$11, -1
	bne	$10, $11, beq_else.10455
	set	$1, 0
	jr $31
beq_else.10455:
	sw	$9, 0($29)
	sw	$8, 4($29)
	sw	$7, 8($29)
	sw	$2, 12($29)
	sw	$28, 16($29)
	sw	$1, 20($29)
	sw	$5, 24($29)
	sw	$10, 28($29)
	sw	$4, 32($29)
	mov	$2, $6
	mov	$1, $10
	mov	$28, $3
	mov	$3, $8
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 32($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	set	$2, 0
	swc	$f0, 36($29)
	bne	$1, $2, beq_else.10456
	set	$1, 0
	j	beq_cont.10457
beq_else.10456:
	setclv	$f1, l.8292
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fless
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
beq_cont.10457:
	set	$2, 0
	bne	$1, $2, beq_else.10458
	lw	$1, 28($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	lw	$1, 24($1)
	set	$2, 0
	bne	$1, $2, beq_else.10459
	set	$1, 0
	jr $31
beq_else.10459:
	lw	$1, 20($29)
	addi	$1, $1, 1
	lw	$2, 12($29)
	lw	$28, 16($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10458:
	setclv	$f0, l.8293
	lwc	$f1, 36($29)
	add.s	$f0, $f1, $f0
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	mul.s	$f1, $f1, $f0
	set	$1, 0
	sll	$1, $1, 2
	lw	$3, 4($29)
	add	$27, $1, $3
	lwc	$f2, 0($27)
	add.s	$f1, $f1, $f2
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f2, 0($27)
	mul.s	$f2, $f2, $f0
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $3
	lwc	$f3, 0($27)
	add.s	$f2, $f2, $f3
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f3, 0($27)
	mul.s	$f0, $f3, $f0
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $3
	lwc	$f3, 0($27)
	add.s	$f0, $f0, $f3
	set	$1, 0
	lw	$2, 12($29)
	lw	$28, 0($29)
	mov.s	$f31, $f2
	mov.s	$f2, $f0
	mov.s	$f0, $f1
	mov.s	$f1, $f31
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.10460
	lw	$1, 20($29)
	addi	$1, $1, 1
	lw	$2, 12($29)
	lw	$28, 16($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10460:
	set	$1, 1
	jr $31
shadow_check_one_or_group.2746:
	lw	$3, 8($28)
	lw	$4, 4($28)
	sll	$5, $1, 2
	add	$27, $5, $2
	lw	$5, 0($27)
	set	$6, -1
	bne	$5, $6, beq_else.10461
	set	$1, 0
	jr $31
beq_else.10461:
	sll	$5, $5, 2
	add	$27, $5, $4
	lw	$4, 0($27)
	set	$5, 0
	sw	$2, 0($29)
	sw	$28, 4($29)
	sw	$1, 8($29)
	mov	$2, $4
	mov	$1, $5
	mov	$28, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -16
	lw	$31, 12($29)
	set	$2, 0
	bne	$1, $2, beq_else.10462
	lw	$1, 8($29)
	addi	$1, $1, 1
	lw	$2, 0($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10462:
	set	$1, 1
	jr $31
shadow_check_one_or_matrix.2749:
	lw	$3, 20($28)
	lw	$4, 16($28)
	lw	$5, 12($28)
	lw	$6, 8($28)
	lw	$7, 4($28)
	sll	$8, $1, 2
	add	$27, $8, $2
	lw	$8, 0($27)
	set	$9, 0
	sll	$9, $9, 2
	add	$27, $9, $8
	lw	$9, 0($27)
	set	$10, -1
	bne	$9, $10, beq_else.10463
	set	$1, 0
	jr $31
beq_else.10463:
	set	$10, 99
	sw	$8, 0($29)
	sw	$5, 4($29)
	sw	$2, 8($29)
	sw	$28, 12($29)
	sw	$1, 16($29)
	bne	$9, $10, beq_else.10464
	set	$1, 1
	j	beq_cont.10465
beq_else.10464:
	sw	$4, 20($29)
	mov	$2, $6
	mov	$1, $9
	mov	$28, $3
	mov	$3, $7
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10466
	set	$1, 0
	j	beq_cont.10467
beq_else.10466:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	setclv	$f1, l.8306
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fless
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10468
	set	$1, 0
	j	beq_cont.10469
beq_else.10468:
	set	$1, 1
	lw	$2, 0($29)
	lw	$28, 4($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10470
	set	$1, 0
	j	beq_cont.10471
beq_else.10470:
	set	$1, 1
beq_cont.10471:
beq_cont.10469:
beq_cont.10467:
beq_cont.10465:
	set	$2, 0
	bne	$1, $2, beq_else.10472
	lw	$1, 16($29)
	addi	$1, $1, 1
	lw	$2, 8($29)
	lw	$28, 12($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10472:
	set	$1, 1
	lw	$2, 0($29)
	lw	$28, 4($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.10473
	lw	$1, 16($29)
	addi	$1, $1, 1
	lw	$2, 8($29)
	lw	$28, 12($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10473:
	set	$1, 1
	jr $31
solve_each_element.2752:
	lw	$4, 36($28)
	lw	$5, 32($28)
	lw	$6, 28($28)
	lw	$7, 24($28)
	lw	$8, 20($28)
	lw	$9, 16($28)
	lw	$10, 12($28)
	lw	$11, 8($28)
	lw	$12, 4($28)
	sll	$13, $1, 2
	add	$27, $13, $2
	lw	$13, 0($27)
	set	$14, -1
	bne	$13, $14, beq_else.10474
	jr $31
beq_else.10474:
	sw	$9, 0($29)
	sw	$11, 4($29)
	sw	$10, 8($29)
	sw	$12, 12($29)
	sw	$5, 16($29)
	sw	$4, 20($29)
	sw	$6, 24($29)
	sw	$3, 28($29)
	sw	$2, 32($29)
	sw	$28, 36($29)
	sw	$1, 40($29)
	sw	$8, 44($29)
	sw	$13, 48($29)
	mov	$2, $3
	mov	$1, $13
	mov	$28, $7
	mov	$3, $5
	sw	$31, 52($29)
	addi	$29, $29, 56
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -56
	lw	$31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.10476
	lw	$1, 48($29)
	sll	$1, $1, 2
	lw	$2, 44($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	lw	$1, 24($1)
	set	$2, 0
	bne	$1, $2, beq_else.10477
	jr $31
beq_else.10477:
	lw	$1, 40($29)
	addi	$1, $1, 1
	lw	$2, 32($29)
	lw	$3, 28($29)
	lw	$28, 36($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10476:
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 24($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	setclv	$f0, l.7945
	sw	$1, 52($29)
	swc	$f1, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fless
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.10479
	j	beq_cont.10480
beq_else.10479:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lwc	$f0, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fless
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.10481
	j	beq_cont.10482
beq_else.10481:
	setclv	$f0, l.8293
	lwc	$f1, 56($29)
	add.s	$f0, $f1, $f0
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 28($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	mul.s	$f1, $f1, $f0
	set	$1, 0
	sll	$1, $1, 2
	lw	$3, 16($29)
	add	$27, $1, $3
	lwc	$f2, 0($27)
	add.s	$f1, $f1, $f2
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f2, 0($27)
	mul.s	$f2, $f2, $f0
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $3
	lwc	$f3, 0($27)
	add.s	$f2, $f2, $f3
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f3, 0($27)
	mul.s	$f3, $f3, $f0
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $3
	lwc	$f4, 0($27)
	add.s	$f3, $f3, $f4
	set	$1, 0
	lw	$3, 32($29)
	lw	$28, 12($29)
	swc	$f3, 60($29)
	swc	$f2, 64($29)
	swc	$f1, 68($29)
	swc	$f0, 72($29)
	mov	$2, $3
	mov.s	$f0, $f1
	mov.s	$f1, $f2
	mov.s	$f2, $f3
	sw	$31, 76($29)
	addi	$29, $29, 80
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -80
	lw	$31, 76($29)
	set	$2, 0
	bne	$1, $2, beq_else.10483
	j	beq_cont.10484
beq_else.10483:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	lwc	$f0, 72($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	lwc	$f0, 68($29)
	lwc	$f1, 64($29)
	lwc	$f2, 60($29)
	lw	$1, 8($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	vecset.2474
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 4($29)
	lw	$3, 48($29)
	add	$27, $1, $2
	sw	$3, 0($27)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lw	$3, 52($29)
	add	$27, $1, $2
	sw	$3, 0($27)
beq_cont.10484:
beq_cont.10482:
beq_cont.10480:
	lw	$1, 40($29)
	addi	$1, $1, 1
	lw	$2, 32($29)
	lw	$3, 28($29)
	lw	$28, 36($29)
	lw	$27, 0($28)
	jr	$27
solve_one_or_network.2756:
	lw	$4, 8($28)
	lw	$5, 4($28)
	sll	$6, $1, 2
	add	$27, $6, $2
	lw	$6, 0($27)
	set	$7, -1
	bne	$6, $7, beq_else.10485
	jr $31
beq_else.10485:
	sll	$6, $6, 2
	add	$27, $6, $5
	lw	$5, 0($27)
	set	$6, 0
	sw	$3, 0($29)
	sw	$2, 4($29)
	sw	$28, 8($29)
	sw	$1, 12($29)
	mov	$2, $5
	mov	$1, $6
	mov	$28, $4
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	lw	$1, 12($29)
	addi	$1, $1, 1
	lw	$2, 4($29)
	lw	$3, 0($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
trace_or_matrix.2760:
	lw	$4, 20($28)
	lw	$5, 16($28)
	lw	$6, 12($28)
	lw	$7, 8($28)
	lw	$8, 4($28)
	sll	$9, $1, 2
	add	$27, $9, $2
	lw	$9, 0($27)
	set	$10, 0
	sll	$10, $10, 2
	add	$27, $10, $9
	lw	$10, 0($27)
	set	$11, -1
	bne	$10, $11, beq_else.10487
	jr $31
beq_else.10487:
	set	$11, 99
	sw	$3, 0($29)
	sw	$2, 4($29)
	sw	$28, 8($29)
	sw	$1, 12($29)
	bne	$10, $11, beq_else.10489
	set	$4, 1
	mov	$2, $9
	mov	$1, $4
	mov	$28, $8
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	j	beq_cont.10490
beq_else.10489:
	sw	$9, 16($29)
	sw	$8, 20($29)
	sw	$4, 24($29)
	sw	$6, 28($29)
	mov	$2, $3
	mov	$1, $10
	mov	$28, $7
	mov	$3, $5
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10491
	j	beq_cont.10492
beq_else.10491:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 28($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fless
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10493
	j	beq_cont.10494
beq_else.10493:
	set	$1, 1
	lw	$2, 16($29)
	lw	$3, 0($29)
	lw	$28, 20($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
beq_cont.10494:
beq_cont.10492:
beq_cont.10490:
	lw	$1, 12($29)
	addi	$1, $1, 1
	lw	$2, 4($29)
	lw	$3, 0($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
judge_intersection.2764:
	lw	$2, 12($28)
	lw	$3, 8($28)
	lw	$4, 4($28)
	set	$5, 0
	setclv	$f0, l.8326
	sll	$5, $5, 2
	add	$27, $5, $3
	swc	$f0, 0($27)
	set	$5, 0
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $4
	lw	$4, 0($27)
	sw	$3, 0($29)
	mov	$3, $1
	mov	$28, $2
	mov	$2, $4
	mov	$1, $5
	sw	$31, 4($29)
	addi	$29, $29, 8
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -8
	lw	$31, 4($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	setclv	$f0, l.8306
	swc	$f1, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fless
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	bne	$1, $2, beq_else.10495
	set	$1, 0
	jr $31
beq_else.10495:
	setclv	$f1, l.8330
	lwc	$f0, 4($29)
	j	min_caml_fless
solve_each_element_fast.2766:
	lw	$4, 36($28)
	lw	$5, 32($28)
	lw	$6, 28($28)
	lw	$7, 24($28)
	lw	$8, 20($28)
	lw	$9, 16($28)
	lw	$10, 12($28)
	lw	$11, 8($28)
	lw	$12, 4($28)
	lw	$13, 0($3)
	sll	$14, $1, 2
	add	$27, $14, $2
	lw	$14, 0($27)
	set	$15, -1
	bne	$14, $15, beq_else.10496
	jr $31
beq_else.10496:
	sw	$9, 0($29)
	sw	$11, 4($29)
	sw	$10, 8($29)
	sw	$12, 12($29)
	sw	$5, 16($29)
	sw	$13, 20($29)
	sw	$4, 24($29)
	sw	$7, 28($29)
	sw	$3, 32($29)
	sw	$2, 36($29)
	sw	$28, 40($29)
	sw	$1, 44($29)
	sw	$8, 48($29)
	sw	$14, 52($29)
	mov	$2, $3
	mov	$1, $14
	mov	$28, $6
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.10498
	lw	$1, 52($29)
	sll	$1, $1, 2
	lw	$2, 48($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	lw	$1, 24($1)
	set	$2, 0
	bne	$1, $2, beq_else.10499
	jr $31
beq_else.10499:
	lw	$1, 44($29)
	addi	$1, $1, 1
	lw	$2, 36($29)
	lw	$3, 32($29)
	lw	$28, 40($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10498:
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 28($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	setclv	$f0, l.7945
	sw	$1, 56($29)
	swc	$f1, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fless
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	set	$2, 0
	bne	$1, $2, beq_else.10501
	j	beq_cont.10502
beq_else.10501:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lwc	$f0, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fless
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	set	$2, 0
	bne	$1, $2, beq_else.10503
	j	beq_cont.10504
beq_else.10503:
	setclv	$f0, l.8293
	lwc	$f1, 60($29)
	add.s	$f0, $f1, $f0
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	mul.s	$f1, $f1, $f0
	set	$1, 0
	sll	$1, $1, 2
	lw	$3, 16($29)
	add	$27, $1, $3
	lwc	$f2, 0($27)
	add.s	$f1, $f1, $f2
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f2, 0($27)
	mul.s	$f2, $f2, $f0
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $3
	lwc	$f3, 0($27)
	add.s	$f2, $f2, $f3
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f3, 0($27)
	mul.s	$f3, $f3, $f0
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $3
	lwc	$f4, 0($27)
	add.s	$f3, $f3, $f4
	set	$1, 0
	lw	$2, 36($29)
	lw	$28, 12($29)
	swc	$f3, 64($29)
	swc	$f2, 68($29)
	swc	$f1, 72($29)
	swc	$f0, 76($29)
	mov.s	$f0, $f1
	mov.s	$f1, $f2
	mov.s	$f2, $f3
	sw	$31, 84($29)
	addi	$29, $29, 88
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -88
	lw	$31, 84($29)
	set	$2, 0
	bne	$1, $2, beq_else.10505
	j	beq_cont.10506
beq_else.10505:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 24($29)
	lwc	$f0, 76($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	lwc	$f0, 72($29)
	lwc	$f1, 68($29)
	lwc	$f2, 64($29)
	lw	$1, 8($29)
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	vecset.2474
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 4($29)
	lw	$3, 52($29)
	add	$27, $1, $2
	sw	$3, 0($27)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lw	$3, 56($29)
	add	$27, $1, $2
	sw	$3, 0($27)
beq_cont.10506:
beq_cont.10504:
beq_cont.10502:
	lw	$1, 44($29)
	addi	$1, $1, 1
	lw	$2, 36($29)
	lw	$3, 32($29)
	lw	$28, 40($29)
	lw	$27, 0($28)
	jr	$27
solve_one_or_network_fast.2770:
	lw	$4, 8($28)
	lw	$5, 4($28)
	sll	$6, $1, 2
	add	$27, $6, $2
	lw	$6, 0($27)
	set	$7, -1
	bne	$6, $7, beq_else.10507
	jr $31
beq_else.10507:
	sll	$6, $6, 2
	add	$27, $6, $5
	lw	$5, 0($27)
	set	$6, 0
	sw	$3, 0($29)
	sw	$2, 4($29)
	sw	$28, 8($29)
	sw	$1, 12($29)
	mov	$2, $5
	mov	$1, $6
	mov	$28, $4
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	lw	$1, 12($29)
	addi	$1, $1, 1
	lw	$2, 4($29)
	lw	$3, 0($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
trace_or_matrix_fast.2774:
	lw	$4, 16($28)
	lw	$5, 12($28)
	lw	$6, 8($28)
	lw	$7, 4($28)
	sll	$8, $1, 2
	add	$27, $8, $2
	lw	$8, 0($27)
	set	$9, 0
	sll	$9, $9, 2
	add	$27, $9, $8
	lw	$9, 0($27)
	set	$10, -1
	bne	$9, $10, beq_else.10509
	jr $31
beq_else.10509:
	set	$10, 99
	sw	$3, 0($29)
	sw	$2, 4($29)
	sw	$28, 8($29)
	sw	$1, 12($29)
	bne	$9, $10, beq_else.10511
	set	$4, 1
	mov	$2, $8
	mov	$1, $4
	mov	$28, $7
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	j	beq_cont.10512
beq_else.10511:
	sw	$8, 16($29)
	sw	$7, 20($29)
	sw	$4, 24($29)
	sw	$6, 28($29)
	mov	$2, $3
	mov	$1, $9
	mov	$28, $5
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10513
	j	beq_cont.10514
beq_else.10513:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 28($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fless
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10515
	j	beq_cont.10516
beq_else.10515:
	set	$1, 1
	lw	$2, 16($29)
	lw	$3, 0($29)
	lw	$28, 20($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
beq_cont.10516:
beq_cont.10514:
beq_cont.10512:
	lw	$1, 12($29)
	addi	$1, $1, 1
	lw	$2, 4($29)
	lw	$3, 0($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
judge_intersection_fast.2778:
	lw	$2, 12($28)
	lw	$3, 8($28)
	lw	$4, 4($28)
	set	$5, 0
	setclv	$f0, l.8326
	sll	$5, $5, 2
	add	$27, $5, $3
	swc	$f0, 0($27)
	set	$5, 0
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $4
	lw	$4, 0($27)
	sw	$3, 0($29)
	mov	$3, $1
	mov	$28, $2
	mov	$2, $4
	mov	$1, $5
	sw	$31, 4($29)
	addi	$29, $29, 8
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -8
	lw	$31, 4($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	setclv	$f0, l.8306
	swc	$f1, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fless
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	bne	$1, $2, beq_else.10517
	set	$1, 0
	jr $31
beq_else.10517:
	setclv	$f1, l.8330
	lwc	$f0, 4($29)
	j	min_caml_fless
get_nvector_rect.2780:
	lw	$2, 8($28)
	lw	$3, 4($28)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $3
	lw	$3, 0($27)
	setclv	$f0, l.7945
	sw	$2, 0($29)
	sw	$1, 4($29)
	sw	$3, 8($29)
	mov	$1, $2
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	vecfill.2479
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$1, 1
	lw	$2, 8($29)
	sub	$1, $2, $1
	set	$3, 1
	sub	$2, $2, $3
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	sw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	sgn.2466
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 12($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	jr $31
get_nvector_plane.2782:
	lw	$2, 4($28)
	set	$3, 0
	lw	$4, 16($1)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f0, 0($27)
	sw	$1, 0($29)
	sw	$2, 4($29)
	sw	$3, 8($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fneg
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$1, 8($29)
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	lw	$3, 0($29)
	lw	$4, 16($3)
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f0, 0($27)
	sw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 12($29)
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	lw	$3, 0($29)
	lw	$3, 16($3)
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f0, 0($27)
	sw	$1, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 16($29)
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	jr $31
get_nvector_second.2784:
	lw	$2, 8($28)
	lw	$3, 4($28)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f0, 0($27)
	lw	$4, 20($1)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f1, 0($27)
	lw	$4, 20($1)
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f2, 0($27)
	sub.s	$f1, $f1, $f2
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f2, 0($27)
	lw	$3, 20($1)
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f3, 0($27)
	sub.s	$f2, $f2, $f3
	lw	$3, 16($1)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f3, 0($27)
	mul.s	$f3, $f0, $f3
	lw	$3, 16($1)
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f4, 0($27)
	mul.s	$f4, $f1, $f4
	lw	$3, 16($1)
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f5, 0($27)
	mul.s	$f5, $f2, $f5
	lw	$3, 12($1)
	set	$4, 0
	sw	$1, 0($29)
	bne	$3, $4, beq_else.10520
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	swc	$f3, 0($27)
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $2
	swc	$f4, 0($27)
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $2
	swc	$f5, 0($27)
	j	beq_cont.10521
beq_else.10520:
	set	$3, 0
	lw	$4, 36($1)
	set	$5, 2
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f6, 0($27)
	mul.s	$f6, $f1, $f6
	lw	$4, 36($1)
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f7, 0($27)
	mul.s	$f7, $f2, $f7
	add.s	$f6, $f6, $f7
	swc	$f5, 4($29)
	swc	$f1, 8($29)
	swc	$f4, 12($29)
	swc	$f2, 16($29)
	swc	$f0, 20($29)
	sw	$2, 24($29)
	sw	$3, 28($29)
	swc	$f3, 32($29)
	mov.s	$f0, $f6
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 32($29)
	add.s	$f0, $f1, $f0
	lw	$1, 28($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	lw	$3, 0($29)
	lw	$4, 36($3)
	set	$5, 2
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f0, 0($27)
	lwc	$f1, 20($29)
	mul.s	$f0, $f1, $f0
	lw	$4, 36($3)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f2, 0($27)
	lwc	$f3, 16($29)
	mul.s	$f2, $f3, $f2
	add.s	$f0, $f0, $f2
	sw	$1, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 12($29)
	add.s	$f0, $f1, $f0
	lw	$1, 36($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	lw	$3, 0($29)
	lw	$4, 36($3)
	set	$5, 1
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f0, 0($27)
	lwc	$f1, 20($29)
	mul.s	$f0, $f1, $f0
	lw	$4, 36($3)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f1, 0($27)
	lwc	$f2, 8($29)
	mul.s	$f1, $f2, $f1
	add.s	$f0, $f0, $f1
	sw	$1, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 4($29)
	add.s	$f0, $f1, $f0
	lw	$1, 40($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.10521:
	lw	$1, 0($29)
	lw	$1, 24($1)
	mov	$27, $2
	mov	$2, $1
	mov	$1, $27
	j	vecunit_sgn.2492
utexture.2789:
	lw	$3, 4($28)
	lw	$4, 0($1)
	set	$5, 0
	lw	$6, 32($1)
	set	$7, 0
	sll	$7, $7, 2
	add	$27, $7, $6
	lwc	$f0, 0($27)
	sll	$5, $5, 2
	add	$27, $5, $3
	swc	$f0, 0($27)
	set	$5, 1
	lw	$6, 32($1)
	set	$7, 1
	sll	$7, $7, 2
	add	$27, $7, $6
	lwc	$f0, 0($27)
	sll	$5, $5, 2
	add	$27, $5, $3
	swc	$f0, 0($27)
	set	$5, 2
	lw	$6, 32($1)
	set	$7, 2
	sll	$7, $7, 2
	add	$27, $7, $6
	lwc	$f0, 0($27)
	sll	$5, $5, 2
	add	$27, $5, $3
	swc	$f0, 0($27)
	set	$5, 1
	bne	$4, $5, beq_else.10522
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f0, 0($27)
	lw	$4, 20($1)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	setclv	$f1, l.8420
	mul.s	$f1, $f0, $f1
	sw	$3, 0($29)
	sw	$1, 4($29)
	sw	$2, 8($29)
	swc	$f0, 12($29)
	mov.s	$f0, $f1
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_floor
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	setclv	$f1, l.8421
	mul.s	$f0, $f0, $f1
	lwc	$f1, 12($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.8411
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fless
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 2
	sll	$2, $2, 2
	lw	$3, 8($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	lw	$2, 4($29)
	lw	$2, 20($2)
	set	$3, 2
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	setclv	$f1, l.8420
	mul.s	$f1, $f0, $f1
	sw	$1, 16($29)
	swc	$f0, 20($29)
	mov.s	$f0, $f1
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_floor
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	setclv	$f1, l.8421
	mul.s	$f0, $f0, $f1
	lwc	$f1, 20($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.8411
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fless
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 1
	set	$3, 0
	lw	$4, 16($29)
	bne	$4, $3, beq_else.10523
	set	$3, 0
	bne	$1, $3, beq_else.10525
	setclv	$f0, l.8404
	j	beq_cont.10526
beq_else.10525:
	setclv	$f0, l.7945
beq_cont.10526:
	j	beq_cont.10524
beq_else.10523:
	set	$3, 0
	bne	$1, $3, beq_else.10527
	setclv	$f0, l.7945
	j	beq_cont.10528
beq_else.10527:
	setclv	$f0, l.8404
beq_cont.10528:
beq_cont.10524:
	sll	$1, $2, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	jr $31
beq_else.10522:
	set	$5, 2
	bne	$4, $5, beq_else.10530
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f0, 0($27)
	setclv	$f1, l.8415
	mul.s	$f0, $f0, $f1
	sw	$3, 0($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_sin
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$1, 0
	setclv	$f1, l.8404
	mul.s	$f1, $f1, $f0
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f1, 0($27)
	set	$1, 1
	setclv	$f1, l.8404
	setclv	$f2, l.7946
	sub.s	$f0, $f2, $f0
	mul.s	$f0, $f1, $f0
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	jr $31
beq_else.10530:
	set	$5, 3
	bne	$4, $5, beq_else.10532
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f0, 0($27)
	lw	$4, 20($1)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f1, 0($27)
	lw	$1, 20($1)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f2, 0($27)
	sub.s	$f1, $f1, $f2
	sw	$3, 0($29)
	swc	$f1, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 24($29)
	swc	$f0, 28($29)
	mov.s	$f0, $f1
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 28($29)
	add.s	$f0, $f1, $f0
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	setclv	$f1, l.8411
	div.s	$f0, $f0, $f1
	swc	$f0, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_floor
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 32($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.8398
	mul.s	$f0, $f0, $f1
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_cos
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$1, 1
	setclv	$f1, l.8404
	mul.s	$f1, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f1, 0($27)
	set	$1, 2
	setclv	$f1, l.7946
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.8404
	mul.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	jr $31
beq_else.10532:
	set	$5, 4
	bne	$4, $5, beq_else.10534
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f0, 0($27)
	lw	$4, 20($1)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	lw	$4, 16($1)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f1, 0($27)
	sw	$3, 0($29)
	sw	$1, 4($29)
	sw	$2, 8($29)
	swc	$f0, 36($29)
	mov.s	$f0, $f1
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 36($29)
	mul.s	$f0, $f1, $f0
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 4($29)
	lw	$3, 20($1)
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f2, 0($27)
	sub.s	$f1, $f1, $f2
	lw	$3, 16($1)
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f2, 0($27)
	swc	$f0, 40($29)
	swc	$f1, 44($29)
	mov.s	$f0, $f2
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 44($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 40($29)
	swc	$f0, 48($29)
	mov.s	$f0, $f1
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 48($29)
	swc	$f0, 52($29)
	mov.s	$f0, $f1
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 52($29)
	add.s	$f0, $f1, $f0
	lwc	$f1, 40($29)
	swc	$f0, 56($29)
	mov.s	$f0, $f1
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fabs
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	setclv	$f1, l.8395
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fless
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.10535
	lwc	$f0, 40($29)
	lwc	$f1, 48($29)
	div.s	$f0, $f1, $f0
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fabs
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_atan
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	setclv	$f1, l.8397
	mul.s	$f0, $f0, $f1
	setclv	$f1, l.8398
	div.s	$f0, $f0, $f1
	j	beq_cont.10536
beq_else.10535:
	setclv	$f0, l.8396
beq_cont.10536:
	swc	$f0, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_floor
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 60($29)
	sub.s	$f0, $f1, $f0
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 4($29)
	lw	$2, 20($1)
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f2, 0($27)
	sub.s	$f1, $f1, $f2
	lw	$1, 16($1)
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f2, 0($27)
	swc	$f0, 64($29)
	swc	$f1, 68($29)
	mov.s	$f0, $f2
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 68($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 56($29)
	swc	$f0, 72($29)
	mov.s	$f0, $f1
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_fabs
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	setclv	$f1, l.8395
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_fless
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	set	$2, 0
	bne	$1, $2, beq_else.10537
	lwc	$f0, 56($29)
	lwc	$f1, 72($29)
	div.s	$f0, $f1, $f0
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_fabs
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_atan
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	setclv	$f1, l.8397
	mul.s	$f0, $f0, $f1
	setclv	$f1, l.8398
	div.s	$f0, $f0, $f1
	j	beq_cont.10538
beq_else.10537:
	setclv	$f0, l.8396
beq_cont.10538:
	swc	$f0, 76($29)
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	min_caml_floor
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	lwc	$f1, 76($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.8402
	setclv	$f2, l.8403
	lwc	$f3, 64($29)
	sub.s	$f2, $f2, $f3
	swc	$f0, 80($29)
	swc	$f1, 84($29)
	mov.s	$f0, $f2
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	lwc	$f1, 84($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.8403
	lwc	$f2, 80($29)
	sub.s	$f1, $f1, $f2
	swc	$f0, 88($29)
	mov.s	$f0, $f1
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	lwc	$f1, 88($29)
	sub.s	$f0, $f1, $f0
	swc	$f0, 92($29)
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	set	$2, 0
	bne	$1, $2, beq_else.10539
	lwc	$f0, 92($29)
	j	beq_cont.10540
beq_else.10539:
	setclv	$f0, l.7945
beq_cont.10540:
	set	$1, 2
	setclv	$f1, l.8404
	mul.s	$f0, $f1, $f0
	setclv	$f1, l.8405
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	jr $31
beq_else.10534:
	jr $31
add_light.2792:
	lw	$1, 8($28)
	lw	$2, 4($28)
	swc	$f2, 0($29)
	swc	$f1, 4($29)
	swc	$f0, 8($29)
	sw	$1, 12($29)
	sw	$2, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fispos
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.10543
	j	beq_cont.10544
beq_else.10543:
	lwc	$f0, 8($29)
	lw	$1, 16($29)
	lw	$2, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	vecaccum.2503
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
beq_cont.10544:
	lwc	$f0, 4($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fispos
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.10545
	jr $31
beq_else.10545:
	lwc	$f0, 4($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f1, 0($29)
	mul.s	$f0, $f0, $f1
	set	$1, 0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 16($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	add.s	$f1, $f1, $f0
	sll	$1, $1, 2
	add	$27, $1, $3
	swc	$f1, 0($27)
	set	$1, 1
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f1, 0($27)
	add.s	$f1, $f1, $f0
	sll	$1, $1, 2
	add	$27, $1, $3
	swc	$f1, 0($27)
	set	$1, 2
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f1, 0($27)
	add.s	$f0, $f1, $f0
	sll	$1, $1, 2
	add	$27, $1, $3
	swc	$f0, 0($27)
	jr $31
trace_reflections.2796:
	lw	$3, 32($28)
	lw	$4, 28($28)
	lw	$5, 24($28)
	lw	$6, 20($28)
	lw	$7, 16($28)
	lw	$8, 12($28)
	lw	$9, 8($28)
	lw	$10, 4($28)
	set	$11, 0
	slt	$27, $1, $11
	bne	$27, $0, ble_else.10548
	sll	$11, $1, 2
	add	$27, $11, $4
	lw	$4, 0($27)
	lw	$11, 4($4)
	sw	$28, 0($29)
	sw	$1, 4($29)
	swc	$f1, 8($29)
	sw	$10, 12($29)
	sw	$2, 16($29)
	swc	$f0, 20($29)
	sw	$6, 24($29)
	sw	$11, 28($29)
	sw	$3, 32($29)
	sw	$5, 36($29)
	sw	$4, 40($29)
	sw	$8, 44($29)
	sw	$9, 48($29)
	mov	$1, $11
	mov	$28, $7
	sw	$31, 52($29)
	addi	$29, $29, 56
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -56
	lw	$31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.10549
	j	beq_cont.10550
beq_else.10549:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 48($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sll	$1, $1, 2
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 44($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	add	$1, $1, $2
	lw	$2, 40($29)
	lw	$3, 0($2)
	bne	$1, $3, beq_else.10551
	set	$1, 0
	set	$3, 0
	sll	$3, $3, 2
	lw	$4, 36($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	lw	$28, 32($29)
	mov	$2, $3
	sw	$31, 52($29)
	addi	$29, $29, 56
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -56
	lw	$31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.10553
	lw	$1, 28($29)
	lw	$2, 0($1)
	lw	$3, 24($29)
	mov	$1, $3
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	veciprod.2495
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 40($29)
	lwc	$f1, 8($1)
	lwc	$f2, 20($29)
	mul.s	$f3, $f1, $f2
	mul.s	$f0, $f3, $f0
	lw	$1, 28($29)
	lw	$2, 0($1)
	lw	$1, 16($29)
	swc	$f0, 52($29)
	swc	$f1, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	veciprod.2495
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 56($29)
	mul.s	$f1, $f1, $f0
	lwc	$f0, 52($29)
	lwc	$f2, 8($29)
	lw	$28, 12($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	j	beq_cont.10554
beq_else.10553:
beq_cont.10554:
	j	beq_cont.10552
beq_else.10551:
beq_cont.10552:
beq_cont.10550:
	set	$1, 1
	lw	$2, 4($29)
	sub	$1, $2, $1
	lwc	$f0, 20($29)
	lwc	$f1, 8($29)
	lw	$2, 16($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10548:
	jr $31
trace_ray.2801:
	lw	$4, 88($28)
	lw	$5, 84($28)
	lw	$6, 80($28)
	lw	$7, 76($28)
	lw	$8, 72($28)
	lw	$9, 68($28)
	lw	$10, 64($28)
	lw	$11, 60($28)
	lw	$12, 56($28)
	lw	$13, 52($28)
	lw	$14, 48($28)
	lw	$15, 44($28)
	lw	$16, 40($28)
	lw	$17, 36($28)
	lw	$18, 32($28)
	lw	$19, 28($28)
	lw	$20, 24($28)
	lw	$21, 20($28)
	lw	$22, 16($28)
	lw	$23, 12($28)
	lw	$24, 8($28)
	lw	$25, 4($28)
	set	$26, 4
	slt	$27, $26, $1
	bne	$27, $0, ble_else.10556
	lw	$26, 8($3)
	sw	$28, 0($29)
	swc	$f1, 4($29)
	sw	$6, 8($29)
	sw	$5, 12($29)
	sw	$15, 16($29)
	sw	$10, 20($29)
	sw	$25, 24($29)
	sw	$9, 28($29)
	sw	$12, 32($29)
	sw	$14, 36($29)
	sw	$7, 40($29)
	sw	$3, 44($29)
	sw	$18, 48($29)
	sw	$4, 52($29)
	sw	$19, 56($29)
	sw	$8, 60($29)
	sw	$21, 64($29)
	sw	$23, 68($29)
	sw	$22, 72($29)
	sw	$13, 76($29)
	sw	$20, 80($29)
	sw	$11, 84($29)
	sw	$24, 88($29)
	swc	$f0, 92($29)
	sw	$16, 96($29)
	sw	$2, 100($29)
	sw	$26, 104($29)
	sw	$1, 108($29)
	mov	$1, $2
	mov	$28, $17
	sw	$31, 116($29)
	addi	$29, $29, 120
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -120
	lw	$31, 116($29)
	set	$2, 0
	bne	$1, $2, beq_else.10557
	set	$1, -1
	lw	$2, 108($29)
	sll	$3, $2, 2
	lw	$4, 104($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	set	$1, 0
	bne	$2, $1, beq_else.10558
	jr $31
beq_else.10558:
	lw	$1, 100($29)
	lw	$2, 96($29)
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	veciprod.2495
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	min_caml_fneg
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	swc	$f0, 112($29)
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	min_caml_fispos
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	set	$2, 0
	bne	$1, $2, beq_else.10560
	jr $31
beq_else.10560:
	lwc	$f0, 112($29)
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	lwc	$f1, 112($29)
	mul.s	$f0, $f0, $f1
	lwc	$f1, 92($29)
	mul.s	$f0, $f0, $f1
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 88($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	set	$1, 0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 84($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	add.s	$f1, $f1, $f0
	sll	$1, $1, 2
	add	$27, $1, $3
	swc	$f1, 0($27)
	set	$1, 1
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f1, 0($27)
	add.s	$f1, $f1, $f0
	sll	$1, $1, 2
	add	$27, $1, $3
	swc	$f1, 0($27)
	set	$1, 2
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f1, 0($27)
	add.s	$f0, $f1, $f0
	sll	$1, $1, 2
	add	$27, $1, $3
	swc	$f0, 0($27)
	jr $31
beq_else.10557:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 80($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sll	$2, $1, 2
	lw	$3, 76($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$3, 8($2)
	lw	$4, 28($2)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f0, 0($27)
	lwc	$f1, 92($29)
	mul.s	$f0, $f0, $f1
	lw	$4, 4($2)
	set	$5, 1
	sw	$3, 116($29)
	swc	$f0, 120($29)
	sw	$1, 124($29)
	sw	$2, 128($29)
	bne	$4, $5, beq_else.10563
	lw	$4, 100($29)
	lw	$28, 72($29)
	mov	$1, $4
	sw	$31, 132($29)
	addi	$29, $29, 136
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -136
	lw	$31, 132($29)
	j	beq_cont.10564
beq_else.10563:
	set	$5, 2
	bne	$4, $5, beq_else.10565
	lw	$28, 68($29)
	mov	$1, $2
	sw	$31, 132($29)
	addi	$29, $29, 136
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -136
	lw	$31, 132($29)
	j	beq_cont.10566
beq_else.10565:
	lw	$28, 64($29)
	mov	$1, $2
	sw	$31, 132($29)
	addi	$29, $29, 136
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -136
	lw	$31, 132($29)
beq_cont.10566:
beq_cont.10564:
	lw	$1, 60($29)
	lw	$2, 56($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	veccpy.2484
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	lw	$1, 128($29)
	lw	$2, 56($29)
	lw	$28, 52($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -136
	lw	$31, 132($29)
	lw	$1, 124($29)
	sll	$1, $1, 2
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 48($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	add	$1, $1, $2
	lw	$2, 108($29)
	sll	$3, $2, 2
	lw	$4, 104($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	lw	$1, 44($29)
	lw	$3, 4($1)
	sll	$5, $2, 2
	add	$27, $5, $3
	lw	$3, 0($27)
	lw	$5, 56($29)
	mov	$2, $5
	mov	$1, $3
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	veccpy.2484
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	lw	$1, 44($29)
	lw	$2, 12($1)
	lw	$3, 128($29)
	lw	$4, 28($3)
	set	$5, 0
	sll	$5, $5, 2
	add	$27, $5, $4
	lwc	$f0, 0($27)
	setclv	$f1, l.8403
	sw	$2, 132($29)
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	min_caml_fless
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	set	$2, 0
	bne	$1, $2, beq_else.10567
	set	$1, 1
	lw	$2, 108($29)
	sll	$3, $2, 2
	lw	$4, 132($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	lw	$1, 44($29)
	lw	$3, 16($1)
	sll	$4, $2, 2
	add	$27, $4, $3
	lw	$3, 0($27)
	lw	$4, 40($29)
	sw	$3, 136($29)
	mov	$2, $4
	mov	$1, $3
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	veccpy.2484
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	setclv	$f0, l.8445
	lwc	$f1, 120($29)
	mul.s	$f0, $f0, $f1
	lw	$1, 136($29)
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	vecscale.2513
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	lw	$1, 44($29)
	lw	$2, 28($1)
	lw	$3, 108($29)
	sll	$4, $3, 2
	add	$27, $4, $2
	lw	$2, 0($27)
	lw	$4, 36($29)
	mov	$1, $2
	mov	$2, $4
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	veccpy.2484
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	j	beq_cont.10568
beq_else.10567:
	set	$1, 0
	lw	$2, 108($29)
	sll	$3, $2, 2
	lw	$4, 132($29)
	add	$27, $3, $4
	sw	$1, 0($27)
beq_cont.10568:
	setclv	$f0, l.8447
	lw	$1, 100($29)
	lw	$2, 36($29)
	swc	$f0, 140($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	veciprod.2495
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	lwc	$f1, 140($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 100($29)
	lw	$2, 36($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	vecaccum.2503
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	lw	$1, 128($29)
	lw	$2, 28($1)
	set	$3, 1
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f0, 0($27)
	lwc	$f1, 92($29)
	mul.s	$f0, $f1, $f0
	set	$2, 0
	set	$3, 0
	sll	$3, $3, 2
	lw	$4, 32($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	lw	$28, 28($29)
	swc	$f0, 144($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 148($29)
	addi	$29, $29, 152
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -152
	lw	$31, 148($29)
	set	$2, 0
	bne	$1, $2, beq_else.10569
	lw	$1, 36($29)
	lw	$2, 96($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	veciprod.2495
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	min_caml_fneg
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	lwc	$f1, 120($29)
	mul.s	$f0, $f0, $f1
	lw	$1, 100($29)
	lw	$2, 96($29)
	swc	$f0, 148($29)
	sw	$31, 156($29)
	addi	$29, $29, 160
	jal	veciprod.2495
	nop
	addi	$29, $29, -160
	lw	 $31, 156($29)
	sw	$31, 156($29)
	addi	$29, $29, 160
	jal	min_caml_fneg
	nop
	addi	$29, $29, -160
	lw	 $31, 156($29)
	mov.s	$f1, $f0
	lwc	$f0, 148($29)
	lwc	$f2, 144($29)
	lw	$28, 24($29)
	sw	$31, 156($29)
	addi	$29, $29, 160
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -160
	lw	$31, 156($29)
	j	beq_cont.10570
beq_else.10569:
beq_cont.10570:
	lw	$1, 56($29)
	lw	$28, 20($29)
	sw	$31, 156($29)
	addi	$29, $29, 160
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -160
	lw	$31, 156($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	set	$2, 1
	sub	$1, $1, $2
	lwc	$f0, 120($29)
	lwc	$f1, 144($29)
	lw	$2, 100($29)
	lw	$28, 12($29)
	sw	$31, 156($29)
	addi	$29, $29, 160
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -160
	lw	$31, 156($29)
	setclv	$f0, l.8451
	lwc	$f1, 92($29)
	sw	$31, 156($29)
	addi	$29, $29, 160
	jal	min_caml_fless
	nop
	addi	$29, $29, -160
	lw	 $31, 156($29)
	set	$2, 0
	bne	$1, $2, beq_else.10571
	jr $31
beq_else.10571:
	set	$1, 4
	lw	$2, 108($29)
	slt	$27, $2, $1
	bne	$27, $0, ble_else.10573
	j	ble_cont.10574
ble_else.10573:
	addi	$1, $2, 1
	set	$3, -1
	sll	$1, $1, 2
	lw	$4, 104($29)
	add	$27, $1, $4
	sw	$3, 0($27)
ble_cont.10574:
	set	$1, 2
	lw	$3, 116($29)
	bne	$3, $1, beq_else.10575
	setclv	$f0, l.7946
	lw	$1, 128($29)
	lw	$1, 28($1)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $1
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	lwc	$f1, 92($29)
	mul.s	$f0, $f1, $f0
	addi	$1, $2, 1
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 8($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	lwc	$f2, 4($29)
	add.s	$f1, $f2, $f1
	lw	$2, 100($29)
	lw	$3, 44($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10575:
	jr $31
ble_else.10556:
	jr $31
trace_diffuse_ray.2807:
	lw	$2, 56($28)
	lw	$3, 52($28)
	lw	$4, 48($28)
	lw	$5, 44($28)
	lw	$6, 40($28)
	lw	$7, 36($28)
	lw	$8, 32($28)
	lw	$9, 28($28)
	lw	$10, 24($28)
	lw	$11, 20($28)
	lw	$12, 16($28)
	lw	$13, 12($28)
	lw	$14, 8($28)
	lw	$15, 4($28)
	sw	$3, 0($29)
	sw	$15, 4($29)
	swc	$f0, 8($29)
	sw	$8, 12($29)
	sw	$7, 16($29)
	sw	$4, 20($29)
	sw	$5, 24($29)
	sw	$10, 28($29)
	sw	$2, 32($29)
	sw	$12, 36($29)
	sw	$14, 40($29)
	sw	$13, 44($29)
	sw	$1, 48($29)
	sw	$6, 52($29)
	sw	$11, 56($29)
	mov	$28, $9
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.10578
	jr $31
beq_else.10578:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 56($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sll	$1, $1, 2
	lw	$2, 52($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	lw	$2, 48($29)
	lw	$2, 0($2)
	lw	$3, 4($1)
	set	$4, 1
	sw	$1, 60($29)
	bne	$3, $4, beq_else.10580
	lw	$28, 44($29)
	mov	$1, $2
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	j	beq_cont.10581
beq_else.10580:
	set	$2, 2
	bne	$3, $2, beq_else.10582
	lw	$28, 40($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	j	beq_cont.10583
beq_else.10582:
	lw	$28, 36($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
beq_cont.10583:
beq_cont.10581:
	lw	$1, 60($29)
	lw	$2, 28($29)
	lw	$28, 32($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	set	$1, 0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 24($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$28, 20($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	set	$2, 0
	bne	$1, $2, beq_else.10584
	lw	$1, 16($29)
	lw	$2, 12($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	veciprod.2495
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fneg
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	swc	$f0, 64($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fispos
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	set	$2, 0
	bne	$1, $2, beq_else.10585
	setclv	$f0, l.7945
	j	beq_cont.10586
beq_else.10585:
	lwc	$f0, 64($29)
beq_cont.10586:
	lwc	$f1, 8($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 60($29)
	lw	$1, 28($1)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	lw	$1, 4($29)
	lw	$2, 0($29)
	j	vecaccum.2503
beq_else.10584:
	jr $31
iter_trace_diffuse_rays.2810:
	lw	$5, 4($28)
	set	$6, 0
	slt	$27, $4, $6
	bne	$27, $0, ble_else.10588
	sll	$6, $4, 2
	add	$27, $6, $1
	lw	$6, 0($27)
	lw	$7, 0($6)
	sw	$3, 0($29)
	sw	$2, 4($29)
	sw	$28, 8($29)
	sw	$1, 12($29)
	sw	$4, 16($29)
	sw	$6, 20($29)
	sw	$5, 24($29)
	mov	$1, $7
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	veciprod.2495
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	swc	$f0, 28($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.10589
	setclv	$f0, l.8470
	lwc	$f1, 28($29)
	div.s	$f0, $f1, $f0
	lw	$1, 20($29)
	lw	$28, 24($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	j	beq_cont.10590
beq_else.10589:
	lw	$1, 16($29)
	addi	$2, $1, 1
	sll	$2, $2, 2
	lw	$3, 12($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	setclv	$f0, l.8469
	lwc	$f1, 28($29)
	div.s	$f0, $f1, $f0
	lw	$28, 24($29)
	mov	$1, $2
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
beq_cont.10590:
	set	$1, 2
	lw	$2, 16($29)
	sub	$4, $2, $1
	lw	$1, 12($29)
	lw	$2, 4($29)
	lw	$3, 0($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10588:
	jr $31
trace_diffuse_ray_80percent.2819:
	lw	$4, 12($28)
	lw	$5, 8($28)
	lw	$6, 4($28)
	set	$7, 0
	sw	$2, 0($29)
	sw	$5, 4($29)
	sw	$3, 8($29)
	sw	$4, 12($29)
	sw	$6, 16($29)
	sw	$1, 20($29)
	bne	$1, $7, beq_else.10592
	j	beq_cont.10593
beq_else.10592:
	set	$7, 0
	sll	$7, $7, 2
	add	$27, $7, $6
	lw	$7, 0($27)
	sw	$7, 24($29)
	mov	$1, $3
	mov	$28, $4
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	set	$4, 118
	lw	$1, 24($29)
	lw	$2, 0($29)
	lw	$3, 8($29)
	lw	$28, 4($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
beq_cont.10593:
	set	$1, 1
	lw	$2, 20($29)
	bne	$2, $1, beq_else.10594
	j	beq_cont.10595
beq_else.10594:
	set	$1, 1
	sll	$1, $1, 2
	lw	$3, 16($29)
	add	$27, $1, $3
	lw	$1, 0($27)
	lw	$4, 8($29)
	lw	$28, 12($29)
	sw	$1, 28($29)
	mov	$1, $4
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	set	$4, 118
	lw	$1, 28($29)
	lw	$2, 0($29)
	lw	$3, 8($29)
	lw	$28, 4($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
beq_cont.10595:
	set	$1, 2
	lw	$2, 20($29)
	bne	$2, $1, beq_else.10596
	j	beq_cont.10597
beq_else.10596:
	set	$1, 2
	sll	$1, $1, 2
	lw	$3, 16($29)
	add	$27, $1, $3
	lw	$1, 0($27)
	lw	$4, 8($29)
	lw	$28, 12($29)
	sw	$1, 32($29)
	mov	$1, $4
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	set	$4, 118
	lw	$1, 32($29)
	lw	$2, 0($29)
	lw	$3, 8($29)
	lw	$28, 4($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
beq_cont.10597:
	set	$1, 3
	lw	$2, 20($29)
	bne	$2, $1, beq_else.10598
	j	beq_cont.10599
beq_else.10598:
	set	$1, 3
	sll	$1, $1, 2
	lw	$3, 16($29)
	add	$27, $1, $3
	lw	$1, 0($27)
	lw	$4, 8($29)
	lw	$28, 12($29)
	sw	$1, 36($29)
	mov	$1, $4
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	set	$4, 118
	lw	$1, 36($29)
	lw	$2, 0($29)
	lw	$3, 8($29)
	lw	$28, 4($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
beq_cont.10599:
	set	$1, 4
	lw	$2, 20($29)
	bne	$2, $1, beq_else.10600
	jr $31
beq_else.10600:
	set	$1, 4
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	lw	$2, 8($29)
	lw	$28, 12($29)
	sw	$1, 40($29)
	mov	$1, $2
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	set	$4, 118
	lw	$1, 40($29)
	lw	$2, 0($29)
	lw	$3, 8($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
calc_diffuse_using_1point.2823:
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$5, 4($28)
	lw	$6, 20($1)
	lw	$7, 28($1)
	lw	$8, 4($1)
	lw	$9, 16($1)
	sll	$10, $2, 2
	add	$27, $10, $6
	lw	$6, 0($27)
	sw	$5, 0($29)
	sw	$4, 4($29)
	sw	$9, 8($29)
	sw	$3, 12($29)
	sw	$8, 16($29)
	sw	$7, 20($29)
	sw	$2, 24($29)
	sw	$1, 28($29)
	mov	$2, $6
	mov	$1, $5
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	veccpy.2484
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 28($29)
	lw	$1, 24($1)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lw	$1, 0($27)
	lw	$2, 24($29)
	sll	$3, $2, 2
	lw	$4, 20($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	sll	$4, $2, 2
	lw	$5, 16($29)
	add	$27, $4, $5
	lw	$4, 0($27)
	lw	$28, 12($29)
	mov	$2, $3
	mov	$3, $4
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	lw	$1, 24($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	lw	$2, 0($27)
	lw	$1, 4($29)
	lw	$3, 0($29)
	j	vecaccumv.2516
calc_diffuse_using_5points.2826:
	lw	$6, 8($28)
	lw	$7, 4($28)
	sll	$8, $1, 2
	add	$27, $8, $2
	lw	$2, 0($27)
	lw	$2, 20($2)
	set	$8, 1
	sub	$8, $1, $8
	sll	$8, $8, 2
	add	$27, $8, $3
	lw	$8, 0($27)
	lw	$8, 20($8)
	sll	$9, $1, 2
	add	$27, $9, $3
	lw	$9, 0($27)
	lw	$10, 20($9)
	addi	$11, $1, 1
	sll	$11, $11, 2
	add	$27, $11, $3
	lw	$3, 0($27)
	lw	$3, 20($3)
	sll	$1, $1, 2
	add	$27, $1, $4
	lw	$1, 0($27)
	lw	$1, 20($1)
	sll	$4, $5, 2
	add	$27, $4, $2
	lw	$2, 0($27)
	sw	$6, 0($29)
	sw	$9, 4($29)
	sw	$1, 8($29)
	sw	$3, 12($29)
	sw	$10, 16($29)
	sw	$7, 20($29)
	sw	$8, 24($29)
	sw	$5, 28($29)
	mov	$1, $7
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	veccpy.2484
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 28($29)
	sll	$2, $1, 2
	lw	$3, 24($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$3, 20($29)
	mov	$1, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	vecadd.2507
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 28($29)
	sll	$2, $1, 2
	lw	$3, 16($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$3, 20($29)
	mov	$1, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	vecadd.2507
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 28($29)
	sll	$2, $1, 2
	lw	$3, 12($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$3, 20($29)
	mov	$1, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	vecadd.2507
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 28($29)
	sll	$2, $1, 2
	lw	$3, 8($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$3, 20($29)
	mov	$1, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	vecadd.2507
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 4($29)
	lw	$1, 16($1)
	lw	$2, 28($29)
	sll	$2, $2, 2
	add	$27, $2, $1
	lw	$2, 0($27)
	lw	$1, 0($29)
	lw	$3, 20($29)
	j	vecaccumv.2516
do_without_neighbors.2832:
	lw	$3, 4($28)
	set	$4, 4
	slt	$27, $4, $2
	bne	$27, $0, ble_else.10602
	lw	$4, 8($1)
	set	$5, 0
	sll	$6, $2, 2
	add	$27, $6, $4
	lw	$4, 0($27)
	slt	$27, $4, $5
	bne	$27, $0, ble_else.10603
	lw	$4, 12($1)
	sll	$5, $2, 2
	add	$27, $5, $4
	lw	$4, 0($27)
	set	$5, 0
	sw	$1, 0($29)
	sw	$28, 4($29)
	sw	$2, 8($29)
	bne	$4, $5, beq_else.10604
	j	beq_cont.10605
beq_else.10604:
	mov	$28, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -16
	lw	$31, 12($29)
beq_cont.10605:
	lw	$1, 8($29)
	addi	$2, $1, 1
	lw	$1, 0($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10603:
	jr $31
ble_else.10602:
	jr $31
neighbors_exist.2835:
	lw	$3, 4($28)
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $3
	lw	$4, 0($27)
	addi	$5, $2, 1
	slt	$27, $5, $4
	bne	$27, $0, ble_else.10608
	set	$1, 0
	jr $31
ble_else.10608:
	set	$4, 0
	slt	$27, $4, $2
	bne	$27, $0, ble_else.10609
	set	$1, 0
	jr $31
ble_else.10609:
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $3
	lw	$2, 0($27)
	addi	$3, $1, 1
	slt	$27, $3, $2
	bne	$27, $0, ble_else.10610
	set	$1, 0
	jr $31
ble_else.10610:
	set	$2, 0
	slt	$27, $2, $1
	bne	$27, $0, ble_else.10611
	set	$1, 0
	jr $31
ble_else.10611:
	set	$1, 1
	jr $31
neighbors_are_available.2842:
	sll	$6, $1, 2
	add	$27, $6, $3
	lw	$6, 0($27)
	lw	$6, 8($6)
	sll	$7, $5, 2
	add	$27, $7, $6
	lw	$6, 0($27)
	sll	$7, $1, 2
	add	$27, $7, $2
	lw	$2, 0($27)
	lw	$2, 8($2)
	sll	$7, $5, 2
	add	$27, $7, $2
	lw	$2, 0($27)
	bne	$2, $6, beq_else.10612
	sll	$2, $1, 2
	add	$27, $2, $4
	lw	$2, 0($27)
	lw	$2, 8($2)
	sll	$4, $5, 2
	add	$27, $4, $2
	lw	$2, 0($27)
	bne	$2, $6, beq_else.10613
	set	$2, 1
	sub	$2, $1, $2
	sll	$2, $2, 2
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$2, 8($2)
	sll	$4, $5, 2
	add	$27, $4, $2
	lw	$2, 0($27)
	bne	$2, $6, beq_else.10614
	addi	$1, $1, 1
	sll	$1, $1, 2
	add	$27, $1, $3
	lw	$1, 0($27)
	lw	$1, 8($1)
	sll	$2, $5, 2
	add	$27, $2, $1
	lw	$1, 0($27)
	bne	$1, $6, beq_else.10615
	set	$1, 1
	jr $31
beq_else.10615:
	set	$1, 0
	jr $31
beq_else.10614:
	set	$1, 0
	jr $31
beq_else.10613:
	set	$1, 0
	jr $31
beq_else.10612:
	set	$1, 0
	jr $31
try_exploit_neighbors.2848:
	lw	$7, 8($28)
	lw	$8, 4($28)
	sll	$9, $1, 2
	add	$27, $9, $4
	lw	$9, 0($27)
	set	$10, 4
	slt	$27, $10, $6
	bne	$27, $0, ble_else.10616
	set	$10, 0
	lw	$11, 8($9)
	sll	$12, $6, 2
	add	$27, $12, $11
	lw	$11, 0($27)
	slt	$27, $11, $10
	bne	$27, $0, ble_else.10617
	sw	$2, 0($29)
	sw	$28, 4($29)
	sw	$5, 8($29)
	sw	$4, 12($29)
	sw	$3, 16($29)
	sw	$1, 20($29)
	sw	$8, 24($29)
	sw	$6, 28($29)
	sw	$9, 32($29)
	sw	$7, 36($29)
	mov	$2, $3
	mov	$3, $4
	mov	$4, $5
	mov	$5, $6
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	neighbors_are_available.2842
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.10618
	lw	$1, 32($29)
	lw	$2, 28($29)
	lw	$28, 36($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10618:
	lw	$1, 32($29)
	lw	$1, 12($1)
	lw	$5, 28($29)
	sll	$2, $5, 2
	add	$27, $2, $1
	lw	$1, 0($27)
	set	$2, 0
	bne	$1, $2, beq_else.10619
	j	beq_cont.10620
beq_else.10619:
	lw	$1, 20($29)
	lw	$2, 16($29)
	lw	$3, 12($29)
	lw	$4, 8($29)
	lw	$28, 24($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
beq_cont.10620:
	lw	$1, 28($29)
	addi	$6, $1, 1
	lw	$1, 20($29)
	lw	$2, 0($29)
	lw	$3, 16($29)
	lw	$4, 12($29)
	lw	$5, 8($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10617:
	jr $31
ble_else.10616:
	jr $31
write_ppm_header.2855:
	lw	$1, 4($28)
	set	$2, 80
	sw	$1, 0($29)
	mov	$1, $2
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_print_char
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 51
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_print_char
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 10
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_print_char
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_print_int
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 32
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_print_char
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_print_int
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 32
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_print_char
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 255
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_print_int
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 10
	j	min_caml_print_char
write_rgb_element.2857:
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_int_of_float
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 255
	slt	$27, $2, $1
	bne	$27, $0, ble_else.10623
	set	$2, 0
	slt	$27, $1, $2
	bne	$27, $0, ble_else.10625
	j	ble_cont.10626
ble_else.10625:
	set	$1, 0
ble_cont.10626:
	j	ble_cont.10624
ble_else.10623:
	set	$1, 255
ble_cont.10624:
	j	min_caml_print_int
write_rgb.2859:
	lw	$1, 4($28)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	sw	$1, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	write_rgb_element.2857
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 32
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_print_char
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	write_rgb_element.2857
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 32
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_print_char
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	write_rgb_element.2857
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 10
	j	min_caml_print_char
pretrace_diffuse_rays.2861:
	lw	$3, 16($28)
	lw	$4, 12($28)
	lw	$5, 8($28)
	lw	$6, 4($28)
	set	$7, 4
	slt	$27, $7, $2
	bne	$27, $0, ble_else.10627
	lw	$7, 8($1)
	sll	$8, $2, 2
	add	$27, $8, $7
	lw	$7, 0($27)
	set	$8, 0
	slt	$27, $7, $8
	bne	$27, $0, ble_else.10628
	lw	$7, 12($1)
	sll	$8, $2, 2
	add	$27, $8, $7
	lw	$7, 0($27)
	set	$8, 0
	sw	$1, 0($29)
	sw	$28, 4($29)
	sw	$2, 8($29)
	bne	$7, $8, beq_else.10629
	j	beq_cont.10630
beq_else.10629:
	lw	$7, 24($1)
	set	$8, 0
	sll	$8, $8, 2
	add	$27, $8, $7
	lw	$7, 0($27)
	setclv	$f0, l.7945
	sw	$6, 12($29)
	sw	$4, 16($29)
	sw	$3, 20($29)
	sw	$5, 24($29)
	sw	$7, 28($29)
	mov	$1, $6
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	vecfill.2479
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 0($29)
	lw	$2, 28($1)
	lw	$3, 4($1)
	lw	$4, 28($29)
	sll	$4, $4, 2
	lw	$5, 24($29)
	add	$27, $4, $5
	lw	$4, 0($27)
	lw	$5, 8($29)
	sll	$6, $5, 2
	add	$27, $6, $2
	lw	$2, 0($27)
	sll	$6, $5, 2
	add	$27, $6, $3
	lw	$3, 0($27)
	lw	$28, 20($29)
	sw	$3, 32($29)
	sw	$2, 36($29)
	sw	$4, 40($29)
	mov	$1, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	set	$4, 118
	lw	$1, 40($29)
	lw	$2, 36($29)
	lw	$3, 32($29)
	lw	$28, 16($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	lw	$1, 0($29)
	lw	$2, 20($1)
	lw	$3, 8($29)
	sll	$4, $3, 2
	add	$27, $4, $2
	lw	$2, 0($27)
	lw	$4, 12($29)
	mov	$1, $2
	mov	$2, $4
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	veccpy.2484
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
beq_cont.10630:
	lw	$1, 8($29)
	addi	$2, $1, 1
	lw	$1, 0($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10628:
	jr $31
ble_else.10627:
	jr $31
pretrace_pixels.2864:
	lw	$4, 36($28)
	lw	$5, 32($28)
	lw	$6, 28($28)
	lw	$7, 24($28)
	lw	$8, 20($28)
	lw	$9, 16($28)
	lw	$10, 12($28)
	lw	$11, 8($28)
	lw	$12, 4($28)
	set	$13, 0
	slt	$27, $2, $13
	bne	$27, $0, ble_else.10633
	set	$13, 0
	sll	$13, $13, 2
	add	$27, $13, $8
	lwc	$f3, 0($27)
	set	$8, 0
	sll	$8, $8, 2
	add	$27, $8, $12
	lw	$8, 0($27)
	sub	$8, $2, $8
	sw	$28, 0($29)
	sw	$11, 4($29)
	sw	$3, 8($29)
	sw	$5, 12($29)
	sw	$1, 16($29)
	sw	$2, 20($29)
	sw	$4, 24($29)
	sw	$6, 28($29)
	sw	$9, 32($29)
	swc	$f2, 36($29)
	swc	$f1, 40($29)
	sw	$10, 44($29)
	swc	$f0, 48($29)
	sw	$7, 52($29)
	swc	$f3, 56($29)
	mov	$1, $8
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_float_of_int
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 56($29)
	mul.s	$f0, $f1, $f0
	set	$1, 0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 52($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	mul.s	$f1, $f0, $f1
	lwc	$f2, 48($29)
	add.s	$f1, $f1, $f2
	sll	$1, $1, 2
	lw	$2, 44($29)
	add	$27, $1, $2
	swc	$f1, 0($27)
	set	$1, 1
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f1, 0($27)
	mul.s	$f1, $f0, $f1
	lwc	$f3, 40($29)
	add.s	$f1, $f1, $f3
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f1, 0($27)
	set	$1, 2
	set	$4, 2
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	lwc	$f1, 36($29)
	add.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 0
	mov	$27, $2
	mov	$2, $1
	mov	$1, $27
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	vecunit_sgn.2492
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	setclv	$f0, l.7945
	lw	$1, 32($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	vecfill.2479
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$1, 28($29)
	lw	$2, 24($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	veccpy.2484
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$1, 0
	setclv	$f0, l.7946
	lw	$2, 20($29)
	sll	$3, $2, 2
	lw	$4, 16($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	setclv	$f1, l.7945
	lw	$5, 44($29)
	lw	$28, 12($29)
	sw	$3, 60($29)
	mov	$2, $5
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	lw	$1, 60($29)
	lw	$2, 0($1)
	lw	$3, 32($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	veccpy.2484
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lw	$1, 60($29)
	lw	$2, 24($1)
	set	$3, 0
	sll	$3, $3, 2
	lw	$4, 8($29)
	add	$27, $3, $2
	sw	$4, 0($27)
	set	$2, 0
	lw	$28, 4($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	set	$1, 1
	lw	$2, 20($29)
	sub	$2, $2, $1
	lw	$1, 8($29)
	addi	$1, $1, 1
	set	$3, 5
	slt	$27, $1, $3
	bne	$27, $0, ble_else.10634
	set	$3, 5
	sub	$3, $1, $3
	j	ble_cont.10635
ble_else.10634:
	mov	$3, $1
ble_cont.10635:
	lwc	$f0, 48($29)
	lwc	$f1, 40($29)
	lwc	$f2, 36($29)
	lw	$1, 16($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10633:
	jr $31
pretrace_line.2871:
	lw	$4, 24($28)
	lw	$5, 20($28)
	lw	$6, 16($28)
	lw	$7, 12($28)
	lw	$8, 8($28)
	lw	$9, 4($28)
	set	$10, 0
	sll	$10, $10, 2
	add	$27, $10, $6
	lwc	$f0, 0($27)
	set	$6, 1
	sll	$6, $6, 2
	add	$27, $6, $9
	lw	$6, 0($27)
	sub	$2, $2, $6
	sw	$3, 0($29)
	sw	$1, 4($29)
	sw	$7, 8($29)
	sw	$8, 12($29)
	sw	$4, 16($29)
	sw	$5, 20($29)
	swc	$f0, 24($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_float_of_int
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 24($29)
	mul.s	$f0, $f1, $f0
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	mul.s	$f1, $f0, $f1
	set	$1, 0
	sll	$1, $1, 2
	lw	$3, 16($29)
	add	$27, $1, $3
	lwc	$f2, 0($27)
	add.s	$f1, $f1, $f2
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f2, 0($27)
	mul.s	$f2, $f0, $f2
	set	$1, 1
	sll	$1, $1, 2
	add	$27, $1, $3
	lwc	$f3, 0($27)
	add.s	$f2, $f2, $f3
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $2
	lwc	$f3, 0($27)
	mul.s	$f0, $f0, $f3
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $3
	lwc	$f3, 0($27)
	add.s	$f0, $f0, $f3
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	set	$2, 1
	sub	$2, $1, $2
	lw	$1, 4($29)
	lw	$3, 0($29)
	lw	$28, 8($29)
	mov.s	$f31, $f2
	mov.s	$f2, $f0
	mov.s	$f0, $f1
	mov.s	$f1, $f31
	lw	$27, 0($28)
	jr	$27
scan_pixel.2875:
	lw	$6, 24($28)
	lw	$7, 20($28)
	lw	$8, 16($28)
	lw	$9, 12($28)
	lw	$10, 8($28)
	lw	$11, 4($28)
	set	$12, 0
	sll	$12, $12, 2
	add	$27, $12, $10
	lw	$10, 0($27)
	slt	$27, $1, $10
	bne	$27, $0, ble_else.10637
	jr $31
ble_else.10637:
	sll	$10, $1, 2
	add	$27, $10, $4
	lw	$10, 0($27)
	lw	$12, 0($10)
	sw	$28, 0($29)
	sw	$6, 4($29)
	sw	$4, 8($29)
	sw	$3, 12($29)
	sw	$7, 16($29)
	sw	$10, 20($29)
	sw	$11, 24($29)
	sw	$5, 28($29)
	sw	$2, 32($29)
	sw	$1, 36($29)
	sw	$9, 40($29)
	mov	$2, $12
	mov	$1, $8
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	veccpy.2484
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 36($29)
	lw	$2, 32($29)
	lw	$3, 28($29)
	lw	$28, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.10639
	set	$2, 0
	lw	$1, 20($29)
	lw	$28, 24($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	j	beq_cont.10640
beq_else.10639:
	set	$6, 0
	lw	$1, 36($29)
	lw	$2, 32($29)
	lw	$3, 12($29)
	lw	$4, 8($29)
	lw	$5, 28($29)
	lw	$28, 16($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
beq_cont.10640:
	lw	$28, 4($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	lw	$1, 36($29)
	addi	$1, $1, 1
	lw	$2, 32($29)
	lw	$3, 12($29)
	lw	$4, 8($29)
	lw	$5, 28($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
scan_line.2881:
	lw	$6, 12($28)
	lw	$7, 8($28)
	lw	$8, 4($28)
	set	$9, 1
	sll	$9, $9, 2
	add	$27, $9, $8
	lw	$9, 0($27)
	slt	$27, $1, $9
	bne	$27, $0, ble_else.10641
	jr $31
ble_else.10641:
	set	$9, 1
	sll	$9, $9, 2
	add	$27, $9, $8
	lw	$8, 0($27)
	set	$9, 1
	sub	$8, $8, $9
	sw	$28, 0($29)
	sw	$5, 4($29)
	sw	$4, 8($29)
	sw	$3, 12($29)
	sw	$2, 16($29)
	sw	$1, 20($29)
	sw	$6, 24($29)
	slt	$27, $1, $8
	bne	$27, $0, ble_else.10643
	j	ble_cont.10644
ble_else.10643:
	addi	$8, $1, 1
	mov	$3, $5
	mov	$2, $8
	mov	$1, $4
	mov	$28, $7
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
ble_cont.10644:
	set	$1, 0
	lw	$2, 20($29)
	lw	$3, 16($29)
	lw	$4, 12($29)
	lw	$5, 8($29)
	lw	$28, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	lw	$1, 20($29)
	addi	$1, $1, 1
	lw	$2, 4($29)
	addi	$2, $2, 2
	set	$3, 5
	slt	$27, $2, $3
	bne	$27, $0, ble_else.10645
	set	$3, 5
	sub	$5, $2, $3
	j	ble_cont.10646
ble_else.10645:
	mov	$5, $2
ble_cont.10646:
	lw	$2, 12($29)
	lw	$3, 8($29)
	lw	$4, 16($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
create_float5x3array.2887:
	set	$1, 3
	setclv	$f0, l.7945
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	mov	$2, $1
	set	$1, 5
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_create_array
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 1
	set	$3, 3
	setclv	$f0, l.7945
	sw	$1, 0($29)
	sw	$2, 4($29)
	mov	$1, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$2, 4($29)
	sll	$2, $2, 2
	lw	$3, 0($29)
	add	$27, $2, $3
	sw	$1, 0($27)
	set	$1, 2
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 8($29)
	mov	$1, $2
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$2, 8($29)
	sll	$2, $2, 2
	lw	$3, 0($29)
	add	$27, $2, $3
	sw	$1, 0($27)
	set	$1, 3
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 12($29)
	mov	$1, $2
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 12($29)
	sll	$2, $2, 2
	lw	$3, 0($29)
	add	$27, $2, $3
	sw	$1, 0($27)
	set	$1, 4
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 16($29)
	mov	$1, $2
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 16($29)
	sll	$2, $2, 2
	lw	$3, 0($29)
	add	$27, $2, $3
	sw	$1, 0($27)
	mov	$1, $3
	jr $31
create_pixel.2889:
	set	$1, 3
	setclv	$f0, l.7945
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	sw	$1, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	create_float5x3array.2887
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 5
	set	$3, 0
	sw	$1, 4($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 5
	set	$3, 0
	sw	$1, 8($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	sw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	create_float5x3array.2887
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	sw	$1, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	create_float5x3array.2887
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 1
	set	$3, 0
	sw	$1, 20($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_create_array
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	sw	$1, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	create_float5x3array.2887
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	mov	$2, $30
	addi	$30, $30, 32
	sw	$1, 28($2)
	lw	$1, 24($29)
	sw	$1, 24($2)
	lw	$1, 20($29)
	sw	$1, 20($2)
	lw	$1, 16($29)
	sw	$1, 16($2)
	lw	$1, 12($29)
	sw	$1, 12($2)
	lw	$1, 8($29)
	sw	$1, 8($2)
	lw	$1, 4($29)
	sw	$1, 4($2)
	lw	$1, 0($29)
	sw	$1, 0($2)
	mov	$1, $2
	jr $31
init_line_elements.2891:
	set	$3, 0
	slt	$27, $2, $3
	bne	$27, $0, ble_else.10647
	sw	$1, 0($29)
	sw	$2, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	create_pixel.2889
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$2, 4($29)
	sll	$3, $2, 2
	lw	$4, 0($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	set	$1, 1
	sub	$2, $2, $1
	mov	$1, $4
	j	init_line_elements.2891
ble_else.10647:
	jr $31
create_pixelline.2894:
	lw	$1, 4($28)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lw	$2, 0($27)
	sw	$1, 0($29)
	sw	$2, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	create_pixel.2889
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	mov	$2, $1
	lw	$1, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 0($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	set	$3, 2
	sub	$2, $2, $3
	j	init_line_elements.2891
adjust_position.2898:
	mul.s	$f0, $f0, $f0
	setclv	$f2, l.8451
	add.s	$f0, $f0, $f2
	swc	$f1, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	setclv	$f1, l.7946
	div.s	$f1, $f1, $f0
	swc	$f0, 4($29)
	mov.s	$f0, $f1
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_atan
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lwc	$f1, 0($29)
	mul.s	$f0, $f0, $f1
	swc	$f0, 8($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_sin
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lwc	$f1, 8($29)
	swc	$f0, 12($29)
	mov.s	$f0, $f1
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_cos
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f1, 12($29)
	div.s	$f0, $f1, $f0
	lwc	$f1, 4($29)
	mul.s	$f0, $f0, $f1
	jr $31
calc_dirvec.2901:
	lw	$4, 4($28)
	set	$5, 5
	slt	$27, $1, $5
	bne	$27, $0, ble_else.10648
	sw	$3, 0($29)
	sw	$4, 4($29)
	sw	$2, 8($29)
	swc	$f0, 12($29)
	swc	$f1, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f1, 16($29)
	swc	$f0, 20($29)
	mov.s	$f0, $f1
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 20($29)
	add.s	$f0, $f1, $f0
	setclv	$f1, l.7946
	add.s	$f0, $f0, $f1
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 12($29)
	div.s	$f1, $f1, $f0
	lwc	$f2, 16($29)
	div.s	$f2, $f2, $f0
	setclv	$f3, l.7946
	div.s	$f0, $f3, $f0
	lw	$1, 8($29)
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	lw	$2, 0($29)
	sll	$3, $2, 2
	add	$27, $3, $1
	lw	$3, 0($27)
	lw	$3, 0($3)
	swc	$f0, 24($29)
	swc	$f1, 28($29)
	swc	$f2, 32($29)
	sw	$1, 36($29)
	mov	$1, $3
	mov.s	$f31, $f2
	mov.s	$f2, $f0
	mov.s	$f0, $f1
	mov.s	$f1, $f31
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	vecset.2474
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 0($29)
	addi	$2, $1, 40
	sll	$2, $2, 2
	lw	$3, 36($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$2, 0($2)
	lwc	$f0, 32($29)
	sw	$2, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fneg
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	mov.s	$f2, $f0
	lwc	$f0, 28($29)
	lwc	$f1, 24($29)
	lw	$1, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	vecset.2474
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 0($29)
	addi	$2, $1, 80
	sll	$2, $2, 2
	lw	$3, 36($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$2, 0($2)
	lwc	$f0, 28($29)
	sw	$2, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fneg
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 32($29)
	swc	$f0, 48($29)
	mov.s	$f0, $f1
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fneg
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	mov.s	$f2, $f0
	lwc	$f0, 24($29)
	lwc	$f1, 48($29)
	lw	$1, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	vecset.2474
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 0($29)
	addi	$2, $1, 1
	sll	$2, $2, 2
	lw	$3, 36($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$2, 0($2)
	lwc	$f0, 28($29)
	sw	$2, 52($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fneg
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 32($29)
	swc	$f0, 56($29)
	mov.s	$f0, $f1
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fneg
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 24($29)
	swc	$f0, 60($29)
	mov.s	$f0, $f1
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fneg
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	mov.s	$f2, $f0
	lwc	$f0, 56($29)
	lwc	$f1, 60($29)
	lw	$1, 52($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	vecset.2474
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lw	$1, 0($29)
	addi	$2, $1, 41
	sll	$2, $2, 2
	lw	$3, 36($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$2, 0($2)
	lwc	$f0, 28($29)
	sw	$2, 64($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fneg
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 24($29)
	swc	$f0, 68($29)
	mov.s	$f0, $f1
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_fneg
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	mov.s	$f1, $f0
	lwc	$f0, 68($29)
	lwc	$f2, 32($29)
	lw	$1, 64($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	vecset.2474
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lw	$1, 0($29)
	addi	$1, $1, 81
	sll	$1, $1, 2
	lw	$2, 36($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	lw	$1, 0($1)
	lwc	$f0, 24($29)
	sw	$1, 72($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_fneg
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 28($29)
	lwc	$f2, 32($29)
	lw	$1, 72($29)
	j	vecset.2474
ble_else.10648:
	swc	$f2, 76($29)
	sw	$3, 0($29)
	sw	$2, 8($29)
	sw	$28, 80($29)
	swc	$f3, 84($29)
	sw	$1, 88($29)
	mov.s	$f0, $f1
	mov.s	$f1, $f2
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	adjust_position.2898
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	lw	$1, 88($29)
	addi	$1, $1, 1
	lwc	$f1, 84($29)
	swc	$f0, 92($29)
	sw	$1, 96($29)
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	adjust_position.2898
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	mov.s	$f1, $f0
	lwc	$f0, 92($29)
	lwc	$f2, 76($29)
	lwc	$f3, 84($29)
	lw	$1, 96($29)
	lw	$2, 8($29)
	lw	$3, 0($29)
	lw	$28, 80($29)
	lw	$27, 0($28)
	jr	$27
calc_dirvecs.2909:
	lw	$4, 4($28)
	set	$5, 0
	slt	$27, $1, $5
	bne	$27, $0, ble_else.10649
	sw	$28, 0($29)
	sw	$1, 4($29)
	swc	$f0, 8($29)
	sw	$3, 12($29)
	sw	$2, 16($29)
	sw	$4, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_float_of_int
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	setclv	$f1, l.8567
	mul.s	$f0, $f0, $f1
	setclv	$f1, l.8568
	sub.s	$f2, $f0, $f1
	set	$1, 0
	setclv	$f0, l.7945
	setclv	$f1, l.7945
	lwc	$f3, 8($29)
	lw	$2, 16($29)
	lw	$3, 12($29)
	lw	$28, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	lw	$1, 4($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_float_of_int
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	setclv	$f1, l.8567
	mul.s	$f0, $f0, $f1
	setclv	$f1, l.8451
	add.s	$f2, $f0, $f1
	set	$1, 0
	setclv	$f0, l.7945
	setclv	$f1, l.7945
	lw	$2, 12($29)
	addi	$3, $2, 2
	lwc	$f3, 8($29)
	lw	$4, 16($29)
	lw	$28, 20($29)
	mov	$2, $4
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	set	$1, 1
	lw	$2, 4($29)
	sub	$1, $2, $1
	lw	$2, 16($29)
	addi	$2, $2, 1
	set	$3, 5
	slt	$27, $2, $3
	bne	$27, $0, ble_else.10650
	set	$3, 5
	sub	$2, $2, $3
	j	ble_cont.10651
ble_else.10650:
ble_cont.10651:
	lwc	$f0, 8($29)
	lw	$3, 12($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10649:
	jr $31
calc_dirvec_rows.2914:
	lw	$4, 4($28)
	set	$5, 0
	slt	$27, $1, $5
	bne	$27, $0, ble_else.10653
	sw	$28, 0($29)
	sw	$1, 4($29)
	sw	$3, 8($29)
	sw	$2, 12($29)
	sw	$4, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_float_of_int
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	setclv	$f1, l.8567
	mul.s	$f0, $f0, $f1
	setclv	$f1, l.8568
	sub.s	$f0, $f0, $f1
	set	$1, 4
	lw	$2, 12($29)
	lw	$3, 8($29)
	lw	$28, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	set	$1, 1
	lw	$2, 4($29)
	sub	$1, $2, $1
	lw	$2, 12($29)
	addi	$2, $2, 2
	set	$3, 5
	slt	$27, $2, $3
	bne	$27, $0, ble_else.10654
	set	$3, 5
	sub	$2, $2, $3
	j	ble_cont.10655
ble_else.10654:
ble_cont.10655:
	lw	$3, 8($29)
	addi	$3, $3, 4
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10653:
	jr $31
create_dirvec.2918:
	lw	$1, 4($28)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 0($29)
	mov	$1, $2
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	mov	$2, $1
	set	$1, 0
	sll	$1, $1, 2
	lw	$3, 0($29)
	add	$27, $1, $3
	lw	$1, 0($27)
	sw	$2, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	mov	$2, $30
	addi	$30, $30, 8
	sw	$1, 4($2)
	lw	$1, 4($29)
	sw	$1, 0($2)
	mov	$1, $2
	jr $31
create_dirvec_elements.2920:
	lw	$3, 4($28)
	set	$4, 0
	slt	$27, $2, $4
	bne	$27, $0, ble_else.10657
	sw	$28, 0($29)
	sw	$1, 4($29)
	sw	$2, 8($29)
	mov	$28, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -16
	lw	$31, 12($29)
	lw	$2, 8($29)
	sll	$3, $2, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	set	$1, 1
	sub	$2, $2, $1
	lw	$28, 0($29)
	mov	$1, $4
	lw	$27, 0($28)
	jr	$27
ble_else.10657:
	jr $31
create_dirvecs.2923:
	lw	$2, 12($28)
	lw	$3, 8($28)
	lw	$4, 4($28)
	set	$5, 0
	slt	$27, $1, $5
	bne	$27, $0, ble_else.10659
	set	$5, 120
	sw	$28, 0($29)
	sw	$3, 4($29)
	sw	$2, 8($29)
	sw	$1, 12($29)
	sw	$5, 16($29)
	mov	$28, $4
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	mov	$2, $1
	lw	$1, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_create_array
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 12($29)
	sll	$3, $2, 2
	lw	$4, 8($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	sll	$1, $2, 2
	add	$27, $1, $4
	lw	$1, 0($27)
	set	$3, 118
	lw	$28, 4($29)
	mov	$2, $3
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	set	$1, 1
	lw	$2, 12($29)
	sub	$1, $2, $1
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10659:
	jr $31
init_dirvec_constants.2925:
	lw	$3, 8($28)
	lw	$4, 4($28)
	set	$5, 0
	slt	$27, $2, $5
	bne	$27, $0, ble_else.10661
	sll	$5, $2, 2
	add	$27, $5, $1
	lw	$5, 0($27)
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $3
	lw	$3, 0($27)
	set	$6, 1
	sub	$3, $3, $6
	sw	$1, 0($29)
	sw	$28, 4($29)
	sw	$2, 8($29)
	mov	$2, $3
	mov	$1, $5
	mov	$28, $4
	sw	$31, 12($29)
	addi	$29, $29, 16
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -16
	lw	$31, 12($29)
	set	$1, 1
	lw	$2, 8($29)
	sub	$2, $2, $1
	lw	$1, 0($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10661:
	jr $31
init_vecset_constants.2928:
	lw	$2, 8($28)
	lw	$3, 4($28)
	set	$4, 0
	slt	$27, $1, $4
	bne	$27, $0, ble_else.10663
	sll	$4, $1, 2
	add	$27, $4, $3
	lw	$3, 0($27)
	set	$4, 119
	sw	$28, 0($29)
	sw	$1, 4($29)
	mov	$1, $3
	mov	$28, $2
	mov	$2, $4
	sw	$31, 12($29)
	addi	$29, $29, 16
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -16
	lw	$31, 12($29)
	set	$1, 1
	lw	$2, 4($29)
	sub	$1, $2, $1
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.10663:
	jr $31
init_dirvecs.2930:
	lw	$1, 12($28)
	lw	$2, 8($28)
	lw	$3, 4($28)
	set	$4, 4
	sw	$1, 0($29)
	sw	$3, 4($29)
	mov	$1, $4
	mov	$28, $2
	sw	$31, 12($29)
	addi	$29, $29, 16
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -16
	lw	$31, 12($29)
	set	$1, 9
	set	$2, 0
	set	$3, 0
	lw	$28, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -16
	lw	$31, 12($29)
	set	$1, 4
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
add_reflection.2932:
	lw	$3, 16($28)
	lw	$4, 12($28)
	lw	$5, 8($28)
	lw	$28, 4($28)
	sw	$3, 0($29)
	sw	$1, 4($29)
	sw	$2, 8($29)
	swc	$f0, 12($29)
	sw	$5, 16($29)
	sw	$4, 20($29)
	swc	$f3, 24($29)
	swc	$f2, 28($29)
	swc	$f1, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	lw	$2, 0($1)
	lwc	$f0, 32($29)
	lwc	$f1, 28($29)
	lwc	$f2, 24($29)
	sw	$1, 36($29)
	mov	$1, $2
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	vecset.2474
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	set	$2, 1
	sub	$2, $1, $2
	lw	$1, 36($29)
	lw	$28, 16($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	mov	$1, $30
	addi	$30, $30, 16
	lwc	$f0, 12($29)
	swc	$f0, 8($1)
	lw	$2, 36($29)
	sw	$2, 4($1)
	lw	$2, 8($29)
	sw	$2, 0($1)
	lw	$2, 4($29)
	sll	$2, $2, 2
	lw	$3, 0($29)
	add	$27, $2, $3
	sw	$1, 0($27)
	jr $31
setup_rect_reflection.2939:
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$5, 4($28)
	sll	$1, $1, 2
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $3
	lw	$6, 0($27)
	setclv	$f0, l.7946
	lw	$2, 28($2)
	set	$7, 0
	sll	$7, $7, 2
	add	$27, $7, $2
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $4
	lwc	$f1, 0($27)
	sw	$3, 0($29)
	swc	$f0, 4($29)
	sw	$6, 8($29)
	sw	$5, 12($29)
	sw	$1, 16($29)
	sw	$4, 20($29)
	mov.s	$f0, $f1
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fneg
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	swc	$f0, 24($29)
	mov.s	$f0, $f1
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fneg
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	swc	$f0, 28($29)
	mov.s	$f0, $f1
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fneg
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	mov.s	$f3, $f0
	lw	$1, 16($29)
	addi	$2, $1, 1
	set	$3, 0
	sll	$3, $3, 2
	lw	$4, 20($29)
	add	$27, $3, $4
	lwc	$f1, 0($27)
	lwc	$f0, 4($29)
	lwc	$f2, 28($29)
	lw	$3, 8($29)
	lw	$28, 12($29)
	swc	$f3, 32($29)
	mov	$1, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	lw	$1, 8($29)
	addi	$2, $1, 1
	lw	$3, 16($29)
	addi	$4, $3, 2
	set	$5, 1
	sll	$5, $5, 2
	lw	$6, 20($29)
	add	$27, $5, $6
	lwc	$f2, 0($27)
	lwc	$f0, 4($29)
	lwc	$f1, 24($29)
	lwc	$f3, 32($29)
	lw	$28, 12($29)
	mov	$1, $2
	mov	$2, $4
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	lw	$1, 8($29)
	addi	$2, $1, 2
	lw	$3, 16($29)
	addi	$3, $3, 3
	set	$4, 2
	sll	$4, $4, 2
	lw	$5, 20($29)
	add	$27, $4, $5
	lwc	$f3, 0($27)
	lwc	$f0, 4($29)
	lwc	$f1, 24($29)
	lwc	$f2, 28($29)
	lw	$28, 12($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	set	$1, 0
	lw	$2, 8($29)
	addi	$2, $2, 3
	sll	$1, $1, 2
	lw	$3, 0($29)
	add	$27, $1, $3
	sw	$2, 0($27)
	jr $31
setup_surface_reflection.2942:
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$5, 4($28)
	sll	$1, $1, 2
	addi	$1, $1, 1
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $3
	lw	$6, 0($27)
	setclv	$f0, l.7946
	lw	$7, 28($2)
	set	$8, 0
	sll	$8, $8, 2
	add	$27, $8, $7
	lwc	$f1, 0($27)
	sub.s	$f0, $f0, $f1
	lw	$7, 16($2)
	sw	$3, 0($29)
	swc	$f0, 4($29)
	sw	$1, 8($29)
	sw	$6, 12($29)
	sw	$5, 16($29)
	sw	$4, 20($29)
	sw	$2, 24($29)
	mov	$2, $7
	mov	$1, $4
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	veciprod.2495
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	setclv	$f1, l.8054
	lw	$1, 24($29)
	lw	$2, 16($1)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lwc	$f2, 0($27)
	mul.s	$f1, $f1, $f2
	mul.s	$f1, $f1, $f0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 20($29)
	add	$27, $2, $3
	lwc	$f2, 0($27)
	sub.s	$f1, $f1, $f2
	setclv	$f2, l.8054
	lw	$2, 16($1)
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $2
	lwc	$f3, 0($27)
	mul.s	$f2, $f2, $f3
	mul.s	$f2, $f2, $f0
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $3
	lwc	$f3, 0($27)
	sub.s	$f2, $f2, $f3
	setclv	$f3, l.8054
	lw	$1, 16($1)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f4, 0($27)
	mul.s	$f3, $f3, $f4
	mul.s	$f0, $f3, $f0
	set	$1, 2
	sll	$1, $1, 2
	add	$27, $1, $3
	lwc	$f3, 0($27)
	sub.s	$f3, $f0, $f3
	lwc	$f0, 4($29)
	lw	$1, 12($29)
	lw	$2, 8($29)
	lw	$28, 16($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	set	$1, 0
	lw	$2, 12($29)
	addi	$2, $2, 1
	sll	$1, $1, 2
	lw	$3, 0($29)
	add	$27, $1, $3
	sw	$2, 0($27)
	jr $31
setup_reflections.2945:
	lw	$2, 12($28)
	lw	$3, 8($28)
	lw	$4, 4($28)
	set	$5, 0
	slt	$27, $1, $5
	bne	$27, $0, ble_else.10668
	sll	$5, $1, 2
	add	$27, $5, $4
	lw	$4, 0($27)
	lw	$5, 8($4)
	set	$6, 2
	bne	$5, $6, beq_else.10669
	lw	$5, 28($4)
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $5
	lwc	$f0, 0($27)
	setclv	$f1, l.7946
	sw	$2, 0($29)
	sw	$1, 4($29)
	sw	$3, 8($29)
	sw	$4, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fless
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.10670
	jr $31
beq_else.10670:
	lw	$2, 12($29)
	lw	$1, 4($2)
	set	$3, 1
	bne	$1, $3, beq_else.10672
	lw	$1, 4($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10672:
	set	$3, 2
	bne	$1, $3, beq_else.10673
	lw	$1, 4($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
beq_else.10673:
	jr $31
beq_else.10669:
	jr $31
ble_else.10668:
	jr $31
rt.2947:
	lw	$3, 60($28)
	lw	$4, 56($28)
	lw	$5, 52($28)
	lw	$6, 48($28)
	lw	$7, 44($28)
	lw	$8, 40($28)
	lw	$9, 36($28)
	lw	$10, 32($28)
	lw	$11, 28($28)
	lw	$12, 24($28)
	lw	$13, 20($28)
	lw	$14, 16($28)
	lw	$15, 12($28)
	lw	$16, 8($28)
	lw	$17, 4($28)
	set	$18, 0
	sll	$18, $18, 2
	add	$27, $18, $15
	sw	$1, 0($27)
	set	$18, 1
	sll	$18, $18, 2
	add	$27, $18, $15
	sw	$2, 0($27)
	set	$15, 0
	set	$18, 2
	sra	$18, $1, 1
	sll	$15, $15, 2
	add	$27, $15, $16
	sw	$18, 0($27)
	set	$15, 1
	set	$18, 2
	sra	$2, $2, 1
	sll	$15, $15, 2
	add	$27, $15, $16
	sw	$2, 0($27)
	set	$2, 0
	setclv	$f0, l.8609
	sw	$7, 0($29)
	sw	$9, 4($29)
	sw	$5, 8($29)
	sw	$11, 12($29)
	sw	$13, 16($29)
	sw	$10, 20($29)
	sw	$12, 24($29)
	sw	$4, 28($29)
	sw	$14, 32($29)
	sw	$3, 36($29)
	sw	$8, 40($29)
	sw	$17, 44($29)
	sw	$6, 48($29)
	sw	$2, 52($29)
	swc	$f0, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_float_of_int
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 56($29)
	div.s	$f0, $f1, $f0
	lw	$1, 52($29)
	sll	$1, $1, 2
	lw	$2, 48($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	lw	$28, 44($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	lw	$28, 44($29)
	sw	$1, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	lw	$28, 44($29)
	sw	$1, 64($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	set	$2, 170
	sw	$1, 68($29)
	mov	$1, $2
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_print_char
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lw	$28, 40($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -80
	lw	$31, 76($29)
	lw	$28, 36($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -80
	lw	$31, 76($29)
	lw	$28, 32($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -80
	lw	$31, 76($29)
	lw	$1, 28($29)
	lw	$2, 24($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	veccpy.2484
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	set	$3, 1
	sub	$1, $1, $3
	lw	$3, 12($29)
	lw	$28, 16($29)
	mov	$2, $1
	mov	$1, $3
	sw	$31, 76($29)
	addi	$29, $29, 80
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -80
	lw	$31, 76($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	set	$2, 1
	sub	$1, $1, $2
	lw	$28, 8($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -80
	lw	$31, 76($29)
	set	$2, 0
	set	$3, 0
	lw	$1, 64($29)
	lw	$28, 4($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -80
	lw	$31, 76($29)
	set	$1, 0
	set	$5, 2
	lw	$2, 60($29)
	lw	$3, 64($29)
	lw	$4, 68($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
min_caml_start:
	set	$1, 1
	set	$2, 0
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_create_array
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 0
	setclv	$f0, l.7945
	sw	$1, 0($29)
	mov	$1, $2
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 60
	set	$3, 0
	set	$4, 0
	set	$5, 0
	set	$6, 0
	set	$7, 0
	mov	$8, $30
	addi	$30, $30, 48
	sw	$1, 40($8)
	sw	$1, 36($8)
	sw	$1, 32($8)
	sw	$1, 28($8)
	sw	$7, 24($8)
	sw	$1, 20($8)
	sw	$1, 16($8)
	sw	$6, 12($8)
	sw	$5, 8($8)
	sw	$4, 4($8)
	sw	$3, 0($8)
	mov	$1, $8
	mov	$27, $2
	mov	$2, $1
	mov	$1, $27
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_create_array
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 4($29)
	mov	$1, $2
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 8($29)
	mov	$1, $2
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 12($29)
	mov	$1, $2
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 1
	setclv	$f0, l.8404
	sw	$1, 16($29)
	mov	$1, $2
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 50
	set	$3, 1
	set	$4, -1
	sw	$1, 20($29)
	sw	$2, 24($29)
	mov	$2, $4
	mov	$1, $3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_create_array
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	mov	$2, $1
	lw	$1, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_create_array
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 1
	set	$3, 1
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $1
	lw	$4, 0($27)
	sw	$1, 28($29)
	sw	$2, 32($29)
	mov	$2, $4
	mov	$1, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_create_array
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	mov	$2, $1
	lw	$1, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_create_array
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 1
	setclv	$f0, l.7945
	sw	$1, 36($29)
	mov	$1, $2
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 1
	set	$3, 0
	sw	$1, 40($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_create_array
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 1
	setclv	$f0, l.8326
	sw	$1, 44($29)
	mov	$1, $2
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 48($29)
	mov	$1, $2
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 1
	set	$3, 0
	sw	$1, 52($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_create_array
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 56($29)
	mov	$1, $2
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 60($29)
	mov	$1, $2
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 64($29)
	mov	$1, $2
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 68($29)
	mov	$1, $2
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	set	$2, 2
	set	$3, 0
	sw	$1, 72($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_create_array
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	set	$2, 2
	set	$3, 0
	sw	$1, 76($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	min_caml_create_array
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	set	$2, 1
	setclv	$f0, l.7945
	sw	$1, 80($29)
	mov	$1, $2
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 84($29)
	mov	$1, $2
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 88($29)
	mov	$1, $2
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 92($29)
	mov	$1, $2
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 96($29)
	mov	$1, $2
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 100($29)
	mov	$1, $2
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 104($29)
	mov	$1, $2
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	set	$2, 0
	setclv	$f0, l.7945
	sw	$1, 108($29)
	mov	$1, $2
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	mov	$2, $1
	set	$1, 0
	sw	$2, 112($29)
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	min_caml_create_array
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	set	$2, 0
	mov	$3, $30
	addi	$30, $30, 8
	sw	$1, 4($3)
	lw	$1, 112($29)
	sw	$1, 0($3)
	mov	$1, $3
	mov	$27, $2
	mov	$2, $1
	mov	$1, $27
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	min_caml_create_array
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	mov	$2, $1
	set	$1, 5
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	min_caml_create_array
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	set	$2, 0
	setclv	$f0, l.7945
	sw	$1, 116($29)
	mov	$1, $2
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	set	$2, 3
	setclv	$f0, l.7945
	sw	$1, 120($29)
	mov	$1, $2
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	set	$2, 60
	lw	$3, 120($29)
	sw	$1, 124($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	min_caml_create_array
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	mov	$2, $30
	addi	$30, $30, 8
	sw	$1, 4($2)
	lw	$1, 124($29)
	sw	$1, 0($2)
	set	$3, 0
	setclv	$f0, l.7945
	sw	$2, 128($29)
	mov	$1, $3
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	mov	$2, $1
	set	$1, 0
	sw	$2, 132($29)
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	min_caml_create_array
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	mov	$2, $30
	addi	$30, $30, 8
	sw	$1, 4($2)
	lw	$1, 132($29)
	sw	$1, 0($2)
	mov	$1, $2
	set	$2, 180
	set	$3, 0
	setclv	$f0, l.7945
	mov	$4, $30
	addi	$30, $30, 16
	swc	$f0, 8($4)
	sw	$1, 4($4)
	sw	$3, 0($4)
	mov	$1, $4
	mov	$27, $2
	mov	$2, $1
	mov	$1, $27
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	min_caml_create_array
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	set	$2, 1
	set	$3, 0
	sw	$1, 136($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	min_caml_create_array
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	mov	$2, $30
	addi	$30, $30, 24
	setl	$3, read_screen_settings.2593
	sw	$3, 0($2)
	lw	$3, 12($29)
	sw	$3, 20($2)
	lw	$4, 104($29)
	sw	$4, 16($2)
	lw	$5, 100($29)
	sw	$5, 12($2)
	lw	$6, 96($29)
	sw	$6, 8($2)
	lw	$7, 8($29)
	sw	$7, 4($2)
	mov	$7, $30
	addi	$30, $30, 16
	setl	$8, read_light.2595
	sw	$8, 0($7)
	lw	$8, 16($29)
	sw	$8, 8($7)
	lw	$9, 20($29)
	sw	$9, 4($7)
	mov	$10, $30
	addi	$30, $30, 8
	setl	$11, read_nth_object.2600
	sw	$11, 0($10)
	lw	$11, 4($29)
	sw	$11, 4($10)
	mov	$12, $30
	addi	$30, $30, 16
	setl	$13, read_object.2602
	sw	$13, 0($12)
	sw	$10, 8($12)
	lw	$10, 0($29)
	sw	$10, 4($12)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$14, read_and_network.2610
	sw	$14, 0($13)
	lw	$14, 28($29)
	sw	$14, 4($13)
	mov	$15, $30
	addi	$30, $30, 24
	setl	$16, read_parameter.2612
	sw	$16, 0($15)
	sw	$2, 20($15)
	sw	$12, 16($15)
	sw	$7, 12($15)
	sw	$13, 8($15)
	lw	$2, 36($29)
	sw	$2, 4($15)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$12, solver_rect_surface.2614
	sw	$12, 0($7)
	lw	$12, 40($29)
	sw	$12, 4($7)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$16, solver_rect.2623
	sw	$16, 0($13)
	sw	$7, 4($13)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$16, solver_surface.2629
	sw	$16, 0($7)
	sw	$12, 4($7)
	mov	$16, $30
	addi	$30, $30, 8
	setl	$17, solver_second.2648
	sw	$17, 0($16)
	sw	$12, 4($16)
	mov	$17, $30
	addi	$30, $30, 24
	setl	$18, solver.2654
	sw	$18, 0($17)
	sw	$7, 16($17)
	sw	$16, 12($17)
	sw	$13, 8($17)
	sw	$11, 4($17)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$13, solver_rect_fast.2658
	sw	$13, 0($7)
	sw	$12, 4($7)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$16, solver_surface_fast.2665
	sw	$16, 0($13)
	sw	$12, 4($13)
	mov	$16, $30
	addi	$30, $30, 8
	setl	$18, solver_second_fast.2671
	sw	$18, 0($16)
	sw	$12, 4($16)
	mov	$18, $30
	addi	$30, $30, 24
	setl	$19, solver_fast.2677
	sw	$19, 0($18)
	sw	$13, 16($18)
	sw	$16, 12($18)
	sw	$7, 8($18)
	sw	$11, 4($18)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$16, solver_surface_fast2.2681
	sw	$16, 0($13)
	sw	$12, 4($13)
	mov	$16, $30
	addi	$30, $30, 8
	setl	$19, solver_second_fast2.2688
	sw	$19, 0($16)
	sw	$12, 4($16)
	mov	$19, $30
	addi	$30, $30, 24
	setl	$20, solver_fast2.2695
	sw	$20, 0($19)
	sw	$13, 16($19)
	sw	$16, 12($19)
	sw	$7, 8($19)
	sw	$11, 4($19)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$13, iter_setup_dirvec_constants.2707
	sw	$13, 0($7)
	sw	$11, 4($7)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$16, setup_startp_constants.2712
	sw	$16, 0($13)
	sw	$11, 4($13)
	mov	$16, $30
	addi	$30, $30, 16
	setl	$20, setup_startp.2715
	sw	$20, 0($16)
	lw	$20, 92($29)
	sw	$20, 12($16)
	sw	$13, 8($16)
	sw	$10, 4($16)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$21, check_all_inside.2737
	sw	$21, 0($13)
	sw	$11, 4($13)
	mov	$21, $30
	addi	$30, $30, 32
	setl	$22, shadow_check_and_group.2743
	sw	$22, 0($21)
	sw	$18, 28($21)
	sw	$12, 24($21)
	sw	$11, 20($21)
	lw	$22, 128($29)
	sw	$22, 16($21)
	sw	$8, 12($21)
	lw	$23, 52($29)
	sw	$23, 8($21)
	sw	$13, 4($21)
	mov	$24, $30
	addi	$30, $30, 16
	setl	$25, shadow_check_one_or_group.2746
	sw	$25, 0($24)
	sw	$21, 8($24)
	sw	$14, 4($24)
	mov	$21, $30
	addi	$30, $30, 24
	setl	$25, shadow_check_one_or_matrix.2749
	sw	$25, 0($21)
	sw	$18, 20($21)
	sw	$12, 16($21)
	sw	$24, 12($21)
	sw	$22, 8($21)
	sw	$23, 4($21)
	mov	$18, $30
	addi	$30, $30, 40
	setl	$24, solve_each_element.2752
	sw	$24, 0($18)
	lw	$24, 48($29)
	sw	$24, 36($18)
	lw	$25, 88($29)
	sw	$25, 32($18)
	sw	$12, 28($18)
	sw	$17, 24($18)
	sw	$11, 20($18)
	lw	$26, 44($29)
	sw	$26, 16($18)
	sw	$23, 12($18)
	lw	$27, 56($29)
	sw	$27, 8($18)
	sw	$13, 4($18)
	mov	$28, $30
	addi	$30, $30, 16
	setl	$22, solve_one_or_network.2756
	sw	$22, 0($28)
	sw	$18, 8($28)
	sw	$14, 4($28)
	mov	$18, $30
	addi	$30, $30, 24
	setl	$22, trace_or_matrix.2760
	sw	$22, 0($18)
	sw	$24, 20($18)
	sw	$25, 16($18)
	sw	$12, 12($18)
	sw	$17, 8($18)
	sw	$28, 4($18)
	mov	$17, $30
	addi	$30, $30, 16
	setl	$22, judge_intersection.2764
	sw	$22, 0($17)
	sw	$18, 12($17)
	sw	$24, 8($17)
	sw	$2, 4($17)
	mov	$18, $30
	addi	$30, $30, 40
	setl	$22, solve_each_element_fast.2766
	sw	$22, 0($18)
	sw	$24, 36($18)
	sw	$20, 32($18)
	sw	$19, 28($18)
	sw	$12, 24($18)
	sw	$11, 20($18)
	sw	$26, 16($18)
	sw	$23, 12($18)
	sw	$27, 8($18)
	sw	$13, 4($18)
	mov	$13, $30
	addi	$30, $30, 16
	setl	$20, solve_one_or_network_fast.2770
	sw	$20, 0($13)
	sw	$18, 8($13)
	sw	$14, 4($13)
	mov	$14, $30
	addi	$30, $30, 24
	setl	$18, trace_or_matrix_fast.2774
	sw	$18, 0($14)
	sw	$24, 16($14)
	sw	$19, 12($14)
	sw	$12, 8($14)
	sw	$13, 4($14)
	mov	$12, $30
	addi	$30, $30, 16
	setl	$13, judge_intersection_fast.2778
	sw	$13, 0($12)
	sw	$14, 12($12)
	sw	$24, 8($12)
	sw	$2, 4($12)
	mov	$13, $30
	addi	$30, $30, 16
	setl	$14, get_nvector_rect.2780
	sw	$14, 0($13)
	lw	$14, 60($29)
	sw	$14, 8($13)
	sw	$26, 4($13)
	mov	$18, $30
	addi	$30, $30, 8
	setl	$19, get_nvector_plane.2782
	sw	$19, 0($18)
	sw	$14, 4($18)
	mov	$19, $30
	addi	$30, $30, 16
	setl	$20, get_nvector_second.2784
	sw	$20, 0($19)
	sw	$14, 8($19)
	sw	$23, 4($19)
	mov	$20, $30
	addi	$30, $30, 8
	setl	$22, utexture.2789
	sw	$22, 0($20)
	lw	$22, 64($29)
	sw	$22, 4($20)
	mov	$28, $30
	addi	$30, $30, 16
	sw	$15, 140($29)
	setl	$15, add_light.2792
	sw	$15, 0($28)
	sw	$22, 8($28)
	lw	$15, 72($29)
	sw	$15, 4($28)
	sw	$7, 144($29)
	mov	$7, $30
	addi	$30, $30, 40
	setl	$10, trace_reflections.2796
	sw	$10, 0($7)
	sw	$21, 32($7)
	lw	$10, 136($29)
	sw	$10, 28($7)
	sw	$2, 24($7)
	sw	$14, 20($7)
	sw	$12, 16($7)
	sw	$26, 12($7)
	sw	$27, 8($7)
	sw	$28, 4($7)
	mov	$10, $30
	addi	$30, $30, 96
	setl	$5, trace_ray.2801
	sw	$5, 0($10)
	sw	$20, 88($10)
	sw	$7, 84($10)
	sw	$24, 80($10)
	sw	$22, 76($10)
	sw	$25, 72($10)
	sw	$21, 68($10)
	sw	$16, 64($10)
	sw	$15, 60($10)
	sw	$2, 56($10)
	sw	$11, 52($10)
	sw	$14, 48($10)
	sw	$1, 44($10)
	sw	$8, 40($10)
	sw	$17, 36($10)
	sw	$26, 32($10)
	sw	$23, 28($10)
	sw	$27, 24($10)
	sw	$19, 20($10)
	sw	$13, 16($10)
	sw	$18, 12($10)
	sw	$9, 8($10)
	sw	$28, 4($10)
	mov	$5, $30
	addi	$30, $30, 64
	setl	$7, trace_diffuse_ray.2807
	sw	$7, 0($5)
	sw	$20, 56($5)
	sw	$22, 52($5)
	sw	$21, 48($5)
	sw	$2, 44($5)
	sw	$11, 40($5)
	sw	$14, 36($5)
	sw	$8, 32($5)
	sw	$12, 28($5)
	sw	$23, 24($5)
	sw	$27, 20($5)
	sw	$19, 16($5)
	sw	$13, 12($5)
	sw	$18, 8($5)
	lw	$2, 68($29)
	sw	$2, 4($5)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$9, iter_trace_diffuse_rays.2810
	sw	$9, 0($7)
	sw	$5, 4($7)
	mov	$5, $30
	addi	$30, $30, 16
	setl	$9, trace_diffuse_ray_80percent.2819
	sw	$9, 0($5)
	sw	$16, 12($5)
	sw	$7, 8($5)
	lw	$9, 116($29)
	sw	$9, 4($5)
	mov	$12, $30
	addi	$30, $30, 16
	setl	$13, calc_diffuse_using_1point.2823
	sw	$13, 0($12)
	sw	$5, 12($12)
	sw	$15, 8($12)
	sw	$2, 4($12)
	mov	$5, $30
	addi	$30, $30, 16
	setl	$13, calc_diffuse_using_5points.2826
	sw	$13, 0($5)
	sw	$15, 8($5)
	sw	$2, 4($5)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$14, do_without_neighbors.2832
	sw	$14, 0($13)
	sw	$12, 4($13)
	mov	$12, $30
	addi	$30, $30, 8
	setl	$14, neighbors_exist.2835
	sw	$14, 0($12)
	lw	$14, 76($29)
	sw	$14, 4($12)
	mov	$17, $30
	addi	$30, $30, 16
	setl	$18, try_exploit_neighbors.2848
	sw	$18, 0($17)
	sw	$13, 8($17)
	sw	$5, 4($17)
	mov	$5, $30
	addi	$30, $30, 8
	setl	$18, write_ppm_header.2855
	sw	$18, 0($5)
	sw	$14, 4($5)
	mov	$18, $30
	addi	$30, $30, 8
	setl	$19, write_rgb.2859
	sw	$19, 0($18)
	sw	$15, 4($18)
	mov	$19, $30
	addi	$30, $30, 24
	setl	$20, pretrace_diffuse_rays.2861
	sw	$20, 0($19)
	sw	$16, 16($19)
	sw	$7, 12($19)
	sw	$9, 8($19)
	sw	$2, 4($19)
	mov	$2, $30
	addi	$30, $30, 40
	setl	$7, pretrace_pixels.2864
	sw	$7, 0($2)
	sw	$3, 36($2)
	sw	$10, 32($2)
	sw	$25, 28($2)
	sw	$6, 24($2)
	lw	$3, 84($29)
	sw	$3, 20($2)
	sw	$15, 16($2)
	lw	$6, 108($29)
	sw	$6, 12($2)
	sw	$19, 8($2)
	lw	$6, 80($29)
	sw	$6, 4($2)
	mov	$7, $30
	addi	$30, $30, 32
	setl	$10, pretrace_line.2871
	sw	$10, 0($7)
	sw	$4, 24($7)
	lw	$4, 100($29)
	sw	$4, 20($7)
	sw	$3, 16($7)
	sw	$2, 12($7)
	sw	$14, 8($7)
	sw	$6, 4($7)
	mov	$2, $30
	addi	$30, $30, 32
	setl	$4, scan_pixel.2875
	sw	$4, 0($2)
	sw	$18, 24($2)
	sw	$17, 20($2)
	sw	$15, 16($2)
	sw	$12, 12($2)
	sw	$14, 8($2)
	sw	$13, 4($2)
	mov	$4, $30
	addi	$30, $30, 16
	setl	$10, scan_line.2881
	sw	$10, 0($4)
	sw	$2, 12($4)
	sw	$7, 8($4)
	sw	$14, 4($4)
	mov	$2, $30
	addi	$30, $30, 8
	setl	$10, create_pixelline.2894
	sw	$10, 0($2)
	sw	$14, 4($2)
	mov	$10, $30
	addi	$30, $30, 8
	setl	$12, calc_dirvec.2901
	sw	$12, 0($10)
	sw	$9, 4($10)
	mov	$12, $30
	addi	$30, $30, 8
	setl	$13, calc_dirvecs.2909
	sw	$13, 0($12)
	sw	$10, 4($12)
	mov	$10, $30
	addi	$30, $30, 8
	setl	$13, calc_dirvec_rows.2914
	sw	$13, 0($10)
	sw	$12, 4($10)
	mov	$12, $30
	addi	$30, $30, 8
	setl	$13, create_dirvec.2918
	sw	$13, 0($12)
	lw	$13, 0($29)
	sw	$13, 4($12)
	mov	$15, $30
	addi	$30, $30, 8
	setl	$16, create_dirvec_elements.2920
	sw	$16, 0($15)
	sw	$12, 4($15)
	mov	$16, $30
	addi	$30, $30, 16
	setl	$17, create_dirvecs.2923
	sw	$17, 0($16)
	sw	$9, 12($16)
	sw	$15, 8($16)
	sw	$12, 4($16)
	mov	$15, $30
	addi	$30, $30, 16
	setl	$17, init_dirvec_constants.2925
	sw	$17, 0($15)
	sw	$13, 8($15)
	lw	$17, 144($29)
	sw	$17, 4($15)
	mov	$18, $30
	addi	$30, $30, 16
	setl	$19, init_vecset_constants.2928
	sw	$19, 0($18)
	sw	$15, 8($18)
	sw	$9, 4($18)
	mov	$9, $30
	addi	$30, $30, 16
	setl	$15, init_dirvecs.2930
	sw	$15, 0($9)
	sw	$18, 12($9)
	sw	$16, 8($9)
	sw	$10, 4($9)
	mov	$10, $30
	addi	$30, $30, 24
	setl	$15, add_reflection.2932
	sw	$15, 0($10)
	lw	$15, 136($29)
	sw	$15, 16($10)
	sw	$13, 12($10)
	sw	$17, 8($10)
	sw	$12, 4($10)
	mov	$12, $30
	addi	$30, $30, 16
	setl	$15, setup_rect_reflection.2939
	sw	$15, 0($12)
	sw	$1, 12($12)
	sw	$8, 8($12)
	sw	$10, 4($12)
	mov	$15, $30
	addi	$30, $30, 16
	setl	$16, setup_surface_reflection.2942
	sw	$16, 0($15)
	sw	$1, 12($15)
	sw	$8, 8($15)
	sw	$10, 4($15)
	mov	$1, $30
	addi	$30, $30, 16
	setl	$10, setup_reflections.2945
	sw	$10, 0($1)
	sw	$15, 12($1)
	sw	$12, 8($1)
	sw	$11, 4($1)
	mov	$28, $30
	addi	$30, $30, 64
	setl	$10, rt.2947
	sw	$10, 0($28)
	sw	$5, 60($28)
	lw	$5, 124($29)
	sw	$5, 56($28)
	sw	$1, 52($28)
	sw	$3, 48($28)
	sw	$4, 44($28)
	lw	$1, 140($29)
	sw	$1, 40($28)
	sw	$7, 36($28)
	sw	$13, 32($28)
	lw	$1, 128($29)
	sw	$1, 28($28)
	sw	$8, 24($28)
	sw	$17, 20($28)
	sw	$9, 16($28)
	sw	$14, 12($28)
	sw	$6, 8($28)
	sw	$2, 4($28)
	set	$1, 128
	set	$2, 128
	sw	$31, 148($29)
	addi	$29, $29, 152
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -152
	lw	$31, 148($29)
	jr	$31
min_caml_print_int:
mov  $19, $29 #stack pointer

slt  $11, $1, $0 #負の数か？
beq  $11, $0, print_int_neg_finish

#negateする
addi $11, $0, -1 #0xffffffff
xor  $1, $1, $11
addi $1, $1, 1

# print '-'
addi $11, $0, 45
sw   $11, -1($0)

print_int_neg_finish:

set  $9, 9 #const for slt

set  $5, 9 #counter
print_int_divloop:

# http://www.hackersdelight.org/divcMore.pdf
# q = (n >> 1) + (n >> 2);
srl $11, $1, 1
srl $12, $1, 2
add $11, $11, $12

# q = q + (q >> 4);
srl $12, $11, 4
add $11, $11, $12

# q = q + (q >> 8);
srl $12, $11, 8
add $11, $11, $12

# q = q + (q >> 16);
srl $12, $11, 16
add $11, $11, $12

# q = q >> 3;
srl $11, $11, 3

# $12=((q << 2) + q)
sll $12, $11, 2
add $12, $11, $12

# $12 << 1
sll $12, $12, 1

# r = n- ...
sub $2, $1, $12

# a = q
mov $1, $11

# if (9<r)
slt $12, $9, $2
beq $12, $0, print_int_div_complete

addi $1, $1, 1
addi $2, $2, -10

# $1 <= $1/10
# $2 <= $1%10

print_int_div_complete:
sw $2, 0($19)
addi $19, $19, 4
addi $5, $5, -1
bne $5, $0, print_int_divloop


# 表示部分

sw $1, 0($19)
set $6, 0 #flag: 最上位はもうあった？

set $5, 10 #counter
print_int_showloop:
addi $5, $5, -1
lw $1, 0($19)

beq $5, $0, print_int_impl     #最下位は必ず表示する
or $3, $1, $6
beq $3, $0, print_int_continue #上のほうの0なら表示しないでいいです

print_int_impl:
set $6, 1
addi $1, $1, 48 #char '0'
sw $1, -1($0)

print_int_continue:
addi $19, $19, -4
bne $5, $0, print_int_showloop

#leave
jr $31


#16進ダンプします。アセンブラレベルデバッグのためなるべくレジスタ使わない方向で
# $1...引数 $12,$13,$14使用

min_caml_print_fhex:
mfc1 $1, $f0

min_caml_print_hex:
ori $12, $0, 0x30 #'0'
sw $12, -1($0)
ori $12, $0, 0x78 #'x'
sw $12, -1($0)

#counter
ori $13, $0, 32

print_hex_loop:
addi $13, $13, -4

srlv $14, $1, $13
andi $14, $14, 15

addi $12, $14, -10
slt $12, $12, $0

addi $14, $14, 48

bne $12, $0, print_hex_u10
addi $14, $14, 7

print_hex_u10:
sw $14, -1($0)

bne $13, $0, print_hex_loop

ori $12, $0, 0x0a #\n
sw $12, -1($0)
jr $31





min_caml_print_char:
	sw	$1, -1($0)
	jr	$31

min_caml_print_xfloat:
	mfc1 $1, $f0
	j min_caml_print_int


# print to stderr
min_caml_prerr_int:
	sw	$1, -3($0)
	jr	$31
min_caml_prerr_char:
	sw	$1, -4($0)
	jr	$31
min_caml_prerr_float:
	swc	$f0, -5($0)
	jr	$31
min_caml_halt:
	halt

min_caml_read_int:
	lw	$1, -1($0)
	jr	$31

min_caml_read_float:
	lwc	$f0, -2($0)
	jr	$31

min_caml_read_raw:
	lwc	$f0, -3($0)
	jr	$31

min_caml_print_newline:
	lli	$1, 0xa
	sw	$1,-1($0)
    jr  $31

min_caml_abs_float:
	abs.s	$f0, $f0
	jr	$31

min_caml_fabs:
	abs.s	$f0, $f0
	jr	$31

min_caml_sqrt:
	sqrt.s	$f0, $f0
	jr	$31

min_caml_float_of_int:
	mtc	$1, $f0
	cvt.s.w	$f0, $f0
	jr	$31

min_caml_int_of_float:
	round.w.s	 $f0, $f0
	mfc	$1, $f0
	jr	$31

min_caml_floor:
    set $1, 0x4b000000
    mtc $1, $f1
    abs.s   $f2, $f0

    c.olt.s $f2, $f1
    bcf floor_ret

	floor.w.s	$f0, $f0
	cvt.s.w	$f0, $f0

floor_ret:
	jr	$31

kernel_sin:
#kernel sin store result in $f15, exponent in $f16, term in $f17 
#	mov.s	$f15, $f0 #first term
#	mov.s $f16, $f0
#
#	mul.s $f16, $f0, $f16 #second term (degree three)
#	mul.s $f16, $f0, $f16
#	mul.s $f17, $f5, $f16
#	add.s $f15, $f15, $f17
#
#	mul.s $f16, $f0, $f16  #third term (degree five) 
#	mul.s $f16, $f0, $f16
#	mul.s $f17, $f6, $f16
#	add.s $f15, $f15, $f17
#
#	mul.s $f16, $f0, $f16 #forth term (degree seven) 
#	mul.s $f16, $f0, $f16
#	mul.s $f17, $f7, $f16
#	add.s $f15, $f15, $f17
#
#	mov.s $f0, $f15

#imporoved with honer method
#store result in $f15, square in $f16
	mul.s	$f16, $f0, $f0
	
	mul.s	$f15, $f7, $f16
	add.s	$f15, $f15, $f6

	mul.s	$f15, $f15, $f16
	add.s	$f15, $f15, $f5
	
	mul.s	$f15, $f15, $f16
	mul.s	$f15, $f15, $f0
	add.s	$f15, $f15, $f0

	mov.s $f0, $f15
    
    jr  $31

kernel_cos:
#kernel cos store result in $f15, exponent in $f16, term in $f17
#	set	$3, 0x3f800000
#	mtc $3, $f16 #1.0
#	mov.s $f15, $f16 #first term (degree zero)
#	mov.s $f16, $f16
#
#
#	mul.s $f16, $f0, $f16 #second term (degree two)
#	mul.s $f16, $f0, $f16
#	mul.s $f17, $f8, $f16
#	add.s $f15, $f15, $f17
#
#	mul.s $f16, $f0, $f16 #third term (degree four) 
#	mul.s $f16, $f0, $f16
#	mul.s $f17, $f9, $f16
#	add.s $f15, $f15, $f17
#
#	mul.s $f16, $f0, $f16 #forth term (degree six) 
#	mul.s $f16, $f0, $f16
#	mul.s $f17, $f10, $f16
#	add.s $f15, $f15, $f17

#imporoved with honer method
#store result in $f15, square in $f16
	mul.s	$f16, $f0, $f0

	mul.s	$f15, $f10, $f16
	add.s	$f15, $f15, $f9

	mul.s	$f15, $f15, $f16
	add.s	$f15, $f15, $f8

	mul.s	$f15, $f15, $f16

	set	$3, 0x3f800000
	mtc $3, $f16 #1.0

	add.s	$f15, $f15, $f16


	mov.s $f0, $f15
	#end kernel cos 

    jr  $31

min_caml_sin:
	set	$1, 0x40490fdb #PI
	mtc	$1, $f2
	set $1, 0x40000000 #2.0
	mtc	$1, $f3
	set	$1, 0x40800000 #4.0 
	mtc	$1, $f4
	set	$1, 0xbe2aaaac #-0.16666668
	mtc	$1, $f5
	set	$1, 0x3c088666 #0.008332824
	mtc	$1, $f6
	set	$1, 0xb94d64b6 #-0.00019587841
	mtc	$1, $f7
	set	$1, 0xbf000000 #-0.5
	mtc	$1, $f8
	set $1, 0x3d2aa789 #0.04166368
	mtc	$1, $f9
	set	$1, 0xbab38106 #-0.0013695068
	mtc	$1, $f10

	#represent sign bit in $2
	set $2, 0x0
	mtc	$2, $f11
	c.olt.s $f0, $f11
	bcf ll.0
	lli $2, 1
ll.0:
	abs.s	$f0, $f0

    #reduction
	mul.s	$f11, $f2, $f3
ll.1:
	c.olt.s	$f0, $f11
	bct	ll.2
	mul.s	$f11, $f11, $f3
	j	ll.1
ll.2:
	mul.s	$f12, $f2, $f3
ll.3:
	c.olt.s	$f0, $f12
	bct ll.5
	c.olt.s	$f0, $f11
	bct ll.4
	sub.s $f0, $f0, $f11
ll.4:
	div.s $f11, $f11, $f3
	j ll.3
ll.5:
	#end reduction

	c.olt.s	$f0, $f2
	bct	ll.6
	sub.s	$f0, $f0, $f2
	# reverse flag
	lli $3, 1
	xor $2, $2, $3


ll.6:
	div.s	$f13, $f2, $f3
	c.olt.s	$f0, $f13
	bct	ll.7
	sub.s	$f0, $f2, $f0
ll.7:

	div.s	$f14, $f2, $f4
	c.olt.s	$f14, $f0
	bct	ll.8
	
	sw	$31, 4($29)
	jal kernel_sin
	nop
	lw  $31, 4($29)

	#kernel sin store result in $f15, exponent in $f16, term in $f17 
	#mov.s	$f15, $f0 #first term
	#mov.s $f16, $f0

	#mul.s $f16, $f0, $f16 #second term (degree three)
	#mul.s $f16, $f0, $f16
    #mfc $1, $f16
    #sw	$1, -1($0)
	#mul.s $f17, $f5, $f16
	#add.s $f15, $f15, $f17

	#mul.s $f16, $f0, $f16  #third term (degree five) 
	#mul.s $f16, $f0, $f16
	#mul.s $f17, $f6, $f16
	#add.s $f15, $f15, $f17

	#mul.s $f16, $f0, $f16 #forth term (degree seven) 
	#mul.s $f16, $f0, $f16
	#mul.s $f17, $f7, $f16
	#add.s $f15, $f15, $f17

	#mov.s $f0, $f15
	#end kernel sin

	j	ll.9	
ll.8:
	sub.s	$f0, $f13, $f0

	sw  $31, 4($29)
	jal kernel_cos
	nop
	lw  $31, 4($29)

	#kernel cos store result in $f15, exponent in $f16, term in $f17
	#set	$3, 0x3f800000
	#mtc $3, $f16 #1.0
	#mov.s $f15, $f16 #first term (degree zero)
	#mov.s $f16, $f16


	#mul.s $f16, $f0, $f16 #second term (degree two)
	#mul.s $f16, $f0, $f16
	#mul.s $f17, $f8, $f16
	#add.s $f15, $f15, $f17

	#mul.s $f16, $f0, $f16 #third term (degree four) 
	#mul.s $f16, $f0, $f16
	#mul.s $f17, $f9, $f16
	#add.s $f15, $f15, $f17

	#mul.s $f16, $f0, $f16 #forth term (degree six) 
	#mul.s $f16, $f0, $f16
	#mul.s $f17, $f10, $f16
	#add.s $f15, $f15, $f17

	#mov.s $f0, $f15
	#end kernel cos 

ll.9:
	beq	$0, $2, ll.10
	neg.s $f0, $f0
ll.10:
	jr	$31

min_caml_cos:
	set	$1, 0x40490fdb #PI
	mtc	$1, $f2
	set $1, 0x40000000 #2.0
	mtc	$1, $f3
	set	$1, 0x40800000 #4.0 
	mtc	$1, $f4
	set	$1, 0xbe2aaaac #-0.16666668
	mtc	$1, $f5
	set	$1, 0x3c088666 #0.008332824
	mtc	$1, $f6
	set	$1, 0xb94d64b6 #-0.00019587841
	mtc	$1, $f7
	set	$1, 0xbf000000 #-0.5
	mtc	$1, $f8
	set $1, 0x3d2aa789 #0.04166368
	mtc	$1, $f9
	set	$1, 0xbab38106 #-0.0013695068
	mtc	$1, $f10

	lli $2, 0x0
	abs.s	$f0, $f0
	#reduction
	mul.s	$f11, $f2, $f3
ll.11:
	c.olt.s	$f0, $f11
	bct	ll.12
	mul.s	$f11, $f11, $f3
	j	ll.11
ll.12:
	mul.s	$f12, $f2, $f3
ll.13:
	c.olt.s	$f0, $f12
	bct ll.15
	c.olt.s	$f0, $f11
	bct ll.14
	sub.s $f0, $f0, $f11
ll.14:
	div.s $f11, $f11, $f3
	j ll.13
ll.15:
	#end reduction

	c.olt.s	$f0, $f2
	bct	ll.16
	sub.s	$f0, $f0, $f2
	# reverse flag
	lli $3, 1
	xor $2, $2, $3

ll.16:
	div.s	$f13, $f2, $f3
	c.olt.s	$f0, $f13
	bct	ll.17
	sub.s	$f0, $f2, $f0
    # reverse flag
	lli $3, 1
	xor $2, $2, $3

ll.17:

	div.s	$f14, $f2, $f4
	c.olt.s	$f0, $f14
	bct	ll.18

	sw  $31, 4($29)
	jal kernel_cos
	nop
	lw  $31, 4($29)

	#kernel cos store result in $f15, exponent in $f16, term in $f17
	#set	$3, 0x3f800000
	#mtc $3, $f16 #1.0
	#mov.s   $f15, $f16
	#add.s $f15, $f15, $f0 #first term (degree zero)

	#mul.s $f16, $f0, $f16 #second term (degree two)
	#mul.s $f16, $f0, $f16
	#mul.s $f17, $f8, $f16
	#add.s $f15, $f15, $f17

	#mul.s $f16, $f0, $f16 #third term (degree four) 
	#mul.s $f16, $f0, $f16
	#mul.s $f17, $f9, $f16
	#add.s $f15, $f15, $f17

	#mul.s $f16, $f0, $f16 #forth term (degree six) 
	#mul.s $f16, $f0, $f16
	#mul.s $f17, $f10, $f16
	#add.s $f15, $f15, $f17

	#mov.s $f0, $f15
	#end kernel cos 

	j	ll.19	
ll.18:
	sub.s	$f0, $f13, $f0
    
	sw  $31, 4($29)
	jal kernel_sin
	nop
	lw  $31, 4($29)

	#kernel sin store result in $f15, exponent in $f16, term in $f17 
	#mov.s	$f15, $f0 #first term
	#mov.s $f16, $f0

	#mul.s $f16, $f0, $f16 #second term (degree three)
	#mul.s $f16, $f0, $f16
	#mul.s $f17, $f5, $f16
	#add.s $f15, $f15, $f17

	#mul.s $f16, $f0, $f16 #third term (degree five) 
	#mul.s $f16, $f0, $f16
	#mul.s $f17, $f6, $f16
	#add.s $f15, $f15, $f17

	#mul.s $f16, $f0, $f16 #forth term (degree seven) 
	#mul.s $f16, $f0, $f16
	#mul.s $f17, $f7, $f16
	#add.s $f15, $f15, $f17

	#mov.s $f0, $f15
	#end kernel sin

ll.19:
	beq	$0, $2, ll.20
	neg.s $f0, $f0
ll.20:
	jr	$31

kernel_atan:
#kernel atan store result in $f14, exponent in $f15, term in $f16
#
#	mov.s $f14, $f0 #first term (degree one)
#	mov.s $f15, $f0
#
#	mul.s $f15, $f0, $f15 #second term (degree three)
#	mul.s $f15, $f0, $f15
#	mul.s $f16, $f7, $f15
#	add.s $f14, $f14, $f16
#
#	mul.s $f15, $f0, $f15 #third term (degree five) 
#	mul.s $f15, $f0, $f15
#	mul.s $f16, $f8, $f15
#	add.s $f14, $f14, $f16
#
#	mul.s $f15, $f0, $f15 #forth term (degree seven) 
#	mul.s $f15, $f0, $f15
#	mul.s $f16, $f9, $f15
#	add.s $f14, $f14, $f16
#
#    mul.s $f15, $f0, $f15 #forth term (degree nine) 
#	mul.s $f15, $f0, $f15
#	mul.s $f16, $f10, $f15
#	add.s $f14, $f14, $f16
#
#    mul.s $f15, $f0, $f15 #forth term (degree eleven) 
#	mul.s $f15, $f0, $f15
#	mul.s $f16, $f11, $f15
#	add.s $f14, $f14, $f16
#
#    mul.s $f15, $f0, $f15 #forth term (degree thirteen) 
#	mul.s $f15, $f0, $f15
#	mul.s $f16, $f12, $f15
#	add.s $f14, $f14, $f16
	
#imporoved with honer method
#store result in $f15, square in $f16
	mul.s	$f16, $f0, $f0

	mul.s	$f15, $f12, $f16
	add.s	$f15, $f15, $f11

	mul.s	$f15, $f15, $f16
	add.s	$f15, $f15, $f10

	mul.s	$f15, $f15, $f16
	add.s	$f15, $f15, $f9

	mul.s	$f15, $f15, $f16
	add.s	$f15, $f15, $f8

	mul.s	$f15, $f15, $f16
	add.s	$f15, $f15, $f7
	
	mul.s	$f15, $f15, $f16
	mul.s	$f15, $f15, $f0

	add.s	$f15, $f15, $f0


    mov.s   $f0, $f15
	#end kernel atan
    jr  $31

min_caml_atan:
	set	$1, 0x40490fdb #PI
	mtc	$1, $f2
	set $1, 0x3ee00000 #0.437500
	mtc $1, $f3
	set $1, 0x401c0000 #2.437500
	mtc $1, $f4 
	set $1, 0x40000000 #2.0
	mtc	$1, $f5
	set	$1, 0x40800000 #4.0 
	mtc	$1, $f6
	set $1, 0xbeaaaaaa #-0.3333333
	mtc $1, $f7
	set $1, 0x3e4ccccd #0.2
	mtc $1, $f8
	set $1, 0xbe124925 #-0.142857142
	mtc $1, $f9
	set $1, 0x3de38e38 #0.111111104
	mtc $1, $f10
	set $1, 0xbdb7d66e #-0.08976446
	mtc $1, $f11
	set $1, 0x3d75e7c5 #0.060035485
	mtc $1, $f12
	set $1, 0x3f800000 #1.0
	mtc	$1, $f13

	set $2, 0x0
	mtc	$2, $f11
	c.olt.s $f0, $f11
	bcf lll.0
	lli $2, 1

lll.0:

	abs.s	$f0, $f0
	c.olt.s	$f0, $f3
	bcf	ll.21

	#kernel atan store result in $f14, exponent in $f15, term in $f16
	#lli	$3, 1
	#mtc	$3, $f13
	#floor $f13, $f13#1.0

	sw  $31, 4($29)
	jal kernel_atan
	nop
	lw  $31, 4($29)
	#mov.s $f14, $f0 #first term (degree one)
	#mov.s $f15, $f0

	#mul.s $f15, $f0, $f15 #second term (degree three)
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f7, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #third term (degree five) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f8, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree seven) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f9, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree nine) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f10, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree eleven) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f11, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree thirteen) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f12, $f15
	#add.s $f14, $f14, $f16


	#mov.s $f0, $f14
	#end kernel atan 
	j ll.23


ll.21:
	c.olt.s	$f4, $f0
    bct	ll.22

	sub.s	$f14, $f0, $f13
	add.s	$f15, $f0, $f13
	div.s	$f0, $f14, $f15 #$f0 <= (|A| - 1.0 / |A| + 1.0)

	sw  $31, 4($29)
	jal kernel_atan
	nop
	lw  $31, 4($29)

	#kernel atan store result in $f14, exponent in $f15, term in $f16

	#mov.s $f14, $f0 #first term (degree one)
	#mov.s $f15, $f0

	#mul.s $f15, $f0, $f15 #second term (degree three)
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f7, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #third term (degree five) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f8, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree seven) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f9, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree nine) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f10, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree eleven) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f11, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree thirteen) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f12, $f15
	#add.s $f14, $f14, $f16
	
	#end kernel atan
	div.s $f1, $f2, $f6
	add.s $f0, $f1, $f0

	j ll.23
	#TODO return

ll.22:	
	div.s	$f0, $f13, $f0

	sw  $31, 4($29)
	jal kernel_atan
	nop
	lw  $31, 4($29)

	#kernel atan store result in $f14, exponent in $f15, term in $f16

	#mov.s $f14, $f0 #first term (degree one)
	#mov.s $f15, $f0

	#mul.s $f15, $f0, $f15 #second term (degree three)
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f7, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #third term (degree five) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f8, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree seven) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f9, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree nine) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f10, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree eleven) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f11, $f15
	#add.s $f14, $f14, $f16

	#mul.s $f15, $f0, $f15 #forth term (degree thirteen) 
	#mul.s $f15, $f0, $f15
	#mul.s $f16, $f12, $f15
	#add.s $f14, $f14, $f16
	
	#end kernel atan

	div.s $f1, $f2, $f5
	sub.s $f0, $f1, $f0

ll.23:
	beq	$0, $2, ll.24
	neg.s $f0, $f0
ll.24:
	jr	$31
	
min_caml_create_array:
	set $3, 0x80030000
	lw  $10, 0($3)
	mov $4, $10
	beq $0, $1, min_caml_create_array_end

min_caml_create_array_loop:
	sw  $2, 0($4)
	addi $4, $4, 4
	addi $1, $1, -1
	bne $0, $1, min_caml_create_array_loop

min_caml_create_array_end:
	sw  $4, 0($3)
	mov $1, $10
	jr    $31


min_caml_create_float_array:
	set $3, 0x80030000
	lw  $10, 0($3)
	mov $4, $10
	beq $0, $1, min_caml_create_float_array_end

min_caml_create_float_array_loop:
	swc  $f0, 0($4)
	addi $4, $4, 4
	addi $1, $1, -1
	bne $0, $1, min_caml_create_float_array_loop

min_caml_create_float_array_end:
	sw  $4, 0($3)
	mov $1, $10
	jr  $31

min_caml_truncate:
	round.w.s  $f0, $f0 #trunc.sを実装しないと値がずれます
	mfc1 $1, $f0
	jr    $31

min_caml_fhalf:
	set	$1, 0x3f000000 #0.5
	mtc	$1, $f1
	mul.s   $f0, $f0, $f1
	jr  $31

min_caml_fsqr:
	mul.s   $f0, $f0, $f0
	jr  $31

min_caml_fneg:
	neg.s $f0, $f0
	jr $31

min_caml_fispos:
	set	$1, 0x0 #0.0
	mtc	$1, $f1

	c.olt.s $f1, $f0
	bct ll.25
	jr  $31
ll.25:
	addi    $1, $1, 1
	jr  $31 

min_caml_fisneg:
	set	$1, 0x0 #0.0
	mtc	$1, $f1

	c.olt.s $f0, $f1
	bct ll.26
	jr  $31
ll.26:
	addi    $1, $1, 1
	jr  $31 

min_caml_fiszero:
	set	$1, 0x0 #0.0
	mtc	$1, $f1

	c.eq.s $f1, $f0
	bct ll.27
	jr  $31
ll.27:
	addi    $1, $1, 1
	jr  $31 

min_caml_fless:
	set $1, 0x0
	c.olt.s $f0, $f1
	bct ll.28
	jr  $31
ll.28:
	addi    $1, $1, 1
	jr  $31

