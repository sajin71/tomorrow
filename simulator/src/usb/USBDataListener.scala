package usb

/**
 * ・ Callbackを受け取る形になった際に必要な可能性大
 * ・ MVCにおけるControllerにあたるか?
 * ・ Controllerはviewとsimulatorの双方を持っていて、Viewからコールバックが来る -> Observerを作る。
 * ・ 多分、ModelへのCallbackとしてControllerとViewを作ればいいと思う。
 * 　これがModelから依存されていて、さらに継承したControllerとViewがModelへ依存する。
 * @todo 今は何もしない
 */
trait USBDataListener {
    def updateUSBData(data: Seq[Byte])
}