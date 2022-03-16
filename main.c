int main(){
    extern int yydebug;
    yydebug = 1;
    yyparse();
}
