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

class Jump extends JumpOpcode(0x02) {
    protected def apply(operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
        programCounter.data += operand.constant * 4//< mipsページの4[31:28]の意味がよくわからない。
    }
}
class JumpRegister extends ThreeRegisterOperandOpcode(0x0, 0x08) {
    protected def apply(operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
    	programCounter.data += (BigEndianInterpreter interpretAsSignedInteger operand.rs) * 4
    }
}
class Jal extends JumpOpcode(0x03) {
    protected def apply(operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
    	registers("r31").bytes = BigEndianInterpreter interpretAsByteArray (programCounter.data + 4)
    	programCounter.data += operand.constant * 4//< mipsページの4[31:28]の意味がよくわからない。
    }
}
class Beq extends ImmediateOperandOpcode(0x04) {
    protected def apply(operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
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
    protected def apply(operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory) = {
        val rs = BigEndianInterpreter interpretAsSignedInteger operand.rs.bytes
        val rt = BigEndianInterpreter interpretAsSignedInteger operand.rt.bytes
        if(rs != rt){
        	programCounter.data += operand.constant * 4 + 4
        }else{
        	programCounter.data += 4
        }
    }
}