/* En-tête du fichier */
#include <stdio.h>
#include <stdlib.h>
#include "../include/ts.h"

/* Definition */ 
#define SYMBOL_MAX 500

Symbol table[SYMBOL_MAX];
int depth = 0; 
int indice = 0;

/* Initialisation */
void ts_init(char id[24]) {
    int ind = ts_get_addr(id) ; 
    table[ind].init = 1 ;
}

/* Is initialized */
int ts_is_init(char id[24]) {
    int ind=ts_get_addr(id);
    return table[ind].init; 
}  

/* Get type */
char* ts_get_type(char id[24]) {
    int ind = ts_get_addr(id);
    return table[ind].type;
}

/* Ajouter un symbole dans la table */
void ts_add_sym(char id[24], char type[24]){
    strcpy(table[indice].name, id);
    table[indice].addr = indice;
    strcpy(table[indice].type, type);
    table[indice].init = 0;
    table[indice].depth = depth;  
    
    indice++; 
}

/* Incrémenter la profondeur */
void ts_inc_depth(){
    depth++;
}

/* Décrémenter la profondeur à n-1 et supprimer symboles de profondeur n*/
void ts_dec_depth(){
    int n = table[indice-1].depth ;
    
    while (table[indice-1].depth == n) {
        indice--;   
    }
    
    depth--;
}

/* Vérifier si la variable existe */
int ts_exists_sym(char id[24]){
    int found = 0;
    int index = indice-1;
    
    while (!(found) && index>=0){
        if((strcmp(table[index].name,id) == 0)){
            found = 1;
        }
        
        index--;
    }
    
    return found;

}

/* Récupérer l'adresse d'une variable */
int ts_get_addr(char id[24] ){
    int addr ; 
    
    for (int k=0; k<indice; k++) {
        if (strcmp(table[k].name,id) == 0) {
            addr = table[k].addr;
            break; 
        } 
    }
    return addr;
}

/* Récupérer la dernière adresse de la table */
int ts_get_last_addr() {
    return indice-1;
}

/* Ajouter une variable temporaire */
void ts_add_tmp(){
    indice++;
}

/* Libérer une variable temporaire */
void ts_free_tmp(){
    indice--;
}

/* Vider la table des symboles */ 
void ts_free_all(){
    indice=0;
} 

/* Afficher la table */
void ts_print_ts(){
    for (int i=0; i<indice; i++) {
        printf("Name : %s // Type : %s // Address : %d // Initialized : %d // Depth : %d \n", 
                table[i].name, 
                table[i].type, 
                table[i].addr, 
                table[i].init, 
                table[i].depth);

    }
}

void ts_print_all() {
    for (int i=0; i<15 ; i++) {
        printf("Name : %s // Type : %s // Address : %d // Initialized : %d // Depth : %d \n", 
                table[i].name, 
                table[i].type, 
                table[i].addr, 
                table[i].init, 
                table[i].depth);

    }    
}

int ts_get_second_to_last_tmp() {
    return indice-2;
}

int ts_get_last_tmp() {
    return indice-1;
}



