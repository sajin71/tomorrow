Tomorrow Assembler
==================

Usage: ./asm [input asm [output bin]]

出力先を指定しないとa.binに出力されます。入力先も指定しないと標準入力から読みます。

- レジスタ番号には$を付けてください。$zero等の名前も使えます。
- # と ; 以降がコメントです。
- だいたいの空白はあってもなくてもいいはずです
- ニーモニックは大文字小文字を区別しません

疑似命令
--------
- MOV    $t, $s (=ADD $t, $s, $0)
- LLI    $t, imm (=ORI $t, $0, imm)
- SET    $t, imm (=LUI $t, imm[31:16]; ORI $t, $t, imm[15:0])
- SETL   $t, label (Set pointer of label using LUI, ORI)
- SETLV  $t, label (Set value of label using LW. label must be placed to 0x0000-0x7fff)
- SETCLV $f, label (Set fp value of label using LWC. label must be placed to 0x0000-0x7fff)
- .long imm (Emit raw imm)

MIPSとの相違点
--------------
- LWC1=LWC など、コプロセッサ番号の省略が可能
- C.cond.s や BC1T, BC1F でのccは0から7までの数値で指定してください（省略すると0になります）
- 遅延スロット関係のNOP自動挿入はしない
- SLL, SRL, SRA, SLLV, SRLV, SRAV のopcodeは0x00ではなく0x18
- JR のopcodeは0x00ではなく0x1B

How to Check Assembler's output
-------------------------------
1. Install *mipseb-linux-elf-objdump*
    1. Download GNU Binutils
    2. ./configure --target=mipseb
    3. make install
2. mipseb-linux-elf-objdump -D -b binary -mmips:isa32r2 -Mreg-names=numeric -EB a.bin
