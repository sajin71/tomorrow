.section ".text"
.global min_caml_print_int
min_caml_print_int:
	sw $1 ,-1($0)
	jr $31
	nop

