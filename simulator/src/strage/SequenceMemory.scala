package strage

import scala.collection.Iterator
import scala.collection.immutable.LongMap
import scala.collection.immutable.MapLike
import scala.collection.immutable.LongMapUtils
import scala.collection.immutable.HashMap
import scala.collection.mutable.ArrayLike

/**
 * 一続きのメモリ領域をあらわすメモリ
 */
class SequenceMemory(size: Int) extends Memory{
    private var data: Array[Int] = new Array[Int](size/4)

    class SequenceMemoryIterator(size: Int) extends Iterator[(Long, Byte)] {
        private var addr: Long = 0
        private var byte: Int = 0
        def hasNext = {
            (addr*4+byte) < size
        }
        def next = {
            byte += 1
            if(byte == 4){
                addr = addr + 1
                byte = 0
            }
            // @todo うそ臭い
            (addr*4+byte -> (data((addr) toInt) >> (byte*8) toByte))
        }
    }
	override def size(): Int = size

    def get(addr: Long): Option[Byte] ={
    	if(addr >= size) 
    	    None 
    	else 
    	    Some((data(addr toInt) & 0xff) toByte)  
    } 
    def iterator: Iterator[(Long, Byte)] = new SequenceMemoryIterator(size)
    def update(index: Long, elem: Byte) = {
        (data(index toInt) = elem)
    }
    
    def updateMemory(addr: Long, _data: Int): Unit = {
        data(addr/4 toInt) = _data
        
    }
    def updateMemory(addr: Long): Int = data(addr/4 toInt)

}