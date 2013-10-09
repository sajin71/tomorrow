package cpu

import cpu.instruction.Opcode
import cpu.instruction.Instruction
import cpu.instruction.Operate
import scala.collection.mutable.HashMap

/**
 * @todo Operateのあらわす関数が、内部状態を変更しないことが必要となっている。
 */
class Decoder(instructionSet: Set[Opcode]) {
    var instructionPool : HashMap[Instruction, Operate] = HashMap()
	def decode(instruction: Instruction): Operate = {
        if(instructionPool contains instruction){
            return instructionPool(instruction)
        }
        
		for(opcode <- instructionSet){
			if(opcode isValid instruction){
			    val operate = opcode parse instruction
				instructionPool += (instruction->operate)
			    return operate
			}
		}

	    throw new DecodeException(instruction)
	}
}