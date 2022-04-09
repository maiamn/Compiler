int main(){
    extern int yydebug;
    yydebug = 1;
    yyparse();
    asm_print_table();
    printf("xxxxxxx\n");
    ts_print_ts();
}
