%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <queue>
    #include "sql.h"
    #define YYSTYPE struct SqlNode*
    using namespace std;
    int yyparse();
    extern int yylex();
    int yywrap();
    int yyerror(char *);
    struct SqlNode *root;
%}

%token ROOT NAME ST FM WH UP SET DEL INS VLS TERMINATOR COMMA QUOTE LBRAC RBRAC LOGIOP COMPOP COL_LIST TBL_LIST CON_LIST SET_LIST VAL_LIST CONDITION SELECT_P FROM_P WHERE_P UPDATE_P SET_P DELETE_P INSERT_P VALUES_P TABLE ROW

%%

program:
stmt TERMINATOR
;

stmt:
sel frm
| sel frm whe
| upd set
| upd set whe
| del frm
| del frm whe
| ins vls
;

sel:
ST col_list {   struct SqlNode *sel_p = mallocNewNode();
                sel_p->type = SELECT_P;
                strcpy(sel_p->text, "SELECT_PERIOD");
                addSon(sel_p, 2, $1, $2);
                $$ = addSon(root, 1, sel_p);
            }
;

frm:
FM tbl_list {   struct SqlNode *tbl_p = mallocNewNode();
                tbl_p->type = FROM_P;
                strcpy(tbl_p->text, "FROM_PERIOD");
                addSon(tbl_p, 2, $1, $2);
                $$ = addSon(root, 1, tbl_p); 
            }
;

upd:
UP NAME     {   struct SqlNode *upd_p = mallocNewNode();
                upd_p->type = UPDATE_P;
                strcpy(upd_p->text, "UPDATE_PERIOD");
                struct SqlNode *p = mallocNewNode();
                p->type = TABLE;
                strcpy(p->text, "TABLE");
                addSon(p, 1, $2);
                addSon(upd_p, 2, $1, p);
                $$ = addSon(root, 1, upd_p);
            }
;

set:
SET set_list    {   struct SqlNode *set_p = mallocNewNode();
                    set_p->type = SET_P;
                    strcpy(set_p->text, "SET_PERIOD");
                    addSon(set_p, 2, $1, $2);
                    $$ = addSon(root, 1, set_p);
                }
;

ins:
INS NAME    {   struct SqlNode *ins_p = mallocNewNode();
                ins_p->type = INSERT_P;
                strcpy(ins_p->text, "INSERT_PERIOD");
                struct SqlNode *p = mallocNewNode();
                p->type = TABLE;
                strcpy(p->text, "TABLE");
                addSon(p, 1, $2);
                addSon(ins_p, 2, $1, p);
                $$ = addSon(root, 1, ins_p);
            }
| INS NAME LBRAC col_list RBRAC {   struct SqlNode *ins_p = mallocNewNode();
                                    ins_p->type = INSERT_P;
                                    strcpy(ins_p->text, "INSERT_PERIOD");
                                    struct SqlNode *p = mallocNewNode();
                                    p->type = TABLE;
                                    strcpy(p->text, "TABLE");
                                    addSon(p, 1, $2);
                                    addSon(ins_p, 3, $1, p, $4);
                                    $$ = addSon(root, 1, ins_p);
                                }
;

vls:
VLS ins_row     {   struct SqlNode *vls_p = mallocNewNode();
                    vls_p->type = VALUES_P;
                    strcpy(vls_p->text, "VALUES_PERIOD");
                    addSon(vls_p, 2, $1, $2);
                    $$ = addSon(root, 1, vls_p);
                }
;

ins_row:
LBRAC val_list RBRAC    {   struct SqlNode *p = mallocNewNode();
                            p->type = ROW;
                            strcpy(p->text, "ROW");
                            $$ = addSon(p, 1, $2);
                        }
| ins_row COMMA LBRAC val_list RBRAC    {   $$ = addSon($1, 1, $4); }
;

del:
DEL             {   struct SqlNode *del_p = mallocNewNode();
                    del_p->type = DELETE_P;
                    strcpy(del_p->text, "DELETE_PERIOD");
                    addSon(del_p, 1, $1);
                    $$ = addSon(root, 1, del_p);
                }
;

whe:
WH con_list {   struct SqlNode *whe_p = mallocNewNode();
                whe_p->type = WHERE_P;
                strcpy(whe_p->text, "WHERE_PERIOD");
                addSon(whe_p, 2, $1, $2);
                $$ = addSon(root, 1, whe_p);
            }
;

col_list:
NAME                    {   struct SqlNode *p = mallocNewNode();
                            p->type = COL_LIST;
                            strcpy(p->text, "COL_LIST");
                            $$ = addSon(p, 1, $1);
                        }
| col_list COMMA NAME   { $$ = addSon($1, 1, $3); }
;

tbl_list:
NAME                    {   struct SqlNode *p = mallocNewNode();
                            p->type = TBL_LIST;
                            strcpy(p->text, "TBL_LIST");
                            $$ = addSon(p, 1, $1);
                        }
| tbl_list COMMA NAME   { $$ = addSon($1, 1, $3); }
;

val_list:
QUOTE NAME QUOTE                    {   struct SqlNode *p = mallocNewNode();
                                        p->type = VAL_LIST;
                                        strcpy(p->text, "VAL_LIST");
                                        $$ = addSon(p, 1, $2);
                                    }
| val_list COMMA QUOTE NAME QUOTE   {   $$ = addSon($1, 1, $4); }
;

con_list:
condition                   {   struct SqlNode *pNew = mallocNewNode();
                                pNew->type = CON_LIST;
                                strcpy(pNew->text, "CON_LIST");
                                $$ = addSon(pNew, 1, $1);
                            }
| con_list LOGIOP condition { 
                                $$ = addSon($1, 2, $2, $3);
                            }
;

set_list:
condition                   {   struct SqlNode *p = mallocNewNode();
                                p->type = SET_LIST;
                                strcpy(p->text, "SET_LIST");
                                $$ = addSon(p, 1, $1);
                            }
| set_list COMMA condition  {
                                $$ = addSon($1, 1, $3);
                            }
;

condition:
NAME COMPOP QUOTE NAME QUOTE    {   struct SqlNode *p = mallocNewNode();
                                    p->type = CONDITION;
                                    strcpy(p->text, "CONDITION");
                                    addSon($2, 2, $1, $4);
                                    $$ = addSon(p, 1, $2);
                                }
;

%%

int main() {
    root = mallocNewNode();
    root->type = ROOT;
    strcpy(root->text, "STMT");
    yyparse();

    printf("<table style='text-align: center;' border='1'>\n");
    struct SqlNode *cur = root;
    queue<SqlNode*> q1, q2;
    q1.push(root);
    int cnt;
    while (!q1.empty()) {
        printf("<tr>\n");
        cnt = 0;
        while (!q1.empty()) {
            cur = q1.front();
            q1.pop();
            if (cur->type == -1) {
                ++cnt;
            }
            printf("<td colspan='%d'>%s</td>\n", cur->span, cur->text);
            if (cur->lpSub) {
                cur = cur->lpSub;
                q2.push(cur);
                while (cur = cur->lpNext) {
                    q2.push(cur);
                }
            } else {
                struct SqlNode *tmp = mallocNewNode();
                tmp->type = -1;
                tmp->span = cur->span;
                strcpy(tmp->text, " ");
                q2.push(tmp);
            }
        }
        q1.swap(q2);
        printf("</tr>\n");
        if (cnt == root->span) {
            break;
        }
    }
    printf("</table>\n");
    return 0;
}
int yyerror(char *msg) {
    printf("Error encountered: %s \n", msg);
    return 0;
}
