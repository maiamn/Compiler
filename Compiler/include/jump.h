#ifndef JUMP_H
#define JUMP_H

/* Type stack node */
typedef struct Node {
    int index ;
    struct Node *next;
} Node; 

/* IF */ 
void jump_add_if(int line);
int jump_pop_if();

/* ELSE */
void jump_add_else(int line);
int jump_pop_else(); 

/* WHILE */
void jump_add_while(int line);
int jump_pop_while();

#endif