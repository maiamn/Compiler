/* En-tête du fichier */
#include <stdio.h>
#include <stdlib.h>
#include "../include/interpreter.h"
#include "../include/asm_table.h"
/* Definition */ 
#define INSTR_MAX 1024
#define MEM_MAX 500
Instr asm_table[INSTR_MAX];
int memory[MEM_MAX];
int index = 0;

// OBJECTIF : parcourir la table des instructions assembleur
// Réalisation de chaque instruction en C

void start_interpreter(int nbInstr) {

    /* Parcourir toutes la table des instructions */
    while(index<nbInstr) {

        /* Traitement selon l'opérateur */ 
        switch(asm_table[index].operator) {
            // ADD
            case 0 :
                memory[op1]=memory[op2]+memory[op3];
                index++;
                break; 

            // MUL
            case 1 :
                memory[op1]=memory[op2]*memory[op3];
                index++;
                break;

            // SUB
            case 2 : 
                memory[op1]=memory[op2]-memory[op3];
                index++;
                break; 

            // DIV 
            case 3 : 
                memory[op1]= (int) (memory[op2]/memory[op3]);
                index++;
                break;

            // COP
            case 4 : 
                memory[op1]=memory[op2];
                index++;
                break;

            // AFC 
            case 5 :
                memory[op1]=op2;
                index++;
                break;

            // JMP
            case 6 : 
                index=op1;
                index++;
                break; 

            // JMF
            case 7 : 
                if (!memory[op1]) {
                    index=op2;
                }
                else {
                    index++;
                }
                break; 

            // INF
            case 8 : 
                memory[op1]=memory[op2]<memory[op3];
                index++;
                break; 

            // SUP
            case 9 : 
                memory[op1]=memory[op2]>memory[op3];
                index++;
                break;

            // EQU
            case 10 : 
                memory[op1]=memory[op2]==memory[op3];
                index++;
                break; 

            // AND
            case 11 : 
                memory[op1]=memory[op2]&&memory[op3];
                index++;
                break;

            // OR
            case 12:
                memory[op1]=memory[op2]||memory[op3];
                index++;
                break;

            // PRI
            case 13 : 
                printf("%d\n", memory[op1]);
                index++;
                break; 

        }
    }

}


