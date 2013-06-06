%{

//#include <stdio.h>
#include <cmath>
#include <cstdio>
#include <cassert>
//#include "lex.yy.c"
#include "symtable.h"

extern "C++" {int yylex(void);}
extern FILE *yyin;
extern int numlin;
int yydebug=1;
int tipo_arg = 0; // para obviar los argumentos de una funcion a la hora de chequear tipos
string nombre[100];
string limitador;
string nombre_tipo;
int check_type[100]; // vector de 100 tipos para el chequeo de los tipos
vartype tipo_funciones[100];
int ind_tipo_fun = 0;
int ind_type = 0;    // indice que controla el vector arriba comentado
vartype tipo_prev;
int indice = 0;    // CAda vez que se inserte debemos de ponerla a 0.
vartype tipo, e_switch; 
int tipo_par =0 ; //1 = IN ; 2 =OUT ; 3 = INOUT
int error_tipo_fun=0;


int cfuncion=0;
int cprocedure=0;
int carray=0;
int cenum=0;
int venum=0;
int enum_array=0;
symtable tabla;


void Comprueba_tipo();
void Insertar();
void Actualizar();
void yyerror (char *s);

%}

%token INT        
%token FLO            
%token CHAR            
%token STRING            

%token RES_PROCEDURE    
%token RES_FUNCTION    
%token RES_BEGIN        
%token RES_END        
%token RES_RETURN    
%token RES_IS        
%token RES_IF        
%token RES_ELSE        
%token RES_THEN        
%token RES_CASE        
%token RES_WHEN        
%token RES_LOOP        
%token RES_WHILE        
%token RES_INTEGER        
%token RES_FLOAT        
%token RES_CHAR        
%token RES_STRING        
%token RES_ARRAY        
%token RES_IN             
%token RES_OUT         
%token RES_IN_OUT     
%token RES_OF        
%token RES_TYPE     

%token OP_ASIGNACION

%token OP_MAS        
%token OP_MENOS        
%token OP_PRODUCTO        
%token OP_DIVISION        
%token OP_IGUAL         
%token OP_MENOR         
%token OP_MENORIGUAL    
%token OP_MAYOR         
%token OP_MAYORIGUAL     
%token OP_NOT            
%token OP_AND            
%token OP_OR             

%token SEP_PUNTOCOMA    
%token SEP_COMA         
%token SEP_APARENTESIS    
%token SEP_CPARENTESIS    
%token SEP_ACORCHETE    
%token SEP_CCORCHETE    
%token SEP_DOSPUNTOS    
%token ID                 
%token FICH             
%token RANGO             
%token OP_FLECHITA        
%token OP_DISTINTO    

%left OP_AND
%left OP_OR
%left OP_NOT
%left OP_MENOR
%left OP_MENORIGUAL
%left OP_MAYOR
%left OP_MAYORIGUAL
%left OP_PRODUCTO
%left OP_DIVISION
%left OP_MAS
%left OP_MENOS
%start program

%%
// Falta llamada prototipo de procedimiento
program : program2 RES_IS {cprocedure = 0;} declaraciones
          RES_BEGIN sequence_of_statements RES_END ID SEP_PUNTOCOMA {tabla.finAmbito(); printf("%d :: <program> RES_PROCEDURE \n",numlin);}
	  | program2 SEP_PUNTOCOMA {cprocedure = 0; tabla.finAmbito();} program  {printf("%d :: <program> Prototipo_proc \n",numlin);} 
          | RES_FUNCTION ID {limitador = nombre[0]; cfuncion = 1; tabla.insertaFun(limitador); indice=0; tabla.nuevoAmbito();} SEP_APARENTESIS function_param SEP_CPARENTESIS {cfuncion = 0;} RES_RETURN types {tipo_funciones[ind_tipo_fun++]= tipo; tabla.modificaFun(limitador,tipo); indice=0;} SEP_PUNTOCOMA {tabla.finAmbito();} program  {printf("%d :: <program> Prototipo_func \n",numlin);}
          ;

program2: RES_PROCEDURE ID SEP_APARENTESIS {limitador = nombre[0]; cprocedure = 1; tabla.insertaPro(nombre[0]); indice=0; tabla.nuevoAmbito();} procedure_param SEP_CPARENTESIS;
          
procedure_call_statement : ID SEP_APARENTESIS parametros SEP_CPARENTESIS SEP_PUNTOCOMA  
                           {printf("%d :: <procedure_call_statement> ID... \n",numlin);}
                         ;
                         
