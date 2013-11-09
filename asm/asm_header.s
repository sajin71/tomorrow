LUI $30, 0x8000     # frame pointer
LUI $29, 0x8010     # stack pointer
jal	min_caml_start
nop
halt

min_caml_print_int:
sw $1, -1($zero)
jr $31

closure_indirect:
jr $27
