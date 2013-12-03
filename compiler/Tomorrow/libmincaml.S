min_caml_print_int:
#	sw	$1, -1($0)
#	jr	$31
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




min_caml_print_byte:
min_caml_print_char:
	sw	$1, -1($0)
	jr	$31

min_caml_read_int:
	lw	$1, -1($0)
	jr	$31

min_caml_read_float:
	lwc	$f0, -1($0)
	jr	$31

min_caml_print_newline:
	lli	$1, 0xa
	sw	$1,-1($0)

min_caml_abs_float:
	abs.s	$f0, $f0
	jr	$31

min_caml_fabs:
	abs.s	$f0, $f0
	jr	$31

min_caml_fsqr:
	mul.s	$f1, $f1, $f1
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

min_caml_truncate:
	trunc.w.s	 $f0, $f0
	mfc	$1, $f0
	jr	$31

min_caml_floor:
	floor.w.s	$f0, $f0
	cvt.s.w	$f0, $f0
	jr	$31

min_caml_sin:
	set	$1, 0x40490fdb #PI
    mtc	$1, $f2
    set $1, 0x40000000 #2.0
	mtc	$1, $f3
	set	$1, 0x40800000 #4.0 
	mtc	$1, $f4
	set	$1, 0xbe2aaaac #0.16666668
	mtc	$1, $f5
	set	$1, 0x3c088666 #0.008332824
	mtc	$1, $f6
	set	$1, 0xb94d64b6 #0.00019587841
	mtc	$1, $f7
	set	$1, 0x3f000000 #0.5
	mtc	$1, $f8
	set $1, 0x3d2aa789 #0.04166368
	mtc	$1, $f9
	set	$1, 0xbab38106 #0.0013695068
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
	c.olt.s	$f0, $f14
	bct ll.4
	sub.s $f0, $f0, $f14
ll.4:
	div.s $f14, $f14, $f3
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
	
	#kernel sin store result in $f15, exponent in $f16, term in $f17 
	mov.s	$f15, $f0 #first term
	mov.s $f16, $f0

	mul.s $f16, $f0, $f16 #second term (degree three)
	mul.s $f16, $f0, $f16
    mfc $1, $f16
    sw	$1, -1($0)
	mul.s $f17, $f5, $f16
	add.s $f15, $f15, $f17

	mul.s $f16, $f0, $f16  #third term (degree five) 
	mul.s $f16, $f0, $f16
	mul.s $f17, $f6, $f16
	add.s $f15, $f15, $f17

	mul.s $f16, $f0, $f16 #forth term (degree seven) 
	mul.s $f16, $f0, $f16
	mul.s $f17, $f6, $f16
	add.s $f15, $f15, $f17

	mov.s $f0, $f15
	#end kernel sin

	j	ll.9	
ll.8:
	sub.s	$f0, $f13, $f0
	#kernel cos store result in $f15, exponent in $f16, term in $f17
	set	$3, 0x3f800000
	mtc $3, $f16 #1.0
	mov.s $f15, $f16 #first term (degree zero)
	mov.s $f16, $f16


	mul.s $f16, $f0, $f16 #second term (degree two)
	mul.s $f16, $f0, $f16
	mul.s $f17, $f7, $f16
	add.s $f15, $f15, $f17

	mul.s $f16, $f0, $f16 #third term (degree four) 
	mul.s $f16, $f0, $f16
	mul.s $f17, $f8, $f16
	add.s $f15, $f15, $f17

	mul.s $f16, $f0, $f16 #forth term (degree six) 
	mul.s $f16, $f0, $f16
	mul.s $f17, $f9, $f16
	add.s $f15, $f15, $f17

	mov.s $f0, $f15
	#end kernel cos 

ll.9:
	beq	$0, $2, ll.10
	neg.s $f0, $f0
ll.10:
	jr	$31
min_caml_cos:

