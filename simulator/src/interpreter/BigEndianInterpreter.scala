package interpreter

import cpp.ConvertFloatInt
import scala.collection.mutable.HashMap
import strage.Register
import strage.IntegerRegister

/**
 * BigEndianで実装する。
 * バイト列の解釈器。
 * 
 * n byteのデータを、
- unsigned int
- int
- floating point number
 * に変換する関数を用意する。また、高速化のためにレジスタを直接解釈する関数も作る。
 * 
 * レジスタはn byteの情報を保持するオブジェクトであり、それがIntegerの情報もFloatの情報も全て解釈次第であるというモデルをとっている。
 *   
 * @todo コンパイル時の追加機能により、bytesのサイズ、Registerの種類等を制限するべきだししたい。
 * @todo 32bitレジスタを使ってDoubleへ変換、8bitのメモリからFloatへ変換等の場合は例外を投げるようにしていない。
 * @todo Double, Char, Byte...への変換メソッドも作るべきだろうとは思う。
 */
object BigEndianInterpreter extends ByteArrayInterpreter{
	/**
     * (Signed)ByteとUnsignedByteの変換のための関数群
     * @todo AnyValを継承したいが、内部クラスのため出来なかった。
     */
	private implicit class UnsignedByte(val b: Byte) {
	    def toUnsigned: Int = {
			val signBit = if((b signum) == -1) 1 else 0
			(b + (signBit * 256))
	    }
	}
    private var signedIntegerPool: HashMap[Seq[Byte], Int] = HashMap()
    private var floatPool: HashMap[Seq[Byte], Float] = HashMap()
    
    def interpretAsSignedInteger(bytes: Seq[Byte]): Int = {
        if(signedIntegerPool contains bytes){
            signedIntegerPool(bytes)
        }else{
        	var tmp: Int = 0
        	if(bytes(0) < 0) {tmp = 0xffffffff}

        	for(byte <- bytes) {
        		tmp <<= 8
        		tmp += (byte toUnsigned)
        	}
	    	signedIntegerPool += (bytes->tmp)
	        tmp
        }
    }
    @deprecated def interpretAsSignedInteger(register: Register): Int = {
        register match {
            case int:IntegerRegister => int.data
            case _ => interpretAsSignedInteger(register.bytes)
        }
    }
    def interpretAsFloat(bytes: Seq[Byte]): Float = {
        if(floatPool contains bytes){
            floatPool(bytes)
        }else{
        	val int = interpretAsSignedInteger(bytes)
        	val float = ConvertFloatInt.convertToFloat(int)
        	floatPool += (bytes->float)
        	float
        }
    }
    @deprecated def interpretAsFloat(register: Register): Float = {
        register match {
            case _ => interpretAsFloat(register.bytes)
        }
    }
    /**
     * @todo not tested
     */
    def interpretAsByteArray(integer: Int): Seq[Byte] = {
        var list = new Array[Byte](4)
        var byte = integer
	   	for(i <- 3 to 0 by -1) {
	   	    list(i) = byte.toByte
	   	    byte >>= 8
	   	}
	   	list
    }
    def interpretAsByteArray(float: Float): Seq[Byte] = {
    	interpretAsByteArray(ConvertFloatInt.convertToInt(float))
    }
}