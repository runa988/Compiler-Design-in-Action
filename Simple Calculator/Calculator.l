%{
#include "Calculator_R.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+(\.[0-9]+)?   { yylval.dval = atof(yytext); return NUMBER; }

[ \t]       { /* Ignore whitespace */ }

\n          { return '\n'; }

"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
"%"         { return '%'; }
"("         { return '('; }
")"         { return ')'; }

.           { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
