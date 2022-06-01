%{
#include <stdlib.h>
#include <stdio.h>
#include "./include/asm_table.h"
#include "./include/ts.h"
#include "./include/jump.h" 
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
%type <nb> Arith_Expr Factor Term Condition Bool_Expr 
%start Program

%%

Program : tINT tID tOP tCP Body ;

/*Body : tOB {
            ts_inc_depth();
       } Content tCB {
           ts_dec_depth();
       };*/ 
Body : tOB Content tCB; 

Content : | Instruction Content ;

Instruction : Declaration
            | Affectation 
            | LoopIf 
            | LoopWhile 
            | Print 
            | Return 
            | tCOMMENT ;     



/*************************************************************************/
/***************************** DECLARATIONS ******************************/
/*************************************************************************/

Declaration : tINT DecNext tSC ; 


DecNext : tID tCOM DecNext { 
                if (ts_exists_sym($1)){
                    fprintf(stderr,"The variable already exists\n");
                    return 1;
                } else { 
                    ts_add_sym($1, "int");} 
                } ;
                
DecNext : tID { 
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



/*************************************************************************/
/***************************** AFFECTATIONS ******************************/
/*************************************************************************/

Affectation : tID tEQ Arith_Expr tSC { 
                                asm_add_copy(ts_get_addr($1)); 
                                ts_init($1);
                                };



/*************************************************************************/
/******************************** LOOP IF ********************************/
/*************************************************************************/
LoopIf : tIF tOP Condition {    
            ts_free_tmp(); 
         }
         tCP {
            jump_add_if(asm_get_index());
            asm_add_instr2(JMF, $3, -1);
         }
         Body IfNext ; 

IfNext : tELSE {
             jump_add_else(asm_get_index());
             asm_add_instr1(JMP, -1);
             asm_update_jmf(jump_pop_if(), asm_get_index());
         }
         Body {
             asm_update_jmp(jump_pop_else(), asm_get_index()); 
         }
         | { asm_update_jmf(jump_pop_if(), asm_get_index()); }; 



/* | tELSE tIF tOP Condition tCP Body IfNext ; */ 


/*************************************************************************/
/****************************** LOOP WHILE *******************************/
/*************************************************************************/
LoopWhile : tWHILE tOP {
                jump_add_while(asm_get_index());
            }
            Condition {
                ts_free_tmp();
            } tCP {
                jump_add_if(asm_get_index());
                asm_add_instr2(JMF, $4, -1);
            }
            Body {
                asm_add_instr1(JMP, jump_pop_while());
                asm_update_jmf(jump_pop_if(), asm_get_index());
            }; 


/*************************************************************************/
/*********************** EXPRESSIONS ARITHMETIQUES ***********************/
/*************************************************************************/

Arith_Expr : Factor {
                $$ = $1;
            } 
            | Arith_Expr tADD Factor {
                ts_free_tmp();
                ts_add_tmp();
                asm_add_arith(ADD);
                $$ = ts_get_last_addr();
            }  
            | Arith_Expr tSUB Factor {
                ts_free_tmp();
                ts_add_tmp();
                asm_add_arith(SUB);
                $$ = ts_get_last_addr();
            } ; 

Factor : Term {
            $$ = $1 ;
        } 
        | Factor tMUL Term {
            ts_free_tmp();
            ts_add_tmp();
            asm_add_arith(MUL);
            $$=ts_get_last_addr();
        } 
        | Factor tDIV Term {
            ts_free_tmp();
            ts_add_tmp();
            asm_add_arith(DIV);
            $$=ts_get_last_addr();
        } ;  

Term : tNB {
            ts_add_tmp();
            asm_add_instr2(AFC, ts_get_last_addr(), $1);
            $$ = $1;
        }  
      | tID {
            ts_add_tmp();
            asm_add_instr2(COP, ts_get_last_addr(), ts_get_addr($1));
            $$ = ts_get_addr($1);
        }  
      | tOP Arith_Expr tCP ;   


/*************************************************************************/
/************************* EXPRESSIONS BOOLEENNES ************************/
/*************************************************************************/ 
Condition : Bool_Expr {
                $$ = $1;
            } 
           | Bool_Expr tAND Bool_Expr {
               ts_free_tmp();
               ts_add_tmp();
               asm_add_arith(AND);
               $$ = ts_get_last_addr();
           } 
           | Bool_Expr tOR Bool_Expr {
               ts_free_tmp();
               ts_add_tmp();
               asm_add_arith(OR);
               $$ = ts_get_last_addr();
           } ;

Bool_Expr : tTRUE {
                $$ = 1;
            }    
           | tFALSE {
               $$ = 0;
           } 
           | Arith_Expr tINF Arith_Expr {
                ts_free_tmp();
                ts_add_tmp();
                asm_add_arith(INF);
                $$ = ts_get_last_addr();
           } 
           | Arith_Expr tSUP Arith_Expr {
                ts_free_tmp();
                ts_add_tmp();
                asm_add_arith(SUP);
                $$ = ts_get_last_addr();
           } 
           | Arith_Expr tDIF Arith_Expr {
                ts_free_tmp();
                ts_add_tmp();
                asm_add_arith(DIF);
                $$ = ts_get_last_addr();
           } 
           | Arith_Expr tEQUAL Arith_Expr {
                ts_free_tmp();
                ts_add_tmp();
                asm_add_arith(EQU);
                $$ = ts_get_last_addr();
           } ;     

/*************************************************************************/
/********************************* PRINT *********************************/
/*************************************************************************/
Print : tPRINTF tOP tNB tCP tSC {
            asm_add_instr1(PRI, $3);
        } 
        | tPRINTF tOP tID tCP tSC {
            if (ts_is_init($3)==0){
                fprintf(stderr,"The variable is not initialized\n");
                return 1;
            } else { 
                asm_add_instr1(PRI, ts_get_addr($3));
            } 
        }  ;

/*************************************************************************/
/******************************** RETURN *********************************/
/*************************************************************************/
Return : tRETURN Expr tSC {
            ts_free_all(); 
         } ; 

Expr : Arith_Expr | Bool_Expr ;  

%%

void yyerror(char *s){
    fprintf(stderr, "%s",s);
    exit(1);
}

