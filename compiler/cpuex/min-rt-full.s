	lui	$29, 0x8000
	lui	$30, 0x8001
	lui	$3, 0x8003
	addi	$4, $3, 4
	sw	$4, 0($3)
	jal	min_caml_start
	nop
	halt
l.6584:	# 128.000000
	.long	0x43000000
l.6551:	# 0.900000
	.long	0x3f666666
l.6550:	# 0.200000
	.long	0x3e4ccccd
l.6456:	# 150.000000
	.long	0x43160000
l.6454:	# -150.000000
	.long	0xc3160000
l.6438:	# 0.100000
	.long	0x3dcccccd
l.6435:	# -2.000000
	.long	0xc0000000
l.6433:	# 0.003906
	.long	0x3b800000
l.6411:	# 20.000000
	.long	0x41a00000
l.6410:	# 0.050000
	.long	0x3d4ccccd
l.6406:	# 0.250000
	.long	0x3e800000
l.6402:	# 10.000000
	.long	0x41200000
l.6398:	# 0.300000
	.long	0x3e99999a
l.6397:	# 255.000000
	.long	0x437f0000
l.6396:	# 0.500000
	.long	0x3f000000
l.6395:	# 0.150000
	.long	0x3e19999a
l.6393:	# 3.141593
	.long	0x40490fdb
l.6392:	# 30.000000
	.long	0x41f00000
l.6391:	# 15.000000
	.long	0x41700000
l.6390:	# 0.000100
	.long	0x38d1b717
l.6347:	# 100000000.000000
	.long	0x4cbebc20
l.6343:	# 1000000000.000000
	.long	0x4e6e6b28
l.6323:	# -0.100000
	.long	0xbdcccccd
l.6310:	# 0.010000
	.long	0x3c23d70a
l.6309:	# -0.200000
	.long	0xbe4ccccd
l.6118:	# 2.000000
	.long	0x40000000
l.6084:	# -200.000000
	.long	0xc3480000
l.6082:	# 200.000000
	.long	0x43480000
l.6078:	# 0.017453
	.long	0x3c8efa35
l.5995:	# -1.000000
	.long	0xbf800000
l.5994:	# 1.000000
	.long	0x3f800000
l.5993:	# 0.000000
	.long	0x0
closure_indirect:
	jr	$27
xor.2461:
	set	$3, 0
	bne	$1, $3, beq_else.8719
	mov	$1, $2
	jr $31
beq_else.8719:
	set	$1, 0
	bne	$2, $1, beq_else.8720
	set	$1, 1
	jr $31
beq_else.8720:
	set	$1, 0
	jr $31
sgn.2464:
	swc	$f0, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 0
	bne	$1, $2, beq_else.8721
	lwc	$f0, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_fispos
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 0
	bne	$1, $2, beq_else.8722
	setclv	$f0, l.5995
	jr $31
beq_else.8722:
	setclv	$f0, l.5994
	jr $31
beq_else.8721:
	setclv	$f0, l.5993
	jr $31
fneg_cond.2466:
	set	$2, 0
	bne	$1, $2, beq_else.8723
	j	min_caml_fneg
beq_else.8723:
	jr $31
add_mod5.2469:
	add	$1, $1, $2
	set	$2, 5
	slt	$27, $1, $2
	bne	$27, $0, ble_else.8724
	set	$2, 5
	sub	$1, $1, $2
	jr $31
ble_else.8724:
	jr $31
vecset.2472:
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
vecfill.2477:
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
vecbzero.2480:
	setclv	$f0, l.5993
	j	vecfill.2477
veccpy.2482:
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
vecunit_sgn.2490:
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
	bne	$1, $2, beq_else.8728
	set	$1, 0
	lw	$2, 0($29)
	bne	$2, $1, beq_else.8730
	setclv	$f0, l.5994
	lwc	$f1, 16($29)
	div.s	$f0, $f0, $f1
	j	beq_cont.8731
beq_else.8730:
	setclv	$f0, l.5995
	lwc	$f1, 16($29)
	div.s	$f0, $f0, $f1
beq_cont.8731:
	j	beq_cont.8729
beq_else.8728:
	setclv	$f0, l.5994
beq_cont.8729:
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
veciprod.2493:
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
veciprod2.2496:
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
vecaccum.2501:
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
vecadd.2505:
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
vecscale.2511:
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
vecaccumv.2514:
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
o_texturetype.2518:
	lw	$1, 0($1)
	jr $31
o_form.2520:
	lw	$1, 4($1)
	jr $31
o_reflectiontype.2522:
	lw	$1, 8($1)
	jr $31
o_isinvert.2524:
	lw	$1, 24($1)
	jr $31
o_isrot.2526:
	lw	$1, 12($1)
	jr $31
o_param_a.2528:
	lw	$1, 16($1)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_param_b.2530:
	lw	$1, 16($1)
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_param_c.2532:
	lw	$1, 16($1)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_param_abc.2534:
	lw	$1, 16($1)
	jr $31
o_param_x.2536:
	lw	$1, 20($1)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_param_y.2538:
	lw	$1, 20($1)
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_param_z.2540:
	lw	$1, 20($1)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_diffuse.2542:
	lw	$1, 28($1)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_hilight.2544:
	lw	$1, 28($1)
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_color_red.2546:
	lw	$1, 32($1)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_color_green.2548:
	lw	$1, 32($1)
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_color_blue.2550:
	lw	$1, 32($1)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_param_r1.2552:
	lw	$1, 36($1)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_param_r2.2554:
	lw	$1, 36($1)
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_param_r3.2556:
	lw	$1, 36($1)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	jr $31
o_param_ctbl.2558:
	lw	$1, 40($1)
	jr $31
p_rgb.2560:
	lw	$1, 0($1)
	jr $31
p_intersection_points.2562:
	lw	$1, 4($1)
	jr $31
p_surface_ids.2564:
	lw	$1, 8($1)
	jr $31
p_calc_diffuse.2566:
	lw	$1, 12($1)
	jr $31
p_energy.2568:
	lw	$1, 16($1)
	jr $31
p_received_ray_20percent.2570:
	lw	$1, 20($1)
	jr $31
p_group_id.2572:
	lw	$1, 24($1)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lw	$1, 0($27)
	jr $31
p_set_group_id.2574:
	lw	$1, 24($1)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $1
	sw	$2, 0($27)
jr $31
p_nvectors.2577:
	lw	$1, 28($1)
	jr $31
d_vec.2579:
	lw	$1, 0($1)
	jr $31
d_const.2581:
	lw	$1, 4($1)
	jr $31
r_surface_id.2583:
	lw	$1, 0($1)
	jr $31
r_dvec.2585:
	lw	$1, 4($1)
	jr $31
r_bright.2587:
	lwc	$f0, 8($1)
	jr $31
rad.2589:
	setclv	$f1, l.6078
	mul.s	$f0, $f0, $f1
	jr $31
read_screen_settings.2591:
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
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	rad.2589
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
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
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	rad.2589
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
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
	setclv	$f3, l.6082
	mul.s	$f2, $f2, $f3
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	swc	$f2, 0($27)
	set	$1, 1
	setclv	$f2, l.6084
	lwc	$f3, 40($29)
	mul.s	$f2, $f3, $f2
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f2, 0($27)
	set	$1, 2
	lwc	$f2, 48($29)
	mul.s	$f4, $f1, $f2
	setclv	$f5, l.6082
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
	setclv	$f4, l.5993
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
read_light.2593:
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
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	rad.2589
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
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
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	rad.2589
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
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
rotate_quadratic_matrix.2595:
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
	mul.s	$f6, $f6, $f1
	lwc	$f7, 8($29)
	mul.s	$f8, $f7, $f0
	sub.s	$f6, $f6, $f8
	mul.s	$f8, $f7, $f4
	mul.s	$f8, $f8, $f1
	mul.s	$f9, $f5, $f0
	add.s	$f8, $f8, $f9
	mul.s	$f9, $f2, $f0
	mul.s	$f10, $f5, $f4
	mul.s	$f10, $f10, $f0
	mul.s	$f11, $f7, $f1
	add.s	$f10, $f10, $f11
	mul.s	$f11, $f7, $f4
	mul.s	$f0, $f11, $f0
	mul.s	$f1, $f5, $f1
	sub.s	$f0, $f0, $f1
	swc	$f0, 28($29)
	swc	$f8, 32($29)
	swc	$f10, 36($29)
	swc	$f6, 40($29)
	swc	$f9, 44($29)
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
	setclv	$f0, l.6118
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
	setclv	$f0, l.6118
	lwc	$f4, 48($29)
	mul.s	$f10, $f3, $f4
	mul.s	$f5, $f10, $f5
	lwc	$f10, 44($29)
	mul.s	$f12, $f7, $f10
	mul.s	$f9, $f12, $f9
	add.s	$f5, $f5, $f9
	lwc	$f9, 68($29)
	mul.s	$f12, $f1, $f9
	mul.s	$f11, $f12, $f11
	add.s	$f5, $f5, $f11
	mul.s	$f0, $f0, $f5
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	setclv	$f0, l.6118
	mul.s	$f3, $f3, $f4
	mul.s	$f2, $f3, $f2
	mul.s	$f3, $f7, $f10
	mul.s	$f3, $f3, $f6
	add.s	$f2, $f2, $f3
	mul.s	$f1, $f1, $f9
	mul.s	$f1, $f1, $f8
	add.s	$f1, $f2, $f1
	mul.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
jr $31
read_nth_object.2598:
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
	bne	$1, $2, beq_else.8741
	set	$1, 0
	jr $31
beq_else.8741:
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
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	set	$2, 0
	lw	$3, 20($29)
	sw	$1, 88($29)
	bne	$3, $2, beq_else.8742
	j	beq_cont.8743
