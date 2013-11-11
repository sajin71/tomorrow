package usb

import scala.collection.mutable.Queue

class USB {
	private var user = List[USBDataListener]()
	private var cpu = List[USBDataListener]()
	private var queue = Queue[Seq[Byte]]()
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
	    queue.enqueue(data);
	    cpu foreach (_.updateUSBData(data))
	}
	/**
	 * でっち上げの産物。最近のデータを受け取る
	 */
	def getLatestDataToCPU(): Seq[Byte] = {
	    this.queue.dequeue;
	}
}