package tomorrow.ver1.fpu

import cpu.instruction.Opcode
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
import tomorrow.ver1.ImmediateOpcodeFPU
import tomorrow.ver1.BranchFPUOpcode

class BCF extends BranchFPUOpcode(0x08, false) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
    	if(!operand.cc){
    		var offset = (if((operand.offset & 0x80) != 0){1}else{0}) << (32-16-2) + (operand.offset << 2);
    	    programCounter.data += offset
    	}else{
    	    programCounter.data += 4
    	}
    }
}
class BCT extends BranchFPUOpcode(0x08, false) {
    protected def apply(usb: USB, operand: Operand, programCounter: IntegerRegister, registers: Map[String, Register], memory: Memory){
    	if(operand.cc){
    		var offset = (if((operand.offset & 0x80) != 0){1}else{0}) << (32-16-2) + (operand.offset << 2);
    	    programCounter.data += offset
    	}else{
    	    programCounter.data += 4
    	}
    }
}