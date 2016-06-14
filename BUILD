
cd SyntaxAnalyzer/
bison -d parser.y	        # generates parser.tab.h and parser.tab.c

if [ $? != 0 ]
then
  echo "failed: bison -d"
  return
fi

cp parser.tab.h ../LexicalAnalyzer/
cd ..

cd LexicalAnalyzer/
make

if [ $? != 0 ]
then
  echo "failed to build scanner"
  return
fi

cd ..


g++ -Wall -std=c++11 -x c++                         \
    -Wno-deprecated-register                        \
    -Wno-unused-function                            \
    -Wno-unneeded-internal-declaration              \
    LexicalAnalyzer/lex.yy.c                        \
    SyntaxAnalyzer/parser.tab.c                     \
    SyntaxAnalyzer/parserUtils.cpp                  \
    CodeGenerator/CodeGenerator.cpp                 \
    SymbolTable/SymbolTable.cpp                     \
    -ly -ll -o cmm

