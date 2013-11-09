all: testsimu disasm hoge

testsimu:
	 g++ -Wall -m32 -g -DNO_DPRINTF -o testsimu testsimu.cpp instR.cpp instI.cpp instJ.cpp x86emit.cpp MIPSinst.cpp tools.cpp

disasm:
	 g++ -Wall -o disasm disasm.cpp instR.cpp instI.cpp instJ.cpp x86emit.cpp MIPSinst.cpp tools.cpp

hoge:
	g++ -Wall -m32 -g -o hoge testsimu.cpp instR.cpp instI.cpp instJ.cpp x86emit.cpp MIPSinst.cpp tools.cpp

.PHONY: all testsimu disasm hoge
