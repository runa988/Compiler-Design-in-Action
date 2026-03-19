%{
#include "ICG.tab.h"
#include <string.h>
%}

%%

[0-9]+      { yylval.str = strdup(yytext); return NUMBER; }
[ \t]       ;
\n          return 0;
"+"         return '+';
"*"         return '*';
"("         return '(';
")"         return ')';

.           return yytext[0];

%%

int yywrap() {
    return 1;
}
