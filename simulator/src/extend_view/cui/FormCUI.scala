package extend_view.cui


import extend_view.Form
import usb.Simulator
import cpu.AbstractCPU
import scala.util.parsing.combinator.RegexParsers
import scala.util.control.Breaks
import java.io.IOException
import scala.collection.immutable.ListMap
import java.io.File

/**
 * CUIで動作させるインターフェース
 */
abstract class FormCUI extends Form {
    val prefix = "simulator $ "
        
    def updateUSBData(data: Seq[Byte]) = {
        data foreach ((byte:Byte) => Console.out.print("%02x ".format(byte)))
        Console.out.println()
    }
        
    def parseArgument(args: Array[String]): Unit = {
        if(args.length == 1){
            this.simulator setExecutable args(0)
        }else if(args.length == 2){
            this.simulator setExecutable args(0)

            // 文字列をusbに格納
            val sendString = (scala.io.Source.fromFile(args(1)).getLines()).toList
	    	var arr = new Array[Byte](4)
	    	var i = 0;
	    	for(str <- sendString){
	    	    for(c <- str){
	    	    	arr(i) = c.toByte
	    	    	i = (i+1)%4
	    	    	if(i == 0){
	    	    		usb.sendToCPU(arr)
	    	    	}
	    	    }
	    	}
	    	
	    	// 実行
		try{
		    while(true){
	    	        simulator stepExecute;
	    	    }
                }catch {
		    case _ => {
		      Console.out.println("halt")
  exit
}

                }   
        }
    }
    def initializeInterface(): Unit = {}
    def control(): Unit = {
    	val mybreaks = new Breaks
    	import mybreaks.{break, breakable}
    	
        breakable {
        	while(true){
        		Console.out.print(prefix)
        		try{
        			if(!CommandParser(Console.readLine)) break()
        		}catch {
                	case e: RuntimeException => Console.err.println(e.getMessage())
                	case e: IOException => Console.err.println(e.getMessage())
        		}
        	}
        }
    }

    /** コマンドをパースする。
     */
	object CommandParser extends RegexParsers {
	    def string = """.*""".r
	    def positive = """\d*""".r ^^ {_.toInt}
	    def helpCommand = "help" ^^ ((str:String) => {Console.out.print(
s"""usage: simulator [<file path>]
commands are:
	help                          Show help
	load/l <file path>            Load file and set executable to CPU
	run/r <instruction num>       Execute <instruction num> instruction
	step/s                        Step execute
    input/i <data(ASCII)>         Send <data> to CPU with USB(data length must be multiples of 4)
	print/p register              Show all register data
	print/p memory <begin> <end>  Show memory data in <begin>...<end>
	end                           End simulator
""")
			true
	    })
	    def loadCommand = ("load" | "l") ~ string ^^ (result => {
	        val filePath = result._2
	        simulator setExecutable filePath
	        true
	    })
	    def runCommand = ("run" | "r") ~ positive ^^ (result => {
	    	val instructionNum = result._2
	    	for(i <- 0 until instructionNum){
	    		simulator stepExecute
	    	}
	    	true
	    })
	    def stepCommand = ("step" | "s") ^^ (result => {
	        simulator.stepExecute()
	    	true
	    })
	    def inputCommand = ("input" | "i") ~ string ^^ (result => {
	    	val sendString = result._2
	    	var arr = new Array[Byte](4)
	    	var i = 0;
	    	for(c <- sendString){
	    	    arr(i) = c.toByte
	    	    i = (i+1)%4
	    	    if(i == 0){
	    	        usb.sendToCPU(arr)
	    	    }
	    	}
	    	true
	    })
	    def printRegister = ("print" | "p") ~ "register" ^^ (result => {
	    	val memonto = simulator.getCPUState()
	    	print("pc:\t")
	    	for(byte <- memonto.programCounter) {
	    		printf("%02x", byte)
	    	}
	    	println()
	    	var isLeft = true
	    	memonto.registers.keys.toList.sortWith((l, r)/*アルファベット + 数字->まず、文字部分の比較 -> 数字同士の比較、最後が数字でない->常にそちらが上*/ 
	    	        => {val reg = """([a-zA-Z])(\d+)""".r
	    	        	l match {
	    	        	    case reg(ls, ld) => r match {
	    	        	        case reg(rs, rd) => if(ls < rs) true else ((ld toInt) < (rd toInt))
	    	        	        case _ => false
	    	        	    }
	    	        	    case _ => reg match {
	    	        	        case reg(rs, rd) => true
	    	        	        case _ => l < r
	    	        	    }
	    	        	}
	    	        }) foreach ((key) => {
	    	    if(!isLeft) print("\t")
	    	    print(s"${key}:\t")
	    	    for(byte <- memonto.registers(key)) {
	    	        printf("%02x", byte)
	    	    }
	    	    if(isLeft) print("\t")
	    	    else println()
	    	    isLeft = !isLeft
	    	    
	    	})
	    	if(!isLeft) println()
	    	true
	    })
	    def printMemory = ("print" | "p") ~ "memory" ~ positive ~ positive ^^ (result => {
	    	val begin = result._1._2
	    	val end = result._2
	    	val memonto = simulator.getCPUState();
	    	var state = 0//< word単位のどこを示しているか
	    	for(i <- begin to end){
	    	    printf("%02x", memonto.memory(i));//< 1byteは16進数で2文字
	    	    if(state == 3){
	    	        println()
	    	    }
	    	    state += 1
	    	    state %= 4
	    	}
	    	if(state != 0) println
	    	true
	    })
	    def endCommand = "end" ^^ (result => false)
	    def emptyLine = "" ^^ ((result) => true)
	    def command =  helpCommand | loadCommand | runCommand | stepCommand | inputCommand | printRegister | printMemory | endCommand | emptyLine 
	    def apply(input: String): Boolean = parseAll(command, input) match {
			case Success(result, _) => result
			case failure : NoSuccess => scala.sys.error(failure.msg)
		}
	}
}
