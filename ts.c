#include "ts.h"
#define SYMBOL_MAX 500

Symbol table[SYMBOL_MAX];
int depth = 0; 
int index = 0;

/* Initialisation */
void initS(char id[24]) {
    int ind = get_addr(id) ; 
    table[ind].init = 1 ;
}

/* Ajouter un symbole dans la table */
void add_sym(char id[24] , char type[16] ){

    table[index].name = id;
    table[index].addr = index;
    table[index].type = type;
    table[index].init = 0;
    table[index].depth = depth;
    
    index++; 
}

/* Incrémenter la profondeur */
void inc_depth(){
    depth++;
}

/* Décrémenter la profondeur à n-1 et supprimer symboles de profondeur n*/
void dec_depth(){
    for(int k=0; k<=index; k++){
        if(table[k].depth == depth){
        
        }
    }
}

/* Récupérer l'adresse d'une variable */
int get_addr(char id[24] ){
    int addr ; 
    
    for (int k=0; k<=index; k++) {
        if (table[k].name==id) {
            addr = table[k].addr;
            break; 
        } 
    }
    return addr;
}

/* Afficher la table */
void print_ts(){}

