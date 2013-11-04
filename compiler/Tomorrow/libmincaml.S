.section ".text"
.global min_caml_print_int
min_caml_print_int:
    sw $1 -1($r0)
   jr $31
   nop

