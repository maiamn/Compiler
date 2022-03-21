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
void ts_initS(char id[24]);

/* Ajouter un symbole dans la table */
void ts_add_sym(char id[24], char type[24]);

/* Incrémenter la profondeur */
void ts_inc_depth();

/* Décrémenter la profondeur à n-1 et supprimer symboles de profondeur n*/
void ts_dec_depth();

/* Récupérer l'adresse d'une variable */
int ts_get_addr(char id[24]);

/* Ajouter une variable temporaire */
void ts_add_tmp();

/* Libérer une variable temporaire */
void ts_free_tmp();

/* Afficher la table */
void ts_print_ts();

#endif
