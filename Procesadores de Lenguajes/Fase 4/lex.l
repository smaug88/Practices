%x inc
%{
#include "sint.tab.h"

#include <cmath>
#include <cstdio>
#include <cassert>
#include "symtable.h"

int numlin =1;
void error (char*);
extern string nombre[100];
extern int indice;
%}

letra	[a-zA-Z]
DD		[0-9]
PO 		[1-9]
DEC 	{PO}?{DD}+
simbolo	"<" | ">" | "=" | "(" | ")" | "[" | "]" |"+" | "-" | "_" | "*" | "/" | ";" | ":"| ","
espacio " "
punto "."

%%
<<EOF>>	{
		yypop_buffer_state();
        numlin=1;
        if ( !YY_CURRENT_BUFFER )
        {
          	yyterminate();
        }
        }

["\t" " "]	{/* Se ignoran espacios en blanco */}
"-""-".*	{/* Se ignoran comentarios de linea */}
\n 			{numlin++;}

procedure 	{return RES_PROCEDURE;}
function 	{return RES_FUNCTION;}
begin 		{return RES_BEGIN;}
end 		{return RES_END;}
return 		{return RES_RETURN;}
with 		{BEGIN(inc);}
is 			{return RES_IS;}
if 			{return RES_IF;}
else 		{return RES_ELSE;}
then 		{return RES_THEN;}
case 		{return RES_CASE;}
when 		{return RES_WHEN;}
loop 		{return RES_LOOP;}
while 		{return RES_WHILE;}
Integer 	{return RES_INTEGER;}
Float 		{return RES_FLOAT;}
Char 		{return RES_CHAR;}
String 		{return RES_STRING;}
Array 		{return RES_ARRAY;}
in 			{return RES_IN;}
out 		{return RES_OUT;}
inout 		{return RES_IN_OUT;}
of 			{return RES_OF;}
type 		{return RES_TYPE;}
Fichero     {return FICH;}

"="">"		{return OP_FLECHITA;}
"/""="		{return OP_DISTINTO;}
".."        {return RANGO;}
"("			{return SEP_APARENTESIS;}
")"			{return SEP_CPARENTESIS;}
","			{return SEP_COMA;}
";"			{return SEP_PUNTOCOMA;}
"["			{return SEP_ACORCHETE;}
"]"			{return SEP_CCORCHETE;}
":"			{return SEP_DOSPUNTOS;}
"<"			{return OP_MENOR;}
">"			{return OP_MAYOR;}	
"<""="		{return OP_MENORIGUAL;}
">""="		{return OP_MAYORIGUAL;}
and 		{return OP_AND;}
or 			{return OP_OR;}
not 		{return OP_NOT;}
"="         {return OP_IGUAL;}
":""="		{return OP_ASIGNACION;}

{letra}({letra}|{PO}|_)*|(_)({letra}|{PO})({letra}|{PO}|_)*      {nombre[indice++] = yytext;return ID;}

"+"        			{return OP_MAS;}
"-"         		{return OP_MENOS;}
"*"         		{return OP_PRODUCTO;}
"/"         		{return OP_DIVISION;}
{DEC}+ 				{return INT;}
{DEC}+"."{DEC}+ 	{return FLO;}

\"{letra}({DEC}|{letra}|{espacio}|{punto})*\"	{return STRING;}
\'({letra}|{DD}|{espacio})\'					{return CHAR;}

<inc>[ \t]*      /* eat the whitespace */
<inc>[^ \t\n]+   { /* got the include file name */
    yyin = fopen( yytext, "r" );
        if ( ! yyin ) error(yytext);
     	yypush_buffer_state(yy_create_buffer( yyin, YY_BUF_SIZE ));
        BEGIN(INITIAL);
}

.           {error(yytext);}
%%


/*int main(int argc, char** argv)
{
	const char *simbolos[53];
	simbolos[0] = "INT";
	simbolos[1] = "FLO";
	simbolos[2] = "CHAR";
	simbolos[3] = "STRING";
	simbolos[4] = "RES_PROCEDURE";
	simbolos[5] = "RES_FUNCTION";
	simbolos[6] = "RES_BEGIN";
	simbolos[7] = "RES_END";
	simbolos[8] = "RES_RETURN";
	simbolos[9] = "RES_WITH";
	simbolos[10] = "RES_IS";
	simbolos[11] = "RES_IF";
	simbolos[12] = "RES_ELSE";
	simbolos[13] = "RES_THEN";
	simbolos[14] = "RES_CASE";
	simbolos[15] = "RES_WHEN";
	simbolos[16] = "RES_LOOP";
	simbolos[17] = "RES_WHILE";
	simbolos[18] = "RES_INTEGER";
	simbolos[19] = "RES_FLOAT";
	simbolos[20] = "RES_CHAR";
	simbolos[21] = "RES_STRING";
	simbolos[22] = "RES_ARRAY";
	simbolos[23] = "RES_IN";
	simbolos[24] = "RES_OUT";
	simbolos[25] = "RES_IN_OUT";
	simbolos[26] = "RES_OF";
	simbolos[27] = "RES_TYPE";
	simbolos[28] = "OP_ASIGNACION";
	simbolos[29] = "OP_MAS";
	simbolos[30] = "OP_MENOS";
	simbolos[31] = "OP_PRODUCTO";
	simbolos[32] = "OP_DIVISION";
	simbolos[33] = "OP_IGUAL";
	simbolos[34] = "OP_MENOR";
	simbolos[35] = "OP_MENORIGUAL";
	simbolos[36] = "OP_MAYOR";
	simbolos[37] = "OP_MAYORIGUAL";
	simbolos[38] = "OP_NOT";
	simbolos[39] = "OP_AND";
	simbolos[40] = "OP_OR";
	simbolos[41] = "SEP_PUNTOCOMA";
	simbolos[42] = "SEP_COMA";
	simbolos[43] = "SEP_ACORCHETE";
	simbolos[44] = "SEP_CCORCHETE";
	simbolos[45] = "SEP_APARENTESIS";
	simbolos[46] = "SEP_CPARENTESIS";
	simbolos[47] = "SEP_DOSPUNTOS";
	simbolos[48] = "ID";
    simbolos[49] = "FICH";	
    simbolos[50] = "RANGO";
	simbolos[51] = "OP_FLECHITA";
	simbolos[52] = "OP_DISTINTO";


	int s;
	
	if (argc > 1)
	{
		printf("Abriendo fichero: %s\n", argv[1]);
		yyin = fopen(argv[1], "r");
		if (yyin == NULL)
			printf("\aError abriendo el fichero.\n");
		else
		{
			s = yylex();
			while (s != 0)
			{
				printf("%i: %s %s\n", s, simbolos[s-257], yytext);
				s = yylex();
			}
		}
	}
	printf("\nANALISIS FINALIZADO\n");
	return 0;
}*/

void error(char* mens)
{
	printf("Error lexico en linea %i: %s\n", numlin, mens);
}





