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
    private var data: Array[Byte] = new Array[Byte](size)

    class SequenceMemoryIterator(size: Int) extends Iterator[(Long, Byte)] {
        private var addr: Long = -1
        def hasNext = {
            (addr+1) < size
        }
        def next = {
            addr = addr + 1
            (addr-1 -> data((addr) toInt))
        }
    }
    
    def get(addr: Long): Option[Byte] ={
    	if(addr >= size) 
    	    None 
    	else 
    	    Some(data(addr toInt))  
    } 
    def iterator: Iterator[(Long, Byte)] = new SequenceMemoryIterator(size)
    def update(index: Long, elem: Byte) = {
        (data(index toInt) = elem)
    }
}