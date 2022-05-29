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
%token tADD tSUB tMUL tDIV tEQ tINF tSUP tEQUAL tDIF tAND tOR
%token tCOMMENT
%token <nb> tNB
%token <str> tID
%start Program

%%

Program : tINT tMAIN tOP tCP Body ;

Body : tOB Content tCB {
                        ts_inc_depth(); 
                       } ;

Content : | Instruction Content ; 

Instruction : Declaration 
              | Affectation
              | LoopIf
              | LoopWhile
              | Print
              | Return 
              | tCOMMENT ; 



/*************************************************************************/
/****************************** DECLARATION ******************************/
/*************************************************************************/

Declaration : tINT DecNext tSC ; 

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
                
DecNext : tID tEQ   { if (ts_exists_sym($1)){
                        fprintf(stderr,"The variable already exists\n");
                        return 1;
                    } else { 
                        ts_add_sym($1, "int");}
                    }                
                    Arith_Expr {
                        asm_add_copy(ts_get_addr($1)); 
                        ts_init($1);
                    } ; 

DecNext : tID tEQ Arith_Expr tCOM DecNext { 
                if (ts_exists_sym($1)){
                    fprintf(stderr,"The variable already exists\n");
                    return 1;
                } else { 
                    ts_add_sym($1, "int");
                    asm_add_copy(ts_get_addr($1)); 
                    ts_init($1);
                }} ; 



/*************************************************************************/
/****************************** AFFECTATION ******************************/
/*************************************************************************/

Affectation : tID tEQ Expr tSC { 
                                asm_add_copy(ts_get_addr($1)); 
                                ts_init($1);
                                };



/*************************************************************************/
/********************************* LOOP IF *******************************/
/*************************************************************************/
                                
LoopIf : tIF tOP Condition tCP Body SuiteIf ;
SuiteIf : | tELSE Body
          | tELSE tIF tOP Condition tCP Body SuiteIf;


/*************************************************************************/
/******************************* LOOP WHILE ******************************/
/*************************************************************************/

BoucleWhile : tWHILE tOP Condition tCP Body ;


/*************************************************************************/
/********************************** PRINT ********************************/
/*************************************************************************/
Print : tPRINTF tOP Condition {

        } tCP tSC {

        }

/*************************************************************************/
/********************************** RETURN ********************************/
/*************************************************************************/
Return : tRETURN Condition {

        } tSC; 


/*************************************************************************/
/*********************** EXPRESSIONS ARITHMETIQUES ***********************/
/*************************************************************************/

Arith_Expr : MD {
                $$ = $1
             } 
             | Arith_Expr tADD MD {
                ts_free_tmp();
                ts_add_tmp();
                asm_add_instr3(ADD);
                $$=ts_get_last_addr();
             }
             | Arith_Expr tSUB MD {
                ts_free_tmp();
                ts_add_tmp();
                asm_add_instr3(SUB);
                $$=ts_get_last_addr();
             } ;

MD : Element {
        $$ = $1
     }
     | MD tMUL Element {
        ts_free_tmp();
        ts_add_tmp();
        asm_add_instr3(MUL);
        $$=ts_get_last_addr();
$$=temp;
     }  
     | MD tDIV Element {
        ts_free_tmp();
        ts_add_tmp();
        asm_add_instr3(DIV);
        $$=ts_get_last_addr();
     } 

Element : Term 
          | tOP Term tCP ; 

Element : tNB {
            ts_add_tmp();
            asm_add_instr2(AFC, ts_get_last_addr(), $1);
          }
          | tID {
            ts_add_tmp();
            asm_add_instr2(COP, ts_get_last_addr(), ts_get_addr($1));        
          }
          | tOP Element tCP ;



/*************************************************************************/
/************************* EXPRESSIONS BOOLEENNES ************************/
/*************************************************************************/

Condition : Bool_Expr tAND Bool_Expr {
                ts_free_tmp();
                ts_add_tmp();
                asm_add_instr3(AND, temp, $1, $3);
                $$=ts_get_last_addr();
            }
            | Bool_Expr tOR Bool_Expr {
                ts_free_tmp();
                ts_add_tmp();
                asm_add_instr3(OR, temp, $1, $3);
                $$=ts_get_last_addr();
            }
            | Bool_Expr {
                $$ = $1;
            }; 

Bool_Expr : tTRUE
            | tFALSE
            | Arith_Expr tINF Arith_Expr {

            }
            | Arith_Expr tSUP Arith_Expr {

            }
            | Arith_Expr tEQUAL Arith_Expr {

            }
            | Arith_Expr tDIF Arith_Expr {

            };


%%

void yyerror(char *s){
    fprintf(stderr, "%s",s);
    exit(1);
}

