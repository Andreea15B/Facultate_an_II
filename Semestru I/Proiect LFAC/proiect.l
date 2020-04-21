%{
#include <stdio.h>
#include "./utils.h"
#include "y.tab.h"
%}

number  0|[1-9][0-9]*
letter  [a-zA-Z_]
id [~]*{letter}+{number}*{letter}*

%%
"Christmas"                                         {return CLASS;}
"private gifts"|"public gifts"			            {return ACCESS;}
"angel"|"eve"|"bells"|"tree"|"elf"                  {yylval.intVal = SetDataType(yytext); return VAR_TYPE;}
"carols"                                            {yylval.intVal = SetDataType(yytext); return VOID_TYPE;}
"It's beginning to look a lot like Christmas"       {return BGIN;}
"Christmas never ends"                              {return END;}
{number}                                            {yylval.intVal = atoi(yytext); return INTEGER;}
{number}"."{number}                                 {yylval.doubleVal = atof(yytext); return DOUBLE;}
["][^"]["]                                          {strcpy(yylval.strVal, yytext + 1); yylval.strVal[strlen(yylval.strVal)-1] = 0; return STRING;}
"while Christmas goes on"                           {return WHILE;}
"for each gift"                                     {return FOR;}
"if you love Christmas you get"                     {return IF;}
"else you're a Grinch"                              {return ELSE;}
"reindeer"                                          {return CONST;}
"Print"                                             {return SPECIAL_PRINT;}
"spreadTheSpirit"                                   {return PRINT;}
{id}[ \t]*\[				{ExtractVectorName(yylval.strVal, yytext); if(WordIsReserved(yylval.strVal)) {REJECT;} yyless(yyleng-1); return ID_VECTOR;}
{id}						{if(WordIsReserved(yytext)) {REJECT;} strcpy(yylval.strVal, yytext); return ID;}
"+="						{strcpy(yylval.strVal, yytext); return(ADD_ASSIGN); }
"-="		 				{strcpy(yylval.strVal, yytext); return(SUB_ASSIGN); }
"*="		 				{strcpy(yylval.strVal, yytext); return(MUL_ASSIGN); }
"/="		 				{strcpy(yylval.strVal, yytext); return(DIV_ASSIGN); }
"%="						{strcpy(yylval.strVal, yytext); return(MOD_ASSIGN); }
"&="		 				{strcpy(yylval.strVal, yytext); return(AND_ASSIGN); }
"|="		 				{strcpy(yylval.strVal, yytext); return(OR_ASSIGN); }
"&&"		 				{return(AND_OP); }
"||"		 				{return(OR_OP); }
"<="		 				{return(LE_OP); }
">="		 				{return(GE_OP); }
"=="		 				{return(EQ_OP); }
"!="		 				{return(NE_OP); }
"<"			 			    {return(LS_OP); }
">"			 			    {return(GR_OP); }
"++"		 				{return(PLSPLS);}
"="			 			    {return('='); }
"!"			 			    {return('!'); }
"-"			 			    {return('-'); }
"+"			 			    {return('+'); }
"*"			 			    {return('*'); }
"/"			 			    {return('/'); }
"%"			 			    {return('%'); }
[ \t]                       ;
\n                          {yylineno++;}
.                           {return yytext[0];}
%%
