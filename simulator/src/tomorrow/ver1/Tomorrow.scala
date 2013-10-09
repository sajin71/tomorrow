 package tomorrow.ver1

import cpu.AbstractCPU
import tomorrow.ver1.arithmetic._
import tomorrow.ver1.jump._
import tomorrow.ver1.logic._
import tomorrow.ver1.memoryAccess._
import tomorrow.ver1.shift._
import scala.collection.immutable.HashSet
import scala.collection.immutable.HashMap
import strage.IntegerRegister

class Tomorrow extends AbstractCPU(
    HashSet(new Add(), new Sub(), new Mul(), new Div(), new Addi(),
            new Jump(), new JumpRegister(), new Jal(), new Beq(), new Bne(), 
    		new And(), new Andi(), new Or(), new Ori(), new Xor(), new Nor(), new LW(), new SW(), new MFHI(), new MFLO(),
    		new Sll(), new Srl(), new Sra()),
    HashMap(("HI" -> new IntegerRegister()), ("LO" -> new IntegerRegister())) ++ 
            (new Range(0, 32, 1).map((i:Int)=>(s"r${i}"->new IntegerRegister()))) toMap,
    0x04000000){
    
	/**
     * 命令の格納されるメモリ空間の先頭アドレス
     */
    protected def executableAddress : Int = 0x00000000
    /**
     * 次にフェッチする命令長を返す。PCは動かさないことが望まれるが、CPU設計次第では、動かす可能性は否定しない。
     * 単位はbyte
     */
    protected def instructionLength : Long = 4
}