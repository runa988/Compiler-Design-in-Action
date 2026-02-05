%{
#include <stdio.h>
%}

DIGIT       [0-9]
OPERATOR    [+*-/]
PARENTHESIS [()]


%%

{DIGIT}+    { printf("NUMBER: %s\n", yytext); }
{OPERATOR}  { printf("OPERATOR: %s\n", yytext); }

[ \t\n]     ; // Ignore whitespace characters

.           { printf("INVALID: %s\n", yytext); }

%%

// Define the yywrap function to indicate the end of the input stream (optional)
int yywrap() {
    return 1; // Return 1 to indicate the end of the input stream (lexer termination).
}


int main() {
    printf("Enter the arithmetic expression:\n");
    yylex();
    return 0;
}
