ROOTCFLAGS    = $(shell $(ROOTSYS)/bin/root-config --cflags)
ROOTLIBS      = $(shell $(ROOTSYS)/bin/root-config --libs)
ROOTGLIBS     = $(shell $(ROOTSYS)/bin/root-config --glibs)

CXX  = g++
CXX += -I./	
CXX += -I./obj/

CXXFLAGS  = -g -Wall -fPIC -Wno-deprecated
CXXFLAGS += $(ROOTCFLAGS)

OUTLIB = ./obj/

#----------------------------------------------------#

all: runTCana	

runTCana: runTCana.cpp obj/TCana.o obj/TCbase.o
	$(CXX) -o runTCana runTCana.cpp $(OUTLIB)*.o $(ROOTCFLAGS) $(ROOTLIBS) $(ROOTGLIBS)

obj/TCana.o: src/TCana.cpp src/TCana.hh obj/TCbase.o
	$(CXX) $(CXXFLAGS) -c -I. -o $(OUTLIB)TCana.o $<

obj/TCbase.o: src/TCbase.cpp src/TCbase.hh
	$(CXX) $(CXXFLAGS) -c -I. -o $(OUTLIB)TCbase.o $<

clean:
	rm -f runTCana
	rm -f *~
	rm -f src/*~
	rm -f $(OUTLIB)*.o
