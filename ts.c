/* En-tête du fichier */
#include "stdio.h"
#include "string.h"
#include "ts.h"
#define SYMBOL_MAX 500

Symbol table[SYMBOL_MAX];
int depth = 0; 
int indice = 0;

/* Initialisation */
void initS(char id[24]) {
    int ind = get_addr(id) ; 
    table[ind].init = 1 ;
}

/* Ajouter un symbole dans la table */
void add_sym(char id[24], char type[24]){
    int found = 0;
    for (int i=0; i<indice; i++) {
        if (strcmp(table[i].name,id) == 0) {
            found = 1;
            break;
        }
    }
    
    if (found == 0){

        strcpy(table[indice].name, id);
        table[indice].addr = indice;
        strcpy(table[indice].type, type);
        table[indice].init = 0;
        table[indice].depth = depth;  
        
        indice++; 
    } else {
        perror("[add_sym] Symbol already in the table");
    }

}

/* Incrémenter la profondeur */
void inc_depth(){
    depth++;
}

/* Décrémenter la profondeur à n-1 et supprimer symboles de profondeur n*/
void dec_depth(){
    int n = table[indice-1].depth ;
    
    while (table[indice-1].depth == n) {
        indice--;   
    }
    
    depth--;
}

/* Récupérer l'adresse d'une variable */
int get_addr(char id[24] ){
    int addr ; 
    
    for (int k=0; k<=indice; k++) {
        if (strcmp(table[k].name,id) == 0) {
            addr = table[k].addr;
            break; 
        } 
    }
    return addr;
}

/* Afficher la table */
void print_ts(){
    for (int i=0; i<indice; i++) {
        printf("Name : %s // Type : %s // Address : %d // Initialized : %d // Depth : %d \n", 
                table[i].name, 
                table[i].type, 
                table[i].addr, 
                table[i].init, 
                table[i].depth);

    }
}

// Main 
void main() {
    add_sym("titi", "int");
    initS("titi");
    inc_depth();
    add_sym("toto", "string");
    add_sym("tutu", "char");
    print_ts();
    printf("Addr tutu : %d \n", get_addr("tutu"));
    dec_depth(); 
    add_sym("tata", "int");
    add_sym("tete", "string");
    print_ts();

}