function_call_statement : ID SEP_APARENTESIS  parametros SEP_CPARENTESIS {}
                          {printf("%d :: <function_call_statement> ID..\n",numlin);}
                        ;

subprogram_declaration : subprogram_specification SEP_PUNTOCOMA {tabla.finAmbito(); indice=0; printf("%d :: <subprogram_declaration> subprogram_specification \n",numlin);}
                       ;

subprogram_specification : RES_PROCEDURE ID {limitador = nombre[0]; cprocedure = 1; tabla.insertaPro(nombre[0]); indice=0; tabla.nuevoAmbito();}
                           SEP_APARENTESIS procedure_param SEP_CPARENTESIS {cprocedure = 0;}
                           RES_IS declaraciones RES_BEGIN sequence_of_statements RES_END ID 
                           {printf("%d :: <subprogram_specification> RES_PROCEDURE \n",numlin);}
                         | RES_FUNCTION ID {limitador = nombre[0]; cfuncion = 1; tabla.insertaFun(nombre[0]); indice=0; tabla.nuevoAmbito();}
                           SEP_APARENTESIS function_param SEP_CPARENTESIS RES_RETURN types {tipo_funciones[ind_tipo_fun++]= tipo; tabla.modificaFun(limitador,tipo); cfuncion = 0; indice=0;}
                           RES_IS declaraciones RES_BEGIN sequenciafunction RES_END ID 
                           {printf("%d :: <subprogram_specification> RES_FUNCTION \n",numlin);}    
                         ;
                         
procedure_param : procedure_param SEP_PUNTOCOMA ID SEP_DOSPUNTOS tipo_ent_proc types { Insertar(); indice=0; tipo_par=0;}
                  {printf("%d :: <procedure_param> procedure_param SEP_PUNTOCOMA \n",numlin);}
                | ID SEP_DOSPUNTOS tipo_ent_proc types { Insertar(); indice=0; tipo_par=0;}
                  {printf("%d :: <procedure_param> ID SEP_DOSPUNTOS \n",numlin);}
                | {printf("%d :: <procedure_param> empty \n",numlin);}
                ;
                
function_param : function_param SEP_PUNTOCOMA ID SEP_DOSPUNTOS types 
                 { Insertar(); indice=0; tipo_par=0; printf("%d :: <function_param> function_param SEP_PUNTOCOMA \n",numlin);}
               | ID SEP_DOSPUNTOS types 
                 {Insertar(); indice=0; tipo_par=0; printf("%d :: <function_param> ID SEP_DOSPUNTOS \n",numlin);}
               | {printf("%d :: <function_param> empty \n",numlin);}
               ;
               
tipo_ent_proc : RES_IN                               {tipo_par = 1; printf("%d :: <tipo_ent_proc> RES_IN \n",numlin);}
              | RES_OUT                              {tipo_par = 2; printf("%d :: <tipo_ent_proc> RES_OUT \n",numlin);}
              | RES_IN_OUT                           {tipo_par = 3; printf("%d :: <tipo_ent_proc> RES_IN_OUT \n",numlin);}
              ;
              
declaraciones : declaraciones declaracion            {printf("%d :: <declaraciones> declaraciones declaracion \n",numlin);}
              |                                      {printf("%d :: <declaraciones> empty \n",numlin);}
              ;

declaracion : ID SEP_DOSPUNTOS types SEP_PUNTOCOMA   {Insertar(); indice=0; printf("%d :: <declaracion> ID SEP_DOSPUNTOS \n",numlin);}
            | enum_type_def                          {printf("%d :: <declaracion> enum_type_def \n",numlin);}
            | array_def                              {printf("%d :: <declaracion> array_def \n",numlin);}
            | subprogram_declaration                 {printf("%d :: <declaracion> subprogram_declaration\n",numlin);}
            ; 

parametros : var                                     {check_type[ind_type++]=tipo; printf("%d :: <parametros> var \n",numlin);}
           | parametros SEP_COMA var                 {check_type[ind_type++]=tipo; printf("%d :: <parametros> parametros SEP_COMA \n",numlin);}
           |                                         {printf("%d :: <parametros> empty \n",numlin);}
           ;

var : ID                                             {tipo = tabla.tipoSym(nombre[indice-1]); printf("%d :: <var> ID \n",numlin);}
    | INT                                            {tipo = _INT; printf("%d :: <var> INT \n",numlin);}
    | FLO                                            {tipo = _FLOAT; printf("%d :: <var> FLO \n",numlin);}
    | CHAR                                           {tipo = _CHAR; printf("%d :: <var> CHAR \n",numlin);}
    | STRING                                         {tipo = _STRING; printf("%d :: <var> STRING \n",numlin);}
    | ID SEP_ACORCHETE expression SEP_CCORCHETE      {tipo =tabla.tipoVec(nombre[indice-1]); printf("%d :: <var> vector \n",numlin);}
    ;