swc   $f0, -5($0)

	set	$1, 0x40490fdb #PI
    mfc	$1, $f2
    set $1, 0x40000000 #2.0
	mfc	$1, $f3
	set	$1, 0x40800000 #4.0 
	mfc	$1, $f4
	set	$1, 0xbe2aaaac #0.16666668
	mfc	$1, $f5
	set	$1, 0x3c088666 #0.008332824
	mfc	$1, $f6
	set	$1, 0xb94d64b6 #0.00019587841
	mfc	$1, $f7
	set	$1, 0x3f000000 #0.5
	mfc	$1, $f8
	set $1, 0x3d2aa789 #0.04166368
	mfc	$1, $f9
	set	$1, 0xbab38106 #0.0013695068
	mfc	$1, $f10

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
	c.olt.s	$f0, $f14
	bct ll.14
	sub.s $f0, $f0, $f14
ll.14:
	div.s $f14, $f14, $f3
	j ll.13
ll.15:
	#end reduction

	c.olt.s	$f0, $f2
	bct	ll.6
	sub.s	$f0, $f0, $f2
	# reverse flag
	lli $3, 1
	xor $2, $2, $3

ll.16:
div.s	$f13, $f2, $f3
	c.olt.s	$f0, $f13
	bct	ll.17
	sub.s	$f0, $f2, $f0
ll.17:

	div.s	$f14, $f2, $f4
	c.olt.s	$f0, $f14
	bct	ll.18

	#kernel cos store result in $f15, exponent in $f16, term in $f17
	set	$3, 0x3f800000
	mtc $3, $f16 #1.0
	add.s $f15, $f15, $f0 #first term (degree zero)

	mul.s $f16, $f0, $f16 #second term (degree two)
	mul.s $f16, $f0, $f16
	mul.s $f17, $f7, $f16
	add.s $f15, $f15, $f17

	mul.s $f16, $f0, $f16 #third term (degree four) 
	mul.s $f16, $f0, $f16
	mul.s $f17, $f8, $f16
	add.s $f15, $f15, $f17

	mul.s $f16, $f0, $f16 #forth term (degree six) 
	mul.s $f16, $f0, $f16
	mul.s $f17, $f9, $f16
	add.s $f15, $f15, $f17

	mov.s $f0, $f15
	#end kernel cos 

	j	ll.19	
ll.18:
	sub.s	$f0, $f13, $f0
	#kernel sin store result in $f15, exponent in $f16, term in $f17 
	mov.s	$f15, $f0 #first term
	mov.s $f16, $f0

	mul.s $f16, $f0, $f16 #second term (degree three)
	mul.s $f16, $f0, $f16
	mul.s $f17, $f5, $f16
	add.s $f15, $f15, $f17

	mul.s $f16, $f0, $f16 #third term (degree five) 
	mul.s $f16, $f0, $f16
	mul.s $f17, $f6, $f16
	add.s $f15, $f15, $f17

	mul.s $f16, $f0, $f16 #forth term (degree seven) 
	mul.s $f16, $f0, $f16
	mul.s $f17, $f6, $f16
	add.s $f15, $f15, $f17

	mov.s $f0, $f17
	#end kernel sin

ll.19:
	beq	$0, $2, ll.20
	neg.s $f0, $f0
