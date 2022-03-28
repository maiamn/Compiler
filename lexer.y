%{
#include <stdlib.h>
#include <stdio.h>
#include "asm_table.h"
#include "ts.h"
int var[24];
void yyerror(char *s);
%}

%union { int nb ; char str[24];}
%token tMAIN tPRINTF tRETURN  tIF tELSE tWHILE tTRUE tFALSE
%token tOP tCP tOB tCB 
%token tCONST tINT tCOM tSC
%token tADD tSUB tMUL tDIV tEQ tINF tSUP tEQUAL tDIF
%token <nb> tNB
%token <str> tID
%start Program

%%

Program : Funs ;
Funs : | Fun Funs ;
Fun : tINT tID tOP Params tCP tOB Body tCB ;

Params : | tINT tID ParamsNext ;
ParamsNext : | tCOM tINT tID ParamsNext ;

Body : Declarations Content | Content ;



/*************************************************************************/
/***************************** DECLARATIONS ******************************/
/*************************************************************************/

Declarations : tINT DecNext tSC ; 


DecNext : tID tCOM DecNext { 
                if (ts_exists_sym($1)){
                    fprintf(stderr,"The variable already exists\n");
                    return 1;
                }else { 
                    ts_add_sym($1, "int");} 
                } ;
                
DecNext :  tID { 
                if (ts_exists_sym($1)){
                    fprintf(stderr,"The variable already exists\n");
                    return 1;
                }else { 
                    ts_add_sym($1, "int");} 
                } ; 
                
DecNext : tID tEQ {if (ts_exists_sym($1)){
                        fprintf(stderr,"The variable already exists\n");
                        return 1;
                  } else { 
                        ts_add_sym($1, "int");
                  }}                
                  Expr {
                        asm_add_copy(ts_get_addr($1)); 
                        ts_init($1);
                  }; 

DecNext : tID tEQ Expr tCOM DecNext { 
                if (ts_exists_sym($1)){
                    fprintf(stderr,"The variable already exists\n");
                    return 1;
                }else { 
                    ts_add_sym($1, "int");
                    asm_add_copy(ts_get_addr($1)); 
                    ts_init($1);
                }} ; 




/*************************************************************************/
/***************************** AFFECTATIONS ******************************/
/*************************************************************************/

Affectations : tID tEQ Expr tSC { 
                                asm_add_copy(ts_get_addr($1)); 
                                ts_init($1);
                                };



/*************************************************************************/
/****************************** EXPRESSIONS ******************************/
/*************************************************************************/


Expr : Expr tADD Expr { 
                        asm_add_arith(ADD);
                      } ;
Expr : Expr tMUL Expr {
                        asm_add_arith(MUL);
                      } ;
Expr : Expr tSUB Expr {
                        asm_add_arith(SUB);
                      } ;
Expr : Expr tDIV Expr {
                        asm_add_arith(DIV);
                      } ;
Expr : tNB {ts_add_tmp();
           asm_add_instr2(AFC, ts_get_last_addr(), $1);} ;
Expr : tID  { 
            ts_add_tmp();
            asm_add_instr2(COP, ts_get_last_addr(), ts_get_addr($1));
            };
Expr : tOP Expr tCP;
    
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

