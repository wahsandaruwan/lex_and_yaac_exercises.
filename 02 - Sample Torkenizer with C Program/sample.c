#include <stdio.h>
#include "samplescanner.h"

// External function which returns a value indicating the type of token that has been obtained
extern int yylex();

// External pointer variable to the matched string (NULL-terminated)
extern char* yytext;

// Pointer data array for keys
char *data[] = {NULL, "user_name", "user_age", "user_designation", "user_school", "user_lucky_number"};

// Main function
int main(void){
    int ntoken, vtoken;

    // Get first name token
    ntoken = yylex();

    // Iterate each name token
    while(ntoken){

        // Print name token
        printf("%d\n", ntoken);

        // Check if COLON is available after any key
        if(yylex() != COLON){
            printf("Syntax error, Expected a ':' but found %s\n", yytext);
            return 1;
        }

        // Get the value token
        vtoken = yylex();

        // Set outputs for each token type
        switch(ntoken){
            case NAME:
            case DESIGNATION:
            case SCHOOL:
                // Check if NAME, DESIGNATION & SCHOOL are IDENTIFIERS 
                if(vtoken != IDENTIFIER){
                    printf("Syntax error, Expected an Identifier but found %s\n", yytext);
                    return 1;
                }
                printf("%s is set to %s\n", data[ntoken], yytext);
                break;
            case AGE:
            case LUCKY_NUMBER:
                // Check if AGE & LUCKY_NUMBER are INTERGERS 
                if(vtoken != INTEGER){
                    printf("Syntax error, Expected an Integer but found %s\n", yytext);
                    return 1;
                }
                printf("%s is set to %s\n", data[ntoken], yytext);
                break;
            default:
                printf("Syntax error.\n");
        }

        // Check if SEMICOLON is available after any value
        if(yylex() != SEMICOLON){
            printf("Syntax error, Expected a ';' but found %s\n", yytext);
            return 1;
        }

        // Get next name token
        ntoken = yylex();
    }
    return 0;
}