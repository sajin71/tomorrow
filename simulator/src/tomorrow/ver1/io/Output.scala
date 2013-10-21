package tomorrow.ver1.io


import strage.IntegerRegister
import scala.collection.immutable.Map
import tomorrow.ver1.ThreeRegisterOperandOpcode
import cpu.instruction.Operate
import strage.IntegerRegister
import strage.Memory
import strage.Register
import interpreter.{BigEndianInterpreter=>I}
import tomorrow.ver1.ImmediateOperandOpcode
import interpreter.BigEndianInterpreter
import cpu.instruction.Opcode
import tomorrow.ver1.ImmediateOperandOpcode
import strage.Register
import strage.IntegerRegister
import usb.USB

class Output extends ImmediateOperandOpcode(0x3f) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
		usb.sendToUser(operand.rs.bytes)
	    programCounter.data += 4	    
	}
}