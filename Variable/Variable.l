%{
#include "variable.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%

[^\n]+   {
            yylval.str = strdup(yytext);
            return IDENTIFIER;
         }

\n        { return '\n'; }

%%

int yywrap(void) {
    return 1;
}
