package test

import org.scalatest.junit.JUnitSuite
import org.scalatest.junit.ShouldMatchersForJUnit
import org.junit.Test
import org.junit.Before
import cpu.AbstractCPU
import cpu.instruction.Opcode
import cpu.instruction.Operate
import cpu.instruction.Instruction
import strage.SequenceMemory
import strage.Register
import strage.IntegerRegister
import scala.collection.immutable.HashMap
import scala.collection.immutable.HashSet
import scala.util.parsing.combinator.RegexParsers

class AbstractCPUTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
    val addr = 0x200
    
    var cpu: AbstractCPU = _
    @Before def initialize() {
        cpu = new TestCPU()
    }
    
    @Test def memontoTest() {
        val cpuMemonto = cpu.getState
        cpuMemonto.programCounter.mkString should be ("0000")
        cpuMemonto.registers.size should be (3)
        cpuMemonto.registers("r1").mkString should be ("0000")
        cpuMemonto.registers("r2").mkString should be ("0000")
        cpuMemonto.registers("r3").mkString should be ("0000")
        /** @todo メモリのテストは面倒なのでしていない。 */
    }
    @Test def simpleTestCase() {
        val data = Array[Byte](0x11,0x40, 0x12,0x30, 0x03, 0x12)//subst r1 <- 0x40;subst r2 <- 0x30; add r3 <- r1 + r2  
        cpu setExecutable data
        for(i <- 0 until data.length/2){
            cpu.stepExecute
        }
        val cpuMemonto = cpu.getState
        
        // bytes -> intへの変換
        val tmp = new IntegerRegister()
        tmp.data = addr + 2*3// 3命令実行->6byte進む
        cpuMemonto.programCounter.mkString should be (tmp.bytes.mkString)
        
        tmp.data = 0x40
        cpuMemonto.registers("r1").mkString should be (tmp.bytes.mkString)
        tmp.data = 0x30
        cpuMemonto.registers("r2").mkString should be (tmp.bytes.mkString)
        tmp.data = 0x70
        cpuMemonto.registers("r3").mkString should be (tmp.bytes.mkString)
    }
}

object AbstractCPUTest {
	def func(a: Int) = 0
}