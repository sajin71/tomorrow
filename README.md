tomorrow
========

Codes for CPU experiment

Instructions:
（算術命令）ADD, SUB, ADDI 
（ロードストア）LW, SW, LUI
（論理）AND, ANDI, OR, ORI, XOR, NOR, SLT 
（シフト）SLL, SRL, SRA
（ジャンプ系）BEQ, BNE, J, JR, JAL, NOP
 (その他) HALT
 
Psuedo Instructions:
Mov
Set
FMov


出力について
メモリマップドIOにすることで一部の班員と合意しました｡
いまのところ､0xffffをrs232cの番地とし､LWはすなわちinput､SWはすなわちoutputに対応する､という予定です｡


10/29に決めたこと
* メモリマップドIOにすることを決めた
0xffffffff に読み書きしようとするとRS-232Cで読み書き
LWは4byteを読み込む（＝コア内に取り込む）が、SWは下位1byteのみを書き込む（＝パソコンに送る）

* コアは、電源投入直後は、終端記号 0xd0000000 を読み込むまでBlockRAMに命令列を読み込んでゆく動作をする（このような動作をするプログラムがBlockRAM上に焼かれている）
* HALT命令 (opcode = 111100 = 0x3c) を読み込むとCPUは動作を停止する


11/5 opcode変更
シフト系 →

opcode = 011000

function field = MIPS準拠(ここでSLL,SRL,SRAのどれなのか判定する)


JR →

opcode = 011011

function field = don't care



11/5 命令セット変更

(+) LUI ... MIPSに準拠   HALT ... 上参照

(-) MULT,DIV,MFHI,MFLO
