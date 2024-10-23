%{
#include <stdio.h>
#include <stdlib.h>

void *add[100];  // Store memory addresses
char sym[100];   // Store symbols
int x = 0;       // Counter for the number of symbols
%}

%%

[a-zA-Z] {
    sym[x] = yytext[0];               // Store the symbol
    add[x] = malloc(sizeof(char));    // Allocate memory for the identifier
    printf("%c\t %p\t identifier\n", sym[x], add[x]);
    x++;
}

[0-9]+ {
    sym[x] = yytext[0];               // Store the symbol
    add[x] = malloc(sizeof(int));     // Allocate memory for the number
    printf("%s\t %p\t number\n", yytext, add[x]);
    x++;
}

"+"|"-"|"*"|"=" {
    sym[x] = yytext[0];               // Store the symbol
    add[x] = malloc(sizeof(char));    // Allocate memory for the operator
    printf("%c\t %p\t operator\n", sym[x], add[x]);
    x++;
}

[ \t\n]+    { /* Ignore whitespace */ }

[$]          { printf("End of Expression\n"); exit(0); }

.            { /* Any other character will be ignored */ }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Expression terminated by $: ");
    yylex();  // Begin lexical analysis
    return 0;
}
