#!/bin/bash
# Utilizar esta, está puesto todo lo necesario para generar el ejecutable
# hacer en linea de comandos: compilar.sh
clear
bison -v -d sint.y
flex lex.l
g++  -o compilador sint.tab.c lex.yy.c symtable.cpp Qmachine.cpp -lfl
