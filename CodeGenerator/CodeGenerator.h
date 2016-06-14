#pragma once

#include <fstream>
#include <iostream>
#include <string>
#include <vector>
using namespace std;

class CodeGenerator {

    private:
        /* class variable to represent current offset from stack pointer */
        static int currOffset;

        fstream codeFile;
        vector<string> staticStrings;

        void writeStaticStrings();

    public:
        CodeGenerator(const string & filename);
        ~CodeGenerator();
        void writeProlog();
        void writePostlog();
        int getCurrOffsetAndUpdate(int offset = 1);
        void genCode(string code);
        void addStaticString(string, string);
};