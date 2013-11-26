min_caml_halt:
halt

min_caml_prerr_int:
	sw	$1, -3($0)
	jr	$31

min_caml_prerr_byte:
	sw	$1, -4($0)
	jr	$31

min_caml_prerr_float:
	swc	$f0, -5($0)
	jr	$31

min_caml_abs_float:
  abs.s $f0, $f0
  jr $31

min_caml_floor:
  floor.w.s $f0, $f0
  cvt.s.w $f0, $f0
  jr $31

min_caml_float_of_int:
  mtc1 $1, $f0
  cvt.s.w $f0, $f0
  jr $31

min_caml_int_of_float:
min_caml_truncate:
  floor.w.s $f0, $f0
  #trunc.w.s $f0, $f0
  mfc1 $1, $f0
  slt $2, $1, $0
  beq $2, $0, min_caml_truncate_return
  addi $1, $1, 1

min_caml_truncate_return:
  jr $31


min_caml_sqrt:
  sqrt.s $f0, $f0
  jr $31

min_caml_sin:
  _sin.s $f0, $f0
  jr $31

min_caml_cos:
  _cos.s $f0, $f0
  jr $31

min_caml_atan:
  _atan.s $f0, $f0
  jr $31

min_caml_read_int:
	lw	$1, -1($0)
	jr	$31
min_caml_read_float:
	lwc	$f0, -2($0)
	jr	$31

min_caml_print_newline:
	addi $1, $0, 10
    j min_caml_print_char


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
sw   $11, -2($0)

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
sw $1, -2($0)

print_int_continue:
addi $19, $19, -4
bne $5, $0, print_int_showloop

#leave
jr $31




min_caml_print_byte:
min_caml_print_char:
	sw	$1, -2($0)
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
  jr	$31
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
  jr	$31




min_caml_objects:
	.skip	240


min_caml_size:
	.skip	8


min_caml_dbg:
	.skip	4


min_caml_screen:
	.skip	24


min_caml_vp:
	.skip	24


min_caml_view:
	.skip	24


min_caml_light:
	.skip	24


min_caml_cos_v:
	.skip	16


min_caml_sin_v:
	.skip	16


min_caml_beam:
	.skip	8


min_caml_and_net:
	.skip	200


min_caml_or_net:
	.skip	4


min_caml_temp:
	.skip	112


min_caml_cs_temp:
	.skip	128


min_caml_solver_dist:
	.skip	8


min_caml_vscan:
	.skip	24


min_caml_intsec_rectside:
	.skip	4


min_caml_tmin:
	.skip	8


min_caml_crashed_point:
	.skip	24


min_caml_crashed_object:
	.skip	4


min_caml_end_flag:
	.skip	4


min_caml_viewpoint:
	.skip	24


min_caml_nvector:
	.skip	24


min_caml_rgb:
	.skip	24


min_caml_texture_color:
	.skip	24


min_caml_solver_w_vec:
	.skip	24


min_caml_chkinside_p:
	.skip	24


min_caml_isoutside_q:
	.skip	24


min_caml_nvector_w:
	.skip	24


min_caml_scan_d:
	.skip	8


min_caml_scan_offset:
	.skip	8


min_caml_scan_sscany:
	.skip	8


min_caml_scan_met1:
	.skip	8


min_caml_wscan:
	.skip	24


