%%{}

%%
/* Regles lexicales */
"main" {return tMAIN;}
"printf"{return tPRINTF;}
"return"{return tRETURN;}

"const" {return tCONST;}
"int" {return tINT;}

"if" {return tIF;}
"else"{return tELSE;}
"while"{return tWHILE;}

"(" {return tOP;}
")" {return tCP;}
"{" {return tOB;}
"}" {return tCB;}
"," {return tCOM;}
";" {return tSC;}

"+" {return tADD;}
"-" {return tSUB;}
"*" {return tMUL;}
"/" {return tDIV;}
"=" {return tEQ;}
"!=" {return tDIF;}

[a-z][a-zA-Z0-9_]* {
    strcpy(yyval.str , yytext);
    return tID;}
(|+|-)([1-9][0-9]*)(e[0-9]+)? {
    yylval.nb = (int) strtold(yytext, NULL);
    return tNB;}



%%
