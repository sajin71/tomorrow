ADDI $2, $zero, 0x20   # $2...メモリ (BlockRAM) の位置
LUI  $3, 0xD000        # $3...終端記号（比較用） 0xd0000000

loop:
LW   $4, -1($zero)     # $4にRS-232Cから読み込む
BEQ  $4, $3, start     # 読み込んだものが終端記号ならstartに飛んでスタート
SW   $4, -1($zero)     # ブロックRAMに命令を書き込む
ADDI $2, $zero, 4      # ブロックRAMのポインタを進める
J loop                 # ループ

start:
nop

