/* En-tête du fichier */
#include <stdio.h>
#include <stdlib.h>
#include <string.h> 
#include "../include/asm_table.h"
#include "../include/ts.h" 
/* Definition */ 
#define INSTR_MAX 1024

/* Variables globales */
Instr asm_table[INSTR_MAX];
int indice_ti = 0 ;

/* Ajout d'une instruction avec 1 paramètre */
void asm_add_instr1(Operator op, int op1){
    Instr newIns = {op, op1, -1, -1};
    asm_table[indice_ti] = newIns;
    indice_ti++;

}

/* Ajout d'une instruction avec 2 paramètres */
void asm_add_instr2(Operator op, int op1, int op2){
    Instr newIns = {op, op1, op2, -1} ;
    asm_table[indice_ti] = newIns;
    indice_ti++;

}

/* Ajout d'une instruction avec 3 paramètres */
void asm_add_instr3(Operator op, int op1, int op2, int op3){
    Instr newIns = {op, op1, op2, op3};
    asm_table[indice_ti] = newIns;
    indice_ti++;

}

/* operator toString */
char *opToStr[] = {[ADD]="ADD",[MUL]="MUL",[SUB]="SUB",[DIV]="DIV",
                   [COP]="COP",[AFC]="AFC",
                   [JMP]="JMP",[JMF]="JMF",
                   [INF]="INF",[SUP]="SUP",[DIF]="DIF", [EQU]="EQU",[AND]="AND",[OR]="OR",
                   [PRI]="PRI"};

char* asm_op_toString(Operator op){
    return opToStr[op];
}

/* Ajout d'une instruction arithmétique dans la table */
void asm_add_arith(Operator op) {
    asm_add_instr3(op, ts_get_second_to_last_tmp(), ts_get_second_to_last_tmp(), ts_get_last_tmp());
    ts_free_tmp();
}

/* Ajout d'une instruction copy dans la table */
void asm_add_copy(int addr) {
    asm_add_instr2(COP, addr, ts_get_last_tmp());
    ts_free_tmp();
}

/* Get instruction line */ 
int asm_get_index() {
    return indice_ti;
}

/* Modification des valeurs des jump */ 
void asm_update_jmp(int to_modify, int new_val) {
    Instr to_be_modified = asm_table[to_modify];
    Instr newInstr = (Instr) {to_be_modified.op, 
                     new_val, 
                     to_be_modified.op2, 
                     to_be_modified.op3} ;
    asm_table[to_modify] = newInstr;
} 

void asm_update_jmf(int to_modify, int new_val) {
    Instr to_be_modified = asm_table[to_modify];
    Instr newInstr = (Instr) {to_be_modified.op, 
                     to_be_modified.op1, 
                     new_val, 
                     to_be_modified.op3} ;
    asm_table[to_modify] = newInstr;
} 


/* Afficher la table */
void asm_print_table(){
    for (int i=0; i<indice_ti; i++) {
        printf("Operator : %s // Op1 : %d // Op2 : %d // Op3 : %d \n", 
                asm_op_toString(asm_table[i].op), 
                asm_table[i].op1, 
                asm_table[i].op2, 
                asm_table[i].op3);

    }
}