beq_else.8742:
	set	$2, 0
	sw	$2, 92($29)
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_read_float
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	rad.2589
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
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
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	rad.2589
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
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
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	rad.2589
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	lw	$1, 100($29)
	sll	$1, $1, 2
	lw	$2, 88($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.8743:
	set	$1, 2
	lw	$2, 12($29)
	bne	$2, $1, beq_else.8744
	set	$1, 1
	j	beq_cont.8745
beq_else.8744:
	lw	$1, 56($29)
beq_cont.8745:
	set	$3, 4
	setclv	$f0, l.5993
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
	bne	$5, $2, beq_else.8746
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
	bne	$1, $2, beq_else.8748
	lwc	$f0, 112($29)
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	sgn.2464
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
	j	beq_cont.8749
beq_else.8748:
	setclv	$f0, l.5993
beq_cont.8749:
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
	bne	$1, $2, beq_else.8750
	lwc	$f0, 124($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	sgn.2464
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
	j	beq_cont.8751
beq_else.8750:
	setclv	$f0, l.5993
beq_cont.8751:
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
	bne	$1, $2, beq_else.8752
	lwc	$f0, 136($29)
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	sgn.2464
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
	j	beq_cont.8753
beq_else.8752:
	setclv	$f0, l.5993
beq_cont.8753:
	lw	$1, 132($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.8747
beq_else.8746:
	set	$2, 2
	bne	$5, $2, beq_else.8754
	set	$2, 0
	lw	$5, 56($29)
	bne	$5, $2, beq_else.8756
	set	$2, 1
	j	beq_cont.8757
beq_else.8756:
	set	$2, 0
beq_cont.8757:
	mov	$1, $3
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	vecunit_sgn.2490
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	j	beq_cont.8755
beq_else.8754:
beq_cont.8755:
beq_cont.8747:
	set	$1, 0
	lw	$2, 20($29)
	bne	$2, $1, beq_else.8758
	j	beq_cont.8759
beq_else.8758:
	lw	$1, 24($29)
	lw	$2, 88($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	rotate_quadratic_matrix.2595
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
beq_cont.8759:
	set	$1, 1
	jr $31
read_object.2600:
	lw	$2, 8($28)
	lw	$3, 4($28)
	set	$4, 60
	slt	$27, $1, $4
	bne	$27, $0, ble_else.8760
jr $31
ble_else.8760:
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
	bne	$1, $2, beq_else.8762
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 4($29)
	lw	$3, 8($29)
	add	$27, $1, $2
	sw	$3, 0($27)
jr $31
beq_else.8762:
	lw	$1, 8($29)
	addi	$1, $1, 1
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
read_all_object.2602:
	lw	$28, 4($28)
	set	$1, 0
	lw	$27, 0($28)
	jr	$27
read_net_item.2604:
	sw	$1, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_read_int
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, -1
	bne	$1, $2, beq_else.8764
	lw	$1, 0($29)
	addi	$1, $1, 1
	set	$2, -1
	j	min_caml_create_array
beq_else.8764:
	lw	$2, 0($29)
	addi	$3, $2, 1
	sw	$1, 4($29)
	mov	$1, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	read_net_item.2604
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$2, 0($29)
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $1
	sw	$3, 0($27)
	jr $31
read_or_network.2606:
	set	$2, 0
	sw	$1, 0($29)
	mov	$1, $2
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	read_net_item.2604
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	mov	$2, $1
	set	$1, 0
	sll	$1, $1, 2
	add	$27, $1, $2
	lw	$1, 0($27)
	set	$3, -1
	bne	$1, $3, beq_else.8765
	lw	$1, 0($29)
	addi	$1, $1, 1
	j	min_caml_create_array
beq_else.8765:
	lw	$1, 0($29)
	addi	$3, $1, 1
	sw	$2, 4($29)
	mov	$1, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	read_or_network.2606
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$2, 0($29)
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $1
	sw	$3, 0($27)
	jr $31
read_and_network.2608:
	lw	$2, 4($28)
	set	$3, 0
	sw	$28, 0($29)
	sw	$2, 4($29)
	sw	$1, 8($29)
	mov	$1, $3
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	read_net_item.2604
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lw	$2, 0($27)
	set	$3, -1
	bne	$2, $3, beq_else.8766
jr $31
beq_else.8766:
	lw	$2, 8($29)
	sll	$3, $2, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	addi	$1, $2, 1
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
read_parameter.2610:
	lw	$1, 20($28)
	lw	$2, 16($28)
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$5, 4($28)
	sw	$5, 0($29)
	sw	$3, 4($29)
	sw	$4, 8($29)
	sw	$2, 12($29)
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
	jal	read_or_network.2606
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 16($29)
	sll	$2, $2, 2
	lw	$3, 0($29)
	add	$27, $2, $3
	sw	$1, 0($27)
jr $31
solver_rect_surface.2612:
	lw	$6, 4($28)
	sll	$7, $3, 2
	add	$27, $7, $2
	lwc	$f3, 0($27)
	sw	$6, 0($29)
	swc	$f2, 4($29)
	sw	$5, 8($29)
	swc	$f1, 12($29)
	sw	$4, 16($29)
	swc	$f0, 20($29)
	sw	$2, 24($29)
	sw	$3, 28($29)
	sw	$1, 32($29)
	mov.s	$f0, $f3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.8769
	lw	$1, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_abc.2534
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$2, 32($29)
	sw	$1, 36($29)
	mov	$1, $2
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$2, 28($29)
	sll	$3, $2, 2
	lw	$4, 24($29)
	add	$27, $3, $4
	lwc	$f0, 0($27)
	sw	$1, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	mov	$2, $1
	lw	$1, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	xor.2461
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$2, 28($29)
	sll	$3, $2, 2
	lw	$4, 36($29)
	add	$27, $3, $4
	lwc	$f0, 0($27)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	fneg_cond.2466
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 20($29)
	sub.s	$f0, $f0, $f1
	lw	$1, 28($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	div.s	$f0, $f0, $f1
	lw	$1, 16($29)
	sll	$3, $1, 2
	add	$27, $3, $2
	lwc	$f1, 0($27)
	mul.s	$f1, $f0, $f1
	lwc	$f2, 12($29)
	add.s	$f1, $f1, $f2
	swc	$f0, 44($29)
	mov.s	$f0, $f1
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fabs
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 16($29)
	sll	$1, $1, 2
	lw	$2, 36($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fless
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.8770
	set	$1, 0
	jr $31
beq_else.8770:
	lw	$1, 8($29)
	sll	$2, $1, 2
	lw	$3, 24($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	lwc	$f1, 44($29)
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
	lw	$2, 36($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fless
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.8771
	set	$1, 0
	jr $31
beq_else.8771:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lwc	$f0, 44($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	jr $31
beq_else.8769:
	set	$1, 0
	jr $31
solver_rect.2621:
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
	bne	$1, $2, beq_else.8772
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
	bne	$1, $2, beq_else.8773
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
	bne	$1, $2, beq_else.8774
	set	$1, 0
	jr $31
beq_else.8774:
	set	$1, 3
	jr $31
beq_else.8773:
	set	$1, 2
	jr $31
beq_else.8772:
	set	$1, 1
	jr $31
solver_surface.2627:
	lw	$3, 4($28)
	sw	$3, 0($29)
	swc	$f2, 4($29)
	swc	$f1, 8($29)
	swc	$f0, 12($29)
	sw	$2, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_abc.2534
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	mov	$2, $1
	lw	$1, 16($29)
	sw	$2, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	veciprod.2493
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	swc	$f0, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fispos
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.8775
	set	$1, 0
	jr $31
beq_else.8775:
	set	$1, 0
	lwc	$f0, 12($29)
	lwc	$f1, 8($29)
	lwc	$f2, 4($29)
	lw	$2, 20($29)
	sw	$1, 28($29)
	mov	$1, $2
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	veciprod2.2496
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fneg
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 24($29)
	div.s	$f0, $f0, $f1
	lw	$1, 28($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	jr $31
quadratic.2633:
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
	swc	$f0, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_a.2528
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f1, 16($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 8($29)
	swc	$f0, 20($29)
	mov.s	$f0, $f1
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 12($29)
	swc	$f0, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_param_b.2530
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 24($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 20($29)
	add.s	$f0, $f1, $f0
	lwc	$f1, 4($29)
	swc	$f0, 28($29)
	mov.s	$f0, $f1
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 12($29)
	swc	$f0, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_c.2532
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 32($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 28($29)
	add.s	$f0, $f1, $f0
	lw	$1, 12($29)
	swc	$f0, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_isrot.2526
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.8776
	lwc	$f0, 36($29)
	jr $31
beq_else.8776:
	lwc	$f0, 4($29)
	lwc	$f1, 8($29)
	mul.s	$f2, $f1, $f0
	lw	$1, 12($29)
	swc	$f2, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_r1.2552
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 40($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 36($29)
	add.s	$f0, $f1, $f0
	lwc	$f1, 0($29)
	lwc	$f2, 4($29)
	mul.s	$f2, $f2, $f1
	lw	$1, 12($29)
	swc	$f0, 44($29)
	swc	$f2, 48($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_r2.2554
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 48($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 44($29)
	add.s	$f0, $f1, $f0
	lwc	$f1, 8($29)
	lwc	$f2, 0($29)
	mul.s	$f1, $f2, $f1
	lw	$1, 12($29)
	swc	$f0, 52($29)
	swc	$f1, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	o_param_r3.2556
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 56($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 52($29)
	add.s	$f0, $f1, $f0
	jr $31
bilinear.2638:
	mul.s	$f6, $f0, $f3
	swc	$f3, 0($29)
	swc	$f0, 4($29)
	swc	$f5, 8($29)
	swc	$f2, 12($29)
	sw	$1, 16($29)
	swc	$f4, 20($29)
	swc	$f1, 24($29)
	swc	$f6, 28($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_a.2528
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 28($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 20($29)
	lwc	$f2, 24($29)
	mul.s	$f3, $f2, $f1
	lw	$1, 16($29)
	swc	$f0, 32($29)
	swc	$f3, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_b.2530
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 36($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 32($29)
	add.s	$f0, $f1, $f0
	lwc	$f1, 8($29)
	lwc	$f2, 12($29)
	mul.s	$f3, $f2, $f1
	lw	$1, 16($29)
	swc	$f0, 40($29)
	swc	$f3, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_c.2532
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 44($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 40($29)
	add.s	$f0, $f1, $f0
	lw	$1, 16($29)
	swc	$f0, 48($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_isrot.2526
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.8777
	lwc	$f0, 48($29)
	jr $31
beq_else.8777:
	lwc	$f0, 20($29)
	lwc	$f1, 12($29)
	mul.s	$f2, $f1, $f0
	lwc	$f3, 8($29)
	lwc	$f4, 24($29)
	mul.s	$f5, $f4, $f3
	add.s	$f2, $f2, $f5
	lw	$1, 16($29)
	swc	$f2, 52($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	o_param_r1.2552
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 52($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 8($29)
	lwc	$f2, 4($29)
	mul.s	$f1, $f2, $f1
	lwc	$f3, 0($29)
	lwc	$f4, 12($29)
	mul.s	$f4, $f4, $f3
	add.s	$f1, $f1, $f4
	lw	$1, 16($29)
	swc	$f0, 56($29)
	swc	$f1, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	o_param_r2.2554
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 60($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 56($29)
	add.s	$f0, $f1, $f0
	lwc	$f1, 20($29)
	lwc	$f2, 4($29)
	mul.s	$f1, $f2, $f1
	lwc	$f2, 0($29)
	lwc	$f3, 24($29)
	mul.s	$f2, $f3, $f2
	add.s	$f1, $f1, $f2
	lw	$1, 16($29)
	swc	$f0, 64($29)
	swc	$f1, 68($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	o_param_r3.2556
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 68($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 64($29)
	add.s	$f0, $f1, $f0
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 48($29)
	add.s	$f0, $f1, $f0
	jr $31
solver_second.2646:
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
	jal	quadratic.2633
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
	bne	$1, $2, beq_else.8778
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
	jal	bilinear.2638
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
	jal	quadratic.2633
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 16($29)
	swc	$f0, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_form.2520
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 3
	bne	$1, $2, beq_else.8779
	setclv	$f0, l.5994
	lwc	$f1, 32($29)
	sub.s	$f0, $f1, $f0
	j	beq_cont.8780
beq_else.8779:
	lwc	$f0, 32($29)
beq_cont.8780:
	lwc	$f1, 28($29)
	swc	$f0, 36($29)
	mov.s	$f0, $f1
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 36($29)
	lwc	$f2, 24($29)
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
	bne	$1, $2, beq_else.8781
	set	$1, 0
	jr $31
beq_else.8781:
	lwc	$f0, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 16($29)
	swc	$f0, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.8782
	lwc	$f0, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fneg
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	j	beq_cont.8783
beq_else.8782:
	lwc	$f0, 44($29)
beq_cont.8783:
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
beq_else.8778:
	set	$1, 0
	jr $31
solver.2652:
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
	sw	$5, 0($29)
	sw	$4, 4($29)
	sw	$2, 8($29)
	sw	$6, 12($29)
	sw	$1, 16($29)
	sw	$3, 20($29)
	swc	$f0, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_param_x.2536
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 24($29)
	sub.s	$f0, $f1, $f0
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 16($29)
	swc	$f0, 28($29)
	swc	$f1, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_y.2538
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 32($29)
	sub.s	$f0, $f1, $f0
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 16($29)
	swc	$f0, 36($29)
	swc	$f1, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_z.2540
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 40($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 16($29)
	swc	$f0, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_form.2520
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 1
	bne	$1, $2, beq_else.8784
	lwc	$f0, 28($29)
	lwc	$f1, 36($29)
	lwc	$f2, 44($29)
	lw	$1, 16($29)
	lw	$2, 8($29)
	lw	$28, 12($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8784:
	set	$2, 2
	bne	$1, $2, beq_else.8785
	lwc	$f0, 28($29)
	lwc	$f1, 36($29)
	lwc	$f2, 44($29)
	lw	$1, 16($29)
	lw	$2, 8($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8785:
	lwc	$f0, 28($29)
	lwc	$f1, 36($29)
	lwc	$f2, 44($29)
	lw	$1, 16($29)
	lw	$2, 8($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
solver_rect_fast.2656:
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
	swc	$f0, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_b.2530
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	mov.s	$f1, $f0
	lwc	$f0, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fless
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.8786
	set	$1, 0
	j	beq_cont.8787
beq_else.8786:
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
	swc	$f0, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_c.2532
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	mov.s	$f1, $f0
	lwc	$f0, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fless
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.8788
	set	$1, 0
	j	beq_cont.8789
beq_else.8788:
	set	$1, 1
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
	bne	$1, $2, beq_else.8790
	set	$1, 1
	j	beq_cont.8791
beq_else.8790:
	set	$1, 0
beq_cont.8791:
beq_cont.8789:
beq_cont.8787:
	set	$2, 0
	bne	$1, $2, beq_else.8792
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
	swc	$f0, 40($29)
	mov.s	$f0, $f2
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fabs
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 28($29)
	swc	$f0, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_a.2528
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	mov.s	$f1, $f0
	lwc	$f0, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fless
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.8793
	set	$1, 0
	j	beq_cont.8794
beq_else.8793:
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	lwc	$f1, 40($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 16($29)
	add.s	$f0, $f0, $f2
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fabs
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 28($29)
	swc	$f0, 48($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_c.2532
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	mov.s	$f1, $f0
	lwc	$f0, 48($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fless
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.8795
	set	$1, 0
	j	beq_cont.8796
beq_else.8795:
	set	$1, 3
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.8797
	set	$1, 1
	j	beq_cont.8798
beq_else.8797:
	set	$1, 0
beq_cont.8798:
beq_cont.8796:
beq_cont.8794:
	set	$2, 0
	bne	$1, $2, beq_else.8799
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
	swc	$f0, 52($29)
	mov.s	$f0, $f1
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fabs
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$1, 28($29)
	swc	$f0, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	o_param_a.2528
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	mov.s	$f1, $f0
	lwc	$f0, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fless
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.8800
	set	$1, 0
	j	beq_cont.8801
beq_else.8800:
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	lwc	$f1, 52($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 8($29)
	add.s	$f0, $f0, $f2
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fabs
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$1, 28($29)
	swc	$f0, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	o_param_b.2530
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	mov.s	$f1, $f0
	lwc	$f0, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fless
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	set	$2, 0
	bne	$1, $2, beq_else.8802
	set	$1, 0
	j	beq_cont.8803
beq_else.8802:
	set	$1, 5
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	set	$2, 0
	bne	$1, $2, beq_else.8804
	set	$1, 1
	j	beq_cont.8805
beq_else.8804:
	set	$1, 0
beq_cont.8805:
beq_cont.8803:
beq_cont.8801:
	set	$2, 0
	bne	$1, $2, beq_else.8806
	set	$1, 0
	jr $31
beq_else.8806:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lwc	$f0, 52($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 3
	jr $31
beq_else.8799:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lwc	$f0, 40($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	jr $31
beq_else.8792:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lwc	$f0, 20($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	jr $31
solver_surface_fast.2663:
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
	bne	$1, $2, beq_else.8807
	set	$1, 0
	jr $31
beq_else.8807:
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
solver_second_fast.2669:
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
	bne	$1, $2, beq_else.8808
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
	jal	quadratic.2633
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 8($29)
	swc	$f0, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_form.2520
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 3
	bne	$1, $2, beq_else.8809
	setclv	$f0, l.5994
	lwc	$f1, 32($29)
	sub.s	$f0, $f1, $f0
	j	beq_cont.8810
beq_else.8809:
	lwc	$f0, 32($29)
beq_cont.8810:
	lwc	$f1, 28($29)
	swc	$f0, 36($29)
	mov.s	$f0, $f1
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 36($29)
	lwc	$f2, 4($29)
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
	bne	$1, $2, beq_else.8811
	set	$1, 0
	jr $31
beq_else.8811:
	lw	$1, 8($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.8812
	set	$1, 0
	lwc	$f0, 40($29)
	sw	$1, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 28($29)
	sub.s	$f0, $f1, $f0
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
	j	beq_cont.8813
beq_else.8812:
	set	$1, 0
	lwc	$f0, 40($29)
	sw	$1, 48($29)
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
	lw	$1, 48($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.8813:
	set	$1, 1
	jr $31
beq_else.8808:
	set	$1, 0
	jr $31
solver_fast.2675:
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
	sw	$5, 0($29)
	sw	$4, 4($29)
	sw	$6, 8($29)
	sw	$1, 12($29)
	sw	$2, 16($29)
	sw	$7, 20($29)
	sw	$3, 24($29)
	swc	$f0, 28($29)
	mov	$1, $7
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_x.2536
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 28($29)
	sub.s	$f0, $f1, $f0
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 20($29)
	swc	$f0, 32($29)
	swc	$f1, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_y.2538
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 36($29)
	sub.s	$f0, $f1, $f0
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 20($29)
	swc	$f0, 40($29)
	swc	$f1, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_z.2540
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 44($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 16($29)
	swc	$f0, 48($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	d_const.2581
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$2, 12($29)
	sll	$2, $2, 2
	add	$27, $2, $1
	lw	$1, 0($27)
	lw	$2, 20($29)
	sw	$1, 52($29)
	mov	$1, $2
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	o_form.2520
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 1
	bne	$1, $2, beq_else.8814
	lw	$1, 16($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	d_vec.2579
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	mov	$2, $1
	lwc	$f0, 32($29)
	lwc	$f1, 40($29)
	lwc	$f2, 48($29)
	lw	$1, 20($29)
	lw	$3, 52($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8814:
	set	$2, 2
	bne	$1, $2, beq_else.8815
	lwc	$f0, 32($29)
	lwc	$f1, 40($29)
	lwc	$f2, 48($29)
	lw	$1, 20($29)
	lw	$2, 52($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8815:
	lwc	$f0, 32($29)
	lwc	$f1, 40($29)
	lwc	$f2, 48($29)
	lw	$1, 20($29)
	lw	$2, 52($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
solver_surface_fast2.2679:
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
	bne	$1, $2, beq_else.8816
	set	$1, 0
	jr $31
beq_else.8816:
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
solver_second_fast2.2686:
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
	bne	$1, $2, beq_else.8817
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
	bne	$1, $2, beq_else.8818
	set	$1, 0
	jr $31
beq_else.8818:
	lw	$1, 4($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.8819
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
	j	beq_cont.8820
beq_else.8819:
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
beq_cont.8820:
	set	$1, 1
	jr $31
beq_else.8817:
	set	$1, 0
	jr $31
solver_fast2.2693:
	lw	$3, 16($28)
	lw	$4, 12($28)
	lw	$5, 8($28)
	lw	$6, 4($28)
	sll	$7, $1, 2
	add	$27, $7, $6
	lw	$6, 0($27)
	sw	$4, 0($29)
	sw	$3, 4($29)
	sw	$5, 8($29)
	sw	$6, 12($29)
	sw	$1, 16($29)
	sw	$2, 20($29)
	mov	$1, $6
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_param_ctbl.2558
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	set	$2, 1
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f1, 0($27)
	set	$2, 2
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f2, 0($27)
	lw	$2, 20($29)
	sw	$1, 24($29)
	swc	$f2, 28($29)
	swc	$f1, 32($29)
	swc	$f0, 36($29)
	mov	$1, $2
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	d_const.2581
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$2, 16($29)
	sll	$2, $2, 2
	add	$27, $2, $1
	lw	$1, 0($27)
	lw	$2, 12($29)
	sw	$1, 40($29)
	mov	$1, $2
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_form.2520
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 1
	bne	$1, $2, beq_else.8821
	lw	$1, 20($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	d_vec.2579
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	mov	$2, $1
	lwc	$f0, 36($29)
	lwc	$f1, 32($29)
	lwc	$f2, 28($29)
	lw	$1, 12($29)
	lw	$3, 40($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8821:
	set	$2, 2
	bne	$1, $2, beq_else.8822
	lwc	$f0, 36($29)
	lwc	$f1, 32($29)
	lwc	$f2, 28($29)
	lw	$1, 12($29)
	lw	$2, 40($29)
	lw	$3, 24($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8822:
	lwc	$f0, 36($29)
	lwc	$f1, 32($29)
	lwc	$f2, 28($29)
	lw	$1, 12($29)
	lw	$2, 40($29)
	lw	$3, 24($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
setup_rect_table.2696:
	set	$3, 6
	setclv	$f0, l.5993
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
	bne	$1, $2, beq_else.8823
	set	$1, 0
	lw	$2, 0($29)
	sw	$1, 12($29)
	mov	$1, $2
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	sw	$1, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	mov	$2, $1
	lw	$1, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	xor.2461
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 0($29)
	sw	$1, 20($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_param_a.2528
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	fneg_cond.2466
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 12($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	setclv	$f0, l.5994
	set	$3, 0
	sll	$3, $3, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	lwc	$f1, 0($27)
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.8824
beq_else.8823:
	set	$1, 1
	setclv	$f0, l.5993
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.8824:
	set	$1, 1
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
	bne	$1, $2, beq_else.8825
	set	$1, 2
	lw	$2, 0($29)
	sw	$1, 24($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 1
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	sw	$1, 28($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	mov	$2, $1
	lw	$1, 28($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	xor.2461
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$2, 0($29)
	sw	$1, 32($29)
	mov	$1, $2
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_b.2530
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	fneg_cond.2466
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 24($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 3
	setclv	$f0, l.5994
	set	$3, 1
	sll	$3, $3, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	lwc	$f1, 0($27)
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.8826
beq_else.8825:
	set	$1, 3
	setclv	$f0, l.5993
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.8826:
	set	$1, 2
	sll	$1, $1, 2
	lw	$3, 4($29)
	add	$27, $1, $3
	lwc	$f0, 0($27)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.8827
	set	$1, 4
	lw	$2, 0($29)
	sw	$1, 36($29)
	mov	$1, $2
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 2
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	sw	$1, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	mov	$2, $1
	lw	$1, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	xor.2461
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$2, 0($29)
	sw	$1, 44($29)
	mov	$1, $2
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_c.2532
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	fneg_cond.2466
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 36($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 5
	setclv	$f0, l.5994
	set	$3, 2
	sll	$3, $3, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	lwc	$f1, 0($27)
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.8828
beq_else.8827:
	set	$1, 5
	setclv	$f0, l.5993
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.8828:
	mov	$1, $2
	jr $31
setup_surface_table.2699:
	set	$3, 4
	setclv	$f0, l.5993
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
	sw	$1, 8($29)
	swc	$f0, 12($29)
	mov	$1, $2
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_a.2528
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f1, 12($29)
	mul.s	$f0, $f1, $f0
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 0($29)
	swc	$f0, 16($29)
	swc	$f1, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_param_b.2530
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 20($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 16($29)
	add.s	$f0, $f1, $f0
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 0($29)
	swc	$f0, 24($29)
	swc	$f1, 28($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_c.2532
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 28($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 24($29)
	add.s	$f0, $f1, $f0
	swc	$f0, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fispos
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 0
	bne	$1, $2, beq_else.8829
	set	$1, 0
	setclv	$f0, l.5993
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.8830
beq_else.8829:
	set	$1, 0
	setclv	$f0, l.5995
	lwc	$f1, 32($29)
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	lw	$3, 0($29)
	sw	$1, 36($29)
	mov	$1, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_a.2528
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 32($29)
	div.s	$f0, $f0, $f1
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fneg
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 36($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	lw	$3, 0($29)
	sw	$1, 40($29)
	mov	$1, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_b.2530
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 32($29)
	div.s	$f0, $f0, $f1
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fneg
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 40($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 3
	lw	$3, 0($29)
	sw	$1, 44($29)
	mov	$1, $3
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_c.2532
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 32($29)
	div.s	$f0, $f0, $f1
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fneg
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 44($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.8830:
	mov	$1, $2
	jr $31
setup_second_table.2702:
	set	$3, 5
	setclv	$f0, l.5993
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
	jal	quadratic.2633
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 0($29)
	swc	$f0, 12($29)
	swc	$f1, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_a.2528
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f1, 16($29)
	mul.s	$f0, $f1, $f0
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
	swc	$f0, 20($29)
	swc	$f1, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_param_b.2530
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 24($29)
	mul.s	$f0, $f1, $f0
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fneg
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 0($29)
	swc	$f0, 28($29)
	swc	$f1, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_c.2532
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 32($29)
	mul.s	$f0, $f1, $f0
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fneg
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 8($29)
	lwc	$f1, 12($29)
	add	$27, $1, $2
	swc	$f1, 0($27)
	lw	$1, 0($29)
	swc	$f0, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_isrot.2526
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.8831
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 8($29)
	lwc	$f0, 20($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	sll	$1, $1, 2
	lwc	$f0, 28($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 3
	sll	$1, $1, 2
	lwc	$f0, 36($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.8832
beq_else.8831:
	set	$1, 1
	set	$2, 2
	sll	$2, $2, 2
	lw	$3, 4($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	lw	$2, 0($29)
	sw	$1, 40($29)
	swc	$f0, 44($29)
	mov	$1, $2
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_r2.2554
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 44($29)
	mul.s	$f0, $f1, $f0
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 0($29)
	swc	$f0, 48($29)
	swc	$f1, 52($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	o_param_r3.2556
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 52($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 48($29)
	add.s	$f0, $f1, $f0
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 20($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 40($29)
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
	sw	$1, 56($29)
	swc	$f0, 60($29)
	mov	$1, $3
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	o_param_r1.2552
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 60($29)
	mul.s	$f0, $f1, $f0
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 0($29)
	swc	$f0, 64($29)
	swc	$f1, 68($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	o_param_r3.2556
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 68($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 64($29)
	add.s	$f0, $f1, $f0
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 28($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 56($29)
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
	sw	$1, 72($29)
	swc	$f0, 76($29)
	mov	$1, $3
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	o_param_r1.2552
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	lwc	$f1, 76($29)
	mul.s	$f0, $f1, $f0
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 0($29)
	swc	$f0, 80($29)
	swc	$f1, 84($29)
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	o_param_r2.2554
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	lwc	$f1, 84($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 80($29)
	add.s	$f0, $f1, $f0
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	lwc	$f1, 36($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 72($29)
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.8832:
	lwc	$f0, 12($29)
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_fiszero
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	set	$2, 0
	bne	$1, $2, beq_else.8833
	set	$1, 4
	setclv	$f0, l.5994
	lwc	$f1, 12($29)
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.8834
beq_else.8833:
beq_cont.8834:
	lw	$1, 8($29)
	jr $31
iter_setup_dirvec_constants.2705:
	lw	$3, 4($28)
	set	$4, 0
	slt	$27, $2, $4
	bne	$27, $0, ble_else.8835
	sll	$4, $2, 2
	add	$27, $4, $3
	lw	$3, 0($27)
	sw	$28, 0($29)
	sw	$2, 4($29)
	sw	$3, 8($29)
	sw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	d_const.2581
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 12($29)
	sw	$1, 16($29)
	mov	$1, $2
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	d_vec.2579
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 8($29)
	sw	$1, 20($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_form.2520
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 1
	bne	$1, $2, beq_else.8836
	lw	$1, 20($29)
	lw	$2, 8($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	setup_rect_table.2696
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 4($29)
	sll	$3, $2, 2
	lw	$4, 16($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	j	beq_cont.8837
beq_else.8836:
	set	$2, 2
	bne	$1, $2, beq_else.8838
	lw	$1, 20($29)
	lw	$2, 8($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	setup_surface_table.2699
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 4($29)
	sll	$3, $2, 2
	lw	$4, 16($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	j	beq_cont.8839
beq_else.8838:
	lw	$1, 20($29)
	lw	$2, 8($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	setup_second_table.2702
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 4($29)
	sll	$3, $2, 2
	lw	$4, 16($29)
	add	$27, $3, $4
	sw	$1, 0($27)
beq_cont.8839:
beq_cont.8837:
	set	$1, 1
	sub	$2, $2, $1
	lw	$1, 12($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.8835:
jr $31
setup_dirvec_constants.2708:
	lw	$2, 8($28)
	lw	$28, 4($28)
	set	$3, 0
	sll	$3, $3, 2
	add	$27, $3, $2
	lw	$2, 0($27)
	set	$3, 1
	sub	$2, $2, $3
	lw	$27, 0($28)
	jr	$27
setup_startp_constants.2710:
	lw	$3, 4($28)
	set	$4, 0
	slt	$27, $2, $4
	bne	$27, $0, ble_else.8841
	sll	$4, $2, 2
	add	$27, $4, $3
	lw	$3, 0($27)
	sw	$28, 0($29)
	sw	$2, 4($29)
	sw	$1, 8($29)
	sw	$3, 12($29)
	mov	$1, $3
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_ctbl.2558
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 12($29)
	sw	$1, 16($29)
	mov	$1, $2
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_form.2520
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	set	$3, 0
	sll	$3, $3, 2
	lw	$4, 8($29)
	add	$27, $3, $4
	lwc	$f0, 0($27)
	lw	$3, 12($29)
	sw	$1, 20($29)
	sw	$2, 24($29)
	swc	$f0, 28($29)
	mov	$1, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_x.2536
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 28($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 24($29)
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	set	$3, 1
	sll	$3, $3, 2
	lw	$4, 8($29)
	add	$27, $3, $4
	lwc	$f0, 0($27)
	lw	$3, 12($29)
	sw	$1, 32($29)
	swc	$f0, 36($29)
	mov	$1, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_y.2538
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 36($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 32($29)
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	set	$3, 2
	sll	$3, $3, 2
	lw	$4, 8($29)
	add	$27, $3, $4
	lwc	$f0, 0($27)
	lw	$3, 12($29)
	sw	$1, 40($29)
	swc	$f0, 44($29)
	mov	$1, $3
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_z.2540
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 44($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 40($29)
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	lw	$3, 20($29)
	bne	$3, $1, beq_else.8842
	set	$1, 3
	lw	$3, 12($29)
	sw	$1, 48($29)
	mov	$1, $3
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_abc.2534
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 16($29)
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
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	veciprod2.2496
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 48($29)
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.8843
beq_else.8842:
	set	$1, 2
	slt	$27, $1, $3
	bne	$27, $0, ble_else.8844
	j	ble_cont.8845
ble_else.8844:
	set	$1, 0
	sll	$1, $1, 2
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
	lw	$1, 12($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	quadratic.2633
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$1, 3
	set	$2, 3
	lw	$3, 20($29)
	bne	$3, $2, beq_else.8846
	setclv	$f1, l.5994
	sub.s	$f0, $f0, $f1
	j	beq_cont.8847
beq_else.8846:
beq_cont.8847:
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
ble_cont.8845:
beq_cont.8843:
	set	$1, 1
	lw	$2, 4($29)
	sub	$2, $2, $1
	lw	$1, 8($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.8841:
jr $31
setup_startp.2713:
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
	jal	veccpy.2482
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
is_rect_outside.2715:
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
	swc	$f0, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_a.2528
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	mov.s	$f1, $f0
	lwc	$f0, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fless
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.8849
	set	$1, 0
	j	beq_cont.8850
beq_else.8849:
	lwc	$f0, 4($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fabs
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 8($29)
	swc	$f0, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_b.2530
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	mov.s	$f1, $f0
	lwc	$f0, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fless
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.8851
	set	$1, 0
	j	beq_cont.8852
beq_else.8851:
	lwc	$f0, 0($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fabs
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 8($29)
	swc	$f0, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_param_c.2532
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	mov.s	$f1, $f0
	lwc	$f0, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fless
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
beq_cont.8852:
beq_cont.8850:
	set	$2, 0
	bne	$1, $2, beq_else.8853
	lw	$1, 8($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.8854
	set	$1, 1
	jr $31
beq_else.8854:
	set	$1, 0
	jr $31
beq_else.8853:
	lw	$1, 8($29)
	j	o_isinvert.2524
is_plane_outside.2720:
	sw	$1, 0($29)
	swc	$f2, 4($29)
	swc	$f1, 8($29)
	swc	$f0, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_abc.2534
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f0, 12($29)
	lwc	$f1, 8($29)
	lwc	$f2, 4($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	veciprod2.2496
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 0($29)
	swc	$f0, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f0, 16($29)
	sw	$1, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	mov	$2, $1
	lw	$1, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	xor.2461
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.8855
	set	$1, 1
	jr $31
beq_else.8855:
	set	$1, 0
	jr $31
is_second_outside.2725:
	sw	$1, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	quadratic.2633
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	lw	$1, 0($29)
	swc	$f0, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	o_form.2520
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 3
	bne	$1, $2, beq_else.8856
	setclv	$f0, l.5994
	lwc	$f1, 4($29)
	sub.s	$f0, $f1, $f0
	j	beq_cont.8857
beq_else.8856:
	lwc	$f0, 4($29)
beq_cont.8857:
	lw	$1, 0($29)
	swc	$f0, 8($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lwc	$f0, 8($29)
	sw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	mov	$2, $1
	lw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	xor.2461
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.8858
	set	$1, 1
	jr $31
beq_else.8858:
	set	$1, 0
	jr $31
is_outside.2730:
	swc	$f2, 0($29)
	swc	$f1, 4($29)
	sw	$1, 8($29)
	swc	$f0, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_x.2536
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f1, 12($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 8($29)
	swc	$f0, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_y.2538
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f1, 4($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 8($29)
	swc	$f0, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_param_z.2540
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 0($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 8($29)
	swc	$f0, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_form.2520
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 1
	bne	$1, $2, beq_else.8859
	lwc	$f0, 16($29)
	lwc	$f1, 20($29)
	lwc	$f2, 24($29)
	lw	$1, 8($29)
	j	is_rect_outside.2715
beq_else.8859:
	set	$2, 2
	bne	$1, $2, beq_else.8860
	lwc	$f0, 16($29)
	lwc	$f1, 20($29)
	lwc	$f2, 24($29)
	lw	$1, 8($29)
	j	is_plane_outside.2720
beq_else.8860:
	lwc	$f0, 16($29)
	lwc	$f1, 20($29)
	lwc	$f2, 24($29)
	lw	$1, 8($29)
	j	is_second_outside.2725
check_all_inside.2735:
	lw	$3, 4($28)
	sll	$4, $1, 2
	add	$27, $4, $2
	lw	$4, 0($27)
	set	$5, -1
	bne	$4, $5, beq_else.8861
	set	$1, 1
	jr $31
beq_else.8861:
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
	jal	is_outside.2730
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.8862
	lw	$1, 20($29)
	addi	$1, $1, 1
	lwc	$f0, 8($29)
	lwc	$f1, 4($29)
	lwc	$f2, 0($29)
	lw	$2, 12($29)
	lw	$28, 16($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8862:
	set	$1, 0
	jr $31
shadow_check_and_group.2741:
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
	bne	$10, $11, beq_else.8863
	set	$1, 0
	jr $31
beq_else.8863:
	sll	$10, $1, 2
	add	$27, $10, $2
	lw	$10, 0($27)
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
	bne	$1, $2, beq_else.8864
	set	$1, 0
	j	beq_cont.8865
beq_else.8864:
	setclv	$f1, l.6309
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fless
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
beq_cont.8865:
	set	$2, 0
	bne	$1, $2, beq_else.8866
	lw	$1, 28($29)
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.8867
	set	$1, 0
	jr $31
beq_else.8867:
	lw	$1, 20($29)
	addi	$1, $1, 1
	lw	$2, 12($29)
	lw	$28, 16($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8866:
	setclv	$f0, l.6310
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
	bne	$1, $2, beq_else.8868
	lw	$1, 20($29)
	addi	$1, $1, 1
	lw	$2, 12($29)
	lw	$28, 16($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8868:
	set	$1, 1
	jr $31
shadow_check_one_or_group.2744:
	lw	$3, 8($28)
	lw	$4, 4($28)
	sll	$5, $1, 2
	add	$27, $5, $2
	lw	$5, 0($27)
	set	$6, -1
	bne	$5, $6, beq_else.8869
	set	$1, 0
	jr $31
beq_else.8869:
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
	bne	$1, $2, beq_else.8870
	lw	$1, 8($29)
	addi	$1, $1, 1
	lw	$2, 0($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8870:
	set	$1, 1
	jr $31
shadow_check_one_or_matrix.2747:
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
	bne	$9, $10, beq_else.8871
	set	$1, 0
	jr $31
beq_else.8871:
	set	$10, 99
	sw	$8, 0($29)
	sw	$5, 4($29)
	sw	$2, 8($29)
	sw	$28, 12($29)
	sw	$1, 16($29)
	bne	$9, $10, beq_else.8872
	set	$1, 1
	j	beq_cont.8873
beq_else.8872:
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
	bne	$1, $2, beq_else.8874
	set	$1, 0
	j	beq_cont.8875
beq_else.8874:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lwc	$f0, 0($27)
	setclv	$f1, l.6323
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fless
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.8876
	set	$1, 0
	j	beq_cont.8877
beq_else.8876:
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
	bne	$1, $2, beq_else.8878
	set	$1, 0
	j	beq_cont.8879
beq_else.8878:
	set	$1, 1
beq_cont.8879:
beq_cont.8877:
beq_cont.8875:
beq_cont.8873:
	set	$2, 0
	bne	$1, $2, beq_else.8880
	lw	$1, 16($29)
	addi	$1, $1, 1
	lw	$2, 8($29)
	lw	$28, 12($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8880:
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
	bne	$1, $2, beq_else.8881
	lw	$1, 16($29)
	addi	$1, $1, 1
	lw	$2, 8($29)
	lw	$28, 12($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8881:
	set	$1, 1
	jr $31
solve_each_element.2750:
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
	bne	$13, $14, beq_else.8882
jr $31
beq_else.8882:
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
	bne	$1, $2, beq_else.8884
	lw	$1, 48($29)
	sll	$1, $1, 2
	lw	$2, 44($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.8885
jr $31
beq_else.8885:
	lw	$1, 40($29)
	addi	$1, $1, 1
	lw	$2, 32($29)
	lw	$3, 28($29)
	lw	$28, 36($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8884:
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 24($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	setclv	$f0, l.5993
	sw	$1, 52($29)
	swc	$f1, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fless
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.8887
	j	beq_cont.8888
beq_else.8887:
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
	bne	$1, $2, beq_else.8889
	j	beq_cont.8890
beq_else.8889:
	setclv	$f0, l.6310
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
	bne	$1, $2, beq_else.8891
	j	beq_cont.8892
beq_else.8891:
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
	jal	vecset.2472
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
beq_cont.8892:
beq_cont.8890:
beq_cont.8888:
	lw	$1, 40($29)
	addi	$1, $1, 1
	lw	$2, 32($29)
	lw	$3, 28($29)
	lw	$28, 36($29)
	lw	$27, 0($28)
	jr	$27
solve_one_or_network.2754:
	lw	$4, 8($28)
	lw	$5, 4($28)
	sll	$6, $1, 2
	add	$27, $6, $2
	lw	$6, 0($27)
	set	$7, -1
	bne	$6, $7, beq_else.8893
jr $31
beq_else.8893:
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
trace_or_matrix.2758:
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
	bne	$10, $11, beq_else.8895
jr $31
beq_else.8895:
	set	$11, 99
	sw	$3, 0($29)
	sw	$2, 4($29)
	sw	$28, 8($29)
	sw	$1, 12($29)
	bne	$10, $11, beq_else.8897
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
	j	beq_cont.8898
beq_else.8897:
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
	bne	$1, $2, beq_else.8899
	j	beq_cont.8900
beq_else.8899:
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
	bne	$1, $2, beq_else.8901
	j	beq_cont.8902
beq_else.8901:
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
beq_cont.8902:
beq_cont.8900:
beq_cont.8898:
	lw	$1, 12($29)
	addi	$1, $1, 1
	lw	$2, 4($29)
	lw	$3, 0($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
judge_intersection.2762:
	lw	$2, 12($28)
	lw	$3, 8($28)
	lw	$4, 4($28)
	set	$5, 0
	setclv	$f0, l.6343
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
	setclv	$f0, l.6323
	swc	$f1, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fless
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	bne	$1, $2, beq_else.8903
	set	$1, 0
	jr $31
beq_else.8903:
	setclv	$f1, l.6347
	lwc	$f0, 4($29)
	j	min_caml_fless
solve_each_element_fast.2764:
	lw	$4, 36($28)
	lw	$5, 32($28)
	lw	$6, 28($28)
	lw	$7, 24($28)
	lw	$8, 20($28)
	lw	$9, 16($28)
	lw	$10, 12($28)
	lw	$11, 8($28)
	lw	$12, 4($28)
	sw	$9, 0($29)
	sw	$11, 4($29)
	sw	$10, 8($29)
	sw	$12, 12($29)
	sw	$5, 16($29)
	sw	$4, 20($29)
	sw	$7, 24($29)
	sw	$28, 28($29)
	sw	$8, 32($29)
	sw	$3, 36($29)
	sw	$6, 40($29)
	sw	$2, 44($29)
	sw	$1, 48($29)
	mov	$1, $3
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	d_vec.2579
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$2, 48($29)
	sll	$3, $2, 2
	lw	$4, 44($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	set	$5, -1
	bne	$3, $5, beq_else.8904
jr $31
beq_else.8904:
	lw	$5, 36($29)
	lw	$28, 40($29)
	sw	$1, 52($29)
	sw	$3, 56($29)
	mov	$2, $5
	mov	$1, $3
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.8906
	lw	$1, 56($29)
	sll	$1, $1, 2
	lw	$2, 32($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.8907
jr $31
beq_else.8907:
	lw	$1, 48($29)
	addi	$1, $1, 1
	lw	$2, 44($29)
	lw	$3, 36($29)
	lw	$28, 28($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8906:
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 24($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	setclv	$f0, l.5993
	sw	$1, 60($29)
	swc	$f1, 64($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fless
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	set	$2, 0
	bne	$1, $2, beq_else.8909
	j	beq_cont.8910
beq_else.8909:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lwc	$f0, 64($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fless
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	set	$2, 0
	bne	$1, $2, beq_else.8911
	j	beq_cont.8912
beq_else.8911:
	setclv	$f0, l.6310
	lwc	$f1, 64($29)
	add.s	$f0, $f1, $f0
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 52($29)
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
	lw	$2, 44($29)
	lw	$28, 12($29)
	swc	$f3, 68($29)
	swc	$f2, 72($29)
	swc	$f1, 76($29)
	swc	$f0, 80($29)
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
	bne	$1, $2, beq_else.8913
	j	beq_cont.8914
beq_else.8913:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 20($29)
	lwc	$f0, 80($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	lwc	$f0, 76($29)
	lwc	$f1, 72($29)
	lwc	$f2, 68($29)
	lw	$1, 8($29)
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	vecset.2472
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 4($29)
	lw	$3, 56($29)
	add	$27, $1, $2
	sw	$3, 0($27)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lw	$3, 60($29)
	add	$27, $1, $2
	sw	$3, 0($27)
beq_cont.8914:
beq_cont.8912:
beq_cont.8910:
	lw	$1, 48($29)
	addi	$1, $1, 1
	lw	$2, 44($29)
	lw	$3, 36($29)
	lw	$28, 28($29)
	lw	$27, 0($28)
	jr	$27
solve_one_or_network_fast.2768:
	lw	$4, 8($28)
	lw	$5, 4($28)
	sll	$6, $1, 2
	add	$27, $6, $2
	lw	$6, 0($27)
	set	$7, -1
	bne	$6, $7, beq_else.8915
jr $31
beq_else.8915:
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
trace_or_matrix_fast.2772:
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
	bne	$9, $10, beq_else.8917
jr $31
beq_else.8917:
	set	$10, 99
	sw	$3, 0($29)
	sw	$2, 4($29)
	sw	$28, 8($29)
	sw	$1, 12($29)
	bne	$9, $10, beq_else.8919
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
	j	beq_cont.8920
beq_else.8919:
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
	bne	$1, $2, beq_else.8921
	j	beq_cont.8922
beq_else.8921:
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
	bne	$1, $2, beq_else.8923
	j	beq_cont.8924
beq_else.8923:
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
beq_cont.8924:
beq_cont.8922:
beq_cont.8920:
	lw	$1, 12($29)
	addi	$1, $1, 1
	lw	$2, 4($29)
	lw	$3, 0($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
judge_intersection_fast.2776:
	lw	$2, 12($28)
	lw	$3, 8($28)
	lw	$4, 4($28)
	set	$5, 0
	setclv	$f0, l.6343
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
	setclv	$f0, l.6323
	swc	$f1, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_fless
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	bne	$1, $2, beq_else.8925
	set	$1, 0
	jr $31
beq_else.8925:
	setclv	$f1, l.6347
	lwc	$f0, 4($29)
	j	min_caml_fless
get_nvector_rect.2778:
	lw	$2, 8($28)
	lw	$3, 4($28)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $3
	lw	$3, 0($27)
	sw	$2, 0($29)
	sw	$1, 4($29)
	sw	$3, 8($29)
	mov	$1, $2
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	vecbzero.2480
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
	jal	sgn.2464
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
get_nvector_plane.2780:
	lw	$2, 4($28)
	set	$3, 0
	sw	$1, 0($29)
	sw	$2, 4($29)
	sw	$3, 8($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	o_param_a.2528
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
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
	sw	$1, 12($29)
	mov	$1, $3
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_b.2530
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
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	lw	$3, 0($29)
	sw	$1, 16($29)
	mov	$1, $3
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_c.2532
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
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
get_nvector_second.2782:
	lw	$2, 8($28)
	lw	$3, 4($28)
	set	$4, 0
	sll	$4, $4, 2
	add	$27, $4, $3
	lwc	$f0, 0($27)
	sw	$2, 0($29)
	sw	$1, 4($29)
	sw	$3, 8($29)
	swc	$f0, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_param_x.2536
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lwc	$f1, 12($29)
	sub.s	$f0, $f1, $f0
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 4($29)
	swc	$f0, 16($29)
	swc	$f1, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_param_y.2538
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 20($29)
	sub.s	$f0, $f1, $f0
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 8($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 4($29)
	swc	$f0, 24($29)
	swc	$f1, 28($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_z.2540
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 28($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 4($29)
	swc	$f0, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_a.2528
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 16($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 4($29)
	swc	$f0, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_b.2530
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 24($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 4($29)
	swc	$f0, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_c.2532
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 32($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 4($29)
	swc	$f0, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_isrot.2526
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.8928
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 0($29)
	lwc	$f0, 36($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	sll	$1, $1, 2
	lwc	$f0, 40($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	sll	$1, $1, 2
	lwc	$f0, 44($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	j	beq_cont.8929
beq_else.8928:
	set	$1, 0
	lw	$2, 4($29)
	sw	$1, 48($29)
	mov	$1, $2
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_r3.2556
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 24($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 4($29)
	swc	$f0, 52($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	o_param_r2.2554
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 32($29)
	mul.s	$f0, $f1, $f0
	lwc	$f2, 52($29)
	add.s	$f0, $f2, $f0
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 36($29)
	add.s	$f0, $f1, $f0
	lw	$1, 48($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	lw	$3, 4($29)
	sw	$1, 56($29)
	mov	$1, $3
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	o_param_r3.2556
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 16($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 4($29)
	swc	$f0, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	o_param_r1.2552
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 32($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 60($29)
	add.s	$f0, $f1, $f0
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 40($29)
	add.s	$f0, $f1, $f0
	lw	$1, 56($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	lw	$3, 4($29)
	sw	$1, 64($29)
	mov	$1, $3
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	o_param_r2.2554
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 16($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 4($29)
	swc	$f0, 68($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	o_param_r1.2552
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 24($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 68($29)
	add.s	$f0, $f1, $f0
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_fhalf
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 44($29)
	add.s	$f0, $f1, $f0
	lw	$1, 64($29)
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
beq_cont.8929:
	lw	$1, 4($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	o_isinvert.2524
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	mov	$2, $1
	lw	$1, 0($29)
	j	vecunit_sgn.2490
get_nvector.2784:
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$5, 4($28)
	sw	$3, 0($29)
	sw	$1, 4($29)
	sw	$5, 8($29)
	sw	$2, 12($29)
	sw	$4, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_form.2520
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 1
	bne	$1, $2, beq_else.8930
	lw	$1, 12($29)
	lw	$28, 16($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8930:
	set	$2, 2
	bne	$1, $2, beq_else.8931
	lw	$1, 4($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8931:
	lw	$1, 4($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
utexture.2787:
	lw	$3, 4($28)
	sw	$2, 0($29)
	sw	$3, 4($29)
	sw	$1, 8($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	o_texturetype.2518
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 0
	lw	$3, 8($29)
	sw	$1, 12($29)
	sw	$2, 16($29)
	mov	$1, $3
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_color_red.2546
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$1, 16($29)
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	lw	$3, 8($29)
	sw	$1, 20($29)
	mov	$1, $3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_color_green.2548
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 20($29)
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 2
	lw	$3, 8($29)
	sw	$1, 24($29)
	mov	$1, $3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_color_blue.2550
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 24($29)
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	set	$1, 1
	lw	$3, 12($29)
	bne	$3, $1, beq_else.8932
	set	$1, 0
	sll	$1, $1, 2
	lw	$3, 0($29)
	add	$27, $1, $3
	lwc	$f0, 0($27)
	lw	$1, 8($29)
	swc	$f0, 28($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_x.2536
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f1, 28($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.6410
	mul.s	$f1, $f0, $f1
	swc	$f0, 32($29)
	mov.s	$f0, $f1
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_floor
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	setclv	$f1, l.6411
	mul.s	$f0, $f0, $f1
	lwc	$f1, 32($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.6402
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fless
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	set	$2, 2
	sll	$2, $2, 2
	lw	$3, 0($29)
	add	$27, $2, $3
	lwc	$f0, 0($27)
	lw	$2, 8($29)
	sw	$1, 36($29)
	swc	$f0, 40($29)
	mov	$1, $2
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_z.2540
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 40($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.6410
	mul.s	$f1, $f0, $f1
	swc	$f0, 44($29)
	mov.s	$f0, $f1
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_floor
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	setclv	$f1, l.6411
	mul.s	$f0, $f0, $f1
	lwc	$f1, 44($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.6402
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fless
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 1
	set	$3, 0
	lw	$4, 36($29)
	bne	$4, $3, beq_else.8933
	set	$3, 0
	bne	$1, $3, beq_else.8935
	setclv	$f0, l.6397
	j	beq_cont.8936
beq_else.8935:
	setclv	$f0, l.5993
beq_cont.8936:
	j	beq_cont.8934
beq_else.8933:
	set	$3, 0
	bne	$1, $3, beq_else.8937
	setclv	$f0, l.5993
	j	beq_cont.8938
beq_else.8937:
	setclv	$f0, l.6397
beq_cont.8938:
beq_cont.8934:
	sll	$1, $2, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
jr $31
beq_else.8932:
	set	$1, 2
	bne	$3, $1, beq_else.8940
	set	$1, 1
	sll	$1, $1, 2
	lw	$3, 0($29)
	add	$27, $1, $3
	lwc	$f0, 0($27)
	setclv	$f1, l.6406
	mul.s	$f0, $f0, $f1
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_sin
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$1, 0
	setclv	$f1, l.6397
	mul.s	$f1, $f1, $f0
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f1, 0($27)
	set	$1, 1
	setclv	$f1, l.6397
	setclv	$f2, l.5994
	sub.s	$f0, $f2, $f0
	mul.s	$f0, $f1, $f0
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
jr $31
beq_else.8940:
	set	$1, 3
	bne	$3, $1, beq_else.8942
	set	$1, 0
	sll	$1, $1, 2
	lw	$3, 0($29)
	add	$27, $1, $3
	lwc	$f0, 0($27)
	lw	$1, 8($29)
	swc	$f0, 48($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_x.2536
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 48($29)
	sub.s	$f0, $f1, $f0
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 8($29)
	swc	$f0, 52($29)
	swc	$f1, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	o_param_z.2540
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 56($29)
	sub.s	$f0, $f1, $f0
	lwc	$f1, 52($29)
	swc	$f0, 60($29)
	mov.s	$f0, $f1
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 60($29)
	swc	$f0, 64($29)
	mov.s	$f0, $f1
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 64($29)
	add.s	$f0, $f1, $f0
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	setclv	$f1, l.6402
	div.s	$f0, $f0, $f1
	swc	$f0, 68($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_floor
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 68($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.6393
	mul.s	$f0, $f0, $f1
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_cos
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	set	$1, 1
	setclv	$f1, l.6397
	mul.s	$f1, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f1, 0($27)
	set	$1, 2
	setclv	$f1, l.5994
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.6397
	mul.s	$f0, $f0, $f1
	sll	$1, $1, 2
	add	$27, $1, $2
	swc	$f0, 0($27)
jr $31
beq_else.8942:
	set	$1, 4
	bne	$3, $1, beq_else.8944
	set	$1, 0
	sll	$1, $1, 2
	lw	$3, 0($29)
	add	$27, $1, $3
	lwc	$f0, 0($27)
	lw	$1, 8($29)
	swc	$f0, 72($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	o_param_x.2536
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 72($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 8($29)
	swc	$f0, 76($29)
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	o_param_a.2528
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	lwc	$f1, 76($29)
	mul.s	$f0, $f1, $f0
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 8($29)
	swc	$f0, 80($29)
	swc	$f1, 84($29)
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	o_param_z.2540
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	lwc	$f1, 84($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 8($29)
	swc	$f0, 88($29)
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	o_param_c.2532
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	lwc	$f1, 88($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 80($29)
	swc	$f0, 92($29)
	mov.s	$f0, $f1
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	lwc	$f1, 92($29)
	swc	$f0, 96($29)
	mov.s	$f0, $f1
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	lwc	$f1, 96($29)
	add.s	$f0, $f1, $f0
	lwc	$f1, 80($29)
	swc	$f0, 100($29)
	mov.s	$f0, $f1
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_fabs
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	setclv	$f1, l.6390
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_fless
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	set	$2, 0
	bne	$1, $2, beq_else.8945
	lwc	$f0, 80($29)
	lwc	$f1, 92($29)
	div.s	$f0, $f1, $f0
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_fabs
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_atan
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	setclv	$f1, l.6392
	mul.s	$f0, $f0, $f1
	setclv	$f1, l.6393
	div.s	$f0, $f0, $f1
	j	beq_cont.8946
beq_else.8945:
	setclv	$f0, l.6391
beq_cont.8946:
	swc	$f0, 104($29)
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_floor
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	lwc	$f1, 104($29)
	sub.s	$f0, $f1, $f0
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 0($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	lw	$1, 8($29)
	swc	$f0, 108($29)
	swc	$f1, 112($29)
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	o_param_y.2538
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	lwc	$f1, 112($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 8($29)
	swc	$f0, 116($29)
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	o_param_b.2530
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	lwc	$f1, 116($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 100($29)
	swc	$f0, 120($29)
	mov.s	$f0, $f1
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	min_caml_fabs
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	setclv	$f1, l.6390
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	min_caml_fless
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	set	$2, 0
	bne	$1, $2, beq_else.8947
	lwc	$f0, 100($29)
	lwc	$f1, 120($29)
	div.s	$f0, $f1, $f0
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	min_caml_fabs
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	min_caml_atan
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	setclv	$f1, l.6392
	mul.s	$f0, $f0, $f1
	setclv	$f1, l.6393
	div.s	$f0, $f0, $f1
	j	beq_cont.8948
beq_else.8947:
	setclv	$f0, l.6391
beq_cont.8948:
	swc	$f0, 124($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	min_caml_floor
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	lwc	$f1, 124($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.6395
	setclv	$f2, l.6396
	lwc	$f3, 108($29)
	sub.s	$f2, $f2, $f3
	swc	$f0, 128($29)
	swc	$f1, 132($29)
	mov.s	$f0, $f2
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	lwc	$f1, 132($29)
	sub.s	$f0, $f1, $f0
	setclv	$f1, l.6396
	lwc	$f2, 128($29)
	sub.s	$f1, $f1, $f2
	swc	$f0, 136($29)
	mov.s	$f0, $f1
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	lwc	$f1, 136($29)
	sub.s	$f0, $f1, $f0
	swc	$f0, 140($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	set	$2, 0
	bne	$1, $2, beq_else.8949
	lwc	$f0, 140($29)
	j	beq_cont.8950
beq_else.8949:
	setclv	$f0, l.5993
beq_cont.8950:
	set	$1, 2
	setclv	$f1, l.6397
	mul.s	$f0, $f1, $f0
	setclv	$f1, l.6398
	div.s	$f0, $f0, $f1
	sll	$1, $1, 2
	lw	$2, 4($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
jr $31
beq_else.8944:
jr $31
add_light.2790:
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
	bne	$1, $2, beq_else.8953
	j	beq_cont.8954
beq_else.8953:
	lwc	$f0, 8($29)
	lw	$1, 16($29)
	lw	$2, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	vecaccum.2501
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
beq_cont.8954:
	lwc	$f0, 4($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fispos
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.8955
jr $31
beq_else.8955:
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
trace_reflections.2794:
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
	bne	$27, $0, ble_else.8958
	sll	$11, $1, 2
	add	$27, $11, $4
	lw	$4, 0($27)
	sw	$28, 0($29)
	sw	$1, 4($29)
	swc	$f1, 8($29)
	sw	$10, 12($29)
	sw	$2, 16($29)
	swc	$f0, 20($29)
	sw	$6, 24($29)
	sw	$3, 28($29)
	sw	$5, 32($29)
	sw	$4, 36($29)
	sw	$8, 40($29)
	sw	$9, 44($29)
	sw	$7, 48($29)
	mov	$1, $4
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	r_dvec.2585
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$28, 48($29)
	sw	$1, 52($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.8959
	j	beq_cont.8960
beq_else.8959:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 44($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sll	$1, $1, 2
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 40($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	add	$1, $1, $2
	lw	$2, 36($29)
	sw	$1, 56($29)
	mov	$1, $2
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	r_surface_id.2583
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$2, 56($29)
	bne	$2, $1, beq_else.8961
	set	$1, 0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 32($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$28, 28($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.8963
	lw	$1, 52($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	d_vec.2579
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	mov	$2, $1
	lw	$1, 24($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	veciprod.2493
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$1, 36($29)
	swc	$f0, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	r_bright.2587
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 20($29)
	mul.s	$f2, $f0, $f1
	lwc	$f3, 60($29)
	mul.s	$f2, $f2, $f3
	lw	$1, 52($29)
	swc	$f2, 64($29)
	swc	$f0, 68($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	d_vec.2579
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	mov	$2, $1
	lw	$1, 16($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	veciprod.2493
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 68($29)
	mul.s	$f1, $f1, $f0
	lwc	$f0, 64($29)
	lwc	$f2, 8($29)
	lw	$28, 12($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -80
	lw	$31, 76($29)
	j	beq_cont.8964
beq_else.8963:
beq_cont.8964:
	j	beq_cont.8962
beq_else.8961:
beq_cont.8962:
beq_cont.8960:
	set	$1, 1
	lw	$2, 4($29)
	sub	$1, $2, $1
	lwc	$f0, 20($29)
	lwc	$f1, 8($29)
	lw	$2, 16($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.8958:
jr $31
trace_ray.2799:
	lw	$4, 80($28)
	lw	$5, 76($28)
	lw	$6, 72($28)
	lw	$7, 68($28)
	lw	$8, 64($28)
	lw	$9, 60($28)
	lw	$10, 56($28)
	lw	$11, 52($28)
	lw	$12, 48($28)
	lw	$13, 44($28)
	lw	$14, 40($28)
	lw	$15, 36($28)
	lw	$16, 32($28)
	lw	$17, 28($28)
	lw	$18, 24($28)
	lw	$19, 20($28)
	lw	$20, 16($28)
	lw	$21, 12($28)
	lw	$22, 8($28)
	lw	$23, 4($28)
	set	$24, 4
	slt	$27, $24, $1
	bne	$27, $0, ble_else.8966
	sw	$28, 0($29)
	swc	$f1, 4($29)
	sw	$6, 8($29)
	sw	$5, 12($29)
	sw	$15, 16($29)
	sw	$10, 20($29)
	sw	$23, 24($29)
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
	sw	$13, 68($29)
	sw	$20, 72($29)
	sw	$11, 76($29)
	sw	$22, 80($29)
	swc	$f0, 84($29)
	sw	$16, 88($29)
	sw	$1, 92($29)
	sw	$2, 96($29)
	sw	$17, 100($29)
	mov	$1, $3
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	p_surface_ids.2564
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	lw	$2, 96($29)
	lw	$28, 100($29)
	sw	$1, 104($29)
	mov	$1, $2
	sw	$31, 108($29)
	addi	$29, $29, 112
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -112
	lw	$31, 108($29)
	set	$2, 0
	bne	$1, $2, beq_else.8967
	set	$1, -1
	lw	$2, 92($29)
	sll	$3, $2, 2
	lw	$4, 104($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	set	$1, 0
	bne	$2, $1, beq_else.8968
jr $31
beq_else.8968:
	lw	$1, 96($29)
	lw	$2, 88($29)
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	veciprod.2493
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_fneg
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	swc	$f0, 108($29)
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	min_caml_fispos
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	set	$2, 0
	bne	$1, $2, beq_else.8970
jr $31
beq_else.8970:
	lwc	$f0, 108($29)
	sw	$31, 116($29)
	addi	$29, $29, 120
	jal	min_caml_fsqr
	nop
	addi	$29, $29, -120
	lw	 $31, 116($29)
	lwc	$f1, 108($29)
	mul.s	$f0, $f0, $f1
	lwc	$f1, 84($29)
	mul.s	$f0, $f0, $f1
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 80($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	mul.s	$f0, $f0, $f1
	set	$1, 0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 76($29)
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
beq_else.8967:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 72($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sll	$2, $1, 2
	lw	$3, 68($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	sw	$1, 112($29)
	sw	$2, 116($29)
	mov	$1, $2
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	o_reflectiontype.2522
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	lw	$2, 116($29)
	sw	$1, 120($29)
	mov	$1, $2
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	o_diffuse.2542
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	lwc	$f1, 84($29)
	mul.s	$f0, $f0, $f1
	lw	$1, 116($29)
	lw	$2, 96($29)
	lw	$28, 64($29)
	swc	$f0, 124($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -136
	lw	$31, 132($29)
	lw	$1, 60($29)
	lw	$2, 56($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	veccpy.2482
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	lw	$1, 116($29)
	lw	$2, 56($29)
	lw	$28, 52($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -136
	lw	$31, 132($29)
	lw	$1, 112($29)
	sll	$1, $1, 2
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 48($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	add	$1, $1, $2
	lw	$2, 92($29)
	sll	$3, $2, 2
	lw	$4, 104($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	lw	$1, 44($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	p_intersection_points.2562
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	lw	$2, 92($29)
	sll	$3, $2, 2
	add	$27, $3, $1
	lw	$1, 0($27)
	lw	$3, 56($29)
	mov	$2, $3
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	veccpy.2482
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	lw	$1, 44($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	p_calc_diffuse.2566
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	lw	$2, 116($29)
	sw	$1, 128($29)
	mov	$1, $2
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	o_diffuse.2542
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	setclv	$f1, l.6396
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	min_caml_fless
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	set	$2, 0
	bne	$1, $2, beq_else.8973
	set	$1, 1
	lw	$2, 92($29)
	sll	$3, $2, 2
	lw	$4, 128($29)
	add	$27, $3, $4
	sw	$1, 0($27)
	lw	$1, 44($29)
	sw	$31, 132($29)
	addi	$29, $29, 136
	jal	p_energy.2568
	nop
	addi	$29, $29, -136
	lw	 $31, 132($29)
	lw	$2, 92($29)
	sll	$3, $2, 2
	add	$27, $3, $1
	lw	$3, 0($27)
	lw	$4, 40($29)
	sw	$1, 132($29)
	mov	$2, $4
	mov	$1, $3
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	veccpy.2482
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	lw	$1, 92($29)
	sll	$2, $1, 2
	lw	$3, 132($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	setclv	$f0, l.6433
	lwc	$f1, 124($29)
	mul.s	$f0, $f0, $f1
	mov	$1, $2
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	vecscale.2511
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	lw	$1, 44($29)
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	p_nvectors.2577
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	lw	$2, 92($29)
	sll	$3, $2, 2
	add	$27, $3, $1
	lw	$1, 0($27)
	lw	$3, 36($29)
	mov	$2, $3
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	veccpy.2482
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	j	beq_cont.8974
beq_else.8973:
	set	$1, 0
	lw	$2, 92($29)
	sll	$3, $2, 2
	lw	$4, 128($29)
	add	$27, $3, $4
	sw	$1, 0($27)
beq_cont.8974:
	setclv	$f0, l.6435
	lw	$1, 96($29)
	lw	$2, 36($29)
	swc	$f0, 136($29)
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	veciprod.2493
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	lwc	$f1, 136($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 96($29)
	lw	$2, 36($29)
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	vecaccum.2501
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	lw	$1, 116($29)
	sw	$31, 140($29)
	addi	$29, $29, 144
	jal	o_hilight.2544
	nop
	addi	$29, $29, -144
	lw	 $31, 140($29)
	lwc	$f1, 84($29)
	mul.s	$f0, $f1, $f0
	set	$1, 0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 32($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$28, 28($29)
	swc	$f0, 140($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -152
	lw	$31, 148($29)
	set	$2, 0
	bne	$1, $2, beq_else.8975
	lw	$1, 36($29)
	lw	$2, 88($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	veciprod.2493
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	min_caml_fneg
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	lwc	$f1, 124($29)
	mul.s	$f0, $f0, $f1
	lw	$1, 96($29)
	lw	$2, 88($29)
	swc	$f0, 144($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	veciprod.2493
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	min_caml_fneg
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	mov.s	$f1, $f0
	lwc	$f0, 144($29)
	lwc	$f2, 140($29)
	lw	$28, 24($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -152
	lw	$31, 148($29)
	j	beq_cont.8976
beq_else.8975:
beq_cont.8976:
	lw	$1, 56($29)
	lw	$28, 20($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -152
	lw	$31, 148($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	set	$2, 1
	sub	$1, $1, $2
	lwc	$f0, 124($29)
	lwc	$f1, 140($29)
	lw	$2, 96($29)
	lw	$28, 12($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -152
	lw	$31, 148($29)
	setclv	$f0, l.6438
	lwc	$f1, 84($29)
	sw	$31, 148($29)
	addi	$29, $29, 152
	jal	min_caml_fless
	nop
	addi	$29, $29, -152
	lw	 $31, 148($29)
	set	$2, 0
	bne	$1, $2, beq_else.8977
jr $31
beq_else.8977:
	set	$1, 4
	lw	$2, 92($29)
	slt	$27, $2, $1
	bne	$27, $0, ble_else.8979
	j	ble_cont.8980
ble_else.8979:
	addi	$1, $2, 1
	set	$3, -1
	sll	$1, $1, 2
	lw	$4, 104($29)
	add	$27, $1, $4
	sw	$3, 0($27)
ble_cont.8980:
	set	$1, 2
	lw	$3, 120($29)
	bne	$3, $1, beq_else.8981
	setclv	$f0, l.5994
	lw	$1, 116($29)
	swc	$f0, 148($29)
	sw	$31, 156($29)
	addi	$29, $29, 160
	jal	o_diffuse.2542
	nop
	addi	$29, $29, -160
	lw	 $31, 156($29)
	lwc	$f1, 148($29)
	sub.s	$f0, $f1, $f0
	lwc	$f1, 84($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 92($29)
	addi	$1, $1, 1
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 8($29)
	add	$27, $2, $3
	lwc	$f1, 0($27)
	lwc	$f2, 4($29)
	add.s	$f1, $f2, $f1
	lw	$2, 96($29)
	lw	$3, 44($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
beq_else.8981:
jr $31
ble_else.8966:
jr $31
trace_diffuse_ray.2805:
	lw	$2, 48($28)
	lw	$3, 44($28)
	lw	$4, 40($28)
	lw	$5, 36($28)
	lw	$6, 32($28)
	lw	$7, 28($28)
	lw	$8, 24($28)
	lw	$9, 20($28)
	lw	$10, 16($28)
	lw	$11, 12($28)
	lw	$12, 8($28)
	lw	$13, 4($28)
	sw	$3, 0($29)
	sw	$13, 4($29)
	swc	$f0, 8($29)
	sw	$8, 12($29)
	sw	$7, 16($29)
	sw	$4, 20($29)
	sw	$5, 24($29)
	sw	$10, 28($29)
	sw	$2, 32($29)
	sw	$12, 36($29)
	sw	$1, 40($29)
	sw	$6, 44($29)
	sw	$11, 48($29)
	mov	$28, $9
	sw	$31, 52($29)
	addi	$29, $29, 56
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -56
	lw	$31, 52($29)
	set	$2, 0
	bne	$1, $2, beq_else.8984
jr $31
beq_else.8984:
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 48($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sll	$1, $1, 2
	lw	$2, 44($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	lw	$2, 40($29)
	sw	$1, 52($29)
	mov	$1, $2
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	d_vec.2579
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	mov	$2, $1
	lw	$1, 52($29)
	lw	$28, 36($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	lw	$1, 52($29)
	lw	$2, 28($29)
	lw	$28, 32($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	set	$1, 0
	set	$2, 0
	sll	$2, $2, 2
	lw	$3, 24($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$28, 20($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.8986
	lw	$1, 16($29)
	lw	$2, 12($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	veciprod.2493
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fneg
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	swc	$f0, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_fispos
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 0
	bne	$1, $2, beq_else.8987
	setclv	$f0, l.5993
	j	beq_cont.8988
beq_else.8987:
	lwc	$f0, 56($29)
beq_cont.8988:
	lwc	$f1, 8($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 52($29)
	swc	$f0, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	o_diffuse.2542
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 60($29)
	mul.s	$f0, $f1, $f0
	lw	$1, 4($29)
	lw	$2, 0($29)
	j	vecaccum.2501
beq_else.8986:
jr $31
iter_trace_diffuse_rays.2808:
	lw	$5, 4($28)
	set	$6, 0
	slt	$27, $4, $6
	bne	$27, $0, ble_else.8990
	sll	$6, $4, 2
	add	$27, $6, $1
	lw	$6, 0($27)
	sw	$3, 0($29)
	sw	$28, 4($29)
	sw	$5, 8($29)
	sw	$1, 12($29)
	sw	$4, 16($29)
	sw	$2, 20($29)
	mov	$1, $6
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	d_vec.2579
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	veciprod.2493
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	swc	$f0, 24($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	min_caml_fisneg
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	bne	$1, $2, beq_else.8991
	lw	$1, 16($29)
	sll	$2, $1, 2
	lw	$3, 12($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	setclv	$f0, l.6456
	lwc	$f1, 24($29)
	div.s	$f0, $f1, $f0
	lw	$28, 8($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
	j	beq_cont.8992
beq_else.8991:
	lw	$1, 16($29)
	addi	$2, $1, 1
	sll	$2, $2, 2
	lw	$3, 12($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	setclv	$f0, l.6454
	lwc	$f1, 24($29)
	div.s	$f0, $f1, $f0
	lw	$28, 8($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -32
	lw	$31, 28($29)
beq_cont.8992:
	set	$1, 2
	lw	$2, 16($29)
	sub	$4, $2, $1
	lw	$1, 12($29)
	lw	$2, 20($29)
	lw	$3, 0($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
ble_else.8990:
jr $31
trace_diffuse_rays.2813:
	lw	$4, 8($28)
	lw	$5, 4($28)
	sw	$3, 0($29)
	sw	$2, 4($29)
	sw	$1, 8($29)
	sw	$5, 12($29)
	mov	$1, $3
	mov	$28, $4
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
	set	$4, 118
	lw	$1, 8($29)
	lw	$2, 4($29)
	lw	$3, 0($29)
	lw	$28, 12($29)
	lw	$27, 0($28)
	jr	$27
trace_diffuse_ray_80percent.2817:
	lw	$4, 8($28)
	lw	$5, 4($28)
	set	$6, 0
	sw	$3, 0($29)
	sw	$2, 4($29)
	sw	$4, 8($29)
	sw	$5, 12($29)
	sw	$1, 16($29)
	bne	$1, $6, beq_else.8994
	j	beq_cont.8995
beq_else.8994:
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $5
	lw	$6, 0($27)
	mov	$1, $6
	mov	$28, $4
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
beq_cont.8995:
	set	$1, 1
	lw	$2, 16($29)
	bne	$2, $1, beq_else.8996
	j	beq_cont.8997
beq_else.8996:
	set	$1, 1
	sll	$1, $1, 2
	lw	$3, 12($29)
	add	$27, $1, $3
	lw	$1, 0($27)
	lw	$4, 4($29)
	lw	$5, 0($29)
	lw	$28, 8($29)
	mov	$3, $5
	mov	$2, $4
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
beq_cont.8997:
	set	$1, 2
	lw	$2, 16($29)
	bne	$2, $1, beq_else.8998
	j	beq_cont.8999
beq_else.8998:
	set	$1, 2
	sll	$1, $1, 2
	lw	$3, 12($29)
	add	$27, $1, $3
	lw	$1, 0($27)
	lw	$4, 4($29)
	lw	$5, 0($29)
	lw	$28, 8($29)
	mov	$3, $5
	mov	$2, $4
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
beq_cont.8999:
	set	$1, 3
	lw	$2, 16($29)
	bne	$2, $1, beq_else.9000
	j	beq_cont.9001
beq_else.9000:
	set	$1, 3
	sll	$1, $1, 2
	lw	$3, 12($29)
	add	$27, $1, $3
	lw	$1, 0($27)
	lw	$4, 4($29)
	lw	$5, 0($29)
	lw	$28, 8($29)
	mov	$3, $5
	mov	$2, $4
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
beq_cont.9001:
	set	$1, 4
	lw	$2, 16($29)
	bne	$2, $1, beq_else.9002
jr $31
beq_else.9002:
	set	$1, 4
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	lw	$2, 4($29)
	lw	$3, 0($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
calc_diffuse_using_1point.2821:
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$5, 4($28)
	sw	$4, 0($29)
	sw	$3, 4($29)
	sw	$5, 8($29)
	sw	$2, 12($29)
	sw	$1, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	p_received_ray_20percent.2570
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 16($29)
	sw	$1, 20($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	p_nvectors.2577
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 16($29)
	sw	$1, 24($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	p_intersection_points.2562
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 16($29)
	sw	$1, 28($29)
	mov	$1, $2
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	p_energy.2568
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$2, 12($29)
	sll	$3, $2, 2
	lw	$4, 20($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	lw	$4, 8($29)
	sw	$1, 32($29)
	mov	$2, $3
	mov	$1, $4
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	veccpy.2482
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 16($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	p_group_id.2572
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$2, 12($29)
	sll	$3, $2, 2
	lw	$4, 24($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	sll	$4, $2, 2
	lw	$5, 28($29)
	add	$27, $4, $5
	lw	$4, 0($27)
	lw	$28, 4($29)
	mov	$2, $3
	mov	$3, $4
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	lw	$1, 12($29)
	sll	$1, $1, 2
	lw	$2, 32($29)
	add	$27, $1, $2
	lw	$2, 0($27)
	lw	$1, 0($29)
	lw	$3, 8($29)
	j	vecaccumv.2514
calc_diffuse_using_5points.2824:
	lw	$6, 8($28)
	lw	$7, 4($28)
	sll	$8, $1, 2
	add	$27, $8, $2
	lw	$2, 0($27)
	sw	$6, 0($29)
	sw	$7, 4($29)
	sw	$5, 8($29)
	sw	$4, 12($29)
	sw	$3, 16($29)
	sw	$1, 20($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	p_received_ray_20percent.2570
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 1
	lw	$3, 20($29)
	sub	$2, $3, $2
	sll	$2, $2, 2
	lw	$4, 16($29)
	add	$27, $2, $4
	lw	$2, 0($27)
	sw	$1, 24($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	p_received_ray_20percent.2570
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 20($29)
	sll	$3, $2, 2
	lw	$4, 16($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	sw	$1, 28($29)
	mov	$1, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	p_received_ray_20percent.2570
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$2, 20($29)
	addi	$3, $2, 1
	sll	$3, $3, 2
	lw	$4, 16($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	sw	$1, 32($29)
	mov	$1, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	p_received_ray_20percent.2570
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$2, 20($29)
	sll	$3, $2, 2
	lw	$4, 12($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	sw	$1, 36($29)
	mov	$1, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	p_received_ray_20percent.2570
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$2, 8($29)
	sll	$3, $2, 2
	lw	$4, 24($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	lw	$4, 4($29)
	sw	$1, 40($29)
	mov	$2, $3
	mov	$1, $4
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	veccpy.2482
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 8($29)
	sll	$2, $1, 2
	lw	$3, 28($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$3, 4($29)
	mov	$1, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	vecadd.2505
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 8($29)
	sll	$2, $1, 2
	lw	$3, 32($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$3, 4($29)
	mov	$1, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	vecadd.2505
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 8($29)
	sll	$2, $1, 2
	lw	$3, 36($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$3, 4($29)
	mov	$1, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	vecadd.2505
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 8($29)
	sll	$2, $1, 2
	lw	$3, 40($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$3, 4($29)
	mov	$1, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	vecadd.2505
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 20($29)
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	p_energy.2568
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$2, 8($29)
	sll	$2, $2, 2
	add	$27, $2, $1
	lw	$2, 0($27)
	lw	$1, 0($29)
	lw	$3, 4($29)
	j	vecaccumv.2514
do_without_neighbors.2830:
	lw	$3, 4($28)
	set	$4, 4
	slt	$27, $4, $2
	bne	$27, $0, ble_else.9004
	sw	$28, 0($29)
	sw	$3, 4($29)
	sw	$1, 8($29)
	sw	$2, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	p_surface_ids.2564
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	lw	$3, 12($29)
	sll	$4, $3, 2
	add	$27, $4, $1
	lw	$1, 0($27)
	slt	$27, $1, $2
	bne	$27, $0, ble_else.9005
	lw	$1, 8($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	p_calc_diffuse.2566
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 12($29)
	sll	$3, $2, 2
	add	$27, $3, $1
	lw	$1, 0($27)
	set	$3, 0
	bne	$1, $3, beq_else.9006
	j	beq_cont.9007
beq_else.9006:
	lw	$1, 8($29)
	lw	$28, 4($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -24
	lw	$31, 20($29)
beq_cont.9007:
	lw	$1, 12($29)
	addi	$2, $1, 1
	lw	$1, 8($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.9005:
jr $31
ble_else.9004:
jr $31
neighbors_exist.2833:
	lw	$3, 4($28)
	set	$4, 1
	sll	$4, $4, 2
	add	$27, $4, $3
	lw	$4, 0($27)
	addi	$5, $2, 1
	slt	$27, $5, $4
	bne	$27, $0, ble_else.9010
	set	$1, 0
	jr $31
ble_else.9010:
	set	$4, 0
	slt	$27, $4, $2
	bne	$27, $0, ble_else.9011
	set	$1, 0
	jr $31
ble_else.9011:
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $3
	lw	$2, 0($27)
	addi	$3, $1, 1
	slt	$27, $3, $2
	bne	$27, $0, ble_else.9012
	set	$1, 0
	jr $31
ble_else.9012:
	set	$2, 0
	slt	$27, $2, $1
	bne	$27, $0, ble_else.9013
	set	$1, 0
	jr $31
ble_else.9013:
	set	$1, 1
	jr $31
get_surface_id.2837:
	sw	$2, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	p_surface_ids.2564
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	lw	$2, 0($29)
	sll	$2, $2, 2
	add	$27, $2, $1
	lw	$1, 0($27)
	jr $31
neighbors_are_available.2840:
	sll	$6, $1, 2
	add	$27, $6, $3
	lw	$6, 0($27)
	sw	$3, 0($29)
	sw	$4, 4($29)
	sw	$5, 8($29)
	sw	$2, 12($29)
	sw	$1, 16($29)
	mov	$2, $5
	mov	$1, $6
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	get_surface_id.2837
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	lw	$2, 16($29)
	sll	$3, $2, 2
	lw	$4, 12($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	lw	$4, 8($29)
	sw	$1, 20($29)
	mov	$2, $4
	mov	$1, $3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	get_surface_id.2837
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 20($29)
	bne	$1, $2, beq_else.9014
	lw	$1, 16($29)
	sll	$3, $1, 2
	lw	$4, 4($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	lw	$4, 8($29)
	mov	$2, $4
	mov	$1, $3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	get_surface_id.2837
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 20($29)
	bne	$1, $2, beq_else.9015
	set	$1, 1
	lw	$3, 16($29)
	sub	$1, $3, $1
	sll	$1, $1, 2
	lw	$4, 0($29)
	add	$27, $1, $4
	lw	$1, 0($27)
	lw	$5, 8($29)
	mov	$2, $5
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	get_surface_id.2837
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 20($29)
	bne	$1, $2, beq_else.9016
	lw	$1, 16($29)
	addi	$1, $1, 1
	sll	$1, $1, 2
	lw	$3, 0($29)
	add	$27, $1, $3
	lw	$1, 0($27)
	lw	$3, 8($29)
	mov	$2, $3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	get_surface_id.2837
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 20($29)
	bne	$1, $2, beq_else.9017
	set	$1, 1
	jr $31
beq_else.9017:
	set	$1, 0
	jr $31
beq_else.9016:
	set	$1, 0
	jr $31
beq_else.9015:
	set	$1, 0
	jr $31
beq_else.9014:
	set	$1, 0
	jr $31
try_exploit_neighbors.2846:
	lw	$7, 8($28)
	lw	$8, 4($28)
	sll	$9, $1, 2
	add	$27, $9, $4
	lw	$9, 0($27)
	set	$10, 4
	slt	$27, $10, $6
	bne	$27, $0, ble_else.9018
	set	$10, 0
	sw	$2, 0($29)
	sw	$28, 4($29)
	sw	$8, 8($29)
	sw	$9, 12($29)
	sw	$7, 16($29)
	sw	$6, 20($29)
	sw	$5, 24($29)
	sw	$4, 28($29)
	sw	$3, 32($29)
	sw	$1, 36($29)
	sw	$10, 40($29)
	mov	$2, $6
	mov	$1, $9
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	get_surface_id.2837
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$2, 40($29)
	slt	$27, $1, $2
	bne	$27, $0, ble_else.9019
	lw	$1, 36($29)
	lw	$2, 32($29)
	lw	$3, 28($29)
	lw	$4, 24($29)
	lw	$5, 20($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	neighbors_are_available.2840
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.9020
	lw	$1, 36($29)
	sll	$1, $1, 2
	lw	$2, 28($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	lw	$2, 20($29)
	lw	$28, 16($29)
	lw	$27, 0($28)
	jr	$27
beq_else.9020:
	lw	$1, 12($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	p_calc_diffuse.2566
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$5, 20($29)
	sll	$2, $5, 2
	add	$27, $2, $1
	lw	$1, 0($27)
	set	$2, 0
	bne	$1, $2, beq_else.9021
	j	beq_cont.9022
beq_else.9021:
	lw	$1, 36($29)
	lw	$2, 32($29)
	lw	$3, 28($29)
	lw	$4, 24($29)
	lw	$28, 8($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
beq_cont.9022:
	lw	$1, 20($29)
	addi	$6, $1, 1
	lw	$1, 36($29)
	lw	$2, 0($29)
	lw	$3, 32($29)
	lw	$4, 28($29)
	lw	$5, 24($29)
	lw	$28, 4($29)
	lw	$27, 0($28)
	jr	$27
ble_else.9019:
jr $31
ble_else.9018:
jr $31
write_ppm_header.2853:
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
write_rgb_element.2855:
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_int_of_float
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 255
	slt	$27, $2, $1
	bne	$27, $0, ble_else.9025
	set	$2, 0
	slt	$27, $1, $2
	bne	$27, $0, ble_else.9027
	j	ble_cont.9028
ble_else.9027:
	set	$1, 0
ble_cont.9028:
	j	ble_cont.9026
ble_else.9025:
	set	$1, 255
ble_cont.9026:
	j	min_caml_print_int
write_rgb.2857:
	lw	$1, 4($28)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lwc	$f0, 0($27)
	sw	$1, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	write_rgb_element.2855
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
	jal	write_rgb_element.2855
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
	jal	write_rgb_element.2855
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$1, 10
	j	min_caml_print_char
pretrace_diffuse_rays.2859:
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$5, 4($28)
	set	$6, 4
	slt	$27, $6, $2
	bne	$27, $0, ble_else.9029
	sw	$28, 0($29)
	sw	$3, 4($29)
	sw	$4, 8($29)
	sw	$5, 12($29)
	sw	$2, 16($29)
	sw	$1, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	get_surface_id.2837
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	set	$2, 0
	slt	$27, $1, $2
	bne	$27, $0, ble_else.9030
	lw	$1, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	p_calc_diffuse.2566
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 16($29)
	sll	$3, $2, 2
	add	$27, $3, $1
	lw	$1, 0($27)
	set	$3, 0
	bne	$1, $3, beq_else.9031
	j	beq_cont.9032
beq_else.9031:
	lw	$1, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	p_group_id.2572
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 12($29)
	sw	$1, 24($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	vecbzero.2480
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$1, 20($29)
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	p_nvectors.2577
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lw	$2, 20($29)
	sw	$1, 28($29)
	mov	$1, $2
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	p_intersection_points.2562
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$2, 24($29)
	sll	$2, $2, 2
	lw	$3, 8($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$3, 16($29)
	sll	$4, $3, 2
	lw	$5, 28($29)
	add	$27, $4, $5
	lw	$4, 0($27)
	sll	$5, $3, 2
	add	$27, $5, $1
	lw	$1, 0($27)
	lw	$28, 4($29)
	mov	$3, $1
	mov	$1, $2
	mov	$2, $4
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	lw	$1, 20($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	p_received_ray_20percent.2570
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$2, 16($29)
	sll	$3, $2, 2
	add	$27, $3, $1
	lw	$1, 0($27)
	lw	$3, 12($29)
	mov	$2, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	veccpy.2482
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
beq_cont.9032:
	lw	$1, 16($29)
	addi	$2, $1, 1
	lw	$1, 20($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.9030:
jr $31
ble_else.9029:
jr $31
pretrace_pixels.2862:
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
	bne	$27, $0, ble_else.9035
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
	jal	vecunit_sgn.2490
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$1, 32($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	vecbzero.2480
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$1, 28($29)
	lw	$2, 24($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	veccpy.2482
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$1, 0
	setclv	$f0, l.5994
	lw	$2, 20($29)
	sll	$3, $2, 2
	lw	$4, 16($29)
	add	$27, $3, $4
	lw	$3, 0($27)
	setclv	$f1, l.5993
	lw	$5, 44($29)
	lw	$28, 12($29)
	mov	$2, $5
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	lw	$1, 20($29)
	sll	$2, $1, 2
	lw	$3, 16($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	mov	$1, $2
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	p_rgb.2560
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$2, 32($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	veccpy.2482
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$1, 20($29)
	sll	$2, $1, 2
	lw	$3, 16($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	lw	$4, 8($29)
	mov	$1, $2
	mov	$2, $4
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	p_set_group_id.2574
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lw	$1, 20($29)
	sll	$2, $1, 2
	lw	$3, 16($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	set	$4, 0
	lw	$28, 4($29)
	mov	$1, $2
	mov	$2, $4
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	set	$1, 1
	lw	$2, 20($29)
	sub	$1, $2, $1
	set	$2, 1
	lw	$3, 8($29)
	sw	$1, 60($29)
	mov	$1, $3
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	add_mod5.2469
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	mov	$3, $1
	lwc	$f0, 48($29)
	lwc	$f1, 40($29)
	lwc	$f2, 36($29)
	lw	$1, 16($29)
	lw	$2, 60($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.9035:
jr $31
pretrace_line.2869:
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
scan_pixel.2873:
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
	bne	$27, $0, ble_else.9037
jr $31
ble_else.9037:
	sll	$10, $1, 2
	add	$27, $10, $4
	lw	$10, 0($27)
	sw	$28, 0($29)
	sw	$6, 4($29)
	sw	$3, 8($29)
	sw	$7, 12($29)
	sw	$11, 16($29)
	sw	$4, 20($29)
	sw	$5, 24($29)
	sw	$2, 28($29)
	sw	$1, 32($29)
	sw	$9, 36($29)
	sw	$8, 40($29)
	mov	$1, $10
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	p_rgb.2560
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	mov	$2, $1
	lw	$1, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	veccpy.2482
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 32($29)
	lw	$2, 28($29)
	lw	$3, 24($29)
	lw	$28, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	set	$2, 0
	bne	$1, $2, beq_else.9039
	lw	$1, 32($29)
	sll	$2, $1, 2
	lw	$3, 20($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	set	$4, 0
	lw	$28, 16($29)
	mov	$1, $2
	mov	$2, $4
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	j	beq_cont.9040
beq_else.9039:
	set	$6, 0
	lw	$1, 32($29)
	lw	$2, 28($29)
	lw	$3, 8($29)
	lw	$4, 20($29)
	lw	$5, 24($29)
	lw	$28, 12($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
beq_cont.9040:
	lw	$28, 4($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	lw	$1, 32($29)
	addi	$1, $1, 1
	lw	$2, 28($29)
	lw	$3, 8($29)
	lw	$4, 20($29)
	lw	$5, 24($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
scan_line.2879:
	lw	$6, 12($28)
	lw	$7, 8($28)
	lw	$8, 4($28)
	set	$9, 1
	sll	$9, $9, 2
	add	$27, $9, $8
	lw	$9, 0($27)
	slt	$27, $1, $9
	bne	$27, $0, ble_else.9041
jr $31
ble_else.9041:
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
	bne	$27, $0, ble_else.9043
	j	ble_cont.9044
ble_else.9043:
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
ble_cont.9044:
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
	set	$2, 2
	lw	$3, 4($29)
	sw	$1, 28($29)
	mov	$1, $3
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	add_mod5.2469
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	mov	$5, $1
	lw	$1, 28($29)
	lw	$2, 12($29)
	lw	$3, 8($29)
	lw	$4, 16($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
create_float5x3array.2885:
	set	$1, 3
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
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
create_pixel.2887:
	set	$1, 3
	setclv	$f0, l.5993
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	sw	$1, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	create_float5x3array.2885
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
	jal	create_float5x3array.2885
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	sw	$1, 16($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	create_float5x3array.2885
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
	jal	create_float5x3array.2885
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
init_line_elements.2889:
	set	$3, 0
	slt	$27, $2, $3
	bne	$27, $0, ble_else.9045
	sw	$1, 0($29)
	sw	$2, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	create_pixel.2887
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
	j	init_line_elements.2889
ble_else.9045:
	jr $31
create_pixelline.2892:
	lw	$1, 4($28)
	set	$2, 0
	sll	$2, $2, 2
	add	$27, $2, $1
	lw	$2, 0($27)
	sw	$1, 0($29)
	sw	$2, 4($29)
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	create_pixel.2887
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
	j	init_line_elements.2889
tan.2894:
	swc	$f0, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_sin
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	lwc	$f1, 0($29)
	swc	$f0, 4($29)
	mov.s	$f0, $f1
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_cos
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lwc	$f1, 4($29)
	div.s	$f0, $f1, $f0
	jr $31
adjust_position.2896:
	mul.s	$f0, $f0, $f0
	setclv	$f2, l.6438
	add.s	$f0, $f0, $f2
	swc	$f1, 0($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_sqrt
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	setclv	$f1, l.5994
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
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	tan.2894
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lwc	$f1, 4($29)
	mul.s	$f0, $f0, $f1
	jr $31
calc_dirvec.2899:
	lw	$4, 4($28)
	set	$5, 5
	slt	$27, $1, $5
	bne	$27, $0, ble_else.9046
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
	setclv	$f1, l.5994
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
	setclv	$f3, l.5994
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
	sw	$1, 24($29)
	swc	$f0, 28($29)
	swc	$f2, 32($29)
	swc	$f1, 36($29)
	mov	$1, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	d_vec.2579
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f0, 36($29)
	lwc	$f1, 32($29)
	lwc	$f2, 28($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	vecset.2472
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 0($29)
	addi	$2, $1, 40
	sll	$2, $2, 2
	lw	$3, 24($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	mov	$1, $2
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	d_vec.2579
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f0, 32($29)
	sw	$1, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	min_caml_fneg
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	mov.s	$f2, $f0
	lwc	$f0, 36($29)
	lwc	$f1, 28($29)
	lw	$1, 40($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	vecset.2472
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lw	$1, 0($29)
	addi	$2, $1, 80
	sll	$2, $2, 2
	lw	$3, 24($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	mov	$1, $2
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	d_vec.2579
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f0, 36($29)
	sw	$1, 44($29)
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
	lwc	$f0, 28($29)
	lwc	$f1, 48($29)
	lw	$1, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	vecset.2472
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lw	$1, 0($29)
	addi	$2, $1, 1
	sll	$2, $2, 2
	lw	$3, 24($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	mov	$1, $2
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	d_vec.2579
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f0, 36($29)
	sw	$1, 52($29)
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
	lwc	$f1, 28($29)
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
	jal	vecset.2472
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lw	$1, 0($29)
	addi	$2, $1, 41
	sll	$2, $2, 2
	lw	$3, 24($29)
	add	$27, $2, $3
	lw	$2, 0($27)
	mov	$1, $2
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	d_vec.2579
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f0, 36($29)
	sw	$1, 64($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_fneg
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lwc	$f1, 28($29)
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
	jal	vecset.2472
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lw	$1, 0($29)
	addi	$1, $1, 81
	sll	$1, $1, 2
	lw	$2, 24($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	d_vec.2579
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f0, 28($29)
	sw	$1, 72($29)
	sw	$31, 76($29)
	addi	$29, $29, 80
	jal	min_caml_fneg
	nop
	addi	$29, $29, -80
	lw	 $31, 76($29)
	lwc	$f1, 36($29)
	lwc	$f2, 32($29)
	lw	$1, 72($29)
	j	vecset.2472
ble_else.9046:
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
	jal	adjust_position.2896
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
	jal	adjust_position.2896
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
calc_dirvecs.2907:
	lw	$4, 4($28)
	set	$5, 0
	slt	$27, $1, $5
	bne	$27, $0, ble_else.9047
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
	setclv	$f1, l.6550
	mul.s	$f0, $f0, $f1
	setclv	$f1, l.6551
	sub.s	$f2, $f0, $f1
	set	$1, 0
	setclv	$f0, l.5993
	setclv	$f1, l.5993
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
	setclv	$f1, l.6550
	mul.s	$f0, $f0, $f1
	setclv	$f1, l.6438
	add.s	$f2, $f0, $f1
	set	$1, 0
	setclv	$f0, l.5993
	setclv	$f1, l.5993
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
	set	$2, 1
	lw	$3, 16($29)
	sw	$1, 24($29)
	mov	$1, $3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	add_mod5.2469
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	mov	$2, $1
	lwc	$f0, 8($29)
	lw	$1, 24($29)
	lw	$3, 12($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.9047:
jr $31
calc_dirvec_rows.2912:
	lw	$4, 4($28)
	set	$5, 0
	slt	$27, $1, $5
	bne	$27, $0, ble_else.9049
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
	setclv	$f1, l.6550
	mul.s	$f0, $f0, $f1
	setclv	$f1, l.6551
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
	set	$2, 2
	lw	$3, 12($29)
	sw	$1, 20($29)
	mov	$1, $3
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	add_mod5.2469
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	mov	$2, $1
	lw	$1, 8($29)
	addi	$3, $1, 4
	lw	$1, 20($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
ble_else.9049:
jr $31
create_dirvec.2916:
	lw	$1, 4($28)
	set	$2, 3
	setclv	$f0, l.5993
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
create_dirvec_elements.2918:
	lw	$3, 4($28)
	set	$4, 0
	slt	$27, $2, $4
	bne	$27, $0, ble_else.9051
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
ble_else.9051:
jr $31
create_dirvecs.2921:
	lw	$2, 12($28)
	lw	$3, 8($28)
	lw	$4, 4($28)
	set	$5, 0
	slt	$27, $1, $5
	bne	$27, $0, ble_else.9053
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
ble_else.9053:
jr $31
init_dirvec_constants.2923:
	lw	$3, 4($28)
	set	$4, 0
	slt	$27, $2, $4
	bne	$27, $0, ble_else.9055
	sll	$4, $2, 2
	add	$27, $4, $1
	lw	$4, 0($27)
	sw	$1, 0($29)
	sw	$28, 4($29)
	sw	$2, 8($29)
	mov	$1, $4
	mov	$28, $3
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
ble_else.9055:
jr $31
init_vecset_constants.2926:
	lw	$2, 8($28)
	lw	$3, 4($28)
	set	$4, 0
	slt	$27, $1, $4
	bne	$27, $0, ble_else.9057
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
ble_else.9057:
jr $31
init_dirvecs.2928:
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
add_reflection.2930:
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$28, 4($28)
	sw	$4, 0($29)
	sw	$1, 4($29)
	sw	$2, 8($29)
	swc	$f0, 12($29)
	sw	$3, 16($29)
	swc	$f3, 20($29)
	swc	$f2, 24($29)
	swc	$f1, 28($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	sw	$1, 32($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	d_vec.2579
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lwc	$f0, 28($29)
	lwc	$f1, 24($29)
	lwc	$f2, 20($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	vecset.2472
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	lw	$1, 32($29)
	lw	$28, 16($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -40
	lw	$31, 36($29)
	mov	$1, $30
	addi	$30, $30, 16
	lwc	$f0, 12($29)
	swc	$f0, 8($1)
	lw	$2, 32($29)
	sw	$2, 4($1)
	lw	$2, 8($29)
	sw	$2, 0($1)
	lw	$2, 4($29)
	sll	$2, $2, 2
	lw	$3, 0($29)
	add	$27, $2, $3
	sw	$1, 0($27)
jr $31
setup_rect_reflection.2937:
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$5, 4($28)
	sll	$1, $1, 2
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $3
	lw	$6, 0($27)
	setclv	$f0, l.5994
	sw	$3, 0($29)
	sw	$6, 4($29)
	sw	$5, 8($29)
	sw	$1, 12($29)
	sw	$4, 16($29)
	swc	$f0, 20($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_diffuse.2542
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 20($29)
	sub.s	$f0, $f1, $f0
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 16($29)
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
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 16($29)
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
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	swc	$f0, 32($29)
	mov.s	$f0, $f1
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	min_caml_fneg
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	mov.s	$f3, $f0
	lw	$1, 12($29)
	addi	$2, $1, 1
	set	$3, 0
	sll	$3, $3, 2
	lw	$4, 16($29)
	add	$27, $3, $4
	lwc	$f1, 0($27)
	lwc	$f0, 24($29)
	lwc	$f2, 32($29)
	lw	$3, 4($29)
	lw	$28, 8($29)
	swc	$f3, 36($29)
	mov	$1, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	lw	$1, 4($29)
	addi	$2, $1, 1
	lw	$3, 12($29)
	addi	$4, $3, 2
	set	$5, 1
	sll	$5, $5, 2
	lw	$6, 16($29)
	add	$27, $5, $6
	lwc	$f2, 0($27)
	lwc	$f0, 24($29)
	lwc	$f1, 28($29)
	lwc	$f3, 36($29)
	lw	$28, 8($29)
	mov	$1, $2
	mov	$2, $4
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	lw	$1, 4($29)
	addi	$2, $1, 2
	lw	$3, 12($29)
	addi	$3, $3, 3
	set	$4, 2
	sll	$4, $4, 2
	lw	$5, 16($29)
	add	$27, $4, $5
	lwc	$f3, 0($27)
	lwc	$f0, 24($29)
	lwc	$f1, 28($29)
	lwc	$f2, 32($29)
	lw	$28, 8($29)
	mov	$1, $2
	mov	$2, $3
	sw	$31, 44($29)
	addi	$29, $29, 48
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -48
	lw	$31, 44($29)
	set	$1, 0
	lw	$2, 4($29)
	addi	$2, $2, 3
	sll	$1, $1, 2
	lw	$3, 0($29)
	add	$27, $1, $3
	sw	$2, 0($27)
jr $31
setup_surface_reflection.2940:
	lw	$3, 12($28)
	lw	$4, 8($28)
	lw	$5, 4($28)
	sll	$1, $1, 2
	addi	$1, $1, 1
	set	$6, 0
	sll	$6, $6, 2
	add	$27, $6, $3
	lw	$6, 0($27)
	setclv	$f0, l.5994
	sw	$3, 0($29)
	sw	$1, 4($29)
	sw	$6, 8($29)
	sw	$5, 12($29)
	sw	$4, 16($29)
	sw	$2, 20($29)
	swc	$f0, 24($29)
	mov	$1, $2
	sw	$31, 28($29)
	addi	$29, $29, 32
	jal	o_diffuse.2542
	nop
	addi	$29, $29, -32
	lw	 $31, 28($29)
	lwc	$f1, 24($29)
	sub.s	$f0, $f1, $f0
	lw	$1, 20($29)
	swc	$f0, 28($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	o_param_abc.2534
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	mov	$2, $1
	lw	$1, 16($29)
	sw	$31, 36($29)
	addi	$29, $29, 40
	jal	veciprod.2493
	nop
	addi	$29, $29, -40
	lw	 $31, 36($29)
	setclv	$f1, l.6118
	lw	$1, 20($29)
	swc	$f0, 32($29)
	swc	$f1, 36($29)
	sw	$31, 44($29)
	addi	$29, $29, 48
	jal	o_param_a.2528
	nop
	addi	$29, $29, -48
	lw	 $31, 44($29)
	lwc	$f1, 36($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 32($29)
	mul.s	$f0, $f0, $f1
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	lwc	$f2, 0($27)
	sub.s	$f0, $f0, $f2
	setclv	$f2, l.6118
	lw	$1, 20($29)
	swc	$f0, 40($29)
	swc	$f2, 44($29)
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	o_param_b.2530
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	lwc	$f1, 44($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 32($29)
	mul.s	$f0, $f0, $f1
	set	$1, 1
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	lwc	$f2, 0($27)
	sub.s	$f0, $f0, $f2
	setclv	$f2, l.6118
	lw	$1, 20($29)
	swc	$f0, 48($29)
	swc	$f2, 52($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	o_param_c.2532
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 52($29)
	mul.s	$f0, $f1, $f0
	lwc	$f1, 32($29)
	mul.s	$f0, $f0, $f1
	set	$1, 2
	sll	$1, $1, 2
	lw	$2, 16($29)
	add	$27, $1, $2
	lwc	$f1, 0($27)
	sub.s	$f3, $f0, $f1
	lwc	$f0, 28($29)
	lwc	$f1, 40($29)
	lwc	$f2, 48($29)
	lw	$1, 8($29)
	lw	$2, 4($29)
	lw	$28, 12($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	set	$1, 0
	lw	$2, 8($29)
	addi	$2, $2, 1
	sll	$1, $1, 2
	lw	$3, 0($29)
	add	$27, $1, $3
	sw	$2, 0($27)
jr $31
setup_reflections.2943:
	lw	$2, 12($28)
	lw	$3, 8($28)
	lw	$4, 4($28)
	set	$5, 0
	slt	$27, $1, $5
	bne	$27, $0, ble_else.9062
	sll	$5, $1, 2
	add	$27, $5, $4
	lw	$4, 0($27)
	sw	$2, 0($29)
	sw	$1, 4($29)
	sw	$3, 8($29)
	sw	$4, 12($29)
	mov	$1, $4
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_reflectiontype.2522
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 2
	bne	$1, $2, beq_else.9063
	lw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_diffuse.2542
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	setclv	$f1, l.5994
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_fless
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 0
	bne	$1, $2, beq_else.9064
jr $31
beq_else.9064:
	lw	$1, 12($29)
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	o_form.2520
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 1
	bne	$1, $2, beq_else.9066
	lw	$1, 4($29)
	lw	$2, 12($29)
	lw	$28, 8($29)
	lw	$27, 0($28)
	jr	$27
beq_else.9066:
	set	$2, 2
	bne	$1, $2, beq_else.9067
	lw	$1, 4($29)
	lw	$2, 12($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
beq_else.9067:
jr $31
beq_else.9063:
jr $31
ble_else.9062:
jr $31
rt.2945:
	lw	$3, 56($28)
	lw	$4, 52($28)
	lw	$5, 48($28)
	lw	$6, 44($28)
	lw	$7, 40($28)
	lw	$8, 36($28)
	lw	$9, 32($28)
	lw	$10, 28($28)
	lw	$11, 24($28)
	lw	$12, 20($28)
	lw	$13, 16($28)
	lw	$14, 12($28)
	lw	$15, 8($28)
	lw	$16, 4($28)
	set	$17, 0
	sll	$17, $17, 2
	add	$27, $17, $14
	sw	$1, 0($27)
	set	$17, 1
	sll	$17, $17, 2
	add	$27, $17, $14
	sw	$2, 0($27)
	set	$14, 0
	set	$17, 2
	sra	$17, $1, 1
	sll	$14, $14, 2
	add	$27, $14, $15
	sw	$17, 0($27)
	set	$14, 1
	set	$17, 2
	sra	$2, $2, 1
	sll	$14, $14, 2
	add	$27, $14, $15
	sw	$2, 0($27)
	set	$2, 0
	setclv	$f0, l.6584
	sw	$7, 0($29)
	sw	$9, 4($29)
	sw	$4, 8($29)
	sw	$10, 12($29)
	sw	$5, 16($29)
	sw	$12, 20($29)
	sw	$11, 24($29)
	sw	$13, 28($29)
	sw	$3, 32($29)
	sw	$8, 36($29)
	sw	$16, 40($29)
	sw	$6, 44($29)
	sw	$2, 48($29)
	swc	$f0, 52($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_float_of_int
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	lwc	$f1, 52($29)
	div.s	$f0, $f1, $f0
	lw	$1, 48($29)
	sll	$1, $1, 2
	lw	$2, 44($29)
	add	$27, $1, $2
	swc	$f0, 0($27)
	lw	$28, 40($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	lw	$28, 40($29)
	sw	$1, 56($29)
	sw	$31, 60($29)
	addi	$29, $29, 64
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -64
	lw	$31, 60($29)
	lw	$28, 40($29)
	sw	$1, 60($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	lw	$28, 36($29)
	sw	$1, 64($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	lw	$28, 32($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	lw	$28, 28($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	lw	$1, 24($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	d_vec.2579
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lw	$2, 20($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	veccpy.2482
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	lw	$1, 24($29)
	lw	$28, 16($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	set	$1, 0
	sll	$1, $1, 2
	lw	$2, 12($29)
	add	$27, $1, $2
	lw	$1, 0($27)
	set	$2, 1
	sub	$1, $1, $2
	lw	$28, 8($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	set	$2, 0
	set	$3, 0
	lw	$1, 60($29)
	lw	$28, 4($29)
	sw	$31, 68($29)
	addi	$29, $29, 72
	lw	$27, 0($28)
	jal	closure_indirect
	nop
	addi	$29, $29, -72
	lw	$31, 68($29)
	set	$1, 0
	set	$5, 2
	lw	$2, 56($29)
	lw	$3, 60($29)
	lw	$4, 64($29)
	lw	$28, 0($29)
	lw	$27, 0($28)
	jr	$27
min_caml_start:
	set	$1, 1
	set	$2, 0
	sw	$31, 4($29)
	addi	$29, $29, 8

	ori	$5, $0, 0xAA
	sw	$5, -1($0)
	
	jal	min_caml_create_array
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	set	$2, 0
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
	sw	$1, 4($29)
	mov	$1, $2
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 3
	setclv	$f0, l.5993
	sw	$1, 8($29)
	mov	$1, $2
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -16
	lw	 $31, 12($29)
	set	$2, 3
	setclv	$f0, l.5993
	sw	$1, 12($29)
	mov	$1, $2
	sw	$31, 20($29)
	addi	$29, $29, 24
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -24
	lw	 $31, 20($29)
	set	$2, 1
	setclv	$f0, l.6397
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
	setclv	$f0, l.5993
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
	setclv	$f0, l.6343
	sw	$1, 44($29)
	mov	$1, $2
	sw	$31, 52($29)
	addi	$29, $29, 56
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -56
	lw	 $31, 52($29)
	set	$2, 3
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
	sw	$1, 56($29)
	mov	$1, $2
	sw	$31, 60($29)
	addi	$29, $29, 64
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -64
	lw	 $31, 60($29)
	set	$2, 3
	setclv	$f0, l.5993
	sw	$1, 60($29)
	mov	$1, $2
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	set	$2, 3
	setclv	$f0, l.5993
	sw	$1, 64($29)
	mov	$1, $2
	sw	$31, 68($29)
	addi	$29, $29, 72
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -72
	lw	 $31, 68($29)
	set	$2, 3
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
	sw	$1, 80($29)
	mov	$1, $2
	sw	$31, 84($29)
	addi	$29, $29, 88
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -88
	lw	 $31, 84($29)
	set	$2, 3
	setclv	$f0, l.5993
	sw	$1, 84($29)
	mov	$1, $2
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	set	$2, 3
	setclv	$f0, l.5993
	sw	$1, 88($29)
	mov	$1, $2
	sw	$31, 92($29)
	addi	$29, $29, 96
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -96
	lw	 $31, 92($29)
	set	$2, 3
	setclv	$f0, l.5993
	sw	$1, 92($29)
	mov	$1, $2
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	set	$2, 3
	setclv	$f0, l.5993
	sw	$1, 96($29)
	mov	$1, $2
	sw	$31, 100($29)
	addi	$29, $29, 104
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -104
	lw	 $31, 100($29)
	set	$2, 3
	setclv	$f0, l.5993
	sw	$1, 100($29)
	mov	$1, $2
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	set	$2, 3
	setclv	$f0, l.5993
	sw	$1, 104($29)
	mov	$1, $2
	sw	$31, 108($29)
	addi	$29, $29, 112
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -112
	lw	 $31, 108($29)
	set	$2, 0
	setclv	$f0, l.5993
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
	setclv	$f0, l.5993
	sw	$1, 116($29)
	mov	$1, $2
	sw	$31, 124($29)
	addi	$29, $29, 128
	jal	min_caml_create_float_array
	nop
	addi	$29, $29, -128
	lw	 $31, 124($29)
	set	$2, 3
	setclv	$f0, l.5993
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
	mov	$1, $2
	set	$2, 0
	setclv	$f0, l.5993
	sw	$1, 128($29)
	mov	$1, $2
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
	setclv	$f0, l.5993
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
	setl	$3, read_screen_settings.2591
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
	setl	$8, read_light.2593
	sw	$8, 0($7)
	lw	$8, 16($29)
	sw	$8, 8($7)
	lw	$9, 20($29)
	sw	$9, 4($7)
	mov	$10, $30
	addi	$30, $30, 8
	setl	$11, read_nth_object.2598
	sw	$11, 0($10)
	lw	$11, 4($29)
	sw	$11, 4($10)
	mov	$12, $30
	addi	$30, $30, 16
	setl	$13, read_object.2600
	sw	$13, 0($12)
	sw	$10, 8($12)
	lw	$10, 0($29)
	sw	$10, 4($12)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$14, read_all_object.2602
	sw	$14, 0($13)
	sw	$12, 4($13)
	mov	$12, $30
	addi	$30, $30, 8
	setl	$14, read_and_network.2608
	sw	$14, 0($12)
	lw	$14, 28($29)
	sw	$14, 4($12)
	mov	$15, $30
	addi	$30, $30, 24
	setl	$16, read_parameter.2610
	sw	$16, 0($15)
	sw	$2, 20($15)
	sw	$7, 16($15)
	sw	$12, 12($15)
	sw	$13, 8($15)
	lw	$2, 36($29)
	sw	$2, 4($15)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$12, solver_rect_surface.2612
	sw	$12, 0($7)
	lw	$12, 40($29)
	sw	$12, 4($7)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$16, solver_rect.2621
	sw	$16, 0($13)
	sw	$7, 4($13)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$16, solver_surface.2627
	sw	$16, 0($7)
	sw	$12, 4($7)
	mov	$16, $30
	addi	$30, $30, 8
	setl	$17, solver_second.2646
	sw	$17, 0($16)
	sw	$12, 4($16)
	mov	$17, $30
	addi	$30, $30, 24
	setl	$18, solver.2652
	sw	$18, 0($17)
	sw	$7, 16($17)
	sw	$16, 12($17)
	sw	$13, 8($17)
	sw	$11, 4($17)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$13, solver_rect_fast.2656
	sw	$13, 0($7)
	sw	$12, 4($7)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$16, solver_surface_fast.2663
	sw	$16, 0($13)
	sw	$12, 4($13)
	mov	$16, $30
	addi	$30, $30, 8
	setl	$18, solver_second_fast.2669
	sw	$18, 0($16)
	sw	$12, 4($16)
	mov	$18, $30
	addi	$30, $30, 24
	setl	$19, solver_fast.2675
	sw	$19, 0($18)
	sw	$13, 16($18)
	sw	$16, 12($18)
	sw	$7, 8($18)
	sw	$11, 4($18)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$16, solver_surface_fast2.2679
	sw	$16, 0($13)
	sw	$12, 4($13)
	mov	$16, $30
	addi	$30, $30, 8
	setl	$19, solver_second_fast2.2686
	sw	$19, 0($16)
	sw	$12, 4($16)
	mov	$19, $30
	addi	$30, $30, 24
	setl	$20, solver_fast2.2693
	sw	$20, 0($19)
	sw	$13, 16($19)
	sw	$16, 12($19)
	sw	$7, 8($19)
	sw	$11, 4($19)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$13, iter_setup_dirvec_constants.2705
	sw	$13, 0($7)
	sw	$11, 4($7)
	mov	$13, $30
	addi	$30, $30, 16
	setl	$16, setup_dirvec_constants.2708
	sw	$16, 0($13)
	sw	$10, 8($13)
	sw	$7, 4($13)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$16, setup_startp_constants.2710
	sw	$16, 0($7)
	sw	$11, 4($7)
	mov	$16, $30
	addi	$30, $30, 16
	setl	$20, setup_startp.2713
	sw	$20, 0($16)
	lw	$20, 92($29)
	sw	$20, 12($16)
	sw	$7, 8($16)
	sw	$10, 4($16)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$21, check_all_inside.2735
	sw	$21, 0($7)
	sw	$11, 4($7)
	mov	$21, $30
	addi	$30, $30, 32
	setl	$22, shadow_check_and_group.2741
	sw	$22, 0($21)
	sw	$18, 28($21)
	sw	$12, 24($21)
	sw	$11, 20($21)
	lw	$22, 128($29)
	sw	$22, 16($21)
	sw	$8, 12($21)
	lw	$23, 52($29)
	sw	$23, 8($21)
	sw	$7, 4($21)
	mov	$24, $30
	addi	$30, $30, 16
	setl	$25, shadow_check_one_or_group.2744
	sw	$25, 0($24)
	sw	$21, 8($24)
	sw	$14, 4($24)
	mov	$21, $30
	addi	$30, $30, 24
	setl	$25, shadow_check_one_or_matrix.2747
	sw	$25, 0($21)
	sw	$18, 20($21)
	sw	$12, 16($21)
	sw	$24, 12($21)
	sw	$22, 8($21)
	sw	$23, 4($21)
	mov	$18, $30
	addi	$30, $30, 40
	setl	$24, solve_each_element.2750
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
	sw	$7, 4($18)
	mov	$28, $30
	addi	$30, $30, 16
	setl	$22, solve_one_or_network.2754
	sw	$22, 0($28)
	sw	$18, 8($28)
	sw	$14, 4($28)
	mov	$18, $30
	addi	$30, $30, 24
	setl	$22, trace_or_matrix.2758
	sw	$22, 0($18)
	sw	$24, 20($18)
	sw	$25, 16($18)
	sw	$12, 12($18)
	sw	$17, 8($18)
	sw	$28, 4($18)
	mov	$17, $30
	addi	$30, $30, 16
	setl	$22, judge_intersection.2762
	sw	$22, 0($17)
	sw	$18, 12($17)
	sw	$24, 8($17)
	sw	$2, 4($17)
	mov	$18, $30
	addi	$30, $30, 40
	setl	$22, solve_each_element_fast.2764
	sw	$22, 0($18)
	sw	$24, 36($18)
	sw	$20, 32($18)
	sw	$19, 28($18)
	sw	$12, 24($18)
	sw	$11, 20($18)
	sw	$26, 16($18)
	sw	$23, 12($18)
	sw	$27, 8($18)
	sw	$7, 4($18)
	mov	$7, $30
	addi	$30, $30, 16
	setl	$20, solve_one_or_network_fast.2768
	sw	$20, 0($7)
	sw	$18, 8($7)
	sw	$14, 4($7)
	mov	$14, $30
	addi	$30, $30, 24
	setl	$18, trace_or_matrix_fast.2772
	sw	$18, 0($14)
	sw	$24, 16($14)
	sw	$19, 12($14)
	sw	$12, 8($14)
	sw	$7, 4($14)
	mov	$7, $30
	addi	$30, $30, 16
	setl	$12, judge_intersection_fast.2776
	sw	$12, 0($7)
	sw	$14, 12($7)
	sw	$24, 8($7)
	sw	$2, 4($7)
	mov	$12, $30
	addi	$30, $30, 16
	setl	$14, get_nvector_rect.2778
	sw	$14, 0($12)
	lw	$14, 60($29)
	sw	$14, 8($12)
	sw	$26, 4($12)
	mov	$18, $30
	addi	$30, $30, 8
	setl	$19, get_nvector_plane.2780
	sw	$19, 0($18)
	sw	$14, 4($18)
	mov	$19, $30
	addi	$30, $30, 16
	setl	$20, get_nvector_second.2782
	sw	$20, 0($19)
	sw	$14, 8($19)
	sw	$23, 4($19)
	mov	$20, $30
	addi	$30, $30, 16
	setl	$22, get_nvector.2784
	sw	$22, 0($20)
	sw	$19, 12($20)
	sw	$12, 8($20)
	sw	$18, 4($20)
	mov	$12, $30
	addi	$30, $30, 8
	setl	$18, utexture.2787
	sw	$18, 0($12)
	lw	$18, 64($29)
	sw	$18, 4($12)
	mov	$19, $30
	addi	$30, $30, 16
	setl	$22, add_light.2790
	sw	$22, 0($19)
	sw	$18, 8($19)
	lw	$22, 72($29)
	sw	$22, 4($19)
	mov	$28, $30
	addi	$30, $30, 40
	sw	$15, 140($29)
	setl	$15, trace_reflections.2794
	sw	$15, 0($28)
	sw	$21, 32($28)
	lw	$15, 136($29)
	sw	$15, 28($28)
	sw	$2, 24($28)
	sw	$14, 20($28)
	sw	$7, 16($28)
	sw	$26, 12($28)
	sw	$27, 8($28)
	sw	$19, 4($28)
	mov	$15, $30
	addi	$30, $30, 88
	sw	$13, 144($29)
	setl	$13, trace_ray.2799
	sw	$13, 0($15)
	sw	$12, 80($15)
	sw	$28, 76($15)
	sw	$24, 72($15)
	sw	$18, 68($15)
	sw	$25, 64($15)
	sw	$21, 60($15)
	sw	$16, 56($15)
	sw	$22, 52($15)
	sw	$2, 48($15)
	sw	$11, 44($15)
	sw	$14, 40($15)
	sw	$1, 36($15)
	sw	$8, 32($15)
	sw	$17, 28($15)
	sw	$26, 24($15)
	sw	$23, 20($15)
	sw	$27, 16($15)
	sw	$20, 12($15)
	sw	$9, 8($15)
	sw	$19, 4($15)
	mov	$9, $30
	addi	$30, $30, 56
	setl	$13, trace_diffuse_ray.2805
	sw	$13, 0($9)
	sw	$12, 48($9)
	sw	$18, 44($9)
	sw	$21, 40($9)
	sw	$2, 36($9)
	sw	$11, 32($9)
	sw	$14, 28($9)
	sw	$8, 24($9)
	sw	$7, 20($9)
	sw	$23, 16($9)
	sw	$27, 12($9)
	sw	$20, 8($9)
	lw	$2, 68($29)
	sw	$2, 4($9)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$12, iter_trace_diffuse_rays.2808
	sw	$12, 0($7)
	sw	$9, 4($7)
	mov	$9, $30
	addi	$30, $30, 16
	setl	$12, trace_diffuse_rays.2813
	sw	$12, 0($9)
	sw	$16, 8($9)
	sw	$7, 4($9)
	mov	$7, $30
	addi	$30, $30, 16
	setl	$12, trace_diffuse_ray_80percent.2817
	sw	$12, 0($7)
	sw	$9, 8($7)
	lw	$12, 116($29)
	sw	$12, 4($7)
	mov	$13, $30
	addi	$30, $30, 16
	setl	$14, calc_diffuse_using_1point.2821
	sw	$14, 0($13)
	sw	$7, 12($13)
	sw	$22, 8($13)
	sw	$2, 4($13)
	mov	$7, $30
	addi	$30, $30, 16
	setl	$14, calc_diffuse_using_5points.2824
	sw	$14, 0($7)
	sw	$22, 8($7)
	sw	$2, 4($7)
	mov	$14, $30
	addi	$30, $30, 8
	setl	$16, do_without_neighbors.2830
	sw	$16, 0($14)
	sw	$13, 4($14)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$16, neighbors_exist.2833
	sw	$16, 0($13)
	lw	$16, 76($29)
	sw	$16, 4($13)
	mov	$17, $30
	addi	$30, $30, 16
	setl	$18, try_exploit_neighbors.2846
	sw	$18, 0($17)
	sw	$14, 8($17)
	sw	$7, 4($17)
	mov	$7, $30
	addi	$30, $30, 8
	setl	$18, write_ppm_header.2853
	sw	$18, 0($7)
	sw	$16, 4($7)
	mov	$18, $30
	addi	$30, $30, 8
	setl	$19, write_rgb.2857
	sw	$19, 0($18)
	sw	$22, 4($18)
	mov	$19, $30
	addi	$30, $30, 16
	setl	$20, pretrace_diffuse_rays.2859
	sw	$20, 0($19)
	sw	$9, 12($19)
	sw	$12, 8($19)
	sw	$2, 4($19)
	mov	$2, $30
	addi	$30, $30, 40
	setl	$9, pretrace_pixels.2862
	sw	$9, 0($2)
	sw	$3, 36($2)
	sw	$15, 32($2)
	sw	$25, 28($2)
	sw	$6, 24($2)
	lw	$3, 84($29)
	sw	$3, 20($2)
	sw	$22, 16($2)
	lw	$6, 108($29)
	sw	$6, 12($2)
	sw	$19, 8($2)
	lw	$6, 80($29)
	sw	$6, 4($2)
	mov	$9, $30
	addi	$30, $30, 32
	setl	$15, pretrace_line.2869
	sw	$15, 0($9)
	sw	$4, 24($9)
	sw	$5, 20($9)
	sw	$3, 16($9)
	sw	$2, 12($9)
	sw	$16, 8($9)
	sw	$6, 4($9)
	mov	$2, $30
	addi	$30, $30, 32
	setl	$4, scan_pixel.2873
	sw	$4, 0($2)
	sw	$18, 24($2)
	sw	$17, 20($2)
	sw	$22, 16($2)
	sw	$13, 12($2)
	sw	$16, 8($2)
	sw	$14, 4($2)
	mov	$4, $30
	addi	$30, $30, 16
	setl	$5, scan_line.2879
	sw	$5, 0($4)
	sw	$2, 12($4)
	sw	$9, 8($4)
	sw	$16, 4($4)
	mov	$2, $30
	addi	$30, $30, 8
	setl	$5, create_pixelline.2892
	sw	$5, 0($2)
	sw	$16, 4($2)
	mov	$5, $30
	addi	$30, $30, 8
	setl	$13, calc_dirvec.2899
	sw	$13, 0($5)
	sw	$12, 4($5)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$14, calc_dirvecs.2907
	sw	$14, 0($13)
	sw	$5, 4($13)
	mov	$5, $30
	addi	$30, $30, 8
	setl	$14, calc_dirvec_rows.2912
	sw	$14, 0($5)
	sw	$13, 4($5)
	mov	$13, $30
	addi	$30, $30, 8
	setl	$14, create_dirvec.2916
	sw	$14, 0($13)
	sw	$10, 4($13)
	mov	$14, $30
	addi	$30, $30, 8
	setl	$15, create_dirvec_elements.2918
	sw	$15, 0($14)
	sw	$13, 4($14)
	mov	$15, $30
	addi	$30, $30, 16
	setl	$17, create_dirvecs.2921
	sw	$17, 0($15)
	sw	$12, 12($15)
	sw	$14, 8($15)
	sw	$13, 4($15)
	mov	$14, $30
	addi	$30, $30, 8
	setl	$17, init_dirvec_constants.2923
	sw	$17, 0($14)
	lw	$17, 144($29)
	sw	$17, 4($14)
	mov	$18, $30
	addi	$30, $30, 16
	setl	$19, init_vecset_constants.2926
	sw	$19, 0($18)
	sw	$14, 8($18)
	sw	$12, 4($18)
	mov	$12, $30
	addi	$30, $30, 16
	setl	$14, init_dirvecs.2928
	sw	$14, 0($12)
	sw	$18, 12($12)
	sw	$15, 8($12)
	sw	$5, 4($12)
	mov	$5, $30
	addi	$30, $30, 16
	setl	$14, add_reflection.2930
	sw	$14, 0($5)
	sw	$17, 12($5)
	lw	$14, 136($29)
	sw	$14, 8($5)
	sw	$13, 4($5)
	mov	$13, $30
	addi	$30, $30, 16
	setl	$14, setup_rect_reflection.2937
	sw	$14, 0($13)
	sw	$1, 12($13)
	sw	$8, 8($13)
	sw	$5, 4($13)
	mov	$14, $30
	addi	$30, $30, 16
	setl	$15, setup_surface_reflection.2940
	sw	$15, 0($14)
	sw	$1, 12($14)
	sw	$8, 8($14)
	sw	$5, 4($14)
	mov	$1, $30
	addi	$30, $30, 16
	setl	$5, setup_reflections.2943
	sw	$5, 0($1)
	sw	$14, 12($1)
	sw	$13, 8($1)
	sw	$11, 4($1)
	mov	$28, $30
	addi	$30, $30, 64
	setl	$5, rt.2945
	sw	$5, 0($28)
	sw	$7, 56($28)
	sw	$1, 52($28)
	sw	$17, 48($28)
	sw	$3, 44($28)
	sw	$4, 40($28)
	lw	$1, 140($29)
	sw	$1, 36($28)
	sw	$9, 32($28)
	sw	$10, 28($28)
	lw	$1, 128($29)
	sw	$1, 24($28)
	sw	$8, 20($28)
	sw	$12, 16($28)
	sw	$16, 12($28)
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



min_caml_print_char:
	sw	$1, -1($0)
	jr	$31

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
	lwc	$f0, -1($0)
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

