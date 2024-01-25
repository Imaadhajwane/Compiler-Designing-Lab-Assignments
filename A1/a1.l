%{
#include <stdio.h>

FILE *identifierFile;
int headingPrinted = 0;  // Flag to check if heading is printed

%}

%option noyywrap

digit       [0-9]
letter      [a-zA-Z]
identifier  {letter}({letter}|{digit})*

%%

[ \t\n]      ; // Ignore whitespaces and tabs

"if"         { printHeading(); printf("%-10s %-15s %-15s %s\n", "Line", "Lexeme", "Token", "Token Value"); }
"else"       { printHeading(); printf("%-10s %-15s %-15s %s\n", "Line", "Lexeme", "Token", "Token Value"); }
"while"      { printHeading(); printf("%-10s %-15s %-15s %s\n", "Line", "Lexeme", "Token", "Token Value"); }
"int"        { printHeading(); printf("%-10s %-15s %-15s %s\n", "Line", "Lexeme", "Token", "Token Value"); }

{identifier} {
    printf("%-10d %-15s %-15s %s\n", yylineno, yytext, "IDENTIFIER", yytext);
    fprintf(identifierFile, "%s\n", yytext);
}

[;,\{\}\(\)\[\]:] { printHeading(); printf("%-10d %-15s %-15s %s\n", yylineno, yytext, "DELIMITER", yytext); }
[+\-*/]      { printHeading(); printf("%-10d %-15s %-15s %s\n", yylineno, yytext, "OPERATOR", yytext); }

{digit}+     { printHeading(); printf("%-10d %-15s %-15s %s\n", yylineno, yytext, "CONSTANT", yytext); }
{letter}({letter}|{digit})*   ; // Ignore identifiers for now

%%

void printHeading() {
    if (!headingPrinted) {
        printf("\n%-10s %-15s %-15s %s\n", "Line", "Lexeme", "Token", "Token Value");
        printf("-------------------------------------------------------\n");
        headingPrinted = 1;
    }
}

int main() {
    printf("Enter input:\n");

    // Your previous code for file handling
    identifierFile = fopen("identifiers.txt", "w");
    if (identifierFile == NULL) {
        perror("Error opening identifiers.txt");
        return 1;
    }

    yylex();

    // Close the identifier file
    fclose(identifierFile);

    return 0;
}
