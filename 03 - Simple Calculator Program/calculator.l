%{
#include "calculator.tab.h"   
%}

%%
"print"                     {return PRINT;}
"exit"                      {return EXIT;}
[a-zA-Z]                    {yylval.ident = yytext[0]; return IDENTIFIER;}
[0-9]+                      {yylval.num = atoi(yytext); return NUMBER;}
[ \t\n]                     ;
[-+=;]                      {return yytext[0];}
.                           {yyerror("Unexpected character error.");}
%%

int yywrap(void){
    return 1;
}