sequenciafunction : sequence_of_statements           {printf("%d :: <sequenciafunction> sequence_of_statements \n",numlin);}
                  ;

sequence_of_statements : sequence_of_statements statement 
                         {printf("%d :: <sequence_of_statements> sequence_of_statements statement \n",numlin);}
                       | statement 
                         {printf("%d :: <sequence_of_statements> statement \n",numlin);}
                       ;

statement : simple_statement                         {ind_type=0; printf("%d :: <statement> simple_statement \n",numlin);}
          | compound_statement                       {ind_type=0; printf("%d :: <statement> compound_statement \n",numlin);}
          | error                                    {printf("------ %d :: SYNTAX ERROR FOUND ON LINE %d \n",numlin,numlin);}
          ;

compound_statement : if_statement                    {printf("%d :: <compound_statement> if_statement \n",numlin);}
                   | case_statement                  {printf("%d :: <compound_statement> case_statement \n",numlin);}
                   | while_statement                 {printf("%d :: <compound_statement> while_statement \n",numlin);}
                   | asignment_statement             {printf("%d :: <compound_statement> asignment_statement \n",numlin);}
                   | return_statement                {printf("%d :: <compound_statement> return_statement \n",numlin);}
                   ;

simple_statement : procedure_call_statement          {printf("%d :: <simple_statement> procedure_call_statement \n",numlin);}
                 ;

asignment_statement : ID OP_ASIGNACION expression SEP_PUNTOCOMA 
                      {check_type[ind_type++] = tabla.tipoSym(nombre[0]);indice=0; Comprueba_tipo(); ind_type = 0; printf("%d :: <asignment_statement> ID OP_ASIGNACION\n", numlin);}
                    | ID OP_ASIGNACION STRING SEP_PUNTOCOMA 
                      {if (tabla.tipoSym(nombre[0]) != _STRING) yyerror("Tipo incompatible"); indice=0; printf("%d :: <asignment_statement> STRING \n",numlin);}
                    | ID SEP_ACORCHETE {check_type[ind_type++]= tabla.tipoVec(nombre[0]); indice = 0; } expression SEP_CCORCHETE {ind_type--;} OP_ASIGNACION expression SEP_PUNTOCOMA 
                      {indice=0; Comprueba_tipo(); ind_type = 0; printf("%d :: <asignment_statement> vector \n",numlin);}
                    | ID OP_ASIGNACION CHAR SEP_PUNTOCOMA 
                      {if (tabla.tipoSym(nombre[0]) != _CHAR) yyerror("Tipo incompatible"); printf("%d :: <asignment_statement> char \n",numlin);}
                    ; 

case_statement : RES_CASE factor RES_IS case_statement_alternative alternative2 RES_END RES_CASE SEP_PUNTOCOMA 
                 {printf("%d :: <case_statement> RES_CASE ID \n",numlin);}
               ;
case_statement_alternative : RES_WHEN var {if (tipo != e_switch) yyerror ("Tipo incompatible en alternativa del case.");} OP_FLECHITA sequence_of_statements 
                             {printf("%d :: <case_statement_alternative> RES_WHEN var \n",numlin);}
                           ;
                           
alternative2 : alternative2 case_statement_alternative  
               {printf("%d :: <alternative2> alternative2 case_statement_alternative \n",numlin);}
             | {printf("%d :: <alternative2> empty \n",numlin);}
             ;

while_statement : RES_WHILE SEP_APARENTESIS cond_expression SEP_CPARENTESIS RES_LOOP {Comprueba_tipo(); ind_type=0;} 
                  sequence_of_statements RES_END RES_LOOP  SEP_PUNTOCOMA 
                  {printf("%d :: <while_statement> RES_WHILE SEP_APARENTESIS \n",numlin);}
                ;

if_statement : RES_IF SEP_APARENTESIS cond_expression SEP_CPARENTESIS RES_THEN {Comprueba_tipo(); ind_type=0;}  
               sequence_of_statements if_stat2 RES_END RES_IF SEP_PUNTOCOMA 
               {printf("%d :: <if_statement> RES_IF SEP_APARENTESIS \n",numlin);}
             ;
             
