package tomorrow.ver1.memoryAccess

import cpu.instruction.Opcode
import cpu.instruction.Instruction
import cpu.instruction.Operate
import strage.IntegerRegister
import strage.Memory
import strage.Register
import interpreter.{BigEndianInterpreter=>I}
import tomorrow.ver1.ImmediateOperandOpcode
import tomorrow.ver1.ThreeRegisterOperandOpcode
import interpreter.BigEndianInterpreter
import usb.USB

class LW extends ImmediateOperandOpcode(0x23) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
		val begin = (BigEndianInterpreter interpretAsUnsignedInteger operand.rs) + operand.constant
		if(begin == 0xffffffffL){
		    operand.rt.bytes = usb.getLatestDataToCPU
		}else{
		    operand.rt.data_=(memory.updateMemory(begin))
		}
		programCounter.data += 4
	}
}

class SW extends ImmediateOperandOpcode(0x2B) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
		val begin = (BigEndianInterpreter interpretAsUnsignedInteger operand.rs) + operand.constant
		if(begin == 0xffffffffL){
		    usb.sendToUser(Array(operand.rt.bytes(3)))
		}else{
		    memory.updateMemory(begin, BigEndianInterpreter.interpretAsSignedInteger(operand.rt))
		}
	    programCounter.data += 4		
	}
}

class MFHI extends ThreeRegisterOperandOpcode(0x00, 0x10) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
	    operand.rd.bytes = registers("HI").bytes
	    programCounter.data += 4	    
	}
}
class MFLO extends ThreeRegisterOperandOpcode(0x00, 0x12) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
	    operand.rd.bytes = registers("LO").bytes
	    programCounter.data += 4	    
	}
}

class LUI extends ImmediateOperandOpcode(0x0f) {// 001111 
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
        operand.rt.bytes = BigEndianInterpreter interpretAsByteArray (operand.constant << 16);
	    programCounter.data += 4	    
	}
}
