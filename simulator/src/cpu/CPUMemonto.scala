package cpu

class CPUMemonto(val programCounter: Seq[Byte], val registers: Map[String, Seq[Byte]], val memory: Seq[Byte]) {
}