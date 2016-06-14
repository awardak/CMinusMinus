/*
 filename: lex_spec.l
 author: Aman Wardak
 
 This is the Lex specification file that is fed into Flex to generate
 a scanner.  It contains the regular expressions for the tokens that
 we expect in a source code file based on our language C-- (C Minus Minus).
 
 */


DIGIT       [0-9]
LETTER      [a-zA-Z]
WSPACE      [ \t\n]+
STRING      \"([^\"])*\"

/* reference for multi-line comment expression: 
   stackoverflow.com/questions/2130097/difficulty-getting-c-style-comments-in-flex-lex
*/
COMMENT     "/*"((\*+[^/*])|([^*]))*\**"*/"

%{
#if 0   // we don't need these anymore since they come from yacc/bison
/* keywords */
#define INT         1
#define CHAR        2
#define VOID        3
#define MAIN        4
#define RETURN      5
#define IF          6
#define ELSE        7
#define FOR         8
#define BREAK       9
#define CONTINUE    10
#define CIN         11
#define COUT        12
#define ENDL        13

/* relational operators: == < > */
/* start at 30 in case we want to add more keywords later */
#define RELOP       30

/* assignment operator: = */
#define ASSIGNOP    40

/* arithmetic operators: + - * / */
#define ADDOP       41
#define MULOP       42

/* input/output operators: >> << */
#define INOP        43
#define OUTOP       44

/* punctuation: ( ) { } [ ] ; */
#define LPAREN      50
#define RPAREN      51
#define LBRACE      52
#define RBRACE      53
#define LBRACK      54
#define RBRACK      55
#define SEMICOLON   56

/* identifier */
#define ID          60

/* literal number */
#define NUMBER      61

/* literal string */
#define STRING      62

/* error status */
#define ERROR       99
#endif

/* commented out all of above since we moved them to yacc */
/* we include below the header file that yacc generates */
#include "../SyntaxAnalyzer/parser.tab.h"

%}

%option yylineno

%%
int                             { return INT; }
char                            { return CHAR; }
void                            { return VOID; }
return                          { return RETURN; }
if                              { return IF; }
else                            { return ELSE; }
while                           { return WHILE; }
break                           { return BREAK; }
continue                        { return CONTINUE; }
cin                             { return CIN; }
cout                            { return COUT; }
endl                            { return ENDL; }
"=="                            { return EQUALITY; }
"<"                             { return '<'; }
">"                             { return '>'; }
"||"                            { return LOGICALOR; }
"&&"                            { return LOGICALAND; }
"="                             { return '='; }
"+"                             { return '+'; }
"-"                             { return '-'; }
"*"                             { return '*'; }
"/"                             { return '/'; }
">>"                            { return INOP; }
"<<"                            { return OUTOP; }
"("                             { return '('; }
")"                             { return ')'; }
"{"                             { return '{'; }
"}"                             { return '}'; }
"["                             { return '['; }
"]"                             { return ']'; }
;                               { return ';'; }
,                               { return ','; }
{LETTER}({LETTER}|{DIGIT})*     { yylval.str = strdup(yytext); return ID; }
{DIGIT}+                        { yylval.str = strdup(yytext); return NUMBER; }
{STRING}                        { yylval.str = strdup(yytext); return STRING; }
{COMMENT}                       { /* do nothing; eat up comments */ }
{WSPACE}                        { /* do nothing; eat up white space */ }
.                               { /* saw some char not in the language */
                                  return ERROR; }
%%

#include <cstdio>   /* fopen() */
using namespace std;

/* fp points to the source file to be analyzed */
FILE *fp;

/* openSourceFile opens the source file */
int openSourceFile(char *filename) {
    fp = fopen(filename, "r");
    if (!fp) {
        return -1;
    }

    /* yyin is the pointer to the file that yylex() reads from */
    yyin = fp;

    return 0;
}

void closeSourceFile() {
    fclose(fp);
}

/* the parser will get the next token in the source file as an integer */
int getNextToken() {
    /* yylex reads the next token and executes the associated action 
        - returns zero when eof reached */
    return yylex();
}
