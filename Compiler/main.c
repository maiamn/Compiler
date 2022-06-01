#include "./include/ts.h"
#include "./include/asm_table.h"
#include "./include/interpreter.h"
#include <stdlib.h> 
#include <stdio.h> 

int main(int argc, char **argv){
    if (argc!=1){
        printf("ERREUR");
    } 
    extern int yydebug;
    yydebug = 1;

    yyparse();

    // Output file
    FILE* ASM = fopen("./ASM", "w+");
    if(!ASM)  {
        perror("fopen");
        exit(EXIT_FAILURE);
    }
    asm_save_table(ASM);
    fclose(ASM); 
    printf("INTERPRETOR\n");
    start_interpreter(asm_get_index());
}
