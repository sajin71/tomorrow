ADDI $2, $zero, 0   # $2...メモリ (BlockRAM) の位置
ADDI $4, $zero, 0x4F   # $4に'O'
SW   $4, -1($zero)     # 'O'出力
ADDI $4, $zero, 0x4B   # $4に'K'
SW   $4, -1($zero)     # 'K'出力
LW   $3, -1($zero)     # ヘッダの値を読み込む(バイト数)

loop:
BEQ  $3, $0, start     # $3(カウントダウン)が0ならstart
LW   $4, -1($zero)     # $4にRS-232Cから読み込む
SW   $4, 0($2)         # ブロックRAMに命令を書き込む
ADDI $2, $2, 4         # ブロックRAMのポインタを進める
ADDI $3, $3, -4        # $3(カウントダウン)を下げる
BEQ $0, $0, loop                 # ループ

start:
JR $0
