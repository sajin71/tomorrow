package test

import org.scalatest.junit.JUnitSuite
import org.scalatest.junit.ShouldMatchersForJUnit
import org.junit.Test
import org.junit.Before
import cpu.Decoder
import cpu.instruction.Opcode
import cpu.instruction.Operate
import cpu.instruction.Instruction
import scala.collection.immutable.HashSet
import cpu.DecodeException
import strage.IntegerRegister
import strage.Memory
import strage.Register
import scala.collection.immutable.HashMap
import strage.SequenceMemory
import usb.USB

class DecoderTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
    var testResult: String = ""
    class Opcode1 extends Opcode {
        def isValid(instruction: Instruction) = {(instruction.data(1) == 0)}
    	def parse(instruction: Instruction): Operate = new Operate {
    	        def apply(usb: USB, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
    	            testResult += s"Opcode1${instruction.data(0)}\n"
    	        }
    	    }
    }
    class Opcode2 extends Opcode {
    	def isValid(instruction: Instruction) = {(instruction.data(1) == 1)}
    	def parse(instruction: Instruction): Operate = new Operate {
    	        def apply(usb: USB, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
    	            testResult += "Opcode2\n"
    	        }
    	    }
    }
    var decoder: Decoder = _ 
    val pc = new IntegerRegister()
    val registers = HashMap[String, Register]()
    val memory = new SequenceMemory(0)
    val usb = new USB
    @Before def initialize() {
        decoder = new Decoder(HashSet(
                	new Opcode1, 
                	new Opcode2))
    }
    @Test def simpleTest() {
        testResult = ""
        decoder.decode(new Instruction(Array[Byte](0, 0)))(usb, pc, registers, memory)
    	decoder.decode(new Instruction(Array[Byte](0, 1)))(usb, pc, registers, memory)
    	decoder.decode(new Instruction(Array[Byte](3, 0)))(usb, pc, registers, memory)
    	decoder.decode(new Instruction(Array[Byte](3, 0)))(usb, pc, registers, memory)

    	testResult should be (s"""Opcode10
Opcode2
Opcode13
Opcode13
""")
    }
    @Test def throwTest() {
        intercept[DecodeException] {
            decoder.decode(new Instruction(Array[Byte](0, 3)))(usb, pc, registers, memory)
        }
    }
}

object DecoderTest {
	def func(a: Int) = 0
}