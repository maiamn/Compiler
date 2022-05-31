#include "./include/ts.h"
#include "./include/asm_table.h"
#include <stdlib.h> 
#include <stdio.h> 

int main(){
    extern int yydebug;
    yydebug = 1;
    yyparse();
    asm_print_table();
    printf("####################\n");
    ts_print_ts();
}
