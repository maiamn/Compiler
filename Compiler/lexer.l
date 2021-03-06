%{
#include "y.tab.h"
%}
%option noyywrap


/* Regles lexicales */
%%
"main" {return tMAIN;}
"printf" {return tPRINTF;}
"return" {return tRETURN;}

"const" {return tCONST;}
"int" {return tINT;}

"if" {return tIF;}
"else" {return tELSE;}
"while" {return tWHILE;}
"true" {return tTRUE;}
"false" {return tFALSE;}

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
"<" {return tINF;}
">" {return tSUP;}
"==" {return tEQUAL;}
"!=" {return tDIF;}
"&&" {return tAND;}
"||" {return tOR;} 
"[\/]{2}.*" {return tCOMMENT;}

[a-z][a-zA-Z0-9_]* {
    strcpy(yylval.str , yytext);
    return tID;}
    
[0-9]+(e[0-9]+)? {
    yylval.nb = (int) strtold(yytext, NULL);
    return tNB;}



%%
