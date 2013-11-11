package tomorrow.ver1.jump

import cpu.instruction.Opcode
import cpu.instruction.Instruction
import cpu.instruction.Operate
import strage.IntegerRegister
import strage.Memory
import strage.Register
import interpreter.{BigEndianInterpreter=>I}
import tomorrow.ver1.ImmediateOperandOpcode
import tomorrow.ver1.ThreeRegisterOperandOpcode
import tomorrow.ver1.JumpOpcode
import tomorrow.ver1.ThreeRegisterOperandOpcode
import tomorrow.ver1.ImmediateOperandOpcode
import interpreter.BigEndianInterpreter
import usb.USB

class Jump extends JumpOpcode(0x02) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
        programCounter.data = ((programCounter.data toLong) & (0xf00000000L)).toInt
        programCounter.data += operand.constant << 2
    }
}
class JumpRegister extends ThreeRegisterOperandOpcode(0x1b, 0x00) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
    	programCounter.data = (BigEndianInterpreter interpretAsSignedInteger operand.rs) * 4
    }
}
class Jal extends JumpOpcode(0x03) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
    	registers("r31").bytes = BigEndianInterpreter interpretAsByteArray (programCounter.data + 4)
    	programCounter.data = ((programCounter.data toLong) & (0xf00000000L)).toInt
        programCounter.data += operand.constant << 2
    }
}
class Beq extends ImmediateOperandOpcode(0x04) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
        val rs = BigEndianInterpreter interpretAsSignedInteger operand.rs.bytes
        val rt = BigEndianInterpreter interpretAsSignedInteger operand.rt.bytes
        if(rs == rt){
        	programCounter.data += operand.constant * 4 + 4
        }else{
        	programCounter.data += 4
        }
    }
}
class Bne extends ImmediateOperandOpcode(0x05) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
        val rs = BigEndianInterpreter interpretAsSignedInteger operand.rs.bytes
        val rt = BigEndianInterpreter interpretAsSignedInteger operand.rt.bytes
        if(rs != rt){
        	programCounter.data += operand.constant * 4 + 4
        }else{
        	programCounter.data += 4
        }
    }
}