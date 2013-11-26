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
import usb.USB
import cpu.instruction.Opcode

abstract class ImmediateOpcodeFPU(opcode: Int) extends Opcode {
	case class Operand(base: Register, ft: Register, constant: Int)
     /**
     * 実際の処理の決定
     */
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory)

	def isValid(instruction: Instruction) = {
		(((instruction.data(0) & 0xFC)>> 2) == opcode)
	}
    
	def parse(instruction: Instruction): Operate = {
	    val func = apply(_, _, _, _, _)
	    new Operate {
	    	def apply(usb: USB, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
		    	val int = BigEndianInterpreter.interpretAsSignedInteger(instruction.data)
		    	val constantTmp = (int & 0x0000FFFF).toShort;
		    	val base = s"r${(int & 0x03E00000)>>21}"
		    	val ft = s"f${(int & 0x001F0000)>>16}"
		    	func(usb, Operand(registers(base), registers(ft), (constantTmp toInt)), programCounter, registers, memory)		    	
			}
	    }
    }

}