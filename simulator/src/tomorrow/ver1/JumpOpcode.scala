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

abstract class JumpOpcode(opcode:Int) extends Opcode {
    case class Operand(constant: Int)
    /**
     * 実際の処理の決定
     */
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory)

	def isValid(instruction: Instruction) = {
		(((instruction.data(0) & 0xFC) >> 2)== opcode)
	}
    
	def parse(instruction: Instruction): Operate = {
	    val func = apply(_, _, _, _, _)
	    new Operate {
	    	def apply(usb: USB, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
		    	val int = BigEndianInterpreter.interpretAsSignedInteger(instruction.data)
		    	val constant = (int & 0x03FFFFFF) | (if((int & 0x02000000).signum != 0) 0xFC000000 else 0)
		    	Logger.getLogger("Tomorrow.ver1").log(Level.FINE, s"${this.getClass().getName()} ${constant}")
		    	func(usb, Operand(constant), programCounter, registers, memory)		    	
			}
	    }
    }

}