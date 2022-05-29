#include "interpreter.h"
#include "asm_table.h"
#define INSTR_MAX 1024
Instr asm_table[INSTR_MAX];
int index = 0;

void start_interpreter(int nbInstr) {

    /* Parcourir toutes la table des instructions */
    while(index<nbInstr) {

        /* Traitement selon l'opérateur */ 
        switch(asm_table[index].operator) {
            // ADD
            case 1 :
                break; 

            // MUL
            case 2 :
                break;

            // SUB
            case 3 : 
                break; 

            // DIV 
            case 4 : 
                break;

            // COP
            case 5 : 
                break;

            // AFC 
            case 6 :
                break;

            // JMP
            case 7 : 
                break; 

            // JMF
            case 8 : 
                break; 

            // INF
            case 9 : 
                break; 

            // SUP
            case 10 : 
                break;

            // EQU
            case 11 : 
                break; 

            // PRI
            case 12 : 
                break; 

        }
    }

}


