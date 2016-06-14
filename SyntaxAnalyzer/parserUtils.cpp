#include <iostream>
#include <string>
#include <cstdio>       /* sprintf */
#include <cstring>      /* strncat */
#include <regex>
#include "../SymbolTable/SymbolTable.h"
#include "../CodeGenerator/CodeGenerator.h"
#include "parserUtils.h"
using namespace std;

void extractArrayInfo(string &, int &, string &);
bool isArray(string);
string genCodeAddSPAndOffset(int loc);

#define VERBOSE 0

CodeGenerator CG("mips_code.s");
SymbolTable symbolTable;

/* helper function for generating unique labels for if and while statements */
char *newLabel() {
    static int counter = 0;
    char *label = new char[10];

    /* sprintf appends terminating null character */
    sprintf(label, "%s%d", "label", counter);
    counter ++;

    return label;
}

/* if_stmt : IF '(' expression ')' statement */
char *genBranchOnZero(ExpressionRecord *er) {
    char *label = newLabel();

    CG.genCode("lw $t0, " + to_string(er->loc) + "($sp)");
    CG.genCode(string("beqz $t0, ") + label);

    return label;
}
/* used to generate unconditional branch at end of while loop and label
 * for end of while loop */
void genBranchAndLabel(string branchToLabel, string label) {
    CG.genCode(string("b ") + branchToLabel);
    CG.genCode(label + ":");
}
/* used to generate unconditional branch out of if stmt and label
 * for the else block; also used for while loop */
char *genBranchAndLabel(string label) {
    char *newLabelStr = newLabel();
    CG.genCode(string("b ") + newLabelStr);
    CG.genCode(label + ":");

    return newLabelStr;
}
char *genLabelStmt(char *label) {
    char *newLabel = new char[10];
    strcpy(newLabel, label);
    strncat(newLabel, ":", 1);
    CG.genCode(newLabel);
    return label;
}
char *genLabelStmt() {
    char *label = newLabel();
    return genLabelStmt(label);
}

/* logical_and_expr : logical_and_expr LOGICALAND equality_expr */
void genCodeAND() {
    /* The MIPS 'and' instruction is a bitwise instruction.
     * What we need is a logical instruction. */

    /* set values if the expressions are not zero */
    CG.genCode("sne $t3, $t1, $zero");
    CG.genCode("sne $t4, $t2, $zero");

    /* make sure both values set above are not zero */
    CG.genCode("and $t0, $t3, $t4");
}
/* relational_expr : relational_expr OP additive_expr */
void genCodeExprOP(ExpressionRecord *er1, ExpressionRecord *er2,
                            Symbol *temp, char op) {
    string loc1, loc2;

    /* if er1 (lvalue) is array with another symbol as a subscript */
    if (er1->isArrayWithSym)
        loc1 = genCodeAddSPAndOffset(er1->loc);
    else
        loc1 = to_string(er1->loc) + "($sp)";

    /* if er2 (expression) is array with another symbol as a subscript */
    if (er2->isArrayWithSym)
        loc2 = genCodeAddSPAndOffset(er2->loc);
    else
        loc2 = to_string(er2->loc) + "($sp)";

    CG.genCode("lw $t1, " + loc1);
    CG.genCode("lw $t2, " + loc2);
    switch(op) {
        case '<':   CG.genCode("slt $t0, $t1, $t2");
                    break;
        case '>':   CG.genCode("sgt $t0, $t1, $t2");
                    break;
        case '+':   CG.genCode("add $t0, $t1, $t2");
                    break;
        case '-':   CG.genCode("sub $t0, $t1, $t2");
                    break;
        case '*':   CG.genCode("mult $t1, $t2");
                    CG.genCode("mflo $t0");
                    break;
        case '/':   CG.genCode("div $t1, $t2");
                    CG.genCode("mflo $t0");
                    break;
        case '=':   CG.genCode("seq $t0, $t1, $t2");
                    break;
        case '|':   CG.genCode("or $t0, $t1, $t2");
                    break;
        case '&':   genCodeAND();
                    break;
    }
    CG.genCode("sw $t0, " + to_string(temp->loc) + "($sp)");
}
ExpressionRecord *genCodeExpr(ExpressionRecord *er1,
                                ExpressionRecord *er2, char op) {
    if ((er1->type != 'i' && er1->type != 'c') 
            || (er2->type != 'i' && er2->type != 'c'))
        throw "arithmetic operand type must be int or char";

    /* get a temp symbol from the symbol table
     * the name is set by the symbol table, we set the type and loc */
    Symbol *tempSymbol = symbolTable.getTemp();
    tempSymbol->type = 'i';
    tempSymbol->loc = CG.getCurrOffsetAndUpdate();

    genCodeExprOP(er1, er2, tempSymbol, op);

    /* create an expression record for the temp symbol */
    ExpressionRecord *erForTemp = createExpRecForSymbol(tempSymbol->name);

    return erForTemp;
}
/* add $sp and offset to reach value in array where subscript is another id.
 * After this method, return reg with the mem address of array elem on stack */
