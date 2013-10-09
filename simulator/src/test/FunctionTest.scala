package test


import org.scalatest.junit.JUnitSuite
import org.scalatest.junit.ShouldMatchersForJUnit
import org.junit.Test
import org.junit.Before
import scala.collection.immutable.HashMap
import scala.collection.immutable.BitSet

class FunctionTestSuite extends JUnitSuite with ShouldMatchersForJUnit {
    abstract class Tree
    case class Leaf(str:String)
    case class Node(l:Tree, r:Tree)
    @Test def mapTest(){
        var map = HashMap[String, Tree]()
        val map2 = HashMap[String, Node]()
        printf("%08x %08x\n", Int.MaxValue, 0xffffffff)
        printf("%08x %08x\n", (0x08000000 << 4) , 0x01000000)
        printf("%d       \n", (0x08000000 << 4));
        
        printf("%d\n", (((0xff << 8) + 0xff << 8) + 0xff) << 8)
        
        
        
        val r = """(.*)(\d+)""".r
        "r1" match {
            case r(s, d) => println(d)
            case _ => print("r1")
        }
    }
}

object FunctionTest {
	def func(a:Int) = 0
}