/*
 filename: parser.y
 author: Aman Wardak

 This is the Yacc specification file for the C-- programming language.  
*/

%{

// remove this and use it in compilation line instead
// #include "../LexicalAnalyzer/lex.yy.c"
#include "parserUtils.h"
#include <iostream>
#include <iomanip>
#include <string>
#include <cstring>
using namespace std;

extern int yylex (void);

void yyerror(const char *s) {
    extern int yylineno;
    cerr << s << endl;
    cerr << "around line: " << yylineno << endl;
}

%}

// the 'const' keyword below removes this warning:
// conversion from string literal to 'char *' is deprecated
%union {
    int num;
    const char *str;
    struct ExpressionRecord *expRec;
}

%token <num> VOID INT CHAR RETURN IF ELSE WHILE BREAK CONTINUE
%token <num> CIN COUT ENDL RELOP ADDOP MULOP INOP OUTOP
%token <num> ERROR EQUALITY LOGICALOR LOGICALAND

%token <str> ID STRING NUMBER

%type <str> var_decl type lvalue while_loop while_keyword while_expr

%type <expRec> expression logical_or_expr logical_and_expr
%type <expRec> equality_expr relational_expr additive_expr 
%type <expRec> multiplicative_expr primary_expr val_token
%type <expRec> assign_lval

%%

program : function_definition program
        |   /* epsilon */
;

function_definition : type ID '(' parameter_list ')' compound_stmt 
;

type : INT                                  {$$ = "int";}
     | CHAR                                 {$$ = "char";}
     | VOID                                 {$$ = "void";}
;

parameter_list : type ID parameter_list_addon
               |        /* epsilon */
;

parameter_list_addon : ',' type ID parameter_list_addon
                     |  /* epsilon */
;

/* the following rule uses a mid-rule action */
compound_stmt : '{'                         {enterBlock();}
              compound_stmt_prime '}'       {exitBlock();}

compound_stmt_prime : statement compound_stmt_prime
                     |   /* epsilon */
;

statement : var_decl                        
          | assignment                      
          | if_stmt                         
          | while_loop                      
          | cin_stmt                        
          | cout_stmt                       
          | jump_stmt                       
          | compound_stmt                   
;

var_decl : type lvalue ';'              {   varDecl($1, $2);    }
;

assignment : assign_lval '=' expression ';' { genCodeAssignment($1, $3); }
;
assign_lval : lvalue                    { $$ = createExpRecForSymbol($1); }
;

expression : logical_or_expr        /* accept default action: $$ = $1 */
;

logical_or_expr : logical_and_expr
                | logical_or_expr LOGICALOR logical_and_expr
                                            {
                                                $$ = genCodeExpr($1, $3, '|');
                                            }
;

logical_and_expr : equality_expr
                 | logical_and_expr LOGICALAND equality_expr
                                            {
                                                $$ = genCodeExpr($1, $3, '&');
                                            }
;

equality_expr : relational_expr
              | equality_expr EQUALITY relational_expr
                                            {
                                                $$ = genCodeExpr($1, $3, '=');
                                            }
;

relational_expr : additive_expr
                | relational_expr '<' additive_expr
                                            {
                                                $$ = genCodeExpr($1, $3, '<');
                                            }
                | relational_expr '>' additive_expr
                                            {
                                                $$ = genCodeExpr($1, $3, '>');
                                            }
;

additive_expr : multiplicative_expr
              | additive_expr '+' multiplicative_expr
                                            {
                                                $$ = genCodeExpr($1, $3, '+');
                                            }
              | additive_expr '-' multiplicative_expr
                                            {
                                                $$ = genCodeExpr($1, $3, '-');
                                            }
;

multiplicative_expr : primary_expr
                    | multiplicative_expr '*' primary_expr      
                                            {
                                                $$ = genCodeExpr($1, $3, '*');
                                            }
                    | multiplicative_expr '/' primary_expr
                                            {
                                                $$ = genCodeExpr($1, $3, '/');
                                            }
