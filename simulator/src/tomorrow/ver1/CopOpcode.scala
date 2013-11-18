package tomorrow.ver1

import cpu.instruction.Opcode
import strage.Register
import usb.USB
import strage.IntegerRegister
import strage.Memory
import cpu.instruction.Instruction
import cpu.instruction.Operate
import interpreter.BigEndianInterpreter

abstract class CopOpcode(mf: Int) extends Opcode {
	case class Operand(rt: Register, fs: Register)
    /**
     * 実際の処理の決定
     */
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory)
	def isValid(instruction: Instruction) = {
		val data = (instruction.data(0) << 8) + instruction.data(1)
		(((instruction.data(0) & 0xFC)>> 2) == 0x11) &&
		(((data & 0x0370) >> 5) == mf) &&//0000 0011 1110 0000
		(instruction.data(3) == 0) &&
		((instruction.data(2) & 0x7) == 0x0)
	}
	def parse(instruction: Instruction): Operate = {
	    val func = apply(_, _, _, _, _)
	    new Operate {
	    	def apply(usb: USB, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
		    	val int = BigEndianInterpreter.interpretAsSignedInteger(instruction.data)
		    	val fs = s"f${(int & 0x03E00000)>>11}"
		    	val rt = s"r${(int & 0x001F0000)>>16}"
		    	func(usb, Operand(registers(rt), registers(fs)), programCounter, registers, memory)
			}
	    }
    }
}