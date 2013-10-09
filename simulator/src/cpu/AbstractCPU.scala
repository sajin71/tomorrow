package cpu

import cpu.instruction.Instruction
import cpu.instruction.Opcode
import strage.IntegerRegister
import strage.Register
import strage.SequenceMemory
import scala.collection.immutable.HashMap
import strage.Memory

/**
 * @todo Decoder->OpcodeにprogramCounter, Register, Memoryを渡す必要
 * @todo このクラスは抽象CPUだと見ているが、CPU内で違うのはInstructionSetとregisters, MemorySizeだけなの？<-fetchとかを変えました。まる。
 */
abstract class AbstractCPU(instructionSet: Set[Opcode], registers: Map[String, Register], memory: Memory) {
    private val decoder = new Decoder(instructionSet)
    protected var programCounter = new IntegerRegister()
    
    def this(instructionSet: Set[Opcode], registers: Map[String, Register], size: Long) = this(instructionSet, registers, new SequenceMemory(size toInt))

    
    /**
     * 命令の格納されるメモリ空間の先頭アドレス
     */
    protected def executableAddress : Int
    /**
     * 次にフェッチする命令長を返す。PCは動かさないことが望まれるが、CPU設計次第では、動かす可能性は否定しない。
     * 単位はbyte
     */
    protected def instructionLength : Long
    
	def stepExecute(): Unit = {
	    executeInstruction(fetch())
	}
	def getState(): CPUMemonto = {
	    new CPUMemonto(programCounter.bytes, registers.map((elem:(String, Register))=>(elem._1, elem._2.bytes)), Array[Byte]())
	}
	
	/**
	 * executableAddressからの番地に登録する。
	 */
	def setExecutable(data: Seq[Byte]): Unit = {
		programCounter.data = executableAddress
		var addr = executableAddress
		for(i <- data){
		    memory(addr) = i
		    addr += 1
		}
	}
	
	private def fetch(): Instruction = {
	    val length = instructionLength
	    val pc = programCounter.data
	    new Instruction(
	            (memory filterKeys ((data) => (pc <= data) && (data <= pc + length))).values.toSeq
	            )
	    //new Instruction(memory.data.slice(programCounter.data, programCounter.data + length))
	}
	
	private def executeInstruction(instruction: Instruction): Unit = {
        val operate = decoder decode instruction
        operate(programCounter, registers, memory)
    }

}