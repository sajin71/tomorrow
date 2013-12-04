min-min.ml: min-header.ml min-rt.ml
	cat min-header.ml min-rt.ml > min-min.ml

min-min.s: min-min.ml
	../../compiler/min-caml min-min

a.bin: min-min.s
	cat min-min.s ../../compiler/Tomorrow/libmincaml.S | ../../asm/asm - a.bin debug_abin.txt

dest.ppm: a.bin
	../../convx86/testsimu a.bin < contest.sld > dest.ppm

pdest.png: dest.ppm
	convert dest.ppm pdest.png

hoge.txt: a.bin
	../../convx86/hoge < a.bin > hoge.txt


86dest.ppm: min-rt
	./min-rt < contest.sld > 86dest.ppm


OCOPT = -ccopt -O2
OCAMLC= ocamlc
OCAMLOPT= ocamlopt

.SUFFIXES: .ml .mli .cmo .cmi .cmx

.ml.cmo:
	$(OCAMLC) -g -c -nopervasives -pp ./preprocess.sh $<

.ml.cmx:
	$(OCAMLOPT) -c $(OCOPT) -nopervasives -pp ./preprocess.sh $<

.mli.cmi:
	$(OCAMLC) -g -c -nopervasives $<

min-rt.cmx: globals.cmx miniMLRuntime.cmx
min-rt.cmo: globals.cmo miniMLRuntime.cmi
globals.cmx: miniMLRuntime.cmx
globals.cmo: miniMLRuntime.cmi

min-rt_b: min-rt.cmo globals.cmo miniMLRuntime.cmo
	$(OCAMLC) -g -o min-rt_b miniMLRuntime.cmo globals.cmo min-rt.cmo 

min-rt: min-rt.cmx globals.cmx miniMLRuntime.cmx
	$(OCAMLOPT) -o min-rt miniMLRuntime.cmx globals.cmx min-rt.cmx 

miniMLRuntime.cmi: miniMLRuntime.mli
	$(OCAMLC) -c miniMLRuntime.mli

miniMLRuntime.cmx: miniMLRuntime.ml miniMLRuntime.cmi
	$(OCAMLOPT) -c $(OCOPT) miniMLRuntime.ml

miniMLRuntime.cmo: miniMLRuntime.ml miniMLRuntime.cmi
	$(OCAMLC) -g -c miniMLRuntime.ml

rt: rt.cmx miniMLRuntime.cmx
	$(OCAMLOPT) -o rt miniMLRuntime.cmx rt.cmx

rt_b: rt.cmo miniMLRuntime.cmo
	$(OCAMLC) -o rt_b miniMLRuntime.cmo rt.cmo
