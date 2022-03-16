#ifndef TS_H
#define TS_H

typedef struct {
    char name[24];
    int addr;
    char type[24];
    int init;
    int depth;
} Symbol;


/* Initialisation */
void init();

/* Ajouter un symbole dans la table */
void add_sym(char[24] id, char[16] type);

/* Incrémenter la profondeur */
void inc_depth();

/* Décrémenter la profondeur à n-1 et supprimer symboles de profondeur n*/
void dec_depth();

/* Récupérer l'adresse d'une variable */
int get_addr(char[16] id);

/* Afficher la table */
void print_ts();

#endif
