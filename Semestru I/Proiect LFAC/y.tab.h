/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    CLASS = 258,
    VAR_TYPE = 259,
    VOID_TYPE = 260,
    BGIN = 261,
    END = 262,
    INTEGER = 263,
    DOUBLE = 264,
    STRING = 265,
    WHILE = 266,
    FOR = 267,
    IF = 268,
    ELSE = 269,
    ID = 270,
    ID_VECTOR = 271,
    LEFT_OP = 272,
    RIGHT_OP = 273,
    LE_OP = 274,
    GE_OP = 275,
    EQ_OP = 276,
    NE_OP = 277,
    LS_OP = 278,
    GR_OP = 279,
    DONE = 280,
    AND_OP = 281,
    OR_OP = 282,
    MUL_ASSIGN = 283,
    DIV_ASSIGN = 284,
    MOD_ASSIGN = 285,
    ADD_ASSIGN = 286,
    SUB_ASSIGN = 287,
    LEFT_ASSIGN = 288,
    RIGHT_ASSIGN = 289,
    AND_ASSIGN = 290,
    XOR_ASSIGN = 291,
    OR_ASSIGN = 292,
    ACCESS = 293,
    CONST = 294,
    PRINT = 295,
    PLSPLS = 296
  };
#endif
/* Tokens.  */
#define CLASS 258
#define VAR_TYPE 259
#define VOID_TYPE 260
#define BGIN 261
#define END 262
#define INTEGER 263
#define DOUBLE 264
#define STRING 265
#define WHILE 266
#define FOR 267
#define IF 268
#define ELSE 269
#define ID 270
#define ID_VECTOR 271
#define LEFT_OP 272
#define RIGHT_OP 273
#define LE_OP 274
#define GE_OP 275
#define EQ_OP 276
#define NE_OP 277
#define LS_OP 278
#define GR_OP 279
#define DONE 280
#define AND_OP 281
#define OR_OP 282
#define MUL_ASSIGN 283
#define DIV_ASSIGN 284
#define MOD_ASSIGN 285
#define ADD_ASSIGN 286
#define SUB_ASSIGN 287
#define LEFT_ASSIGN 288
#define RIGHT_ASSIGN 289
#define AND_ASSIGN 290
#define XOR_ASSIGN 291
#define OR_ASSIGN 292
#define ACCESS 293
#define CONST 294
#define PRINT 295
#define PLSPLS 296

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 15 "proiect.y" /* yacc.c:1909  */

    int intVal;
    double doubleVal;
    bool boolVal;
    char *strVal;
    struct variable var;
    struct Parameter parameter;

#line 145 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
