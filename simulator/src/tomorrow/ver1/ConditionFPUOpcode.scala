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

abstract class ConditionFPUOpcode(function: Int) extends Opcode {
    case class Operand(ft: Register, fs: Register, cc: Int)
    /**
     * 実際の処理の決定
     */
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory)

	def isValid(instruction: Instruction) = {
        val int = BigEndianInterpreter.interpretAsSignedInteger(instruction.data)
    	(((instruction.data(0) & 0xFC) >> 2) == 0x11) && 
    	((instruction.data(3) & 0x3F) == function) // 111111
	}
    
	def parse(instruction: Instruction): Operate = {
	    val func = apply(_, _, _, _, _)
	    new Operate {
	    	def apply(usb: USB, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
		    	val int = BigEndianInterpreter.interpretAsSignedInteger(instruction.data)
		    	val ft = s"f${(int & 0x001F0000)>>16}"
		    	val fs = s"f${(int & 0x0000F800)>>11}"
		    	val cc = (int & 0x00000700)>>8
		    	func(usb, Operand(registers(ft), registers(fs), cc), programCounter, registers, memory)		    	
			}
	    }
    }

}