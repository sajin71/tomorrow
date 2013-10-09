package cpu

import org.omg.CORBA.UserException
import cpu.instruction.Instruction

class DecodeException(instruction: Instruction) extends UserException(
s"""cannot decode instruction: ${instruction.data foreach ((byte: Byte)=>println(byte + " "))}"""
) {
}