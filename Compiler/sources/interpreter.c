/* En-tête du fichier */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "../include/interpreter.h"
#include "../include/asm_table.h"
/* Definition */ 
#define INSTR_MAX 1024
#define MEM_MAX 500
Instr asm_table[INSTR_MAX];
int memory[MEM_MAX];
int line = 0;


// OBJECTIF : parcourir la table des instructions assembleur
// Réalisation de chaque instruction en C

void start_interpreter(int nbInstr) {

    asm_print_table();
    memset(memory, -1, sizeof(memory));

    int op1, op2, op3; 

    /* Parcourir toutes la table des instructions */
    while(line<nbInstr) {
        //printf("%s\n", asm_op_toString(asm_table[line].op));
        op1=asm_table[line].op1;
        op2=asm_table[line].op2;
        op3=asm_table[line].op3;

        /* Traitement selon l'opérateur */ 
        switch(asm_table[line].op) {
            // ADD
            case 0 :
                memory[op1]=memory[op2]+memory[op3];
                line++;
                break; 

            // MUL
            case 1 :
                memory[op1]=memory[op2]*memory[op3];
                line++;
                break;

            // SUB
            case 2 : 
                memory[op1]=memory[op2]-memory[op3];
                line++;
                break; 

            // DIV 
            case 3 : 
                memory[op1]= (int) (memory[op2]/memory[op3]);
                line++;
                break;

            // COP
            case 4 : 
                memory[op1]=memory[op2];
                line++;
                break;

            // AFC 
            case 5 :
                memory[op1]=op2;
                line++;
                break;

            // JMP
            case 6 : 
                line=op1;
                break; 

            // JMF
            case 7 : 
                if (!memory[op1]) {
                    line=op2;
                }
                else {
                    line++;
                }
                break; 

            // INF
            case 8 : 
                memory[op1]=memory[op2]<memory[op3];
                line++;
                break; 

            // SUP
            case 9 : 
                memory[op1]=memory[op2]>memory[op3];
                line++;
                break;

            // EQU
            case 10 : 
                memory[op1]=memory[op2]==memory[op3];
                line++;
                break; 

            //DIF
            case 11 : 
                memory[op1]=memory[op2]!=memory[op3];
                line++;
                break; 

            // AND
            case 12 : 
                memory[op1]=memory[op2]&&memory[op3];
                line++;
                break;

            // OR
            case 13 :
                memory[op1]=memory[op2]||memory[op3];
                line++;
                break;

            // PRI
            case 14 : 
                printf("%d\n", memory[op1]);
                line++;
                break; 

        }
    }

}