string genCodeAddSPAndOffset(int loc) {
    // we will alternate between these registers in sequence
    string regs[7] = { "$t3", "$t4", "$t5", "$t6",
                       "$t7", "$t8", "$t9" };
    // the user expects to use the reg as indirect address into stack
    string regs_indirect[7] = { "($t3)", "($t4)", "($t5)", "($t6)",
                       "($t7)", "($t8)", "($t9)" };
    static int index = 0;

    CG.genCode("move $t0, $sp");
    CG.genCode("lw $t1, " + to_string(loc) + "($sp)");
    CG.genCode("add " + regs[index] + ", $t0, $t1");

    string dest = regs_indirect[index];

    // increment index into array for next register
    index++;
    index %= 7;

    return dest;
}
/* cin_stmt : CIN INOP lvalue cin_stmt_prime ';' */
void genCodeCin(string symbol) {
    ExpressionRecord *expRec = createExpRecForSymbol(symbol);
    string dest;

    if (expRec->isArrayWithSym) {
        // add $sp and offset to reach value in array
        dest = genCodeAddSPAndOffset(expRec->loc);
    } else {
        dest = to_string(expRec->loc) + "($sp)";
    }

    if (expRec->type == 'i') {
        CG.genCode("li $v0, 5");
        CG.genCode("syscall");
        CG.genCode("sw $v0, " + dest);
    } else if (expRec->type == 'c') {
        CG.genCode("li $v0, 12");
        CG.genCode("syscall");
        CG.genCode("sw $v0, " + dest);
    }
}
/* cout_mid : OUTOP ENDL cout_mid_prime */
void genCodeEndl() {
    CG.genCode("li $a0, '\\n'");
    CG.genCode("li $v0, 11");
    CG.genCode("syscall");
}
/* cout_mid : OUTOP val_token cout_mid_prime */
void genCodeCout(ExpressionRecord *expRec) {
    string dest;
    if (expRec->isArrayWithSym) {
        // add $sp and offset to reach value in array
        dest = genCodeAddSPAndOffset(expRec->loc);
        CG.genCode("lw $a0, " + dest);
        if (expRec->type == 'i')
            CG.genCode("li $v0, 1");
        else if (expRec->type == 'c')
            CG.genCode("li $v0, 11");
    } else {
        if (expRec->type == 'i') {
            CG.genCode("lw $a0, " + to_string(expRec->loc) + "($sp)");
            CG.genCode("li $v0, 1");

        } else if (expRec->type == 'c') {
            CG.genCode("lw $a0, " + to_string(expRec->loc) + "($sp)");
            CG.genCode("li $v0, 11");

        } else if (expRec->type == 's') {
            CG.genCode("la $a0, " + expRec->locLabel);
            CG.genCode("li $v0, 4");
        }
    }
    CG.genCode("syscall");
}
/* assignment : lvalue '=' expression ';' */
void genCodeAssignment(ExpressionRecord *er1, ExpressionRecord *er2) {
    if(VERBOSE) cout << "Assign stmt: " << er1->loc << " = " << er2->loc << endl;
    string loc1, loc2;

    /* allow:  char_type = int_type; */
    if (er1->type == 'c' && er2->type == 'i')
        er2->type = 'c';

    /* error if var type doesn't match expression type */
    if (er1->type != er2->type) 
        throw "assignment types do not match";

    /* if er1 (lvalue) is array with another symbol as a subscript */
    if (er1->isArrayWithSym) {
        loc1 = genCodeAddSPAndOffset(er1->loc);
    } else {
        loc1 = to_string(er1->loc) + "($sp)";
    }

    /* if er2 (expression) is array with another symbol as a subscript */
    if (er2->isArrayWithSym) {
        loc2 = genCodeAddSPAndOffset(er2->loc);
    } else {
        loc2 = to_string(er2->loc) + "($sp)";
    }

    /* copy value of expression into variable */
    CG.genCode("lw $t1, " + loc2);
    CG.genCode("sw $t1, " + loc1);
}
/* val_token : STRING */
ExpressionRecord *genCodeLitStr(string lexeme) {
    /* create expression record for string */
    ExpressionRecord *expRec = createExpRec('s');

    /* add static string to list of strings to be included in .data section */
    CG.addStaticString(expRec->locLabel, lexeme);

    return expRec;
}
/* val_token : NUMBER */
ExpressionRecord *genCodeLitNum(string lexeme) {
    /* create expression record for integer */
    ExpressionRecord *expRec = createExpRec('i');

    /* store value for integer on stack */
    CG.genCode("li $t0, " + lexeme);
    CG.genCode("sw $t0, " + to_string(expRec->loc) + "($sp)");

    return expRec;
}
ExpressionRecord *createExpRec(char type) {
    if (VERBOSE) {
        cout << "creating ExpRec for type: " << type << endl;
    }

    ExpressionRecord *expRec = new ExpressionRecord;
    expRec->isArrayWithSym = false;
    expRec->type = type;
    if (type == 'i' || type == 'c')
        expRec->loc = CG.getCurrOffsetAndUpdate();

    else if (type == 's') {
        Symbol * newString = symbolTable.getStringLabel();
        expRec->locLabel = newString->name;
    }

    return expRec;
}
ExpressionRecord *createExpRecForSymbol(string symbolName) {
    if (VERBOSE)
        cout << "creating exp rec for symbol: " << symbolName << endl;

    /* if var is array, extract name and index */
    int index = 0;
    string idIndex;
    if (isArray(symbolName)) {
        extractArrayInfo(symbolName, index, idIndex);
    }

    Symbol *symbol = symbolTable.lookup(symbolName);

    /* if index == -1, it means index was an identifier.
     * in that case, look up the identifier in symbol table as well.
     */
    Symbol *indexSym;
    if (index == -1) {
        indexSym = symbolTable.lookup(idIndex);
    }

    ExpressionRecord *expRec = new ExpressionRecord;
    expRec->type = symbol->type;

    if (index == -1) {
        /* symbol is array with another symbol as subscript.
         * create temp on stack that will point to array elem
         */
        expRec->isArrayWithSym = true;

        Symbol *tempSymbol = symbolTable.getTemp();
        tempSymbol->loc = CG.getCurrOffsetAndUpdate();
        expRec->loc = tempSymbol->loc;

        // load value of index symbol
        CG.genCode("lw $t0, " + to_string(indexSym->loc) + "($sp)");
        // multiply by 4 (by doubling twice)
        CG.genCode("add $t0, $t0, $t0");
        CG.genCode("add $t0, $t0, $t0");
        // now subtract above offset from offset of array
        CG.genCode("li $t1, " + to_string(symbol->loc));
        CG.genCode("sub $t0, $t1, $t0");
        // store final address to array elem in temp variable's location
        CG.genCode("sw $t0, " + to_string(tempSymbol->loc) + "($sp)");
    } else {
        /* otherwise, symbol is not an array or
         * it is an array with a literal number as subscript
         */
        expRec->isArrayWithSym = false;
        expRec->loc = symbol->loc - index * 4;
    }
    return expRec;
}

