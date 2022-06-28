%{
/* ---C declarations, headers and variables--- */

#include "samplescanner.h"
%}

/* ---Token specifications (Pattern -> Action)--- */

%%
:                           return COLON;
"user_name"                 return NAME;
"user_age"                  return AGE;
"user_designation"          return DESIGNATION;
"user_school"               return SCHOOL;
"user_lucky_number"         return LUCKY_NUMBER;

[a-zA-Z][_a-zA-Z0-9]*       return IDENTIFIER;
[1-9][0-9]*                 return INTEGER;
";"                         return SEMICOLON;
[ \t\n]                     ;
.                           printf("Unexpected character error.\n");
%%

/* ---Functions--- */

/* Called when the scanner encounters the end of the file(input). */
int yywrap(){       
    return 1;
}