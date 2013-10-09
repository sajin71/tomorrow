package cpu.instruction

/**
 * 返すOperateクラスについては、ProgramCounterの移動の責務もあるので注意すること。
 */
abstract class Opcode {
    def isValid(instruction: Instruction): Boolean
	def parse(instruction: Instruction): Operate
}