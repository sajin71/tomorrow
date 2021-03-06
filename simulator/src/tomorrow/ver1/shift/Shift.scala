package tomorrow.ver1.shift

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

class Sll extends ThreeRegisterOperandOpcode(0x18, 0x00) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
	    operand.rt.bytes = BigEndianInterpreter interpretAsByteArray ((BigEndianInterpreter.interpretAsSignedInteger(operand.rs)) << operand.shift) //< 算術シフトと論理シフトに差はないので適当にやる。
	    programCounter.data += 4	    
	}
}
class Srl extends ThreeRegisterOperandOpcode(0x18, 0x02) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
	    operand.rt.bytes = BigEndianInterpreter interpretAsByteArray ((BigEndianInterpreter interpretAsSignedInteger operand.rs) >>> operand.shift)
	    programCounter.data += 4	    
	}
}
class Sra extends ThreeRegisterOperandOpcode(0x18, 0x03) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
	    operand.rt.bytes = BigEndianInterpreter interpretAsByteArray ((BigEndianInterpreter.interpretAsSignedInteger(operand.rs)) << operand.shift)
	    programCounter.data += 4	    
	}
}
