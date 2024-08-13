%{
#include "parser.tab.h"
%}

%%
"Protocol"          { return PROTOCOL; }
"REQUEST"           { return REQUEST; }
"RESPONSE"          { return RESPONSE; }
"INT"               { return INT_TYPE; }
"BOOL"              { return BOOL_TYPE; }
"STRING"            { return STRING_TYPE; }
[a-zA-Z]+           { yylval.str = strdup(yytext); return IDENTIFIER; }
[0-9]+              { yylval.num = atoi(yytext); return NUMBER; }
"{"                 { return OPEN_BRACE; }
"}"                 { return CLOSE_BRACE; }
";"                 { return SEMICOLON; }
"("                 { return OPEN_PAREN; }
")"                 { return CLOSE_PAREN; }
[ \t\n]             ; // skip whitespace
.                   { printf("Unexpected character '%s'\n", yytext); }
%%

int yywrap() {
    return 1;
}
