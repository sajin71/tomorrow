SRCDIR=src
BINDIR=bin

SRCS = $(shell find ./$(SRCDIR) -name "*.scala" -and -not -name "*Test*")

all: src/cpp/libconvert_float_int.so
	scalac -classpath /usr/share/java/jna.jar $(SRCS) -d $(BINDIR) -nowarn
	ant -f build2.xml
src/cpp/libconvert_float_int.so: 
	make -C src/cpp