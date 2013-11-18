package tomorrow.ver1.fpu

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
import tomorrow.ver1.ImmediateOpcodeFPU

class LWC extends ImmediateOpcodeFPU(0x31){
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
		val begin = (BigEndianInterpreter interpretAsUnsignedInteger operand.base) + operand.constant
		var data = new Array[Byte](4)
		for(i <- 0 until 4){
			data(i) = memory(begin + i)
		}
		operand.ft.bytes = data
	    programCounter.data += 4
	}
}

class SWC extends ImmediateOpcodeFPU(0x29) {
	protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
		val begin = (BigEndianInterpreter interpretAsUnsignedInteger operand.base) + operand.constant
	    val data = operand.ft.bytes
		for(i <- 0 until (data.length)){
			memory(begin+i) = data(i)
		}
	    programCounter.data += 4		
	}
}
