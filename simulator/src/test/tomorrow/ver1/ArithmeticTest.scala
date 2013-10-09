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

class ArithmeticTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
    var cpu: AbstractCPU = _
    @Before def initialize() {
        cpu = new Tomorrow()
    }
    @Test def addTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x10, 
    	        				   0x00, 0x21, 0x10, 0x20)
    	        				   /*t
    	        				    * addi r1 <- r0 + 0x10
    	        				    * add r2 <- r1 + r1
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x10)
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r2")) should be (0x20)    	
    }
    @Test def subTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x10, 
    	        				   0x00, 0x20, 0x08, 0x22)
    	        				   /*
    	        				    * addi r1 <- r0 + 0x10
    	        				    * sub r1 <- r1 - r0
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x10)
    }
    @Test def mulTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x10, 
    	        					0x00, 0x21, 0x00, 0x18)
    	        				   /*
    	        				    * addi r1 <- r0 + 0x10
    	        				    * mul r1 * r1
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("HI")) should be (0x00)
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("LO")) should be (0x10*0x10)
    }
    @Test def divTest() {
        val testCode = Array[Byte](0x20, 0x01, 0x00, 0x10,
                					0x20, 0x02, 0x00, 0x03,
    	        					0x00, 0x22, 0x00, 0x1A)
    	        				   /*
    	        				    * addi r1 <- r0 + 0x10(16)
    	        				    * addi r2 <- r0 + 0x03 (3)
    	        				    * div r1/r2
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("HI")) should be (0x01)
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("LO")) should be (0x05)
    }
}

object ArithmeticTest {
	def func(a:Int) = 0
}