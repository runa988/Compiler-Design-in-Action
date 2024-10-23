%{
#include "variable.tab.h"
#include <stdio.h>

void yyerror(const char *s);
%}

%%

[a-zA-Z_][a-zA-Z0-9_]*  { return IDENTIFIER; }
[ \t]                   ;  /* Ignore whitespace */
\n                      { return '\n'; }
.                       { yyerror("Invalid variable name"); }  // Report error only once

%%

int yywrap(void) {
    return 1;
}
