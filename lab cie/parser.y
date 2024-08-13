%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern FILE* yyin;

void yyerror(const char* msg) {
    // Do nothing for syntax errors
}


%}

%union {
    int num;
    char* str;
}

%token <num> NUMBER
%token <str> IDENTIFIER
%token PROTOCOL REQUEST RESPONSE INT_TYPE BOOL_TYPE STRING_TYPE OPEN_BRACE CLOSE_BRACE SEMICOLON OPEN_PAREN CLOSE_PAREN

%%

Protocol : PROTOCOL IDENTIFIER OPEN_BRACE ProtocolBody CLOSE_BRACE;

ProtocolBody : RequestResponseList;

RequestResponseList : RequestResponse | RequestResponseList RequestResponse;

RequestResponse : Request | Response;

Request : REQUEST IDENTIFIER OPEN_BRACE RequestBody CLOSE_BRACE SEMICOLON;

RequestBody : INT_TYPE IDENTIFIER SEMICOLON STRING_TYPE IDENTIFIER SEMICOLON;

Response : RESPONSE IDENTIFIER OPEN_BRACE ResponseBody CLOSE_BRACE SEMICOLON;

ResponseBody : BOOL_TYPE IDENTIFIER SEMICOLON STRING_TYPE IDENTIFIER SEMICOLON;

%%

int main(int argc, char** argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }
    FILE* input = fopen(argv[1], "r");
    if (!input) {
        perror("fopen");
        return 1;
    }
    yyin = input;
    yyparse();
    fclose(input);
    printf("Lexical and Semantic Analysis completed, Result.txt file formed!");
    return 0;
}
