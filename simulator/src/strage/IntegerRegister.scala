package strage

import scala.collection.Seq
import cpp.ConvertFloatInt
import interpreter.BigEndianInterpreter

/**
 * Int型によってデータを保持するレジスタ
 * interpretIntegerの高速化のためのある。
 * @todo ByteArrayInterpreterへは依存するべきじゃない
 */
class IntegerRegister extends Register{
    var data: Int = 0
	def bytes: Seq[Byte] = {
        BigEndianInterpreter interpretAsByteArray (data)
	}
	def bytes_=(bytes: Seq[Byte]): Unit = {
        data = BigEndianInterpreter interpretAsSignedInteger (bytes)
	}
	def data_=(float: Float): Unit = {
	    bytes = BigEndianInterpreter.interpretAsByteArray(float)
	}
}