;

primary_expr : '(' expression ')'           {
                                                $$ = $2;
                                            }
             | val_token                    {
                                                $$ = $1;
                                            }
;

val_token : lvalue          {   
                                $$ = createExpRecForSymbol($1);
                            }
          | NUMBER          {
                                $$ = genCodeLitNum($1);
                            }
          | STRING          {
                                $$ = genCodeLitStr($1);
                            }
;

if_stmt : IF '(' expression ')'     {
                                        $<str>$ = genBranchOnZero($3);
                                    }
        statement                   {
                                        $<str>$ = genBranchAndLabel($<str>5);
                                    }
        else_stmt                   {
                                        char *label = new char[10];
                                        strcpy(label, $<str>7);
                                        genLabelStmt(label);
                                    }
;
else_stmt : ELSE statement
          |     /* epsilon */
;

/*
while_loop : WHILE                  {
                                        $<str>$ = genLabelStmt(newLabel());
                                    }
           '(' expression ')'       {
                                        $<str>$ = genBranchOnZero($4);
                                    }
           statement                {
                                        genBranchAndLabel($<str>2, $<str>6);
                                    }
;
*/

while_loop : while_keyword while_expr while_stmt
                                    {
                                        genBranchAndLabel($1, $2); 
                                    } 
;

while_keyword : WHILE               {
                                        $$ = genLabelStmt();
                                    }
;
while_expr : '(' expression ')'     {
                                        $$ = genBranchOnZero($2);
                                    }
;
while_stmt : statement
;

/* mid-action rules needed below to read items in the correct order */
cin_stmt : CIN INOP lvalue                  {
                                                genCodeCin($3);
                                            }
           cin_stmt_prime ';'
;

cin_stmt_prime : INOP lvalue                {
                                                genCodeCin($2);
                                            }
                 cin_stmt_prime
               |    /* epsilon */
;

cout_stmt : COUT cout_mid ';'               
;

/* mid-action rules needed below to print items in the order they appear */
cout_mid : OUTOP val_token
                                            {
                                                genCodeCout($2);
                                            }
           cout_mid_prime
         | OUTOP ENDL                       {
                                                genCodeEndl();
                                            }
           cout_mid_prime
;

cout_mid_prime : OUTOP val_token            {
                                                genCodeCout($2);
                                            }
                 cout_mid_prime
               | OUTOP ENDL                 {
                                                genCodeEndl();
                                            }
                 cout_mid_prime
               |    /* epsilon */
;

jump_stmt : CONTINUE ';'
          | BREAK ';'
          | RETURN ';'                      
          | RETURN expression ';'           
          | ID '(' ')' ';'                  
          | ID '(' argument_list ')' ';'    
;

argument_list : val_token arg_list_prime    
;

arg_list_prime : ',' val_token arg_list_prime  
               |    /* epsilon */             
;

lvalue : ID
       | ID '[' NUMBER ']'      {
                                    $$ = string(string($1) + "[" + 
                                    $3 + "]").c_str();
                                }
       | ID '[' ID ']'          {
                                    $$ = string(string($1) + "[" +
                                    $3 + "]").data();
                                }
;

%%

