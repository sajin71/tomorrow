ADDI $2, $zero, 0   # $2...メモリ (BlockRAM) の位置
LUI  $3, 0xD000        # $3...終端記号（比較用） 0xd0000000
ADDI $4, $zero, 0x4F   # $4に'O'
SW   $4, -1($zero)     # 'O'出力
ADDI $4, $zero, 0x4B   # $4に'K'
SW   $4, -1($zero)     # 'K'出力

loop:
LW   $4, -1($zero)     # $4にRS-232Cから読み込む
BEQ  $4, $3, start     # 読み込んだものが終端記号ならstartに飛んでスタート
SW   $4, 0($2)         # ブロックRAMに命令を書き込む
ADDI $2, $2, 4         # ブロックRAMのポインタを進める
BEQ $0, $0, loop                 # ループ

start:
JR $0