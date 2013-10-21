package extend_view

import usb.USBDataListener
import usb.Simulator
import cpu.AbstractCPU
import usb.USB

/**
 * 拡張MVCのForm(Controller + View)に当たる。
 * BCEのBoundaryにも当たる。
 * @todo このクラスはいるのか。mainで行う処理は本当にこれだけなのか
 * @todo SimpleSwingApplicationみたいなのの使用に辛くなるかも。
 * @todo not tested
 */
abstract class Form extends USBDataListener{
    protected val simulator: Simulator = new Simulator(makeCPU)
    protected var usb: USB = _
    
    def makeCPU(): AbstractCPU
    def getUSB(): USB = {
        if(usb == null){
            usb = new USB()
        }
        usb
    }
    def parseArgument(args: Array[String]): Unit
    def initializeInterface(): Unit
    def control(): Unit
    
    def main(args: Array[String]){
        getUSB().addUserEndListener(this);
        parseArgument(args)
        initializeInterface()
        control()
    }
}