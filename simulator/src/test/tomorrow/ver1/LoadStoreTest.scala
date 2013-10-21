package test.tomorrow.ver1

import org.scalatest.junit.JUnitSuite
import org.scalatest.junit.ShouldMatchersForJUnit
import org.junit.Test
import org.junit.Before
import strage.IntegerRegister
import cpu.AbstractCPU
import tomorrow.ver1.Tomorrow
import interpreter.{BigEndianInterpreter=>I}
import interpreter.BigEndianInterpreter
import usb.USB

class LoadStoreTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
	var cpu: AbstractCPU = _
    @Before def initialize() {
        cpu = new Tomorrow(new USB)
    }
    @Test def storeLoadTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x10, 
    	        				   0xAC toByte, 0x01, 0x00, 0x10,//1010 11|00 000|0 0001| 0000 0000 0x10 
    	        				   0x8C toByte, 0x21, 0x00, 0x00)//1000 11|00 001|0 0001| 0000 0000 0000 0000 
    	        				   /*
    	        				    * addi r1 <- r0 + 0x10
    	        				    * sw Memory[r0+0x10] <- r1 : sw r0 r1 0x10 
    	        				    * ld r1 <- Memory[r1+0] : lw r1 r1 0x10
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x10)
    }
    @Test def floatTest() {
    	val testCode = Array[Byte](0x20, 0x01, 0x00, 0x10, 
    	        					0x00, 0x21, 0x00, 0x18,
    	        					0x00, 0x00, 0x08, 0x10,
    	        					0x00, 0x00, 0x10, 0x12)
    	        				   /*
    	        				    * addi r1 <- r0 + 0x10
    	        				    * mul r1 * r1
    	        				    * mfhi 0 0 r1
    	        				    * mhlo 0 0 r2
    	        				    */
    	cpu.setExecutable(testCode)
    	cpu.stepExecute
    	cpu.stepExecute
    	cpu.stepExecute
    	cpu.stepExecute
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r1")) should be (0x00)
    	BigEndianInterpreter interpretAsSignedInteger (cpu.getState.registers("r2")) should be (0x10*0x10)
    }
}

object LoadStoreTest {
	def func(a: Int) = 0
}