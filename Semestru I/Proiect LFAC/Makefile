all:
	flex proiect.l
	yacc -dy proiect.y
	g++ lex.yy.c y.tab.c utils.cpp -ly -ll
