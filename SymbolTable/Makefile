
CC		= clang++
CFLAGS	= -Wall -std=c++11

all: SymbolTableDriver

SymbolTable.o : SymbolTable.cpp SymbolTable.h
	$(CC) $(CFLAGS) -c $< -o $@

SymbolTableDriver.o : SymbolTableDriver.cpp SymbolTable.h
	$(CC) $(CFLAGS) -c $< -o $@

SymbolTableDriver : SymbolTableDriver.o SymbolTable.o
	$(CC) $^ $(CFLAGS) -o $@

clean:
	rm -f *.o
	rm -f SymbolTableDriver

