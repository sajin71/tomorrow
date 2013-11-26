package tomorrow.ver1.fpu

import tomorrow.ver1.CopOpcode
import usb.USB
import strage.IntegerRegister
import strage.Memory
import cpu.instruction.Instruction
import cpu.instruction.Operate
import interpreter.BigEndianInterpreter
import strage.Register

class MFC extends CopOpcode(0x00){
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
		programCounter.data += 4
		operand.rt.bytes = operand.fs.bytes
	}
}
class MTC extends CopOpcode(0x07){
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
		operand.fs.bytes = operand.rt.bytes
		programCounter.data += 4
	}
}