CXX ?= c++
CXXFLAGS ?= -g
CXXFLAGS += -fPIC
#CXXFLAGS += -DNDEBUG
SRC = ../src

all: SteloPlugin2.so testAll

clean:
	rm -f testAll *.o *.so core

%.o: $(SRC)/%.cpp
	$(CXX) $(CXXFLAGS) -c $<

SDiffuser.o: $(SRC)/SDiffuser.cpp $(SRC)/SDiffuser.h
SteloPlugin2.o: $(SRC)/SteloPlugin2.cpp $(SRC)/SDiffuser.h

testAll: testAll.o SDiffuser.o
	$(CXX) $(CXXFLAGS) -o $@ testAll.o SDiffuser.o

SteloPlugin2.so: SteloPlugin2.o SDiffuser.o
	$(CXX) -shared $(CXXFLAGS) -o $@ SteloPlugin2.o SDiffuser.o