ll.20:
	jr	$31

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
    set $1, 0xbeaaaaaa #0.3333333
    mtc $1, $f7
    set $1, 0x3e4ccccd #0.2
    mtc $1, $f8
    set $1, 0xbe124925 #0.142857142
    mtc $1, $f9
    set $1, 0x3de38e38 #0.111111104
    mfc $1, $f10
    set $1, 0xbdb7d66e #0.08976446
    mfc $1, $f11
    set $1, 0x3d75e7c5 #0.060035485
    mfc $1, $f12
	set $1, 0x3f800000 #1.0
	mfc	$1, $f13

	abs.s	$f0, $f0
	c.olt.s	$f0, $f3
    bcf	ll.21

	#kernel atan store result in $f14, exponent in $f15, term in $f16
	#lli	$3, 1
	#mtc	$3, $f13
	#floor $f13, $f13#1.0

	mov.s $f14, $f0 #first term (degree one)
	mov.s $f15, $f0

	mul.s $f15, $f0, $f15 #second term (degree three)
	mul.s $f15, $f0, $f15
	mul.s $f16, $f6, $f15
	add.s $f14, $f14, $f16

	mul.s $f15, $f0, $f15 #third term (degree five) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f7, $f15
	add.s $f14, $f14, $f16

	mul.s $f15, $f0, $f15 #forth term (degree seven) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f9, $f15
	add.s $f14, $f14, $f16

    mul.s $f15, $f0, $f15 #forth term (degree nine) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f10, $f15
	add.s $f14, $f14, $f16

    mul.s $f15, $f0, $f15 #forth term (degree eleven) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f11, $f15
	add.s $f14, $f14, $f16

    mul.s $f15, $f0, $f15 #forth term (degree thirteen) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f12, $f15
	add.s $f14, $f14, $f16


	mov.s $f0, $f14
	#end kernel atan 
	j ll.23


ll.21:
	c.olt.s	$f3, $f0
    bct	ll.22

	sub.s	$f0, $f13, $f14
	add.s	$f0, $f13, $f15
	div.s	$f14, $f15, $f0 #$f0 <= (|A| - 1.0 / |A| + 1.0)

	#kernel atan store result in $f14, exponent in $f15, term in $f16

	mov.s $f14, $f0 #first term (degree one)
	mov.s $f15, $f0

	mul.s $f15, $f0, $f15 #second term (degree three)
	mul.s $f15, $f0, $f15
	mul.s $f16, $f6, $f15
	add.s $f14, $f14, $f16

	mul.s $f15, $f0, $f15 #third term (degree five) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f7, $f15
	add.s $f14, $f14, $f16

	mul.s $f15, $f0, $f15 #forth term (degree seven) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f9, $f15
	add.s $f14, $f14, $f16

    mul.s $f15, $f0, $f15 #forth term (degree nine) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f10, $f15
	add.s $f14, $f14, $f16

    mul.s $f15, $f0, $f15 #forth term (degree eleven) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f11, $f15
	add.s $f14, $f14, $f16

    mul.s $f15, $f0, $f15 #forth term (degree thirteen) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f12, $f15
	add.s $f14, $f14, $f16
	
	#end kernel atan
	div.s $f2, $f5, $f1
	sub.s $f0, $f1, $f14

	j ll.23
	#TODO return

ll.22:	
	div.s	$f0, $f13, $f0


	#kernel atan store result in $f14, exponent in $f15, term in $f16

	mov.s $f14, $f0 #first term (degree one)
	mov.s $f15, $f0

	mul.s $f15, $f0, $f15 #second term (degree three)
	mul.s $f15, $f0, $f15
	mul.s $f16, $f6, $f15
	add.s $f14, $f14, $f16

	mul.s $f15, $f0, $f15 #third term (degree five) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f7, $f15
	add.s $f14, $f14, $f16

	mul.s $f15, $f0, $f15 #forth term (degree seven) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f9, $f15
	add.s $f14, $f14, $f16

    mul.s $f15, $f0, $f15 #forth term (degree nine) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f10, $f15
	add.s $f14, $f14, $f16

    mul.s $f15, $f0, $f15 #forth term (degree eleven) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f11, $f15
	add.s $f14, $f14, $f16

    mul.s $f15, $f0, $f15 #forth term (degree thirteen) 
	mul.s $f15, $f0, $f15
	mul.s $f16, $f12, $f15
	add.s $f14, $f14, $f16
	
	#end kernel atan

	div.s $f1, $f2, $f5
	sub.s $f0, $f2, $f14

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


