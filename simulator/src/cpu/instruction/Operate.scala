package cpu.instruction

import strage.IntegerRegister
import strage.Register
import strage.Memory
import usb.USB

abstract class Operate {
	def apply(usb: USB, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory): Unit
}