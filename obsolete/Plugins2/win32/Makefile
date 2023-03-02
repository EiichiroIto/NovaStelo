CXX = i686-w64-mingw32-g++
CXXFLAGS ?= -g
#CXXFLAGS += -DWindowsDLL
CXXFLAGS += -fPIC -static-libgcc
#CXXFLAGS += -I$(HOME)/working/m5stack/ArduinoJson/ -w
CXXFLAGS += -DNDEBUG
SRC = ../src

all: SteloPlugin2.dll testAll.exe

clean:
	rm -f testAll.exe SteloPlugin2.dll *.o *.a core Dlltest.def

%.o: $(SRC)/%.cpp
	$(CXX) $(CXXFLAGS) -c $<

SDiffuser.o: $(SRC)/SDiffuser.cpp $(SRC)/SDiffuser.h
SteloPlugin2.o: $(SRC)/SteloPlugin2.cpp $(SRC)/SDiffuser.h
testAll.o: $(SRC)/testAll.cpp $(SRC)/SDiffuser.h

testAll.exe: testAll.o SDiffuser.o
	$(CXX) $(CXXFLAGS) -o $@ testAll.o SDiffuser.o -static -lstdc++ -lgcc -lwinpthread

SteloPlugin2.dll: SteloPlugin2.o SDiffuser.o
	$(CXX) -shared $(CXXFLAGS) -o $@ SteloPlugin2.o SDiffuser.o -static -lstdc++ -lgcc -lwinpthread -Wl,-k,--output-def,Dlltest.def,--out-implib,libtest.a
