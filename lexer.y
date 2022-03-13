%{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}

%union { int nb ; char str[16];}
%token tMAIN tPRINTF tRETURN  tIF tELSE tWHILE
%token tOP tCP tOB tCB 
%token tCONST tINT tCOM tSC
%token tADD tSUB tMUL tDIV tEQ
%token <nb> tNB
%token <var> tID
%token
%start Program

%%

Program : Funs ;
Funs : | Fun Funs ;
Fun : tINT tID tOP Params tCP tOB Body tCB ;

Params : | tINT tID ParamsNext ;
ParamsNext : tCOM tINT tID ParamsNext ;

Body : Affectations | ;
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
    
Boucleif : tIF tOP Condition tCP tOB Content tCB Suiteif ;
Suiteif : | Content 
          | tELSE tOB Content tCB
          | tELSE tIF tOP Condition tCP tOB Content tCB ;

Bouclewhile : tWHILE tOP Condition tCP tOB Content tCB Content ;

Content : TOUT ;
Condition : ;

Printf : tPRINTF tOP C tCP





%%

void yyerror(char *s){
    fprintf(stderr, "%s",s);
    exit(1);
}

/* syntaxe correcte mais éditeur de texte reconnait pas ?*/
