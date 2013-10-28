tomorrow
========

Codes for CPU experiment

Instructions:
（算術命令）ADD, SUB, MULT, DIV, ADDI, (MULI?) 
（ロードストア）LW, SW, MFHI, MFLO,
（論理）AND, ANDI, OR, ORI, XOR, NOR, SLT 
（シフト）SLL, SRL, SRA, 
（ジャンプ系）BEQ, BNE, J, JR, JAL, NOP

Psuedo Instructions:
Mov
Set
FMov


出力について
メモリマップドIOにすることで一部の班員と合意しました｡
いまのところ､0xffffをrs232cの番地とし､LWはすなわちinput､SWはすなわちoutputに対応する､という予定です｡
