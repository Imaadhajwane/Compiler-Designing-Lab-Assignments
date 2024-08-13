%{
#include <stdlib.h>
#include <stdio.h>
#include "cal.tab.h"
extern YYSTYPE yylval;
void yyerror(char*);
%}

%%
"quit"|"exit"   { return CMD_EXT; }
"+"             { return OP_ADD; }
"-"             { return OP_SUB; }
"*"             { return OP_MUL; }
"/"             { return OP_DIV; }
"^"             { return OP_POW; }
"="             { return OP_EQL; }
"("             { return SYM_PRNL; }
")"             { return SYM_PRNR; }
","             { return SYM_COMMA; }
"sin"|"SIN"     { return FUNC_SIN; }
"cos"|"COS"     { return FUNC_COS; }
"tan"|"TAN"     { return FUNC_TAN; }
"sqrt"|"SQRT"   { return FUNC_SQRT; }
"ln"|"LN"       { return FUNC_LN; }
"log"|"LOG"     { return FUNC_LOG; }
"e"             { return CONST_E; }
"pi"            { return CONST_PI; }
[0-9]+          { sscanf(yytext, "%lf", &yylval); return T_INT; }
[0-9]+(\.[0-9]*)?([eE][-+]?[0-9]+)? { sscanf(yytext, "%lf", &yylval); return T_FLOAT; }
[a-zA-Z][a-zA-Z0-9]* { return T_IDEN; }
\n              { return EOL; }
[ \t]+          ; // Ignore whitespace
.               { yyerror("ERROR: Unrecognized input!"); }
%%

int yywrap()
{
	return 1;
}
