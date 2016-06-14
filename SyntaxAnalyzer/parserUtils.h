#include <string>
using namespace std;

struct ExpressionRecord {
    char type;
    int loc;
    string locLabel;
    bool isArrayWithSym;
};

char *newLabel();
char *genBranchOnZero(ExpressionRecord *er);
void genBranchAndLabel(string branchToLabel, string label);
char *genBranchAndLabel(string label);
char *genLabelStmt(char *label);
char *genLabelStmt();
ExpressionRecord *genCodeExpr(ExpressionRecord *, ExpressionRecord *, char);
void genCodeCin(string symbol);
void genCodeEndl();
void genCodeCout(ExpressionRecord *expRec);
void genCodeAssignment(ExpressionRecord *var, ExpressionRecord *expRec);
void genCodeAssignment(string var, ExpressionRecord *expRec);
ExpressionRecord *genCodeLitStr(string lexeme);
ExpressionRecord *genCodeLitNum(string lexeme);
ExpressionRecord *createExpRec(char type);
ExpressionRecord *createExpRecForSymbol(string symbol);
void varDecl(string type, string name);
void exitBlock();
void enterBlock();
