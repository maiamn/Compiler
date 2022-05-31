/* En-tête du fichier */
#include <stdio.h>
#include <stdlib.h>
#include "../include/jump.h"

/* Definition */
Node* ifStack = NULL;
Node* elseStack = NULL;
Node* whileStack = NULL; 

/* Is a structure empty */
int is_empty(stack) {
    return !stack;
}

/* IF */ 
void jump_add_if(int line){
    // Create a new node 
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->index=line;
    newNode->next=ifStack;
    // WhileStack must point to the new start 
    ifStack=newNode;
} 

int jump_pop_if() {
    int line=-1;
    if (is_empty(ifStack)) {
        printf("Cannot pop the while stack as it is empty!");
    } else {
        Node* pop = ifStack;
        ifStack = ifStack->next;
        line = pop->index;
        free(pop);
    } 
    return line;
} 



/* ELSE */
void jump_add_else(int line) {
    // Create a new node 
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->index=line;
    newNode->next=elseStack;
    // WhileStack must point to the new start 
    elseStack=newNode;
} 

int jump_pop_else() {
    int line=-1;
    if (is_empty(elseStack)) {
        printf("Cannot pop the while stack as it is empty!");
    } else {
        Node* pop = elseStack;
        elseStack = elseStack->next;
        line = pop->index;
        free(pop);
    } 
    return line;
}  



/* WHILE */
void jump_add_while(int line) {
    // Create a new node 
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->index=line;
    newNode->next=whileStack;
    // WhileStack must point to the new start 
    whileStack=newNode;
} 

int jump_pop_while() {
    int line=-1;
    if (is_empty(whileStack)) {
        printf("Cannot pop the while stack as it is empty!");
    } else {
        Node* pop = whileStack;
        whileStack = whileStack->next;
        line = pop->index;
        free(pop);
    } 
    return line;
} 