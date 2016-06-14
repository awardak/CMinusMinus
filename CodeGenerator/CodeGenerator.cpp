
#include <fstream>
#include "CodeGenerator.h"
using namespace std;

/* initialize class variable */
int CodeGenerator::currOffset = 0;

CodeGenerator::CodeGenerator(const string & filename) {
    codeFile.open(filename, ios::out);
    if (!codeFile) {
        throw string("unable to open code file: " + filename);
    }

    writeProlog();
}
CodeGenerator::~CodeGenerator() {
    writePostlog();
    codeFile.close();
}

void CodeGenerator::writeProlog() {
    codeFile << "# Prolog:"         << endl
        << ".text"                  << endl
        << "main:"                  << endl
        << "move $fp $sp"           << endl
        << "la $a0 ProgStart"       << endl
        << "li $v0 4"               << endl
        << "syscall"                << endl
        << "# End of Prolog"        << endl << endl;
}
void CodeGenerator::writePostlog() {
    codeFile << "\n# Postlog:"        << endl
        << "la $a0 ProgEnd"         << endl
        << "li $v0 4"               << endl
        << "syscall"                << endl
        << "li $v0 10"              << endl
        << "syscall"                << endl
        << ".data"                  << endl
        << "ProgStart: \t .asciiz \"Program Start\\n\""  << endl
        << "ProgEnd:   \t .asciiz \"Program End\\n\""    << endl;

    writeStaticStrings();
}
int CodeGenerator::getCurrOffsetAndUpdate(int offset) {
    int temp = currOffset;
    // multiply offset by 4 (# of bytes in word on stack)
    currOffset -= offset * 4;
    return temp;
}
void CodeGenerator::genCode(string code) {
    codeFile << code << endl;
}
void CodeGenerator::addStaticString(string name, string lexeme) {
    staticStrings.push_back(name + ": \t\t .asciiz " + lexeme);
}
void CodeGenerator::writeStaticStrings() {
    for (string s : staticStrings)
        codeFile << s << endl;
}