%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

extern char *yytext;  // Declare yytext as an external variable
%}

%token IDENTIFIER

%%

input:
    | input line
    ;

line:
    IDENTIFIER '\n' { printf("Valid variable name: %s\n", yytext); }
    | '\n'
    | error '\n' { yyerrok; }  // Handle errors and continue parsing
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter variable names (press Ctrl+D to end):\n");
    return yyparse();
}
