package strage

/**
 * 一連のメモリ領域として扱えるが、実際には複数のメモリ領域に分離されているもの
 * 
 * validAreaの各要素(begin, memory)に対し、[begin, begin + memory.length)の領域をmemoryにマッピングする。this(begin)がmemory(0)にマッピングされる。
 * @todo 領域が被っている時の問題について全く何もしていない
 */
class DividedMemory(validArea: Seq[(Long, Memory)]) extends Memory{
	private class DividedMemoryIterator extends Iterator[(Long, Byte)] {
	    private var areaIndex: Int = 0
		private var addr: Long = -1
		private var virtualAddr: Long = -1
        def hasNext = (addr+1) < validArea.last._1 + (validArea.last._2 size)
        def next = {
			addr = addr + 1
			
			if(addr >= (validArea(areaIndex)._2 size)){
			    addr = 0
			    areaIndex += 1
			}
			
			(validArea(areaIndex)._1 + addr -> validArea(areaIndex)._2(addr - 1))
        }
    }
	
	// areaを単純にに分割する
	def this(area1: (Long, Int), area2: (Long, Int)) = {
	    this(Array((area1._1->new SequenceMemory(area1._2)), (area2._1->new SequenceMemory(area2._2))))
	}
	
    def update(addr: Long, data: Byte): Unit = {
        for(area <- validArea) {
            if(area._1 <= addr && addr < area._1 + area._2.size){
                area._2(addr - area._1) = data
            }
        }
    }
    def updateMemory(addr: Long, data: Int): Unit = {
        for(area <- validArea) {
            if(area._1 <= addr && addr < area._1 + area._2.size){
                area._2.updateMemory(addr - area._1, data)
            }
        }
    }
    def updateMemory(addr: Long): Int = {
        for(area <- validArea) {
            if(area._1 <= addr && addr < area._1 + area._2.size){
                return area._2.updateMemory(addr - area._1)
            }
        }
        return 0
    }
    
    def get(addr: Long): Option[Byte] = {
        for(area <- validArea) {
            if(area._1 <= addr && addr < area._1 + area._2.size){
                return area._2.get(addr - area._1)
            }
        }
        None
    } 
    def iterator: Iterator[(Long, Byte)] = new DividedMemoryIterator()
}