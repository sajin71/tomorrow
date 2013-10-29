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


10/29に決めたこと
* メモリマップドIOにすることを決めた
0xffffffff に読み書きしようとするとRS-232Cで読み書き
LWは4byteを読み込む（＝コア内に取り込む）が、SWは下位1byteのみを書き込む（＝パソコンに送る）

* コアは、電源投入直後は、終端記号 0xd0000000 を読み込むまでBlockRAMに命令列を読み込んでゆく動作をする（このような動作をするプログラムがBlockRAM上に焼かれている）
* HALT命令 (opcode = 111100 = 0x3c) を読み込むとCPUは動作を停止する
