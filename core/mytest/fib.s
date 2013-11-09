.section	".rodata"
.align	8
.section	".text"
	lli $5, 0x4d
	sw $5, -1($0)

	lli $29, 1000
	jal	min_caml_start
	nop
	halt
min_caml_print_int:
	lli $5, 0x50
	sw $5, -1($0)

	sw $1, -1($0)
	jr $31
fib.10:
	lli $5, 0x46
	sw $5, -1($0)

	sw $1, -1($0)
	lli	$2, 1
	addi	$27, $2, 0
	slt	$27, $27, $1
	bne	$27, $0, ble_else.24
	jr $31
ble_else.24:
	lli $5, 0x42
	sw $5, -1($0)

	lli	$2, 1
	sub	$2, $1, $2
	sw	$1, 0($29)
	mov	$1, $2
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	fib.10
	nop

	lli $5, 0x21
	sw $5, -1($0)

	addi	$29, $29, -8
	lw	 $31, 4($29)
	lli	$2, 2
	lw	$3, 0($29)
	sub	$2, $3, $2
	sw	$1, 4($29)
	mov	$1, $2
	sw	$31, 12($29)
	addi	$29, $29, 16
	jal	fib.10
	nop

	lli $5, 0x3f
	sw $5, -1($0)
	
	addi	$29, $29, -16
	lw	 $31, 12($29)
	lw	$2, 4($29)
	add	$1, $2, $1
	jr $31
min_caml_start:
	lli $5, 0x53
	sw $5, -1($0)

	lli	$1, 10
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	fib.10
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	sw	$31, 4($29)
	addi	$29, $29, 8
	jal	min_caml_print_int
	nop
	addi	$29, $29, -8
	lw	 $31, 4($29)
	jr $31
