%{}

%%
/* Regles lexicales */
"main" {return tMAIN;}
"printf"{return tPRINTF;}
"return"{return tRETURN;}

"(" {return tOP;}
")" {return tCP;}
"{" {return tOB;}
"}" {return tCB;}

"const" {return tCONST;}
"int" {return tINT;}
[a-z][a-zA-Z0-9_]* {return tID;}

"+" {return tADD;}
"-" {return tSUB;}
"*" {return tMUL;}
"/" {return tDIV;}
"=" {return tEQ;}

" " {return tSPACE;}
[ \t] {return tTAB;}
[ \n] {return tNL;}
"," {return tCOM;}
";" {return tSC;}

(|+|-)([1-9][0-9]*)(e[0-9]+)? {return tNB;}

"if" {return tIF;}
"else"{return tELSE;}
"while"{return tWHILE;}






%%