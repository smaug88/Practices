clear
bison -v -d -t sint.y
flex lex.l
gcc -o sint sint.tab.c lex.yy.c -lfl