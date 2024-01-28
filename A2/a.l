%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int line_number = 1;
%}

%option noyywrap

%{
enum TokenType {
    NOUN,
    PRONOUN,
    VERB,
    ADJECTIVE,
    ADVERB,
    PREPOSITION,
    CONJUNCTION,
    INTERJECTION
};
%}

%%
[ \t]+              ; // Ignore whitespace
\n                  { line_number++; }
"/*".*?"*/"         ; // Ignore multiline comments

she|he|it|they      { printf("| %-15d | %-15s | %-15s | %-15d |\n", line_number, "PRONOUN", yytext, line_number); }
beautiful           { printf("| %-15d | %-15s | %-15s | %-15d |\n", line_number, "ADJECTIVE", yytext, line_number); }
is                  { printf("| %-15d | %-15s | %-15s | %-15d |\n", line_number, "VERB", yytext, line_number); }
[.!?]               { printf("| %-15d | %-15s | %-15s | %-15d |\n", line_number, "INTERJECTION", yytext, line_number); }
[.,;]               { printf("| %-15d | %-15s | %-15s | %-15d |\n", line_number, "CONJUNCTION", yytext, line_number); }
and|but|or          { printf("| %-15d | %-15s | %-15s | %-15d |\n", line_number, "CONJUNCTION", yytext, line_number); }
in|on|at            { printf("| %-15d | %-15s | %-15s | %-15d |\n", line_number, "PREPOSITION", yytext, line_number); }
[[:alpha:]]+        { printf("| %-15d | %-15s | %-15s | %-15d |\n", line_number, "NOUN", yytext, line_number); }
[[:alpha:]]+ly      { printf("| %-15d | %-15s | %-15s | %-15d |\n", line_number, "ADVERB", yytext, line_number); }
.                   { printf("| %-15d | %-15s | %-15s | %-15d |\n", line_number, "UNKNOWN", yytext, line_number); } // Handle unmatched characters

%%

int main() {
    // Print table header
    printf("| %-15s | %-15s | %-15s | %-15s |\n", "Line", "Token Type", "Lexeme", "Value");
    printf("|-----------------|-----------------|-----------------|-----------------|\n");

    yyin = fopen("input.txt", "r");
    if (!yyin) {
        fprintf(stderr, "Unable to open input file.\n");
        return 1;
    }

    yylex();

    fclose(yyin);
    return 0;
}