if_stat2 : RES_ELSE sequence_of_statements           {printf("%d :: <if_stat2> RES_ELSE sequence_of_statements \n",numlin);}
         |                                           {printf("%d :: <if_stat2> empty \n",numlin);}
         ;

return_statement : RES_RETURN math_expression SEP_PUNTOCOMA 
                   {error_tipo_fun=1; check_type[ind_type++]=tipo_funciones[--ind_tipo_fun]; Comprueba_tipo(); error_tipo_fun=0; printf("%d :: <return_statement> RES_RETURN math_expression \n",numlin);}
                 | RES_RETURN CHAR SEP_PUNTOCOMA 
                   {if(tipo_funciones[--ind_tipo_fun]!= _CHAR) yyerror("El tipo devuelto por la funcion no coincide.") ;printf("%d :: <return_statement> RES_RETURN CHAR \n",numlin);}
                 | RES_RETURN STRING SEP_PUNTOCOMA 
                   {if(tipo_funciones[--ind_tipo_fun]!= _STRING) yyerror("El tipo devuelto por la funcion no coincide.") ; printf("%d :: <return_statement> RES_RETURN STRING \n",numlin);}
                 ;

enum_type_def : RES_TYPE ID RES_IS SEP_APARENTESIS {cenum=1; Insertar(); cenum=0; indice=0;} enum_type_def2 SEP_CPARENTESIS SEP_PUNTOCOMA 
                {printf("%d :: <enum_type_def> RES_TYPE ID \n",numlin);}
              ;

enum_type_def2 : enum_type_def2 SEP_COMA ID
                 {venum=1; Insertar(); venum=0; indice=0; printf("%d :: <enum_type_def2> ID COMA ID \n",numlin);}
               | ID 
                 {venum=1; Insertar(); venum=0; indice=0; printf("%d :: <enum_type_def2> ID \n",numlin);}
               ;

array_def : RES_TYPE ID RES_IS RES_ARRAY SEP_APARENTESIS INT RANGO INT SEP_CPARENTESIS RES_OF types SEP_PUNTOCOMA 
            {carray=1; Insertar(); carray=0; indice=0; printf("%d :: <array_def> RES_TYPE ID \n",numlin);}
          ;

types : ID                                           {enum_array=1; printf("%d :: <types> ID \n",numlin);}
      | RES_INTEGER                                  {tipo = _INT;   printf("%d :: <types> RES_INTEGER \n",numlin);}
      | RES_FLOAT                                    {tipo = _FLOAT; printf("%d :: <types> RES_FLOAT \n",numlin);}
      | RES_CHAR                                     {tipo = _CHAR ; printf("%d :: <types> RES_CHAR \n",numlin);}
      | RES_STRING                                   {tipo = _STRING;printf("%d :: <types> RES_STRING \n",numlin);}
      | FICH                                         {tipo = _TFILE; printf("%d :: <types> FICH \n",numlin);}
      ;


additive_operation : OP_MAS                          {printf("%d :: <additive_operation> OP_MAS \n",numlin);}    
                   | OP_MENOS                        {printf("%d :: <additive_operation> OP_MENOS \n",numlin);}    
                   ;
        
multiplicative_operation : OP_PRODUCTO               {printf("%d :: <multiplicative_operation> OP_PRODUCTO \n",numlin);}    
                         | OP_DIVISION               {printf("%d :: <multiplicative_operation> OP_DIVISION \n",numlin);}    
                         ;

cond_op : OP_IGUAL                                   {printf("%d :: <cond_op> OP_IGUAL \n",numlin);}    
        | OP_MENOR                                   {printf("%d :: <cond_op> OP_MENOR \n",numlin);}    
        | OP_MENORIGUAL                              {printf("%d :: <cond_op> OP_MENORIGUAL \n",numlin);}    
        | OP_MAYOR                                   {printf("%d :: <cond_op> OP_MAYOR \n",numlin);}    
        | OP_MAYORIGUAL                              {printf("%d :: <cond_op> OP_MAYORIGUAL \n",numlin);}    
        | OP_DISTINTO                                {printf("%d :: <cond_op> OP_DISTINTO \n",numlin);}    
        ;
            
expression : math_expression                         {printf("%d :: <expression> math_expression \n",numlin);}    
           ;

cond_expression : cond_expression OP_OR conditional_expression 
                  {printf("%d :: <cond_expression> cond_expression OP_OR \n",numlin);}    
                | cond_expression OP_AND conditional_expression 
                  {printf("%d :: <cond_expression> cond_expression OP_AND \n",numlin);}    
                | conditional_expression 
                  {printf("%d :: <cond_expression> cond_expression \n",numlin);}    
                | OP_NOT conditional_expression 
                  {printf("%d :: <cond_expression> cond_expression OP_NOT \n",numlin);}    
                ;

