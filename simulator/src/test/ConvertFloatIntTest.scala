package test

import org.scalatest.junit.JUnitSuite
import org.scalatest.junit.ShouldMatchersForJUnit
import org.junit.Test
import org.junit.Before
import cpp.ConvertFloatInt

class ConvertFloatIntTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
 	@Test def convertToIntTest() {
 	    val a = 2.0f
 	    val b = ConvertFloatInt.convertToInt(a)
 	    b should be (0x40000000)
	}
 	@Test def convertToFloatTest() {
 	    val a = 0x40000000
 	    val b = ConvertFloatInt.convertToFloat(a)
 	    b should be (2.0f)
 	}
}

object ConvertFloatIntTest {
	def func(a:Int) = 0
}