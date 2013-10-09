package test
import cpu.AbstractCPU
import cpu.instruction.Opcode
import cpu.instruction.Operate
import cpu.instruction.Instruction
import strage.Memory
import strage.Register
import strage.IntegerRegister
import scala.collection.immutable.HashMap
import scala.collection.immutable.HashSet
import interpreter.{BigEndianInterpreter=>I}
import interpreter.BigEndianInterpreter
/**
 * add(4bit 0) r1(4bit) <- r2 + r3
 */
class Add extends Opcode {
	def isValid(instruction: Instruction) = {
		val opcode = instruction.data(0) >> 4
		opcode == 0 
	}
	def parse(instruction: Instruction): Operate = new Operate {
		def apply(programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
			val r1 = registers(s"r${instruction.data(0) & 0x0F}")
			val r2 = registers(s"r${instruction.data(1) >> 4}")
			val r3 = registers(s"r${instruction.data(1) & 0x0F}")

			r1.bytes = BigEndianInterpreter.interpretAsByteArray((BigEndianInterpreter.interpretAsSignedInteger(r2) + BigEndianInterpreter.interpretAsSignedInteger(r3)))
			programCounter.data += 2
		}
	}
}
/**
 * subst(4bit 1) r1(4bit) <- C(8bit)
 */
class Subst extends Opcode {
	def isValid(instruction: Instruction) = {
		val opcode = instruction.data(0) >> 4
		opcode == 1
	}
	def parse(instruction: Instruction): Operate = new Operate {
		def apply(programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
			val r1 = s"r${instruction.data(0) & 0x0F}"
			registers(r1).bytes = Array(instruction.data(1))
			programCounter.data += 2
		}
	}
}

class TestCPU extends AbstractCPU(HashSet(new Add(), new Subst()), HashMap[String, Register](("r1"->new IntegerRegister()), ("r2"->new IntegerRegister()), ("r3"->new IntegerRegister())), 1024) {
	protected val executableAddress = 0x200 toLong
	protected def instructionLength = 2 //< 2byte固定長
}

