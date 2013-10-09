package interpreter

import strage.Register

trait ByteArrayInterpreter {
    def interpretAsSignedInteger(bytes: Seq[Byte]): Int 
    @deprecated def interpretAsSignedInteger(register: Register): Int
    def interpretAsFloat(bytes: Seq[Byte]): Float 
    @deprecated def interpretAsFloat(register: Register): Float
    def interpretAsByteArray(integer: Int): Seq[Byte] 
    def interpretAsByteArray(float: Float): Seq[Byte] 
}