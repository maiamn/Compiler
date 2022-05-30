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
void ts_init(char id[24]);

/* Is initialized */
int ts_is_init(char id[24]) ;

/* Ajouter un symbole dans la table */
void ts_add_sym(char id[24], char type[24]);

/* Incrémenter la profondeur */
void ts_inc_depth();

/* Décrémenter la profondeur à n-1 et supprimer symboles de profondeur n*/
void ts_dec_depth();

/* Vérifier si la variable existe */
int ts_exists_sym(char id[24]);

/* Récupérer l'adresse d'une variable */
int ts_get_addr(char id[24]);

/* Récupérer la dernière adresse de la table */
int ts_get_last_addr();

/* Ajouter une variable temporaire */
void ts_add_tmp();

/* Récupérer les adresses des deux dernières variables temporaires */
int ts_get_second_to_last_tmp() ;

int ts_get_last_tmp() ;

/* Libérer une variable temporaire */
void ts_free_tmp();

/* Vider la table des symboles */
void ts_free_all();

/* Afficher la table */
void ts_print_ts();

#endif
