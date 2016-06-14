#
# filename: Makefile
# author: Aman Wardak
#
# Makefile for the syntax analyzer
#

CC		= clang++
CFLAGS	+= -Wall -std=c++11

# turn off the warning: treating 'c' input as 'c++'
CFLAGS  += -x c++

# turn off the warning that the 'register' keyword is deprecated
CFLAGS  += -Wno-deprecated-register

# link with the lex library
LEX_LIB = -ll

scanner : lex.yy.c

status:
	@echo "CC           = $(CC)"
	@echo "CFLAGS       = $(CFLAGS)"
	@echo "LEX_LIB      = $(LEX_LIB)"

lex.yy.c : lex_spec.l ../SyntaxAnalyzer/parser.tab.h
	flex lex_spec.l

lex.yy.o : lex.yy.c
	$(CC) $(CFLAGS) -c $< -o $@

main.o : main.cpp
	$(CC) $(CFLAGS) -c $< -o $@

scannerDriver : lex.yy.o main.o
	$(CC) $^ $(CFLAGS) $(LEX_LIB) -o $@


clean:
	rm -f *.o
	rm scanner

