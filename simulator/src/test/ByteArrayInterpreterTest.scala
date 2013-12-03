package test

import org.scalatest.junit.JUnitSuite
import org.scalatest.junit.ShouldMatchersForJUnit
import org.junit.Test
import org.junit.Before
import strage._
import interpreter.BigEndianInterpreter

class BigEndianInterpreterTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
    @Test def integerTest() {
        val byteArray = Array[Byte](0x00, 0x00, 0x00, 0x10)//< 16
        (BigEndianInterpreter interpretAsSignedInteger byteArray) should be (16)
        val byteArray2 = Array[Byte](-1, -1)// 0xffff <- -1
        (BigEndianInterpreter interpretAsSignedInteger byteArray2) should be (-1)
    }
    @Test def unsignedIntegerTest(){
       val byteArray = Array[Byte](-1, -1, -1, -1)//< 0xffffffff
       (BigEndianInterpreter interpretAsUnsignedInteger byteArray) should be (0xffffffffL)
       val byteArray2 = Array[Byte](-1, -1)// 0xffff 
       (BigEndianInterpreter interpretAsUnsignedInteger byteArray2) should be (0xffffL)
     }
    @Test def floatTest() {
        val byteArray = Array[Byte](0x40, 0x00, 0x00, 0x00)//< 2.0f
        (BigEndianInterpreter interpretAsFloat byteArray) should be (2.0f)
    }
    @Test def interpretRegisterTest() {
    	val integerRegister = new IntegerRegister()
    	integerRegister.data = 0x40000000//< int 0x40000000, float 2.0f
    	
    	(BigEndianInterpreter interpretAsSignedInteger integerRegister) should be (0x40000000)
    	(BigEndianInterpreter interpretAsFloat integerRegister) should be (2.0f)
    }
}

object ByteArrayInterpreterTest {
	def func(a:Int) = 0
}
