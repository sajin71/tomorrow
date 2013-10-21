package test.tomorrow.ver1

import org.scalatest.junit.JUnitSuite
import org.scalatest.junit.ShouldMatchersForJUnit
import org.junit.Test
import org.junit.Before
import cpu.AbstractCPU
import cpu.instruction.Opcode
import cpu.instruction.Operate
import cpu.instruction.Instruction
import tomorrow.ver1.arithmetic._
import tomorrow.ver1.Tomorrow
import interpreter.{BigEndianInterpreter => I}
import interpreter.BigEndianInterpreter
import usb.USB

class ShiftTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
    var cpu: AbstractCPU = _
    @Before def initialize() {
        cpu = new Tomorrow(new USB)
    }
    @Test def sllTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x10, 
    	        				   0x00, 0x21, 0x00, 0x40)
    	        				   /*
    	        				    * addi r1 <- r0 + 0x10
    	        				    * sll r1 <- r1 << 1
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x20)
    }
    @Test def srlTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x10, 
    	        				   0x00, 0x21, 0x00, 0x42)
    	        				   /*
    	        				    * addi r1 <- r0 + 0x10
    	        				    * srl r1 <- r1 >> 1
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x08)
    }
    @Test def sraTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x10, 
    	        				   0x00, 0x21, 0x00, 0x42)
    	        				   /*
    	        				    * addi r1 <- r0 + 0x10
    	        				    * sra r1 <- r1 >>> 1
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x08)
    }
}

object ShiftTest {
	def func(a: Int) = 0
}