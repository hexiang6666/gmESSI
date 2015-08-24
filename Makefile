
CC= g++ -O3 -std=c++11
CFLAGS = -c

all: gmssi

gmssi: Element.o GmshParser.o GmshTranslator.o Mapping.o Node.o PhysicalGroup.o Semantics.o Tokenizer.o OctParser.o GmssiPython.o gmssi.o
		mkoctfile --link-stand-alone -I/usr/local/include/octave-3.8.0/octave  -lboost_python-py27 -lpython2.7  gmssi.o Element.o GmshParser.o GmshTranslator.o Mapping.o Node.o PhysicalGroup.o Semantics.o Tokenizer.o OctParser.o GmssiPython.o -o gmssi
		mkoctfile -I/usr/local/include/octave-3.8.0/octave  -lboost_python-py27 -lpython2.7 Element.o GmshParser.o GmshTranslator.o Mapping.o Node.o PhysicalGroup.o Semantics.o Tokenizer.o OctParser.o GmssiPython.o -o gmssi.so
		mv gmssi.so.oct gmssi.so

gmssi.o: gmssi.cpp
		$(CC) $(CFLAGS) gmssi.cpp
GmshTranslator.o: GmshTranslator.cpp
		$(CC) -pthread -fno-strict-aliasing -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -fPIC -I/usr/include/python2.7 -I/usr/local/boost_1_58_0 -I/usr/include/octave/ -lboost_python -lboost_system $(CFLAGS) GmshTranslator.cpp 
GmshParser.o: GmshParser.cpp
		$(CC) -pthread -fno-strict-aliasing -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -fPIC -I/usr/include/python2.7 -I/usr/local/boost_1_58_0 -I/usr/include/octave/ -lboost_python -lboost_system $(CFLAGS) GmshParser.cpp
Mapping.o: Mapping.cpp
		$(CC) -pthread -fno-strict-aliasing -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -fPIC -I/usr/include/python2.7 -I/usr/local/boost_1_58_0 -I/usr/include/octave/ -lboost_python -lboost_system $(CFLAGS) Mapping.cpp
PhysicalGroup.o: PhysicalGroup.cpp
		$(CC) -pthread -fno-strict-aliasing -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -fPIC -I/usr/include/python2.7 -I/usr/local/boost_1_58_0 -I/usr/include/octave/ -lboost_python -lboost_system $(CFLAGS) PhysicalGroup.cpp
Node.o: Node.cpp
		$(CC) -pthread -fno-strict-aliasing -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -fPIC -I/usr/include/python2.7 -I/usr/local/boost_1_58_0 -I/usr/include/octave/ -lboost_python -lboost_system $(CFLAGS) Node.cpp
Element.o: Element.cpp 
		$(CC) -pthread -fno-strict-aliasing -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -fPIC -I/usr/include/python2.7 -I/usr/local/boost_1_58_0 -I/usr/include/octave/ -lboost_python -lboost_system $(CFLAGS) Element.cpp 
Semantics.o: Semantics.cpp
		$(CC) -pthread -fno-strict-aliasing -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -fPIC -I/usr/include/python2.7 -I/usr/local/boost_1_58_0 -I/usr/include/octave/ -lboost_python -lboost_system $(CFLAGS) Semantics.cpp
Tokenizer.o: Tokenizer.cpp
		$(CC) -pthread -fno-strict-aliasing -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -fPIC -I/usr/include/python2.7 -I/usr/local/boost_1_58_0 -I/usr/include/octave/ -lboost_python -lboost_system $(CFLAGS) Tokenizer.cpp
OctParser.o: OctParser.cpp
		mkoctfile -I/usr/local/include/octave-3.8.0/octave -c OctParser.cpp
GmssiPython.o: GmssiPython.cpp
		$(CC)  -pthread -fno-strict-aliasing -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -fPIC -I/usr/include/python2.7 -I/usr/local/boost_1_58_0 -I/usr/include/octave/ -lboost_python -lboost_system $(CFLAGS) GmssiPython.cpp
clean:
		-rm *.o *.so gmssi

install:
		if [ -d "/usr/local/gmssi" ]; then	sudo rm -r /usr/local/gmssi; fi
		echo "creating directory in usr/local/gmssi"
		sudo mkdir /usr/local/gmssi
		sudo mkdir /usr/local/gmssi/src
		sudo mkdir /usr/local/gmssi/bin
		sudo mkdir /usr/local/gmssi/lib
		sudo cp *.cpp *.h mapping.fei Makefile /usr/local/gmssi/src
		sudo cp mapping.fei gmssi /usr/local/gmssi/bin
		sudo cp gmssi.so mapping.fei /usr/local/gmssi/lib
		if [ -d "/usr/lib/python2.7/gmssi.so" ]; then sudo rm  /usr/lib/python2.7/gmssi.so ; fi
		if [ -d "/usr/lib/python2.7/mapping.fei" ]; then sudo rm  /usr/lib/python2.7/mapping.fei; fi
		sudo cp gmssi.so mapping.fei /usr/lib/python2.7	
		sudo ln -s -f /usr/local/gmssi/bin/mapping.fei /usr/local/bin/mapping.fei
		sudo ln -s -f /usr/local/gmssi/bin/gmssi /usr/local/bin/gmssi
		