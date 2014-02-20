all: testsimu disasm hoge

testsimu:
	 g++ -Wall -m32 -masm=intel -g -DNO_DPRINTF -o testsimu testsimu.cpp instR.cpp instI.cpp instJ.cpp instFP.cpp instOther.cpp x86emit.cpp MIPSinst.cpp tools.cpp fmul.cpp fsqrt_table.o finv_table.o

disasm:
	 g++ -Wall -g -o disasm disasm.cpp instR.cpp instI.cpp instJ.cpp instFP.cpp instOther.cpp x86emit.cpp MIPSinst.cpp tools.cpp

hoge:
	g++ -Wall -g -DNO_DPRINTF -o hoge hoge.cpp instR.cpp instI.cpp instJ.cpp instFP.cpp instOther.cpp x86emit.cpp MIPSinst.cpp tools.cpp

.PHONY: all testsimu disasm hoge
