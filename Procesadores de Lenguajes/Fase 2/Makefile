all: lex cc

lex:
	flex lex.l

cc:
	gcc -g -Wall lex.yy.c -o alex -lfl

clean:
	-rm lex.yy.c
	-rm alex
