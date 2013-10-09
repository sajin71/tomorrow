package strage

/**
 * CPU上で一連の領域となっているメモリをあらわすクラス
 * メモリは、mutableな、address(:Long)からdata(:Byte)への写像として表される。
 * @todo +, -メソッドのオーバーライドはあっていいものなのか？
 */
trait Memory extends Map[Long, Byte]{
    def update(addr: Long, data: Byte): Unit
    
    def + [B1 >: Byte](kv: (Long, B1)) = this
    def -(key: Long) = this
}