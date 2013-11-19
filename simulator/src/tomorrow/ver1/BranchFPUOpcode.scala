package tomorrow.ver1

import cpu.instruction.Opcode
import cpu.instruction.Opcode
import strage.Register
import usb.USB
import strage.IntegerRegister
import strage.Memory
import cpu.instruction.Instruction
import cpu.instruction.Operate
import interpreter.BigEndianInterpreter

abstract class BranchFPUOpcode(rs: Int, negPos: Boolean) extends Opcode {
	case class Operand(cc: Boolean, offset: Int)
    /**
     * 実際の処理の決定
     */
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory)
	def isValid(instruction: Instruction) = {
		val int = BigEndianInterpreter.interpretAsSignedInteger(instruction.data)
		val data = (instruction.data(0) << 8) + instruction.data(1)
		(((instruction.data(0) & 0xFC)>> 2) == 0x11) &&
		(((data & 0x0370) >> 5) == 0x08) &&//0000 0011 1110 0000
		((instruction.data(1) & 0x1) == (if(negPos){1}else{0})) &&
		((int & 0x03E00000) >> 21) == rs
	}
	def parse(instruction: Instruction): Operate = {
	    val func = apply(_, _, _, _, _)
	    new Operate {
	    	def apply(usb: USB, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
		    	val int = BigEndianInterpreter.interpretAsSignedInteger(instruction.data)
		    	val cc = registers("FCSR").bytes
		    	val fcc = (int & 0x001C0000)>>11 
		    	val offset = int & 0xff
		    	if(fcc == 0){
		    		func(usb, Operand((BigEndianInterpreter.interpretAsUnsignedInteger(cc) >> (23) & 0x1) != 0/*0でなければ1=>true*/, offset), programCounter, registers, memory)		    	    
		    	}else{
		    		func(usb, Operand((BigEndianInterpreter.interpretAsUnsignedInteger(cc) >> (24+fcc) & 0x1) != 0/*0でなければ1=>true*/, offset), programCounter, registers, memory)		    	    
		    	}
		    	s"f${}"// 00000000 00011100 00000000 00000000 

			}
	    }
    }

}