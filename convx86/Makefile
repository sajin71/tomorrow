all:
	 g++ -Wall -m32 -g -DNO_DPRINTF -o testsimu testsimu.cpp instR.cpp instI.cpp instJ.cpp x86emit.cpp MIPSinst.cpp tools.cpp

disasm:
	 g++ -Wall -o disasm disasm.cpp instR.cpp instI.cpp instJ.cpp x86emit.cpp MIPSinst.cpp tools.cpp

.PHONY: all disasm
