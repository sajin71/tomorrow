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

class JumpTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
    var cpu: AbstractCPU = _
    @Before def initialize() {
        cpu = new Tomorrow(new USB)
    }
    @Test def jumpTest() {
    	val testCode = Array[Byte](0x08, 0x00, 0x00, 0x01,
    	        					0x20, 0x01, 0x00, 0x10, 
    	        				   0x0B, -1, -1, -1)//1011
    	        				   /*
    	        				    * jump 1 <- 1<<2=4先へ行く
    	        				    * addi r1 <- r0 + 0x10
    	        				    * jump -1 <- 先頭がやはり0
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x10)
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.programCounter) should be (8)
    }
    @Test def jumpRegisterTest() {
        val testCode = Array[Byte](0x20, 0x01, 0x00, 0x02, 
                				   0x00, 0x20, 0x00, 0x08,
    	        				   0x20, 0x01, 0x00, 0x10, 
    	        				   0x20, 0x01, 0x00, 0x20)
    	        				   /*
    	        				    * addi r1 <- r0 + 0x02
    	        				    * jr r1
    	        				    * addi r1 <- r0 + 0x10
    	        				    * addi r1 <- r0 + 0x20
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger(cpu.getState.registers("r1")) should be (0x20)
    }
    @Test def jalTest() {
        val testCode = Array[Byte](0x0C, 0x00, 0x00, 0x01)
        /*
         * jal 1//< programCounterは1<<2で4へ行く
         */
        cpu.setExecutable(testCode)
        val pc = BigEndianInterpreter interpretAsSignedInteger cpu.getState.programCounter
        cpu.stepExecute
        BigEndianInterpreter interpretAsSignedInteger(cpu.getState.registers("r31")) should be (pc + 4)
        BigEndianInterpreter interpretAsSignedInteger(cpu.getState.programCounter) should be (4)
    }
    @Test def beqTest() {
        val testCode = Array[Byte](0x20, 0x01, 0x00, 0x02,
                					0x10, 0x00, 0x00, 0x01, //0x04 -> 0001 00|00 000|0 0000| 0000 0000 0000 00001
                					0x00, 0x00, 0x00, 0x00,
                					0x10, 0x20, 0x00, 0x10, 
                					0x20, 0x01, 0x00, 0x04)
         /*
         * addi r1 <- r0 + 0x02
         * beq r0 r0 1
         * xxxx
         * beq r1 r0 0x10
         * addi r1 <- r0 + 0x04
         */
        cpu.setExecutable(testCode)
        cpu.stepExecute
        cpu.stepExecute
        cpu.stepExecute
        cpu.stepExecute
        cpu.stepExecute
        BigEndianInterpreter interpretAsSignedInteger(cpu.getState.registers("r1")) should be (0x04)
    }
    @Test def bneTest() {
        val testCode = Array[Byte](0x20, 0x01, 0x00, 0x02,
                					0x14, 0x00, 0x00, 0x01, //0x05 -> 0001 01|00 000|0 0000| 0000 0000 0000 00001
                					0x14, 0x20, 0x00, 0x10, 
                 					0x20, 0x01, 0x00, 0x04) 
        /*
         * addi r1 <- r0 + 0x02
         * bne r0 r0 1
         * bne r1 r0 0x10
         * addi r1 <- r0 + 0x04
         */
        cpu.setExecutable(testCode)
        cpu.stepExecute
        cpu.stepExecute
        cpu.stepExecute
        cpu.stepExecute
        BigEndianInterpreter interpretAsSignedInteger(cpu.getState.registers("r1")) should be (0x02)
    }
}

object JumpTest {
	def func(a:Int) = 0
}