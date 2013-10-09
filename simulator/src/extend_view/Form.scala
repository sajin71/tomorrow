package extend_view

import simulator.SimulatorObserver
import simulator.Simulator
import cpu.AbstractCPU

/**
 * 拡張MVCのForm(Controller + View)に当たる。
 * @todo このクラスはいるのか。mainで行う処理は本当にこれだけなのか
 * @todo SimpleSwingApplicationみたいなのの使用に辛くなるかも。
 * @todo not tested
 */
abstract class Form extends SimulatorObserver{
    protected val simulator: Simulator = new Simulator(makeCPU)

    def makeCPU(): AbstractCPU
    def parseArgument(args: Array[String]): Unit
    def initializeInterface(): Unit
    def control(): Unit
    
    def main(args: Array[String]){
        parseArgument(args)
        initializeInterface()
        control()
    }
}