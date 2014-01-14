SRCS=$(shell find ./  -maxdepth 1 -name "*.cpp" )
OBJS=$(SRCS:.cpp=.o)
TESTSRCS=$(shell find ./test -name "*.cpp")
CXXFLAGS +=-std=c++0x -I/usr/src/gtest -I. -g

all: $(OBJS)
test: autotest
autotest: $(OBJS) $(TESTSRCS)
	g++ $(CXXFLAGS) -o autotest /usr/src/gtest/src/gtest-all.cc $(OBJS) $(TESTSRCS) $(LDFLAGS) -lpthread
