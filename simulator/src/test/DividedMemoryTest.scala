package test

import org.scalatest.junit.JUnitSuite
import org.scalatest.junit.ShouldMatchersForJUnit
import org.junit.Test
import org.junit.Before
import strage.SequenceMemory
import strage.Memory
import strage.DividedMemory

class DividedMemoryTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
    var mem: Memory = _
	@Before def initialize() {
        mem = new DividedMemory((0L->10), (20L->10))
	}
    @Test def simpleTest() {
        mem(9) = 0x01
        mem(9) should be (0x01)
        mem(21) = 0x10
        mem(21) should be (0x10)
    }
    // 領域外参照させる
    @Test def segmentationFault(){
        mem(15) = 0
        intercept[NoSuchElementException](mem(15))
    }
    
}
object DividedMemoryTest {
	def func(a:Int) = 0
}