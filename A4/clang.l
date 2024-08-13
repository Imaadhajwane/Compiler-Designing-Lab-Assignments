%{
#include "clang.tab.h"
%}

%%

"while"  { return WHILE; }
"("      { return LPAREN; }
")"      { return RPAREN; }
";"      { return SEMICOLON; }
[a-zA-Z][a-zA-Z0-9]* { /* handle identifiers */ }
[ \t\n] ; // Ignore whitespace and newline characters
.        { /* Handle unrecognized characters */ }

%%

int yywrap() {
    return 1;
}
