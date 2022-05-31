#ifndef ASM_TABLE_H
#define ASM_TABLE_H

typedef enum Operator {ADD, MUL, SUB, DIV, 
                       COP, AFC, 
                       JMP, JMF, 
                       INF, SUP, EQU, DIF, AND, OR, 
                       PRI} Operator; 

typedef struct Instr {
    Operator op;
    int op1;
    int op2; 
    int op3;
} Instr;


/* Add insutrctions */ 
void asm_add_instr1(Operator op, int op1);
void asm_add_instr2(Operator op, int op1, int op2);
void asm_add_instr3(Operator op, int op1, int op2, int op3);

void asm_add_arith(Operator op);
void asm_add_copy(int addr);

/* Update jump operation */ 
void asm_update_jmp(int to_modify, int new_val);
void asm_update_jmf(int to_modify, int new_val);

/* Print table */ 
void asm_print_table(); 
char* asm_op_toString(Operator op);




#endif
