package tomorrow.ver1

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
import usb.USB

abstract class ThreeRegisterOperandOpcode(opcode:Int, function:Int) extends Opcode {
    case class Operand(rs: Register, rt: Register, rd: Register, shift: Int)
    /**
     * 実際の処理の決定
     */
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory)

	def isValid(instruction: Instruction) = {
		(((instruction.data(0) & 0xFC) >> 2) == opcode) && ((instruction.data(3) & 0x3F) == function)
	}
    
	def parse(instruction: Instruction): Operate = {
	    val func = apply(_, _, _, _, _)
	    new Operate {
	    	def apply(usb: USB, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
		    	val int = BigEndianInterpreter.interpretAsSignedInteger(instruction.data)
		    	val rs = s"r${(int & 0x03E00000)>>21}"
		    	val rt = s"r${(int & 0x001F0000)>>16}"
		    	val rd = s"r${(int & 0x0000F800)>>11}"
		    	val shift = (int & 0x000007C0)>>6
		    	Logger.getLogger("Tomorrow.ver1").log(Level.FINE, s"${this.getClass().getName()} ${rs} ${rt} ${rd} ${shift}")
		    	func(usb, Operand(registers(rs), registers(rt), registers(rd), (int & 0x000007C0)>>6), programCounter, registers, memory)		    	
			}
	    }
    }

}