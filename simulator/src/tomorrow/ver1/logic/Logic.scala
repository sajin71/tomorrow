package tomorrow.ver1.logic

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

class And extends ThreeRegisterOperandOpcode(0x00, 0x24) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
	    operand.rd.bytes = BigEndianInterpreter interpretAsByteArray ((BigEndianInterpreter.interpretAsSignedInteger(operand.rs)) & (BigEndianInterpreter interpretAsSignedInteger operand.rt))
	    programCounter.data += 4	    
	}
}
class Andi extends ImmediateOperandOpcode(0x0C) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
	    operand.rt.bytes = BigEndianInterpreter interpretAsByteArray ((BigEndianInterpreter.interpretAsSignedInteger(operand.rs)) & operand.constant)
	    programCounter.data += 4
	}
}
class Or extends ThreeRegisterOperandOpcode(0x00, 0x25) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
	    operand.rd.bytes = BigEndianInterpreter interpretAsByteArray ((BigEndianInterpreter.interpretAsSignedInteger(operand.rs)) | (BigEndianInterpreter interpretAsSignedInteger operand.rt))
	    programCounter.data += 4	    
	}
}
class Ori extends ImmediateOperandOpcode(0x0D) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
	    operand.rt.bytes = BigEndianInterpreter interpretAsByteArray ((BigEndianInterpreter.interpretAsSignedInteger(operand.rs)) | operand.constant)
	    programCounter.data += 4	    
	}
}
class Xor extends ThreeRegisterOperandOpcode(0x00, 0x26) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
	    operand.rd.bytes = BigEndianInterpreter interpretAsByteArray ((BigEndianInterpreter.interpretAsSignedInteger(operand.rs)) ^ (BigEndianInterpreter interpretAsSignedInteger operand.rt))
	    programCounter.data += 4
	}
}

class Nor extends ThreeRegisterOperandOpcode(0x00, 0x27) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
	    operand.rd.bytes = BigEndianInterpreter interpretAsByteArray (~((BigEndianInterpreter.interpretAsSignedInteger(operand.rs)) | (BigEndianInterpreter interpretAsSignedInteger operand.rt)))
	    programCounter.data += 4	    
	}
}
