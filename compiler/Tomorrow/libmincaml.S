.section ".text"
min_caml_print_char:
min_caml_print_int:
	sw 	$1 ,-1($0)
	jr 	$31
min_caml_abs_float:
	abs.s	$f1, $f1
	jr	$31
min_caml_sqrt:
	sqrt.s	$f1, $f1
	jr	$31
min_caml_float_of_int:
	conv.s	$f1, $1
	jr	$31
min_caml_int_of_float:
	floor.w	 $1, $f1
	jr	$31

