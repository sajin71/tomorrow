package cpp

import com.sun.jna._ 
import java.lang.Integer

object ConvertFloatInt {
    val lib = NativeLibrary.getInstance("src/cpp/libconvert_float_int.so")
    val convertToIntFunc = lib.getFunction("convertToInt")
    val convertToFloatFunc = lib.getFunction("convertToFloat")
    val convertToIntFromByteFunc = lib.getFunction("convertToIntFromByte")
	def convertToInt(data: Float) = {
	    convertToIntFunc.invoke(Class.forName("java.lang.Integer"), Array(new java.lang.Float(data))) match {
	        case integer: java.lang.Integer => integer
	    }
	}

	def convertToFloat(data: Int) = {
	    convertToFloatFunc.invoke(Class.forName("java.lang.Float"), Array(new java.lang.Integer(data))) match {
	        case float: java.lang.Float => float
	    }
	}
}