/* input: name is an array variable name like: arr[10] or arr[i]
 * output:  name: str
 *          index: 10 (or -1 if index is an identifier)
 *          idIndex: i
 *          if not array, name and index remain unchanged
 */
void extractArrayInfo(string &name, int &index, string &idIndex) {
    regex base_regex(".*\\[(.*)\\]");
    smatch base_match;

    if (regex_match(name, base_match, base_regex)) {
        if (base_match.size() == 2) {
            ssub_match base_sub_match = base_match[1];
            string base = base_sub_match.str();
            if(VERBOSE) cout << name << " has index of: " << base << endl;

            try {
                // index of array variable
                index = stoi(base);
            } catch (invalid_argument ex) {
                idIndex = base;
                index = -1;
            }

            // remove index specifier from symbol name
            string::size_type i;
            i = name.find('[');
            name = name.substr(0, i);
            if(VERBOSE) cout << "symbol name is: " << name << endl;
        }
    }
}
bool isArray(string symbol) {
    return symbol.find('[') != string::npos;
}
/* var_decl : type lvalue ';' */
void varDecl(string type, string name) {
    /* only variables of type int or char are allowed */
    if (type != "int" && type != "char")
        throw "invalid type in variable declaration: " + type;

    // size of variable (in terms of # of words on stack)
    int size = 1;

    // is it an array declaration?
    if (isArray(name)) {
        // found array declaration

        // verify size given is a number, not a variable
        regex base_regex(".*\\[([1-9][0-9]*)\\]");
        smatch base_match;

        if (regex_match(name, base_match, base_regex)) {
            if (base_match.size() == 2) {
                ssub_match base_sub_match = base_match[1];
                string base = base_sub_match.str();
                if(VERBOSE) cout << name << " has size of: " << base << endl;

                // size of array
                size = stoi(base);

                // remove size specifier from symbol name
                string::size_type i;
                i = name.find('[');
                name = name.substr(0, i);
                if(VERBOSE) cout << "new name is: " << name << endl;
            }
        } else {
            throw "invalid array declaration";
        }
    }

    /* create new symbol and insert into symbol table */
    /* it's an error if it already exists */
    Symbol *newSymbol = new Symbol;
    newSymbol->name = name;
    newSymbol->type = type[0];
    newSymbol->loc = CG.getCurrOffsetAndUpdate(size);
    if (size > 0)
        newSymbol->size = size;

    if (VERBOSE) {
        cout << "adding new symbol: " 
             << "name: " << name << " type: " << type[0] 
             << " size(if array): " << size << endl;
    }
    
    Symbol *temp = symbolTable.find(newSymbol);
    if (temp) {
        throw "symbol already exists: " + name;
    }

    symbolTable.insert(newSymbol);
}
void exitBlock() {
    symbolTable.leaveScope();
}
void enterBlock() {
    symbolTable.enterNewScope();
}