conditional_expression : conditional_expression cond_op math_expression 
                         {printf("%d :: <conditional_expression> conditional_expression \n",numlin);}    
                       | math_expression 
                         {printf("%d :: <conditional_expression> math_expression \n",numlin);}    
                       ;
        
operation_expression : operation_expression multiplicative_operation factor 
                       {printf("%d :: <operation_expression> operation_expression \n",numlin);}    
                     | factor 
                       {printf("%d :: <operation_expression> factor \n",numlin);}
                     | function_call_statement 
                       {printf("%d :: <operation_expression> function_call_statement \n",numlin);}
                     | operation_expression multiplicative_operation function_call_statement 
                       {printf("%d :: <operation_expression> operation_expression multiplicative_operation function_call_statement\n",numlin);}
                     ;
             
math_expression : math_expression additive_operation operation_expression 
                  {printf("%d :: <math_expression> math_expression \n",numlin);}
                | operation_expression 
                  {printf("%d :: <math_expression> operation_expression \n",numlin);}
                | OP_MENOS operation_expression 
                  {printf("%d :: <math_expression> OP_MENOS \n",numlin);}
                ;
             
factor : SEP_APARENTESIS expression SEP_CPARENTESIS  {printf("%d :: <factor> SEP_APARENTESIS \n",numlin);}
       | ID                                          {if (!tabla.existeSimbolo(nombre[indice-1])) yyerror("El identificador no existe");else {if(tabla.tipoSym(nombre[0])==_ENUM){if (!tabla.checkEnum(nombre[0],nombre[indice-1])) yyerror("Valor de enumerado incompatible"); } else {printf("factor id %s", nombre[indice-1].c_str()); tipo = tabla.tipoSym(nombre[indice-1]); check_type[ind_type++]=tabla.tipoSym(nombre[indice-1]); indice=0; printf("%d :: <factor> ID \n",numlin);}}}
       | INT                                         {tipo = _INT; check_type[ind_type++]=_INT; printf("%d :: <factor> INT \n",numlin);}
       | FLO                                         {tipo = _FLOAT; check_type[ind_type++]=_FLOAT; printf("%d :: <factor> FLO \n",numlin);}
       | ID SEP_ACORCHETE expression SEP_CCORCHETE   {tipo =tabla.tipoVec(nombre[indice-1]); check_type[ind_type++]=tabla.tipoVec(nombre[indice-1]); printf("%d :: <factor> vector \n",numlin);}
       ;

%% 

void Insertar(){

  //Actualizar();
  
  if (cprocedure){ // si son parametros de una funcion
    for (int i = 0; i<indice;i++)
    {
      
      tabla.insertaParam(nombre[i], tipo, tipo_par);
    }
  }
  else if (cfuncion){ // si son campos de una struct
    for (int i = 0; i<indice;i++){
        tabla.insertaParam(nombre[i], tipo, 1); //Siempre son de entrada
    }
  }
  else if(carray){ // tipo array
    for (int i = 0; i<indice;i++)
        tabla.insertaArray(nombre[i],tipo);
    indice=0;
  }
  else if(cenum){ // tipo enum
    for (int i = 0; i<indice;i++)
        tabla.insertaEnum(nombre[i]);
  }
  else if(venum){ // tipo enum
    for (int i = 0; i<indice;i++)
        tabla.insertaCampoEnum(nombre[i]);
  }
  else if(enum_array){ // tipo enum
    tabla.insertaVariableTipo(nombre[0], nombre[1]);
    enum_array=0;    
  }
  else{ // Son varaibles normales, de tipos normales
    for (int i = 0; i<indice;i++) 
      tabla.insertaVar(nombre[i], tipo);
  }
}


void Comprueba_tipo(){
      
      for(int z=1;z<ind_type;z++){
      if (check_type[z] != check_type[0]){
		if(error_tipo_fun) 
			yyerror("El tipo devuelto en la funcion no coincide");
		else
			yyerror ("Tipos incompatibles");
           	break;
      }
       }    
}

int main() 
{ 
    //yyerror ("Inicio \n"); 
  try{
    yyparse(); 
  }
    catch(char const *mensaje){
    printf ("%s. En la linea: %d\n", mensaje,numlin);     
  }
} 
              
void yyerror (char *s) 
{ 
    printf ("Error en linea %d: %s\n",numlin, s);                
}

