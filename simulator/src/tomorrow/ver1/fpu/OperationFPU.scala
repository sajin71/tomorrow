package tomorrow.ver1.fpu

import strage.IntegerRegister
import usb.USB
import scala.collection.immutable.Map
import tomorrow.ver1.ThreeOperandOpcodeFPU
import cpu.instruction.Instruction
import cpu.instruction.Operate
import strage.IntegerRegister
import strage.Memory
import strage.Register
import interpreter.{BigEndianInterpreter=>I}
import java.util.logging.Logger
import java.util.logging.Level
import interpreter.BigEndianInterpreter
import usb.USB

class AddS extends ThreeOperandOpcodeFPU(0x00, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val fs = I.interpretAsFloat(operand.fs)
        val ft = I.interpretAsFloat(operand.ft)
        operand.fd.bytes = I.interpretAsByteArray(fs + ft)         
    }
}
class SubS extends ThreeOperandOpcodeFPU(0x01, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val fs = I.interpretAsFloat(operand.fs)
        val ft = I.interpretAsFloat(operand.ft)
        operand.fd.bytes = I.interpretAsByteArray(fs - ft)         
    }
}
class MulS extends ThreeOperandOpcodeFPU(0x02, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val fs = I.interpretAsFloat(operand.fs)
        val ft = I.interpretAsFloat(operand.ft)
        operand.fd.bytes = I.interpretAsByteArray(fs * ft)         
    }
}
class DivS extends ThreeOperandOpcodeFPU(0x03, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val fs = I.interpretAsFloat(operand.fs)
        val ft = I.interpretAsFloat(operand.ft)
        operand.fd.bytes = I.interpretAsByteArray(fs / ft)         
    }
}
class SqrtS extends ThreeOperandOpcodeFPU(0x04, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val ft = I.interpretAsFloat(operand.ft)
        operand.fd.bytes = I.interpretAsByteArray(Math.sqrt(ft).toFloat)         
    }
}
class AbsS extends ThreeOperandOpcodeFPU(0x05, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val fs = I.interpretAsFloat(operand.fs)
        operand.fd.bytes = I.interpretAsByteArray(Math.abs(fs).toFloat)         
    }
}
class MovS extends ThreeOperandOpcodeFPU(0x05, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
    	operand.fd.bytes = operand.fs.bytes
    }
}
class NegS extends ThreeOperandOpcodeFPU(0x06, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val fs = I.interpretAsFloat(operand.fs)
    	operand.fd.bytes = I interpretAsByteArray(-fs)
    }
}
class RecipS extends ThreeOperandOpcodeFPU(0x15, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val fs = I.interpretAsFloat(operand.fs)
    	operand.fd.bytes = I interpretAsByteArray((1/fs) toFloat)
    }
}

class FloorW extends ThreeOperandOpcodeFPU(0x0f, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val fs = I.interpretAsFloat(operand.fs)
        operand.fd.bytes = I.interpretAsByteArray(fs toInt)
    }
}

class RoundW extends ThreeOperandOpcodeFPU(0x0c, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val fs = I.interpretAsFloat(operand.fs)
        if(fs < fs.toInt + 0.5){
        	operand.fd.bytes = I.interpretAsByteArray((fs) toInt)
        }else if(fs > fs.toInt + 0.5){
        	operand.fd.bytes = I.interpretAsByteArray(((fs) toInt)+1)//< 0.5を足して
        }else{
            // fs == fs.5の場合 => 最近偶数丸め
            if(fs.toInt % 2 == 0){
                operand.fd.bytes = I.interpretAsByteArray((fs) toInt)
            }else{
                operand.fd.bytes = I.interpretAsByteArray(((fs) toInt)+1)
            }
        }
    }
}


class CEqS extends ThreeOperandOpcodeFPU(0x32, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val ft = I.interpretAsFloat(operand.ft)
        val fs = I.interpretAsFloat(operand.fs)
        val fd = I.interpretAsUnsignedInteger(operand.fd)
        if(ft == fs){
            if(fd == 0){
                registers("FCSR").bytes = I.interpretAsByteArray(I.interpretAsUnsignedInteger(registers("FCSR").bytes) | 0x00400000) //00000000 01000000 00000000 00000000
            }else{
            	registers("FCSR").bytes = I.interpretAsByteArray(I.interpretAsUnsignedInteger(registers("FCSR").bytes) | 0x1 << (24+fd))
            }
        }else{
            if(fd == 0){
                var tmp = registers("FCSR").bytes
                var tmp2 = tmp(1) & 0xBF
                registers("FCSR").bytes = Array[Byte](tmp(0), tmp2.toByte, tmp(2), tmp(3))
            }else{
                var tmp = registers("FCSR").bytes
                var tmp2 = tmp(0) & (0xff-0x1<< fd)// fd=1の時、0xff-0x02 = 11111101となり,&をとって、2bit目(23+2bit)のみを下ろせる
                registers("FCSR").bytes = Array[Byte](tmp2.toByte, tmp(1), tmp(2), tmp(3))
            }
            
        }
    }
}

class COltS extends ThreeOperandOpcodeFPU(0x34, 0x10) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val ft = I.interpretAsFloat(operand.ft)
        val fs = I.interpretAsFloat(operand.fs)
        val fd = I.interpretAsUnsignedInteger(operand.fd)
        if(ft < fs){
            if(fd == 0){
                registers("FCSR").bytes = I.interpretAsByteArray(I.interpretAsUnsignedInteger(registers("FCSR").bytes) | 0x00400000) //00000000 01000000 00000000 00000000
            }else{
            	registers("FCSR").bytes = I.interpretAsByteArray(I.interpretAsUnsignedInteger(registers("FCSR").bytes) | 0x1 << (24+fd))
            }
        }else{
            if(fd == 0){
                var tmp = registers("FCSR").bytes
                var tmp2 = tmp(1) & 0xBF
                registers("FCSR").bytes = Array[Byte](tmp(0), tmp2.toByte, tmp(2), tmp(3))
            }else{
                var tmp = registers("FCSR").bytes
                var tmp2 = tmp(0) & (0xff-0x1<< fd)// fd=1の時、0xff-0x02 = 11111101となり,&をとって、2bit目(23+2bit)のみを下ろせる
                registers("FCSR").bytes = Array[Byte](tmp2.toByte, tmp(1), tmp(2), tmp(3))
            }
            
        }
    }
}
class CvtS extends ThreeOperandOpcodeFPU(0x20, 0x24) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
        val ft = I.interpretAsSignedInteger(operand.ft)
        operand.fd.bytes = I.interpretAsByteArray(ft toFloat)         
    }
}
