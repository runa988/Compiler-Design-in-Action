%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

int temp_count = 1;
%}

%union {
    char *str;
}

%token <str> NUMBER
%type <str> E

/* Operator precedence */
%left '+'
%left '*'

%%

S : E {
        printf("Result: %s\n", $1);
    }
  ;

E : E '+' E {
        char temp[10];
        sprintf(temp, "t%d", temp_count++);
        printf("%s = %s + %s\n", temp, $1, $3);
        $$ = strdup(temp);
    }
  | E '*' E {
        char temp[10];
        sprintf(temp, "t%d", temp_count++);
        printf("%s = %s * %s\n", temp, $1, $3);
        $$ = strdup(temp);
    }
  | '(' E ')' {
        $$ = $2;
    }
  | NUMBER {
        $$ = strdup($1);
    }
  ;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main() {
    printf("Enter expression:\n");
    yyparse();
    return 0;
}
