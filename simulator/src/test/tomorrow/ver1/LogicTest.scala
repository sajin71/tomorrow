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

class LogicTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
    var cpu: AbstractCPU = _
    @Before def initialize() {
        cpu = new Tomorrow(new USB)
    }
    @Test def andTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x10,
    	        					0x00, 0x20, 0x08, 0x24)
    	        				   /*
    	        				    * addi r1 <- r0 + 0x10
    	        				    * and r1 <- r1 & r0
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x00)
    }
    @Test def andiTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x11,
    								0x30, 0x21, 0x10, 0x10)//0C -> 0011 00|00 001|0 0001| 
    	        				   /*
    	        				    * addi r1 <- r0 + 0x11
    	        				    * andi r1 <- r1 & 0x1010
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x10)
    }
    @Test def orTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x11,
    								0x00, 0x20, 0x08, 0x25) 
    	        				   /*
    	        				    * addi r1 <- r0 + 0x11
    	        				    * or r1 <- r1 | r0
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x11)
    }
    @Test def oriTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x11,
    								0x34, 0x21, 0x10, 0x10)
    	        				   /*
    	        				    * addi r1 <- r0 + 0x11
    	        				    * ori r1 <- r1 | 0x1010
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x1011)
    }
    @Test def xorTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x11,
    								0x00, 0x20, 0x08, 0x26) 
    	        				   /*
    	        				    * addi r1 <- r0 + 0x11
    	        				    * xor r1 <- r1 | r0
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x0011)
    }
    @Test def norTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x11,
    								0x00, 0x20, 0x08, 0x27) 
    	        				   /*
    	        				    * addi r1 <- r0 + 0x11
    	        				    * nor r1 <- r1 | r0
    	        				    * 
    	        				    * 
    	        				    * or r1 | r0 => 0x11
    	        				    * not 0x00000011 -> 0x11111100
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0xffffffee)
    }
}
    
object LogicTest {
	def func(a:Int) = 0
}