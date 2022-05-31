/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tMAIN = 258,
    tPRINTF = 259,
    tRETURN = 260,
    tIF = 261,
    tELSE = 262,
    tWHILE = 263,
    tTRUE = 264,
    tFALSE = 265,
    tOP = 266,
    tCP = 267,
    tOB = 268,
    tCB = 269,
    tCONST = 270,
    tINT = 271,
    tCOM = 272,
    tSC = 273,
    tADD = 274,
    tSUB = 275,
    tMUL = 276,
    tDIV = 277,
    tEQ = 278,
    tINF = 279,
    tSUP = 280,
    tEQUAL = 281,
    tDIF = 282,
    tAND = 283,
    tOR = 284,
    tCOMMENT = 285,
    tNB = 286,
    tID = 287
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tPRINTF 259
#define tRETURN 260
#define tIF 261
#define tELSE 262
#define tWHILE 263
#define tTRUE 264
#define tFALSE 265
#define tOP 266
#define tCP 267
#define tOB 268
#define tCB 269
#define tCONST 270
#define tINT 271
#define tCOM 272
#define tSC 273
#define tADD 274
#define tSUB 275
#define tMUL 276
#define tDIV 277
#define tEQ 278
#define tINF 279
#define tSUP 280
#define tEQUAL 281
#define tDIF 282
#define tAND 283
#define tOR 284
#define tCOMMENT 285
#define tNB 286
#define tID 287

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 11 "parser.y"
 int nb ; char str[24];

#line 124 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
