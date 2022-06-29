%{
/* ---C declarations, headers and variables--- */

#include <stdio.h>
#include <string.h>
#include "sample.tab.h"
void showError();
%}

/* ---Regular Expressions --- */

numbers     ([0-9])+
alpha       ([a-zA-Z])+

/* ---Token specifications (Pattern -> Action)--- */

%%
{alpha}     {sscanf(yytext, "%s", yylval.name); return (STRING);}
{numbers}   {yylval.number = atoi(yytext); return (NUM);}
";"         {return (SEMICOLON);}
.           {showError(); return (OTHER);}
%%

/* ---Functions--- */

/* Display the errors for invalid inputs. */
void showError(){
    printf("Other input");
}

/* Called when the scanner encounters the end of the file(input). */
int yywrap(){
    return 1;
}