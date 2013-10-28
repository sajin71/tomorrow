.section ".text"
.global min_caml_print_int
min_caml_print_int:
	lli $r2 65535
    sw $1 0($r2)
   jr $31
   nop

