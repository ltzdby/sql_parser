CC=g++
LEX=flex
YACC=yacc
YACCFLAGS=-d
TARGET=sql_parser

$(TARGET): lex.yy.c y.tab.c sql.c
	$(CC) lex.yy.c y.tab.c sql.c -o $(TARGET)

lex.yy.c: scan.l
	$(LEX) scan.l

y.tab.c y.tab.h: analyze.y
	$(YACC) $(YACCFLAGS) analyze.y

clean:
	rm lex.yy.c y.tab.c y.tab.h $(TARGET)

