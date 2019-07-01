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
    ROOT = 258,
    NAME = 259,
    ST = 260,
    FM = 261,
    WH = 262,
    UP = 263,
    SET = 264,
    DEL = 265,
    INS = 266,
    VLS = 267,
    TERMINATOR = 268,
    COMMA = 269,
    QUOTE = 270,
    LBRAC = 271,
    RBRAC = 272,
    LOGIOP = 273,
    COMPOP = 274,
    COL_LIST = 275,
    TBL_LIST = 276,
    CON_LIST = 277,
    SET_LIST = 278,
    VAL_LIST = 279,
    CONDITION = 280,
    SELECT_P = 281,
    FROM_P = 282,
    WHERE_P = 283,
    UPDATE_P = 284,
    SET_P = 285,
    DELETE_P = 286,
    INSERT_P = 287,
    VALUES_P = 288,
    TABLE = 289,
    ROW = 290
  };
#endif
/* Tokens.  */
#define ROOT 258
#define NAME 259
#define ST 260
#define FM 261
#define WH 262
#define UP 263
#define SET 264
#define DEL 265
#define INS 266
#define VLS 267
#define TERMINATOR 268
#define COMMA 269
#define QUOTE 270
#define LBRAC 271
#define RBRAC 272
#define LOGIOP 273
#define COMPOP 274
#define COL_LIST 275
#define TBL_LIST 276
#define CON_LIST 277
#define SET_LIST 278
#define VAL_LIST 279
#define CONDITION 280
#define SELECT_P 281
#define FROM_P 282
#define WHERE_P 283
#define UPDATE_P 284
#define SET_P 285
#define DELETE_P 286
#define INSERT_P 287
#define VALUES_P 288
#define TABLE 289
#define ROW 290

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
