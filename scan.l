%{
    #define YYSTYPE struct SqlNode*
    #include "y.tab.h"
    #include "sql.h"
    extern YYSTYPE yylval;
%}

chars   [A-Za-z0-9_\.]+
blank   [ \n\t]+
st      (select|SELECT|Select)
fm      (from|FROM|From)
wh      (where|WHERE|Where)
up      (update|UPDATE|Update)
set     (set|SET|Set)
del     (delete|DELETE|Delete)
ins     ("insert into"|"INSERT INTO"|"Insert Into")
vls     (values|VALUES|Values)
semi    ;
comma   ,
quote   '
lbrac   "("
rbrac   ")"
logiop  (and|AND|or|OR)
compop  [<>=|(<=)|(>=)|(<>)]

%%

{st}    {
            yylval = mallocNewNode();
            yylval->type = ST;
            strcpy(yylval->text, yytext);
            return ST;
        }

{fm}    {
            yylval = mallocNewNode();
            yylval->type = FM;
            strcpy(yylval->text, yytext);
            return FM;
        }

{wh}    {
            yylval = mallocNewNode();
            yylval->type = WH;
            strcpy(yylval->text, yytext);
            return WH;
        }

{up}    {
            yylval = mallocNewNode();
            yylval->type = UP;
            strcpy(yylval->text, yytext);
            return UP;
        }

{set}   {
            yylval = mallocNewNode();
            yylval->type = SET;
            strcpy(yylval->text, yytext);
            return SET;
        }

{del}   {
            yylval = mallocNewNode();
            yylval->type = DEL;
            strcpy(yylval->text, yytext);
            return DEL;
        }

{ins}   {
            yylval = mallocNewNode();
            yylval->type = INS;
            strcpy(yylval->text, yytext);
            return INS;
        }

{vls}   {
            yylval = mallocNewNode();
            yylval->type = VLS;
            strcpy(yylval->text, yytext);
            return VLS;
        }

{semi}  {
            return TERMINATOR;
        }

{comma} {
            return COMMA;
        }

{quote} {
            return QUOTE;
        }

{lbrac} {
            return LBRAC;
        }

{rbrac} {
            return RBRAC;
        }

{logiop}    {
                yylval = mallocNewNode();
                yylval->type = LOGIOP;
                strcpy(yylval->text, yytext);
                return LOGIOP;
            }

{compop}    {
                yylval = mallocNewNode();
                yylval->type = COMPOP;
                strcpy(yylval->text, yytext);
                return COMPOP;
            }

{chars} {
            yylval = mallocNewNode();
            yylval->type = NAME;
            strcpy(yylval->text, yytext);
            return NAME;
        }

{blank} ;

%%

int yywrap() {
    return 1;
}
