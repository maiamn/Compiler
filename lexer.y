%{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}

%union { int nb ; char str[16];}
%token tMAIN tPRINTF tRETURN  tIF tELSE tWHILE tTRUE tFALSE
%token tOP tCP tOB tCB 
%token tCONST tINT tCOM tSC
%token tADD tSUB tMUL tDIV tEQ tINF tSUP tEQUAL tDIF
%token <nb> tNB
%token <var> tID
%start Program

%%

Program : Funs ;
Funs : | Fun Funs ;
Fun : tINT tID tOP Params tCP tOB Body tCB ;

Params : | tINT tID ParamsNext ;
ParamsNext : | tCOM tINT tID ParamsNext ;

Body : Declarations Content | Content ;
Declarations : tINT DecNext tSC ; 
DecNext : tID tCOM DecNext
        | tID 
        | Affectations 
        | Affectations tCOM DecNext ;
Affectations : tID tEQ Valeur ;
Valeur : Valeur tADD Valeur 
    | Valeur tMUL Valeur
    | tNB 
    | tID 
    | tOP Valeur tCP;
    
BoucleIf : tIF tOP Condition tCP tOB Content tCB SuiteIf ;
SuiteIf : | tELSE tOB Content tCB
          | tELSE tIF tOP Condition tCP tOB Content tCB SuiteIf;

BoucleWhile : tWHILE tOP Condition tCP tOB Content tCB Content ;

Condition : tTRUE
           | tFALSE;
           /* A COMPLETER */

Content : | Declarations Content | Affectations Content | BoucleIf Content | BoucleWhile Content ;


/*Printf : tPRINTF tOP C tCP*/





%%

void yyerror(char *s){
    fprintf(stderr, "%s",s);
    exit(1);
}

