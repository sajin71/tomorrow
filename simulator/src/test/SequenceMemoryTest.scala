package test

import org.scalatest.junit.JUnitSuite
import org.scalatest.junit.ShouldMatchersForJUnit
import org.junit.Test
import org.junit.Before
import strage.SequenceMemory
import strage.Memory

class SequenceMemoryTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
    var mem: Memory = _
	@Before def initialize() {
        mem = new SequenceMemory(100)
	}
    @Test def simpleTest() {
        mem(10) = 0x01
        mem(10) should be (0x01)
        mem.size should be (100)
    }
}
object SequenceMemoryTest {
	def func(a:Int) = 0
}