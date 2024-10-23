%{
#include<stdio.h>
#include<stdlib.h>
int temp_count=0;
void yyerror(const char*s){
fprintf(stderr,"Error:%s\n",s);
}
%}
%token NUM EOL
%left '+' '-'
%left '*' '/'
%%
program:lines
;
lines:lines line
| line
;
line:expr EOL
{
printf("Result:t%d\n",$1);
}
;
expr:NUM{
$$=$1;
}
| '(' expr ')'
{
$$=$2;
}
| expr '+' expr
{
printf("t%d=%d+%d\n",++temp_count,$1,$3);
$$=temp_count;
}
| expr '-' expr
{
printf("t%d=%d-%d\n",++temp_count,$1,$3);
$$=temp_count;
}
| expr '*' expr
{
printf("t%d=%d*%d\n",++temp_count,$1,$3);
$$=temp_count;
}
| expr '/' expr
{
if($3==0)
{yyerror("Division by zero");

$$=0;}
else{
printf("t%d=%d/%d\n",++temp_count,$1,$3);
$$=temp_count;
}
}
;
%%
int main()
{
yyparse();
return 0;
}