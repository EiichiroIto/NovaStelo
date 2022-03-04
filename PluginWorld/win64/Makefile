CXX = x86_64-w64-mingw32-gcc
CXXFLAGS ?= -g
#CXXFLAGS += -DWindowsDLL
CXXFLAGS += -fPIC -static-libgcc
#CXXFLAGS += -I$(HOME)/working/m5stack/ArduinoJson/ -w
SRC = ../src
INCLUDE = ../include

all: stelo.exe stelo64.dll

clean:
	rm -f stelo.exe stelo64.dll *.o *.dll core *.a *.def

%.o: $(SRC)/%.cpp
	$(CXX) $(CXXFLAGS) -I $(INCLUDE) -c $<

SCommon.o: $(SRC)/SCommon.cpp $(INCLUDE)/SCommon.h
SVariables.o: $(SRC)/SVariables.cpp $(INCLUDE)/SCommon.h $(INCLUDE)/SVariables.h
SBreeds.o: $(SRC)/SBreeds.cpp $(INCLUDE)/SCommon.h $(INCLUDE)/SVariables.h $(INCLUDE)/SBreeds.h
SMicroWorld.o: $(SRC)/SMicroWorld.cpp $(INCLUDE)/SCommon.h $(INCLUDE)/SVariables.h $(INCLUDE)/SBreeds.h $(INCLUDE)/SMicroWorld.h
SProcesses.o: $(SRC)/SProcesses.cpp $(INCLUDE)/SCommon.h $(INCLUDE)/SVariables.h $(INCLUDE)/SBreeds.h $(INCLUDE)/SMicroWorld.h $(INCLUDE)/SProcesses.h
SInstructions.o: $(SRC)/SInstructions.cpp $(INCLUDE)/SCommon.h $(INCLUDE)/SVariables.h $(INCLUDE)/SBreeds.h $(INCLUDE)/SMicroWorld.h $(INCLUDE)/SProcesses.h
main.o: $(SRC)/main.cpp $(INCLUDE)/SCommon.h $(INCLUDE)/SVariables.h $(INCLUDE)/SBreeds.h $(INCLUDE)/SMicroWorld.h
capi.o: $(SRC)/capi.cpp $(INCLUDE)/SCommon.h $(INCLUDE)/SVariables.h $(INCLUDE)/SBreeds.h $(INCLUDE)/SMicroWorld.h $(INCLUDE)/SProcesses.h
LazyArray.o: $(SRC)/LazyArray.cpp $(INCLUDE)/LazyArray.h
SDiffuser.o: $(SRC)/SDiffuser.cpp $(INCLUDE)/SDiffuser.h

OBJS = SCommon.o SVariables.o SBreeds.o SMicroWorld.o SProcesses.o SInstructions.o LazyArray.o SDiffuser.o

stelo.exe: main.o $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ main.o $(OBJS) -static -lstdc++ -lgcc -lwinpthread

stelo64.dll: capi.o $(OBJS)
	$(CXX) -shared $(CXXFLAGS) -o $@ capi.o $(OBJS) -static -lstdc++ -lgcc -lwinpthread -Wl,-k,--output-def,Dlltest.def,--out-implib,libtest.a
