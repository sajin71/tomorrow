 l0:  addi $3, $0, 5
 l1:  addi $4, $0, 1
 l2:  mult $3, $4
 l3:  mflo $4
 l4:  addi $3, $3, -1
 l5:  beq  $0, $3, l7
 l6:  jal l2
 l7:  add  $0,$0,$0

andi $5, $3, 6
ori  $5, $3, 6
slti $5, $3, 6
nop

add $1, $2, $3
sub $1, $2, $3
and $1, $2, $3
or $1, $2, $3
xor $1, $2, $3
nor $1, $2, $3
slt $1, $2, $3

mult $1, $2
div  $1, $2

mfhi $5
mflo $2
mfhi $0

sll $3, $1, 2
srl $3, $1, 2
sra $3, $1, 2
lui $5, 0xFFFF

lw $6, 4($2)
lw $6, 0x234($2)

sw $6, 4($2)
sw $6, 0x234($2)
