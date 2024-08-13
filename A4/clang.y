%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token WHILE LPAREN RPAREN SEMICOLON IDENTIFIER

%%

program: statements;

statements: /* empty */
          | statements statement;

statement: while_statement
         | other_statement;

while_statement: WHILE LPAREN condition RPAREN SEMICOLON
{
    printf("Valid while statement\n");
};

condition: /* Define your condition rules here */;

other_statement: empty_statement
               | identifier_statement;

empty_statement: SEMICOLON /* Allow empty statement */;

identifier_statement: IDENTIFIER SEMICOLON /* Statement with identifier */;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
