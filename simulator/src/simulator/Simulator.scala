package simulator

import cpu.AbstractCPU
import cpu.CPUMemonto
import java.io.FileInputStream

/**
 * @todo not teste
 */
class Simulator(cpu: AbstractCPU) {
	private def readExecutable(filePath: String) : Seq[Byte] = {
		val path = new java.io.File(filePath)
		val buf=new Array[Byte](path.length.asInstanceOf[Int])
		val io=new FileInputStream(path)
		io.read(buf)
		io.close()
		buf
	}
	def setExecutable(filePath: String): Unit = cpu setExecutable readExecutable(filePath)
	def getCPUState(): CPUMemonto = cpu getState
	def stepExecute(): Unit = cpu.stepExecute
}