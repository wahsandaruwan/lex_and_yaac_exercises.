%{
/* ---C declarations, headers and variables--- */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
int symbols[52];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
int yylex();
void yyerror(char const *s);
%}

/* ---Yacc definitions--- */

%union{
    int num;
    char ident;
}
%start stmt
%token PRINT
%token EXIT
%token <num> NUMBER
%token <ident> IDENTIFIER
%type <num> stmt exp term
%type <ident> assignment

/* ---Descriptions of expected inputs | Corresponding actions in C--- */

%%
stmt        : assignment ';'            {;}
            | EXIT ';'                  {exit(0);}
            | PRINT exp ';'             {printf("Printing %d\n", $2)}
            | stmt assignment ';'       {;}
            | stmt PRINT exp ';'        {printf("Printing %d\n", $3)}
            | stmt EXIT ';'             {exit(0);}
            ;

assignment  : IDENTIFIER '=' exp        {updateSymbolVal($1, $3);}
            ;

exp         : term                      {$$ = $1;}
            | exp '+' term              {$$ = $1 + $3;}
            | exp '-' term              {$$ = $1 - $3;}
            ;

term        : NUMBER                    {$$ = $1;}
            | IDENTIFIER                {$$ = symbolVal($1);}
            ;
%%

/* ---Functions--- */

/* Get the correct symbol index */
int computeSymbolIndex(char token){
    int index = -1;
    if(islower(token)){
        index = token - 'a' + 26;
    }
    else if(isupper(token)){
        index = token - 'A';
    }
    return index;
}

/* Returns the value of given symbol */
int symbolVal(char symbol){
    int bucket = computeSymbolIndex(symbol);
    return symbols[bucket];
}

/* Updates the value of a given symbol */
void updateSymbolVal(char symbol, int val){
    int bucket = computeSymbolIndex(symbol);
    symbols[bucket] = val;
}

/* Report the parse error */
void yyerror(char const *s){
    printf("drd%s\n", s);
}

/* Starting point */
int main(void){
    /* Initialize the symbol table */
    int i;
    for(i = 0; i < 52; i++){
        symbols[i] = 0;
    }

    return yyparse();
}