package tomorrow.ver1

import cpu.instruction.Opcode
import cpu.instruction.Opcode
import cpu.instruction.Instruction
import cpu.instruction.Operate
import strage.IntegerRegister
import strage.Memory
import strage.Register
import interpreter.{BigEndianInterpreter=>I}
import java.util.logging.Logger
import java.util.logging.Level
import interpreter.BigEndianInterpreter

/**
 * 即値付きの命令
 */
abstract class ImmediateOperandOpcode(opcode: Int) extends Opcode {
    case class Operand(rs: Register, rt: Register, constant: Int)
    /**
     * 実際の処理の決定
     */
    protected def apply(operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory)

	def isValid(instruction: Instruction) = {
		(((instruction.data(0) & 0xFC)>> 2) == opcode)
	}
    
	def parse(instruction: Instruction): Operate = {
	    val func = apply(_, _, _, _)
	    new Operate {
	    	def apply(programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
		    	val int = BigEndianInterpreter.interpretAsSignedInteger(instruction.data)
		    	val constantTmp = (int & 0x0000FFFF).toShort;
		    	val rs = s"r${(int & 0x03E00000)>>21}"
		    	val rt = s"r${(int & 0x001F0000)>>16}"
		    	Logger.getLogger("Tomorrow.ver1").log(Level.FINE, s"${this.getClass().getName()} ${rs} ${rt} ${constantTmp toInt}")
		    	func(Operand(registers(rs), registers(rt), (constantTmp toInt)), programCounter, registers, memory)		    	
			}
	    }
    }

}