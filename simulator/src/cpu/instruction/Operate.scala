package cpu.instruction

import strage.IntegerRegister
import strage.Register
import strage.Memory

abstract class Operate {
	def apply(programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory): Unit
}