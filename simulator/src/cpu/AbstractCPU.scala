package cpu

import cpu.instruction.Instruction
import cpu.instruction.Opcode
import strage.IntegerRegister
import strage.Register
import strage.SequenceMemory
import scala.collection.immutable.HashMap
import strage.Memory
import usb.USB

/**
 */
abstract class AbstractCPU(usb: USB, instructionSet: Set[Opcode], registers: Map[String, Register], memory: Memory) {
    private val decoder = new Decoder(instructionSet)
    protected var programCounter = new IntegerRegister()
    
    def this(usb: USB, instructionSet: Set[Opcode], registers: Map[String, Register], size: Long) = this(usb, instructionSet, registers, new SequenceMemory(size toInt))

    
    /**
     * 命令の格納されるメモリ空間の先頭アドレス
     */
    protected def executableAddress : Long
    /**
     * 次にフェッチする命令長を返す。PCは動かさないことが望まれるが、CPU設計次第では、動かす可能性は否定しない。
     * 単位はbyte
     */
    protected def instructionLength : Int
    
	def stepExecute(): Unit = {
	    executeInstruction(fetch())
	}
	def getState(): CPUMemonto = {
	    new CPUMemonto(programCounter.bytes, registers.map((elem:(String, Register))=>(elem._1, elem._2.bytes)), memory)
	}
	
	/**
	 * executableAddressからの番地に登録する。
	 */
	def setExecutable(data: Seq[Byte]): Unit = {
		programCounter.data = executableAddress toInt
		var addr = executableAddress
		for(i <- data){
		    memory(addr) = i
		    addr += 1
		}
	}
	
	private def fetch(): Instruction = {
	    val length = instructionLength
	    val pc = programCounter.data
	    var code = new Array[Byte](length)
	    for(i <- 0 until length){
	        code(i) = memory((pc+i) toLong) 
	    }
	    new Instruction(code)
	}
	
	private def executeInstruction(instruction: Instruction): Unit = {
        val operate = decoder decode instruction
        operate(usb, programCounter, registers, memory)
    }

}