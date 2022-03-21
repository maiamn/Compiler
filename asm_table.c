/* En-tête du fichier */
#include "stdio.h"
#include "string.h"
#include "asm_table.h"
#define INSTR_MAX 1024

/* Variables globales */
Instr asm_table[INSTR_MAX];
int indice = 0 ;

/* Ajout d'une instruction avec 1 paramètre */
void asm_add_instr1(Operator op, int op1){
    Instr newIns = {op, op1};
    asm_table[indice] = newIns;
    indice++;

}

/* Ajout d'une instruction avec 2 paramètres */
void asm_add_instr2(Operator op, int op1, int op2){
    Instr newIns = {op, op1, op2};
    asm_table[indice] = newIns;
    indice++;

}

/* Ajout d'une instruction avec 3 paramètres */
void asm_add_instr3(Operator op, int op1, int op2, int op3){
    Instr newIns = {op, op1, op2, op3};
    asm_table[indice] = newIns;
    indice++;

}

/* operator toString */
char* asm_op_toString(Operator op){
    char* op_str ;
    switch(op) {
        case ADD : 
            op_str="ADD";
            break;
        case MUL : 
            op_str="MUL";
            break;
        case SOU : 
            op_str="SOU";
            break;
        case DIV : 
            op_str="DIV";
            break;
        case COP : 
            op_str="COP";
            break;
        case AFC : 
            op_str="AFC";
            break;
        case JMP : 
            op_str="JMP";
            break;
        case JMF : 
            op_str="JMF";
            break;
        case INF : 
            op_str="INF";
            break;
        case SUP : 
            op_str="SUP";
            break;
        case EQU : 
            op_str="EQU";
            break;
        case PRI : 
            op_str="PRI";
            break;
    }
    return op_str;
}

/* Afficher la table */
void asm_print_table(){
    for (int i=0; i<indice; i++) {
        printf("Operator : %s // Op1 : %d // Op2 : %d // Op3 : %d \n", 
                asm_op_toString(asm_table[i].op), 
                asm_table[i].op1, 
                asm_table[i].op2, 
                asm_table[i].op3);

    }
}



