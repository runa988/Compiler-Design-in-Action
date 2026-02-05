%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int yylex(void);
void yyerror(const char *s);

int isValid(char *s);
%}

%union {
    char *str;
}

%token <str> IDENTIFIER

%%

input:
     | input line
     ;

line:
     IDENTIFIER '\n'
     {
        if (isValid($1))
            printf("Valid variable name: %s\n", $1);
        else
            printf("Error: Invalid variable name\n");

        free($1);
     }
   | '\n'
   ;

%%

int isValid(char *s)
{
    if (!(isalpha(s[0]) || s[0] == '_'))
        return 0;

    for (int i = 1; s[i]; i++)
        if (!(isalnum(s[i]) || s[i] == '_'))
            return 0;

    return 1;
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main(void) {
    printf("Enter variable names (Ctrl+D to end):\n");
    return yyparse();
}
