package test

import org.scalatest.junit.JUnitSuite
import org.scalatest.junit.ShouldMatchersForJUnit
import org.junit.Test
import org.junit.Before
import strage.IntegerRegister

class Integer32bitRegisterTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
    var r1: IntegerRegister = _
	@Before def initialize() {
        r1 = new IntegerRegister
	}
	@Test def intDataTest() {
	    r1.data = 0x10000102
	    (r1.data) should be (0x10000102)
	}
	@Test def bytesTest() {
	    r1.data = 0x10000102
	    r1.bytes.mkString should be (Array[Byte](0x10, 0x00, 0x01, 0x02).mkString)
	    r1.bytes = Array[Byte](0,0,0,1)
	    r1.bytes.mkString should be (Array[Byte](0x00, 0x00, 0x00, 0x01).mkString)
	    
	    r1.bytes = Array[Byte](-1, -1, 0, -1)
	    r1.bytes.mkString should be (Array[Byte](-1, -1, 0, -1).mkString)
	}
}

object RegisterTest {
	def func(a: Int) = 0
}