const string rule_desc[] = {
    "0",
    "<program> -> <func_def> <program>",
    "<program> -> epsilon",
    "<func_def> -> <type> ID ( <param_list> ) <compound_stmt>",
    "<type> -> int",
    "<type> -> char",
    "<type> -> void",
    "<param_list> -> <type> <lvalue> <param_list_addon>",
    "<param_list> -> epsilon",
    "<param_list_addon> -> , <type> <lvalue> <param_list_addon>",
    "<param_list_addon> -> epsilon",
    "<compound_stmt> -> { <compound_stmt_prime> }",
    "<compound_stmt_prime> -> <statement> <compound_stmt_prime>",
    "<compound_stmt_prime> -> epsilon",
    "<statement> -> <var_decl>",
    "<statement> -> <assignment>",
    "<statement> -> <if_stmt>",
    "<statement> -> <while_loop>",
    "<statement> -> <cin_stmt>",
    "<statement> -> <cout_stmt>",
    "<statement> -> <jump_stmt>",
    "<statement> -> <compound_stmt>",
    "<var_decl> -> <type> <lvalue> ;",
    "0",                            // removed 
    "<assignmet> -> <lvalue> = expression ;",
    "<expression> -> <logical_or_expr>",
    "<logical_or_expr> -> <logical_and_expr>",
    "<logical_or_expr> -> <logical_or_expr> || <logical_and_expr>",
    "<logical_and_expr> -> <equality_expr>",
    "<logical_and_expr> -> <logical_and_expr> && <equality_expr>",
    "<equality_expr> -> <relational_expr>",
    "<equality_expr> -> <equality_expr> == <relational_expr>",
    "<relational_expr> -> <additive_expr>",
    "<relational_expr> -> <relational_expr> < <additive_expr>",
    "<relational_expr> -> <relational_expr> > <additive_expr>",
    "<additive_expr> -> <multiplicative_expr>",
    "<additive_expr> -> <additive_expr> + <multiplicative_expr>",
    "<additive_expr> -> <additive_expr> - <multiplicative_expr>",
    "<multiplicative_expr> -> <primary_expr>",
    "<multiplicative_expr> -> <multiplicative_expr> * <primary_expr>",
    "<multiplicative_expr> -> <multiplicative_expr> / <primary_expr>",
    "<primary_expr> -> ( <expression> )",
    "<primary_expr> -> <val_token>",
    "<val_token> -> <lvalue>",
    "<val_token> -> NUMBER",
    "<val_token> -> STRING",
    "<if_stmt> -> if ( <expression> ) <statement>",
    "<if_stmt> -> if ( <expression> ) <statement> else <statement>",
    "<while_loop> -> while ( <expression> ) <statement>",
    "<cin_stmt> -> cin >> <lvalue> <cin_stmt_prime> ;",
    "<cin_stmt_prime> -> >> <lvalue> <cin_stmt_prime>",
    "<cin_stmt_prime> -> epsilon",
    "<cout_stmt> -> cout <cout_mid> ;",
    "<cout_mid> -> << <val_token> <cout_mid_prime>",
    "<cout_mid> -> << endl <cout_mid_prime>",
    "<cout_mid_prime> -> << <val_token> <cout_mid_prime>",
    "<cout_mid_prime> -> << endl <cout_mid_prime>",
    "<cout_mid_prime> -> epsilon",
    "<jump_stmt> -> continue ;",
    "<jump_stmt> -> break ;",
    "<jump_stmt> -> return ;",
    "<jump_stmt> -> return <expression> ;",
    "<jump_stmt> -> ID ( ) ;",
    "<jump_stmt> -> ID ( <argument_list> ) ;",
    "<argument_list> -> <val_token> <arg_list_prime>",
    "<arg_list_prime> -> , <val_token> <arg_list_prime>",
    "<arg_list_prime> -> epsilon",
    "<lvalue> -> ID",
    "<lvalue> -> ID [ NUMBER ]"
};

#include <vector>
using namespace std;

int openSourceFile(char *);
void closeSourceFile();

int main(int argc, char *argv[]) {
    extern int yylineno;

    if (argc < 2) {
        cout << "cmm: error: no input files\n";
        return -1;
    }

    if (openSourceFile(argv[1]) != 0) {
        cout << "cmm: error: unable to open source file\n";
        return -2;
    }

    try {
      /* yyparse() returns 0 to mean end of input
       if it returns before then, it must have run into an error */
      if (yyparse() != 0)
        return -1;
    } catch (const char *ex) {
        cerr << ex << endl;
        cerr << "around lineno: " << yylineno << endl;
    } catch (string &ex) {
        cerr << ex << endl;
        cerr << "around lineno: " << yylineno << endl;
    }

    closeSourceFile();
}

