%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Function to evaluate constant expressions
int evaluate(int left, char op, int right) {
    switch (op) {
        case '+': return left + right;
        case '-': return left - right;
        case '*': return left * right;
        case '/': return left / right;
        case '%': return left % right;
        case '^': return pow(left, right);  // power operation
        default: return 0;
    }
}
%}

%%

[ \t\n]+           ;   // Ignore whitespaces
[0-9]+             { /* Handle numbers here */ }
"+"                { return '+'; }
"-"                { return '-'; }
"*"                { return '*'; }
"/"                { return '/'; }
"%"                { return '%'; }
"^"                { return '^'; }

"n*1"              { printf("Strength Reduction: %s -> n\n", yytext); }
"1*n"              { printf("Strength Reduction: %s -> n\n", yytext); }
"n*0"              { printf("Strength Reduction: %s -> 0\n", yytext); }
"0*n"              { printf("Strength Reduction: %s -> 0\n", yytext); }
"n/1"              { printf("Strength Reduction: %s -> n\n", yytext); }
"n^2"              { printf("Algebraic Transformation: %s -> n*n\n", yytext); }
"2^n"              { printf("Algebraic Transformation: %s -> n+n\n", yytext); }
[0-9]+[\+\-\*/%][0-9]+ { 
                        int left, right;
                        char op;
                        sscanf(yytext, "%d%c%d", &left, &op, &right);
                        int result = evaluate(left, op, right);
                        printf("Constant Folding: %s -> %d\n", yytext, result); 
                      }

%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
