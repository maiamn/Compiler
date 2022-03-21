%{
#include <stdlib.h>
#include <stdio.h>
#include <asm_table.h>
#include <ts.h>
int var[24];
void yyerror(char *s);
%}

%union { int nb ; char str[24];}
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
        | tID {ts_add_sym($1)}
        | Affectations 
        | Affectations tCOM DecNext ;
Affectations : tID tEQ Valeur ;
Valeur : Valeur tADD Valeur {add_instr3(ADD, $1, $1, $3)}
    | Valeur tMUL Valeur {add_instr3(MUL, $1, $1, $3)}
    | Valeur tSUB Valeur {add_instr3(SUB, $1, $1, $3)}
    | Valeur tDIV Valeur {add_instr3(DIV, $1, $1, $3)}
    | tNB {ts_add_tmp();
           asm_add_instr2(AFC, ts_get_last_addr(), $1)}
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

