%{
#include <stdio.h>
#include <string.h>

void generate_assembly(char* op, char* arg1, char* arg2, char* result);
int yywrap() { return 1; }  // Define yywrap here
%}

%%
[a-zA-Z][a-zA-Z0-9]*[ ]*=[ ]*[a-zA-Z][a-zA-Z0-9]*[ ]*[+][ ]*[a-zA-Z][a-zA-Z0-9]* { // Assignment with addition
    char result[20], arg1[20], arg2[20];
    sscanf(yytext, "%s = %s + %s", result, arg1, arg2);
    generate_assembly("+", arg1, arg2, result);
}

[a-zA-Z][a-zA-Z0-9]*[ ]*=[ ]*[a-zA-Z][a-zA-Z0-9]*[ ]*[-][ ]*[a-zA-Z][a-zA-Z0-9]* { // Assignment with subtraction
    char result[20], arg1[20], arg2[20];
    sscanf(yytext, "%s = %s - %s", result, arg1, arg2);
    generate_assembly("-", arg1, arg2, result);
}

[a-zA-Z][a-zA-Z0-9]*[ ]*=[ ]*[a-zA-Z][a-zA-Z0-9]* { // Simple assignment
    char result[20], arg1[20];
    sscanf(yytext, "%s = %s", result, arg1);
    printf("MOV %s, %s\n", result, arg1);
}

goto[ ]+[a-zA-Z0-9]+ { // Goto statement
    char label[20];
    sscanf(yytext, "goto %s", label);
    printf("JMP %s\n", label);
}

if[ ]+[a-zA-Z][a-zA-Z0-9]*[ ]*==[ ]*[a-zA-Z][a-zA-Z0-9]*[ ]+goto[ ]+[a-zA-Z0-9]+ { // If condition
    char arg1[20], arg2[20], label[20];
    sscanf(yytext, "if %s == %s goto %s", arg1, arg2, label);
    printf("CMP %s, %s\n", arg1, arg2);
    printf("JE %s\n", label);
}

[a-zA-Z0-9]+: { // Label
    char label[20];
    sscanf(yytext, "%s:", label);
    printf("%s:\n", label);
}

[ \t\n]+  ; // Ignore whitespace

%%

void generate_assembly(char* op, char* arg1, char* arg2, char* result) {
    if (strcmp(op, "+") == 0) {
        printf("MOV AX, %s\n", arg1);
        printf("ADD AX, %s\n", arg2);
        printf("MOV %s, AX\n", result);
    } else if (strcmp(op, "-") == 0) {
        printf("MOV AX, %s\n", arg1);
        printf("SUB AX, %s\n", arg2);
        printf("MOV %s, AX\n", result);
    }
}

int main() {
    yylex();
    return 0;
}
