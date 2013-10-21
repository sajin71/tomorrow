package usb

class USB {
	private var user = List[USBDataListener]()
	private var cpu = List[USBDataListener]()
	def addUserEndListener(listener: USBDataListener) {
	    user = listener::user;
	}
	def addCPUEndListener(listener: USBDataListener) {
	    cpu = listener::cpu;
	}
	def sendToUser(data: Seq[Byte]){
	    user foreach (_.updateUSBData(data))
	}
	def sendToCPU(data: Seq[Byte]){
	    cpu foreach (_.updateUSBData(data))
	}
}