%{

#include <cmath>
#include <cstdio>
#include <stdio.h>
#include <cassert>
#include <cstring>
//#include "lex.yy.c"
#include "symtable.h"
#include "Qmachine.h"
  #include <cassert>

extern "C++" {int yylex(void);}
extern FILE *yyin;
FILE* fout;

bool negativo=false;
int labelCount = 2;
bool parteIzquierda = true; // true si se está en la parte izquierda de una asignación, false si en la parte derecha
// Macro: genera código
// Se le pasa la cadena de formato (tipo printf) y las variables a imprimir.
// No se le pasa el \n final.
// Por ejemplo: gc("L %d: GT(%d);", 1, 2); generaría la etiqueta 1 y el salto a la etiqueta 2
bool global = false;
char temp[256];
string inic_globales = "";
#define gc(formato, params...) { \
    if (global){\
        sprintf(temp, formato, ##params);\
        inic_globales = inic_globales + temp;\
    }\
    else\
      fprintf(fout, formato, ##params); \
}

// Máquina Q modelada
Qmachine qm;

extern int numlin;
int yydebug=1;
/* Variable utilizada para obviar los argumentos de 
 * una función a la hora de chequear tipos. */
int tipo_arg = 0;
/* Almacenes temporales para identificadores. */
string nombre[100];
string limitador;
string nombre_tipo;
string nombre_param;
string var_vector;
/* Vector de 100 tipos para el chequeo de los mismos. */
int check_type[100];
vartype tipo_funciones[100];
int ind_tipo_fun = 0;
/* Índice que controla el vector declarado encima. */
int ind_type = 0;

vartype tipo_prev;
/* Índice para la inserción en el vector nombre[]. */
int indice = 0;
vartype tipo, e_switch; 
/* Variable que almacena el tipo de un parámetro:
 *   - 1 = tipo IN,
 *   - 2 = tipo OUT,
 *   - 3 = tipo INOUT. */
int tipo_par =0;
int error_tipo_fun=0;
string operador;
string nombre_fun;
string asignacion;
string asigna_vec;
int valor_enum =0;
int ind_type_aux;


//Variables externas del lexico
int valEntero = 0;
float valFlotante = 0.0;
string valRistra;
int sizeOfVector = -1; // tamaño del vector (nº de elementos) que se está inicializando en una declaración
bool paso_params = false;
int retaddr = -1;


int cfuncion=0;
int cprocedure=0;
int carray=0;
int cenum=0;
int venum=0;
int enum_array=0;
int numparam=0;
int et;
int tam_vector;
symtable tabla;

/* Declaraciones prototipo para funciones definidas
 * al final del fichero. */
void Comprueba_tipo();
bool Comprueba_numparam(string nombre);
void Insertar();
void Actualizar();
int ne();
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

%token RES_PRINTD
%token RES_PRINTF
%token RES_PRINTS
%token RES_PRINTC

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
%start primera_etiqueta

%%
// Falta llamada prototipo de procedimiento
program : program2 RES_IS 
          {
              //Programa principal
              tabla.asignaEtiqueta(limitador, 0); //Por que es etiqueta 0? Probablemente sea porque se suma a un puntero
              cprocedure = 0; 
          } 
          declaraciones
          {
              gc("L 1:\t\t\t// Establecemos el valor de R6 y R7 en base a los datos estaticos\n");
              gc("\tR6 = R7;\n");
              gc("\tR7 = %d;\n", tabla.Cima());
          }
          RES_BEGIN sequence_of_statements RES_END ID SEP_PUNTOCOMA 
          { 
              tabla.finAmbito(); 
              printf("%d :: <program> RES_PROCEDURE \n",numlin); 
              /*Fin del Programa Q*/
	            gc("\tGT(-2);\n");

              //***********************Codigo para las ristras 
              gc("L 0:\t\t\t// Comienzo del programa\n");
              // obtiene vector de literales string a partir de symtable
              vector<symrec> strings = tabla.listaString();
              // carga de literales string en heap
              unsigned long dirFinHeap = H; // dirección de final del heap
              unsigned int i, j, tamReserva = 0;
              DEBUG_PRINT("H: %d\n", H);
              int etiqueta = ne();
              for (i = 0; i < strings.size(); i++)
              {
                tamReserva += strings[i].ristra.size() + 1;
              }
              gc("\tR0 = %d;\t\t\t// Codigo necesario para revervar memoria en el heap\n", etiqueta);
              gc("\tR1 = %d;\t\t\t// cantidad de memoria a reservarT\n", tamReserva);
              gc("\tIF(R1) GT(new_);\n");
              gc("L %d:\n", etiqueta);
              for (i = 0; i < strings.size(); i++)
              {
                for (j = 0; j < strings[i].ristra.size(); j++)
                {
                  gc("\tU(%#.8x) = %d;\n",
                    strings[i].dir + j,
                    strings[i].ristra[j]);
                }
                gc("\tU(%#.8x) = 0; // fin de cadena\n",
                  strings[i].dir + j);
                
                // se incrementa el tamaño del heap usado, ya que esta cadena
                // ocupa tantos bytes como su longitud + el carácter de fin de
                // cadena (\0): size() + 1
                dirFinHeap -= strings[i].ristra.size() + 1;
              }
              
              // si i > 0: dirFinHeap == string[i-1].dir
              // si no:    dirFinHeap == H
              assert(dirFinHeap == (i > 0 ? strings[i-1].dir : H));
              assert(H - dirFinHeap == tamReserva);
              //***************Fin código para las ristras

              gc("\tR5 = %#.8lx;\n", dirFinHeap);
              gc("\tGT(1);\n");
            

              gc("END\n");
              fclose(fout);
          }
        | program2 SEP_PUNTOCOMA 
          { 
              cprocedure = 0; 
              tabla.finAmbito(); 
          } 
          program 
          { 
              printf("%d :: <program> Prototipo_proc \n",numlin); 
          } 
        | RES_FUNCTION ID 
          { 
              limitador = nombre[0]; 
              cfuncion = 1; 
              tabla.insertaFun(limitador); 
              indice=0; 
              tabla.nuevoAmbito();

              //Generamos etiqueta para declaración prototipo 
              int etiq = ne();
              gc("L %d:\n", etiq);
              tabla.asignaEtiqueta(limitador, etiq);
          }
          SEP_APARENTESIS function_param SEP_CPARENTESIS 
          { 
              cfuncion = 0; 
          } 
          RES_RETURN types 
          { 
              tipo_funciones[ind_tipo_fun++]= tipo; 
              tabla.modificaFun(limitador,tipo); 
              indice=0; 
          } 
          SEP_PUNTOCOMA 
          { 
              tabla.finAmbito(); 
          }
          program 
          { 
              printf("%d :: <program> Prototipo_func \n",numlin); 
          }
        ;

primera_etiqueta: {gc("#include \"Q.h\" \n");gc("BEGIN\n");global=false;} program;

nueva_etiqueta : {$$=ne();};

program2 : 
            RES_PROCEDURE ID SEP_APARENTESIS 
           { 
               limitador = nombre[0]; 
               cprocedure = 1; 
               tabla.insertaPro(nombre[0]); 
               indice=0; 
               tabla.nuevoAmbito(); 
           }
           procedure_param SEP_CPARENTESIS
         ;
          
procedure_call_statement : ID SEP_APARENTESIS
                          {
                              nombre_fun = nombre[indice-1];
                              numparam=0;
			      DEBUG_PRINT("\n******COMIENZO DE LA LLAMADA A PROCEDIMIENTO******\n\n");
			      //Guardamos los registros R0, R1, R6, RR0 y RR1
			      gc("\tR7 = R7 - %d;\t\t\t// Comienzo llamada a procedimiento\n", 3*qm.sizeOfType('I') + 2*qm.sizeOfType('D'));
			      gc("\tI(R7) = R0;\n");
			      gc("\tI(R7 + %d) = R1;\n", qm.sizeOfType('I'));
			      gc("\tI(R7 + %d) = R6;\n", 2*qm.sizeOfType('I'));
			      gc("\tD(R7 + %d) = RR0;\n", 3*qm.sizeOfType('I'));
			      gc("\tD(R7 + %d) = RR1;\n", 3*qm.sizeOfType('I') + qm.sizeOfType('D'));
                            
                              gc("\tR7 = R7 - %d;\n", qm.sizeOfType('I')); // espacio para retaddr
                              /*## Guarda la dirección de retorno en la pila */
                              gc("\tI(R7) = %d;\n", retaddr = ne()); // deja hueco para retval, y encima de retval mete retaddr
                              gc("\tR4 = R7;\n");
                              paso_params=true; 
                           }     
        
                           parametros SEP_CPARENTESIS SEP_PUNTOCOMA  
                           { 
                            paso_params=false;
                            if(!Comprueba_numparam(nombre_fun))
                              yyerror((char*)("ERROR: Número de parámetros incorrecto en la llamada\n")); 
                            numparam=0; 
                            printf("%d :: <procedure_call_statement> ID..\n",numlin);


                            gc("\tR6 = R4;\n");
                            // salto al código de la función
                            gc("\tGT(%d);\n", tabla.etiqueta(nombre_fun));
                            // etiqueta al código que va después de la llamada
                            gc("L %d:\n", retaddr);

                            // Guardamos el valor devuelto en un registro para poder restaurar
                            // Los registros del procedimiento que llamó a la función
                           /* char rQType = qm.qTypeFromCpmType(tabla.tipoSym(nombre_fun));
                            switch (rQType){
                              case 'F':
                              case 'D':
                                  gc("\tRR3 = %c(R7);\n", rQType);
                                  gc("\tR7 = R7 + %d;\n", qm.sizeOfType(rQType));
                                  break;
                              default:
                                  gc("\tR4 = %c(R7);\n", rQType);
                                  gc("\tR7 = R7 + %d;\n", qm.sizeOfType(rQType));
                            }*/

                            // Restaura los registros
                            gc("\tR0 = I(R7);\n");                                                // restaura r0
                            gc("\tR1 = I(R7+%d);\n", qm.sizeOfType('I'));                         // restaura r1
                            gc("\tR6 = I(R7+%d);\n", 2*qm.sizeOfType('I'));                       // restaura r6
                            gc("\tRR0 = D(R7+%d);\n", 3*qm.sizeOfType('I'));                      // restaura RR0
                            gc("\tRR1 = D(R7+%d);\n", 3*qm.sizeOfType('I') + qm.sizeOfType('D')); // restaura RR1
                            gc("\tR7 = R7 + %d;\n", 3*qm.sizeOfType('I') + 2*qm.sizeOfType('D'));  // actualiza cima de la pila
                         }
                ;
                         
function_call_statement : ID SEP_APARENTESIS
			  {
                              nombre_fun = nombre[indice-1];
                              numparam=0;
			      DEBUG_PRINT("\n******COMIENZO DE LA LLAMADA A FUNCIÓN******\n\n");
			      //Guardamos los registros R0, R1, R6, RR0 y RR1
			      gc("\tR7 = R7 - %d;\t\t\t// Comienzo llamada a funcion\n", 3*qm.sizeOfType('I') + 2*qm.sizeOfType('D'));
			      gc("\tI(R7) = R0;\n");
			      gc("\tI(R7 + %d) = R1;\n", qm.sizeOfType('I'));
			      gc("\tI(R7 + %d) = R6;\n", 2*qm.sizeOfType('I'));
			      gc("\tD(R7 + %d) = RR0;\n", 3*qm.sizeOfType('I'));
			      gc("\tD(R7 + %d) = RR1;\n", 3*qm.sizeOfType('I') + qm.sizeOfType('D'));

                            int size_retval = qm.sizeOfType(qm.qTypeFromCpmType(tabla.tipoSym(nombre_fun)));
                            gc("\tR7 = R7 - %d;\n", qm.sizeOfType('I') + size_retval); // espacio para retaddr + espacio para retval
                            /*## Guarda la dirección de retorno en la pila */
                            gc("\tI(R7) = %d;\n", retaddr = ne()); // deja hueco para retval, y encima de retval mete retaddr
                            gc("\tR4 = R7;\t\t\t// A continuacion codigo de parametros\n");
                            paso_params=true;

			  }

			  parametros SEP_CPARENTESIS
        { 
            paso_params=false;
            if(!Comprueba_numparam(nombre_fun))
              yyerror((char*)("ERROR: Número de parámetros incorrecto en la llamada\n")); 
            numparam=0; 
            printf("%d :: <function_call_statement> ID..\n",numlin);


            gc("\tR6 = R4;\n");
            // salto al código de la función
            gc("\tGT(%d);\t\t\t// GT a la funcion \n", tabla.etiqueta(nombre_fun));
            // etiqueta al código que va después de la llamada
            gc("L %d:\t\t\t// Etiqueta de retorno\n", retaddr);

            // Guardamos el valor devuelto en un registro para poder restaurar
            // Los registros del procedimiento que llamó a la función
            char rQType = qm.qTypeFromCpmType(tabla.tipoSym(nombre_fun));
            switch (rQType){
              case 'F':
              case 'D':
                  gc("\tRR3 = %c(R7);\n", rQType);
                  gc("\tR7 = R7 + %d;\n", qm.sizeOfType(rQType));
                  break;
              default:
                  gc("\tR4 = %c(R7);\n", rQType);
                  gc("\tR7 = R7 + %d;\n", qm.sizeOfType(rQType));
            }

            // Restaura los registros
            gc("\tR0 = I(R7);\t\t\t// Restauramos los registros\n");                                                // restaura r0
            gc("\tR1 = I(R7+%d);\n", qm.sizeOfType('I'));                         // restaura r1
            gc("\tR6 = I(R7+%d);\n", 2*qm.sizeOfType('I'));                       // restaura r6
            gc("\tRR0 = D(R7+%d);\n", 3*qm.sizeOfType('I'));                      // restaura RR0
            gc("\tRR1 = D(R7+%d);\n", 3*qm.sizeOfType('I') + qm.sizeOfType('D')); // restaura RR1
            gc("\tR7 = R7 + %d;\n", 3*qm.sizeOfType('I') + 2*qm.sizeOfType('D'));  // actualiza cima de la pila
        
            // Ponemos en la pila el valor de retorno que se guardó en un registro
            switch (rQType){
              case 'F':
              case 'D':
              case 'E':
                gc("\tR7 = R7 - %d;\n", qm.sizeOfType('F'));
                rQType = 'F';
                gc("\tF(R7) = RR3;\n");
                break;
              default:
                gc("\tR7 = R7 - %d;\n", qm.sizeOfType('I'));
                rQType = 'I';
                gc("\tI(R7) = R4;\n");
            }
            
            $$ = rQType; //retornamos el tipo de la función

        }
        ;

subprogram_declaration : subprogram_specification SEP_PUNTOCOMA 
                         { 
                             tabla.finAmbito(); 
                             indice=0; 
                             numparam=0; 
                             printf("%d :: <subprogram_declaration> subprogram_specification \n",numlin);
                         }
                       ;

subprogram_specification : RES_PROCEDURE ID 
                           { 
                               limitador = nombre[0]; 
                               cprocedure = 1; 
                               tabla.insertaPro(nombre[0]); 
                               indice=0;
                               numparam=0; 
                               tabla.nuevoAmbito();

                               //Se le asigna una etiqueta
                               int etiq = ne();
                               gc("L %d:\n", etiq);
                               tabla.asignaEtiqueta(limitador, etiq);
                           }
                           SEP_APARENTESIS procedure_param SEP_CPARENTESIS 
                           { 
                               cprocedure = 0; 
                           }
                           RES_IS declaraciones { gc("\tR7 = R6 - %d;\n",tabla.valorRcima());} 

                           RES_BEGIN sequence_of_statements RES_END ID 
                           
                           { 
                               gc("\tR7 = R6;\n");
                               gc("\tR0 = I(R7);\n"); // almacena la dirección de retorno en R0
                               gc("\tR7 = R7 + %d;\n", qm.sizeOfType('I'));
                               gc("\tGT(R0);\n");
                               printf("%d :: <subprogram_specification> RES_PROCEDURE \n",numlin);
                           }
                         | RES_FUNCTION ID 
                           {
                               limitador = nombre[0]; 
                               cfuncion = 1; 
                               tabla.insertaFun(nombre[0]); 
                               indice=0; 
                               numparam=0;
                               tabla.nuevoAmbito();

                               //Se le asigna una etiqueta
                               int etiq = ne();
                               gc("L %d:\n", etiq);
                               tabla.asignaEtiqueta(limitador, etiq)
                           }
                           SEP_APARENTESIS function_param {/*Insertar(); indice=0;tipo_par=0;numparam=0;*/ } SEP_CPARENTESIS RES_RETURN types 
                           {
                               tipo_funciones[ind_tipo_fun++]= tipo; 
                               tabla.modificaFun(limitador,tipo); 
                               cfuncion = 0; 
                               indice=0;
                           }
                           RES_IS declaraciones { gc("\tR7 = R6 - %d;\n",tabla.valorRcima());} 
                           
                           RES_BEGIN sequenciafunction RES_END ID 

                           {
                               printf("%d :: <subprogram_specification> RES_FUNCTION \n",numlin);
                           }    
                         ;
                         
procedure_param : procedure_param SEP_PUNTOCOMA ID SEP_DOSPUNTOS tipo_ent_proc types 
                  { 
                      numparam++;
                      printf("\n\n P param NUMPARAM++\n\n");
                      Insertar(); 
                      indice=0; 
                      tipo_par=0;
                      printf("%d :: <procedure_param> procedure_param SEP_PUNTOCOMA \n",numlin);
                  }
                | ID SEP_DOSPUNTOS tipo_ent_proc types 
                  { 
                      numparam++;
                      printf("\n\n P param NUMPARAM++\n\n");
                      Insertar(); 
                      indice=0; 
                      tipo_par=0;
                      printf("%d :: <procedure_param> ID SEP_DOSPUNTOS \n",numlin);
                  }
                | {
                      printf("%d :: <procedure_param> empty \n",numlin);
                  }
                ;
                
function_param : function_param SEP_PUNTOCOMA ID {nombre_param= nombre[indice-1];} SEP_DOSPUNTOS types 
                 { 
                     numparam++;
                     printf("\n\n F param NUMPARAM++\n\n");
                     Insertar(); 
                     //indice=0; 
                     tipo_par=0; 
                     printf("%d :: <function_param> function_param SEP_PUNTOCOMA \n",numlin);
                 }
               | ID SEP_DOSPUNTOS {nombre_param= nombre[indice-1];} types 
                 {
                     numparam++;
                     printf("\n\n F param NUMPARAM++\n\n");
                     Insertar(); 
                     //ATENCIÓN: ESTE CASO ES ESPECIAL, SI SÓLO HAY UN PARÁMETRO HAY QUE HACERLO ARRIBA
                     //SI NO SE QUITA EL INSERTAR DE AQUI,SE EJECUTA UNA VEZ PARA EL ULTIMO CASO Y OTRA VEZ
                     //PARA LA REGLA DE ARRIBA (EL CASO RESURSIVO) No se hizo esto. Ver donde se llama a function param
                     //y eso se tiene q duplicar en procedure param
                     //indice=0; 
                     tipo_par=0; 

                     printf("%d :: <function_param> ID SEP_DOSPUNTOS \n",numlin);
                 }
               | {
                     printf("%d :: <function_param> empty \n",numlin);
                 }
               ;
               
tipo_ent_proc : RES_IN 
                {
                    tipo_par = 1; 
                    printf("%d :: <tipo_ent_proc> RES_IN \n",numlin);
                }
              | RES_OUT 
                {
                    tipo_par = 2; 
                    printf("%d :: <tipo_ent_proc> RES_OUT \n",numlin);
                }
              | RES_IN_OUT
                {
                    tipo_par = 3; 
                    printf("%d :: <tipo_ent_proc> RES_IN_OUT \n",numlin);
                }
              ;
              
declaraciones : declaraciones declaracion
                {
                    printf("%d :: <declaraciones> declaraciones declaracion \n",numlin);
                }
              | {
                    printf("%d :: <declaraciones> empty \n",numlin);
                }
              ;

declaracion : ID SEP_DOSPUNTOS types SEP_PUNTOCOMA 
              {
                  Insertar();
                  //Ponemos en $$ el tipo convertido de variable
                  $$ = qm.qTypeFromCpmType((vartype)$1); 
                  indice=0; 
                  printf("%d :: <declaracion> ID SEP_DOSPUNTOS \n",numlin);
              }
            | enum_type_def
              {
                  printf("%d :: <declaracion> enum_type_def \n",numlin);
              }
            | array_def 
              {
                  printf("%d :: <declaracion> array_def \n",numlin);
              }
            | subprogram_declaration
              {
                  printf("%d :: <declaracion> subprogram_declaration\n",numlin);
              }
            ; 

parametros : var
             {
                 numparam++; 
                 printf("\n\n -> Parametros NUMPARAM++\n\n");
                 //check_type[ind_type++]=tipo; 
                 char tParam= qm.qTypeFromCpmType(tipo); //Obtenemos el tipo en modo carácter
                 if(tipo != tabla.tipoParam(nombre_fun,numparam-1))  yyerror((char*)("Parametro pasado de tipo incorrecto")); 
                 string reg = qm.autoReg(tParam);
                 gc("\tR7 = R7 - %d;\n", qm.sizeOfType(tParam)); // decrementa R7

                 switch (tParam)
                 {
                    case 'P':
                    case 'U':
                    case 'I':
                        gc("\t%c(R7) = R0;\n", tParam); // expression devuelve entero en R0
                        break;
                    case 'F':
                        gc("\t%c(R7) = RR0;\n", tParam); // expression devuelve doble en RR0
                  }

                 printf("%d :: <parametros> var \n",numlin);
             }
           | parametros SEP_COMA var
             {
                 numparam++; 
                 printf("\n\n > Parametros NUMPARAM++\n\n");
                 //check_type[ind_type++]=tipo;
                 char tParam= qm.qTypeFromCpmType(tipo); //Obtenemos el tipo en modo carácter
                 if(tipo != tabla.tipoParam(nombre_fun,numparam-1))  yyerror((char*)("Parametro pasado de tipo incorrecto")); 
                 string reg = qm.autoReg(tParam);
                 gc("\tR7 = R7 - %d;\n", qm.sizeOfType(tParam)); // decrementa R7

                 switch (tParam)
                 {
                    case 'P':
                    case 'U':
                    case 'I':
                        gc("\t%c(R7) = R0;\n", tParam); // expression devuelve entero en R0
                        break;
                    case 'F':
                        gc("\t%c(R7) = RR0;\n", tParam); // expression devuelve doble en RR0
                  }


                 printf("%d :: <parametros> parametros SEP_COMA \n",numlin);
             }
           | {
                 printf("%d :: <parametros> empty \n",numlin);
             }
           ;

var : ID 
      {
          tipo = tabla.tipoSym(nombre[indice-1]); 
	        if (!paso_params){
              gc("\tR1 = %s;\n" , tabla.dirVar(nombre[indice-1]));
              $$ = qm.qTypeFromCpmType(tipo);
          }
          else{
            $$ = qm.qTypeFromCpmType(tabla.tipoSym(nombre[indice-1]));
            gc("\t%s0 = %s;\n" ,qm.autoReg($$).c_str(), tabla.dirVar(nombre[indice-1]));
            //gc("\tR0 = R1;\n");
          }
          printf("%d :: <var> ID \n",numlin);
      }
    | INT 
      {
          tipo = _INT; 
          if (!paso_params){
              gc("\tR1 = %d;\n", valEntero); $$='I';
          }
          else{
            gc("\tR0 = %d;\n", valEntero); $$='I';
          }
          printf("%d :: <var> INT \n",numlin);
      }
    | FLO 
      {
          tipo = _FLOAT; 
          if (!paso_params){
	           gc("\tRR1 = %f;\n", valFlotante); $$='F';
          }
          else{
            gc("\tRR0 = %f;\n", valFlotante); $$='F';
          }
          printf("%d :: <var> FLO \n",numlin);
      }
    | CHAR 
      {
          tipo = _CHAR; 
          if (!paso_params){
	           gc("\tR1 = %d;\n", valEntero); $$='I';
          }
          else{
            gc("\tR0 = %d;\n", valEntero); $$='I';
          }
          printf("%d :: <var> CHAR \n",numlin);
      }
    | STRING 
      {
          tipo = _STRING; 
          printf("%d :: <var> STRING \n",numlin);
      }
    | ID SEP_ACORCHETE {var_vector=nombre[indice-1]} expression SEP_CCORCHETE
      {
          tipo = tabla.tipoVec(var_vector); 
          printf("%d :: <var> vector \n",numlin);
          $$ = qm.qTypeFromCpmType(tipo);
          gc("\tR0 = %s;\n",tabla.dirVector(asigna_vec)); 
      	  gc("\tR3 = I(R7);\n");
          gc("\tR7 = R7 + 4;\n");
      	  gc("\tR3 = R3 * 4;\n");
      	  gc("\tR3 = R3 - 4;\n");
      	  gc("\tR0 = R0 + R3;\n\n");
      	  gc("\t%s0 = %c(R0);\n",qm.autoReg($$).c_str(),qm.qTypeFromCpmType(tipo));
          //gc("\tR7 = R7 - 4;\n\t%c(R7) = %s0;\n", $$, qm.autoReg($$).c_str());
      }
    ;

sequenciafunction : sequence_of_statements 
                    {
                        printf("%d :: <sequenciafunction> sequence_of_statements \n",numlin);
                    }
                  ;

sequence_of_statements : sequence_of_statements statement 
                         {
                             printf("%d :: <sequence_of_statements> sequence_of_statements statement \n",numlin);
                         }
                       | statement 
                         {
                             printf("%d :: <sequence_of_statements> statement \n",numlin);
                         }
                       ;

statement : simple_statement
            {
                ind_type=0; 
                printf("%d :: <statement> simple_statement \n",numlin);
            }
          | compound_statement 
            {
                ind_type=0; 
                printf("%d :: <statement> compound_statement \n",numlin);
            }
          | error
            {
                printf("------ %d :: SYNTAX ERROR FOUND ON LINE %d \n",numlin,numlin);
            }
          |
            print_statement
            {
                printf("------ %d :: <statement> print_statement %d \n",numlin,numlin);
            }
          ;

compound_statement : if_statement 
                     {
                         printf("%d :: <compound_statement> if_statement \n",numlin);
                     }
                   | case_statement
                     {
                         printf("%d :: <compound_statement> case_statement \n",numlin);
                     }
                   | while_statement 
                     {
                         printf("%d :: <compound_statement> while_statement \n",numlin);
                     }
                   | asignment_statement
                     {
                         printf("%d :: <compound_statement> asignment_statement \n",numlin);
                     }
                   | return_statement 
                     {
                         printf("%d :: <compound_statement> return_statement \n",numlin);
                     }
                   ;

simple_statement : procedure_call_statement 
                   {
                       printf("%d :: <simple_statement> procedure_call_statement \n",numlin);
                   }
                 ;

print_statement: RES_PRINTD nueva_etiqueta SEP_APARENTESIS ID SEP_CPARENTESIS SEP_PUNTOCOMA 
                {
                  gc("\tR0 = %d;\t\t\t// Imprimir entero\n", $2);
                  gc("\tR1 = %s;\n",tabla.dirVar(nombre[indice-1]));
                  gc("\tR2 = 0;\n");
                  gc("\tGT(putf_);\nL %d:\n",$2);

                  printf("%d :: <print_statement> printd \n",numlin);
                }

                |

                RES_PRINTF nueva_etiqueta SEP_APARENTESIS ID SEP_CPARENTESIS SEP_PUNTOCOMA 
                {
                  gc("\tR0 = %d;\t\t\t// Imprimir reales\n", $2);
                  gc("\tRR1 = %s;\n",tabla.dirVar(nombre[indice-1]));
                  gc("\tR2 = 1;\n");
                  gc("\tGT(putf_);\nL %d:\n",$2);

                  printf("%d :: <print_statement> printf \n",numlin);
                }

                |

                RES_PRINTS nueva_etiqueta SEP_APARENTESIS ID SEP_CPARENTESIS SEP_PUNTOCOMA 
                {
                  gc("\tR0 = %d;\t\t\t// Imprimir string\n", $2);
                  gc("\tR1 = %s;\n",tabla.dirVar(nombre[indice-1]));
                  gc("\tR2 = 2;\n");
                  gc("\tGT(putf_);\nL %d:\n",$2);

                  printf("%d :: <print_statement> printf \n",numlin);
                  
                }

                |
                  RES_PRINTC nueva_etiqueta SEP_APARENTESIS ID SEP_CPARENTESIS SEP_PUNTOCOMA 
                {
                  gc("\tR0 = %d;\t\t\t// Imprimir char\n", $2);
                  gc("\tR1 = %s;\n",tabla.dirVar(nombre[indice-1]));
                  gc("\tR2 = 3;\n");
                  gc("\tGT(putf_);\nL %d:\n",$2);

                  printf("%d :: <print_statement> printd \n",numlin);
                }
                ;

asignment_statement: ID { asignacion = nombre[indice-1]; ind_type=0;} asignment_statement2

asignment_statement2 : OP_ASIGNACION expression SEP_PUNTOCOMA 
                      {
                          printf("**************///////--------- %d\n\n\n",indice);
                          printf("**************////////////////%s\n\n\n",asignacion.c_str());
                          check_type[ind_type++] = tabla.tipoSym(asignacion); 
                          indice=0;
                          Comprueba_tipo(); 
                          ind_type = 0; 
                          printf("%d :: <asignment_statement> ID OP_ASIGNACION\n", numlin);
                          gc("\t%s0 = %c(R7);\t\t\t// Codigo de asignacion -> expression\n",qm.autoReg($2).c_str(), $2);
                          gc("\t%s = %s0;\n",tabla.dirVar(asignacion), qm.autoReg($2).c_str());
                          gc("\tR7 = R7 + %d;\n",qm.sizeOfType($2));
                          $$=$1; parteIzquierda = true;
                      }
                    | OP_ASIGNACION STRING SEP_PUNTOCOMA 
                      {
                          if (tabla.tipoSym(nombre[0]) != _STRING) 
                              yyerror((char*)("Tipo incompatible")); 
                          indice=0; 
                          printf("%d :: <asignment_statement> STRING \n",numlin);
                          //Meter en R0 la dir del literal ristra
                          gc("\tR0 = %d;\t\t\t// Codigo de asignacion -> string\n",tabla.insertaString(valRistra)); //Asignación de una string
                          //gc("Se genera aqui la dir de la string");
                          gc("\t%s = R0;\n",tabla.dirVar(asignacion));
                      }
                    | SEP_ACORCHETE 
                      {
                          check_type[ind_type++]= tabla.tipoVec(asignacion); 
                          ind_type_aux=ind_type;
                          indice = 0; 
                      } 
                      expression SEP_CCORCHETE 
                      {
                  			  //Hay que recuperar el valor de la posición
                          ind_type=ind_type_aux;
                  	  gc("\tR3 = %c(R7);\t\t\t// Codigo de asignacion -> array := expression\n", $3);
              		    gc("\tR7 = R7 + 4;\n");
                       } 
                      OP_ASIGNACION expression SEP_PUNTOCOMA 
                      {
                          indice=0; 
                          Comprueba_tipo(); 
                          ind_type = 0;
                          gc("\t%s0 = %c(R7);\n",qm.autoReg($7).c_str(), $7);
			                    gc("\tR1 = %s;\n",tabla.dirVector(asignacion));
		                      //Sumamos R1= R1+ posición -1
			                     gc("\tR3 = R3 * 4;\n");
                  			  gc("\tR1 = R1 + R3;\n");
                  			  gc("\tR1 = R1 - 4;\n");
                          gc("\t%c(R1) = %s0;\n",qm.qTypeFromCpmType(tabla.tipoVec(asignacion)),qm.autoReg($7).c_str());
                          gc("\tR7 = R7 + %d;\n",qm.sizeOfType($7)); 
                          printf("%d :: <asignment_statement> vector \n",numlin);
                      }
                    ; 

case_statement : RES_CASE nueva_etiqueta factor {gc("\t%s2 = %c(R7);\t\t\t// Codigo de case\n",qm.autoReg($3).c_str(), $3); et = $2; e_switch=tipo;} RES_IS case_statement_alternative alternative2 RES_END RES_CASE SEP_PUNTOCOMA 
                 {
		     gc("L %d:\n",$2);
			
		     gc("\tR7 = R7 + 4;\n"); //Se compensa la reserva de pila del principio
                     printf("%d :: <case_statement> RES_CASE ID \n",numlin);
                 }
               ;
case_statement_alternative : RES_WHEN nueva_etiqueta var 
                             {
				gc("\t%s0 = %s2 - %s1;\n",qm.autoReg($3).c_str(),qm.autoReg($3).c_str(),qm.autoReg($3).c_str());
				gc("\tIF(%s0) GT(%d);\t\t\t// Case alternative\n",qm.autoReg($3).c_str(),$2); 
                                 if (tipo != e_switch) 
                                     yyerror ((char*)("Tipo incompatible en alternativa del case."));
				 
                             } 
                             OP_FLECHITA sequence_of_statements 
                             {
                                 printf("%d :: <case_statement_alternative> RES_WHEN var \n",numlin);
				 gc("\tGT(%d);\t\t\t// Fin del case\n",et); //Tras la opción, salimos del case
				 gc("L %d :\n",$2);
                             }
                           ;
                           
alternative2 : alternative2 case_statement_alternative  
               {
                   printf("%d :: <alternative2> alternative2 case_statement_alternative \n",numlin);
               }
             | {
                   printf("%d :: <alternative2> empty \n",numlin);
               }
             ;

while_statement : RES_WHILE escribe_etiqueta nueva_etiqueta SEP_APARENTESIS cond_expression SEP_CPARENTESIS  

                  { 
                    gc("\tR7 = R7 + 4;\n");
                    gc("\tIF(!R0) GT(%d);\t\t\t// While: Punto de decision\n",$3);
                  } 

                  RES_LOOP 
                  {
                      Comprueba_tipo(); 
                      ind_type=0;
                  } 
                  sequence_of_statements RES_END RES_LOOP  SEP_PUNTOCOMA 
                  {
                      gc("\tGT(%d);\nL %d:\t\t\t// Etiqueta despues del while\n",$2,$3);
                      printf("%d :: <while_statement> RES_WHILE SEP_APARENTESIS \n",numlin);
                  }
                ;

escribe_etiqueta: nueva_etiqueta {gc("L %d:\n", $1); $$ = $1;};

if_statement : RES_IF SEP_APARENTESIS condicion  SEP_CPARENTESIS  RES_THEN nueva_etiqueta
               {
                   Comprueba_tipo(); 
                   ind_type=0;
               }  
               sequence_of_statements {gc("\tGT(%d);\t\t\t// GT: Fin del if\nL %d:\t\t\t// Etiqueta del else\n",$6,$3);} if_stat2 RES_END RES_IF SEP_PUNTOCOMA 
               {
                   gc("L %d:\t\t\t// Fin del IF\n",$6);

                   printf("%d :: <if_statement> RES_IF SEP_APARENTESIS \n",numlin);
               }
        
             ;

condicion: nueva_etiqueta cond_expression 
                {
                   //Nueva etiqueta es la etiqueta del else
                   gc("\tR7 = R7 + 4;\n");
                   gc("\tIF (!%s0) GT(%d);\t\t\t// IF -> GT Else\n",qm.autoReg($2).c_str(),$1); $$=$1;
                } 
             
if_stat2 : RES_ELSE sequence_of_statements 
           {
               printf("%d :: <if_stat2> RES_ELSE sequence_of_statements \n",numlin);
           }
         | {
               printf("%d :: <if_stat2> empty \n",numlin);
           }
         ;

return_statement : RES_RETURN math_expression SEP_PUNTOCOMA 
                   {
                       error_tipo_fun=1; 
                       check_type[ind_type++]=tipo_funciones[--ind_tipo_fun]; 
                       Comprueba_tipo(); 
                       error_tipo_fun=0; 
                       printf("%d :: <return_statement> RES_RETURN math_expression \n",numlin);

                       //Código de retorno de la función 
                       gc("\tR7 = R6;\n");

                       // Almacena el valor de retorno
                       //gc("\tR7 = R6;\n");
                       gc("\t%c(R7+%d) = %s0;\t\t\t// Return -> Almacena valor de retorno\n", // encima de retval está retaddr, así que hay que "saltar" retaddr: R7+sizeof(P)
                          qm.qTypeFromCpmType(tabla.tipoSym(limitador)),
                          qm.sizeOfType('I'),
                          qm.autoReg($2).c_str());
                       // Retorna de la función
                       gc("\tR0 = I(R7);\t\t\t// Return -> Almacena direccion de retorno\n"); // almacena la dirección de retorno en R0
                       gc("\tR7 = R7 + %d;\n", qm.sizeOfType('I')); // elimina retaddr de la pila (queda retval)
                       gc("\tGT(R0);\t\t\t// Return -> GT direccion de retorno\n");

                   }
                 | RES_RETURN STRING SEP_PUNTOCOMA 
                   {
                       if(tipo_funciones[--ind_tipo_fun]!= _STRING) 
                           yyerror((char*)("El tipo devuelto por la funcion no coincide."));
                       printf("%d :: <return_statement> RES_RETURN STRING \n",numlin);
                   }
                 ;

enum_type_def : RES_TYPE ID RES_IS SEP_APARENTESIS 
                {
                    cenum=1;
		    valor_enum=0; 
                    Insertar(); 
                    cenum=0; 
                    indice=0;
                } 
                enum_type_def2 SEP_CPARENTESIS SEP_PUNTOCOMA 
                {
                    printf("%d :: <enum_type_def> RES_TYPE ID \n",numlin);
                }
              ;

enum_type_def2 : enum_type_def2 SEP_COMA ID
                 {
                     venum=1; 
                     Insertar(); 
                     venum=0; 
                     indice=0; 
                     printf("%d :: <enum_type_def2> ID COMA ID \n",numlin);
                 }
               | ID 
                 {
                     venum=1; 
                     Insertar(); 
                     venum=0; 
                     indice=0; 
                     printf("%d :: <enum_type_def2> ID \n",numlin);
                 }
               ;

array_def : RES_TYPE ID RES_IS RES_ARRAY SEP_APARENTESIS INT RANGO INT {tam_vector = valEntero;} SEP_CPARENTESIS RES_OF types SEP_PUNTOCOMA 
            {
                carray=1; 
                Insertar(); 
                carray=0; 
                indice=0; 
                printf("%d :: <array_def> RES_TYPE ID \n",numlin);
            }
          ;

types : ID
        {
            tabla.ea_param = nombre[indice-1];
            enum_array=1;
	          if (tabla.tipoSym(tabla.ea_param) == _ENUM) tipo=_ENUM;
            else tipo=_ARRAY;
            $$ = tipo; 
            printf("%d :: <types> ID \n",numlin);
        }
      | RES_INTEGER 
        {
            tipo = _INT;
            $$ = tipo;
            printf("%d :: <types> RES_INTEGER \n",numlin);
        }
      | RES_FLOAT 
        {
            tipo = _FLOAT; 
            $$ = tipo;
            printf("%d :: <types> RES_FLOAT \n",numlin);
        }
      | RES_CHAR 
        {
            tipo = _CHAR;
            $$ = tipo; 
            printf("%d :: <types> RES_CHAR \n",numlin);
        }
      | RES_STRING 
        {
            tipo = _STRING;
            $$ = tipo;
            printf("%d :: <types> RES_STRING \n",numlin);
        }
      | FICH 
        {
            tipo = _TFILE; 
            $$ = tipo;
            printf("%d :: <types> FICH \n",numlin);
        }
      ;


additive_operation : OP_MAS  
                     {
                         $$ = 43; //Codigo ASCII del +
                         printf("%d :: <additive_operation> OP_MAS \n",numlin);
                     }    
                   | OP_MENOS 
                     {
                         $$ = 45; //Codigo ASCII del -
                         printf("%d :: <additive_operation> OP_MENOS \n",numlin);
                     }    
                   ;
        
multiplicative_operation : OP_PRODUCTO 
                           {
                               $$ = 42; //Codigo ASCII del *
                               printf("%d :: <multiplicative_operation> OP_PRODUCTO \n",numlin);
                           }    
                         | OP_DIVISION 
                           {
                               $$ = 47; //Codigo ASCII del /
                               printf("%d :: <multiplicative_operation> OP_DIVISION \n",numlin);
                           }    
                         ;

cond_op : OP_IGUAL 
          {
              operador="=";
              printf("%d :: <cond_op> OP_IGUAL \n",numlin);
          }    
        | OP_MENOR
          {
              operador="<";
              printf("%d :: <cond_op> OP_MENOR \n",numlin);
          }    
        | OP_MENORIGUAL
          {
              operador="<=";
              printf("%d :: <cond_op> OP_MENORIGUAL \n",numlin);
          }    
        | OP_MAYOR 
          {
              operador=">";
              printf("%d :: <cond_op> OP_MAYOR \n",numlin);
          }    
        | OP_MAYORIGUAL
          {
              operador=">=";
              printf("%d :: <cond_op> OP_MAYORIGUAL \n",numlin);
          }    
        | OP_DISTINTO
          {
              operador="!=";
              printf("%d :: <cond_op> OP_DISTINTO \n",numlin);
          }    
        ;
            
expression : math_expression
             {
                 $$ = $1;
                 printf("%d :: <expression> math_expression \n",numlin);
             }    
           ;

cond_expression : cond_expression OP_OR cond_expression 
                  {
                        //Se ha modificado: antes era conditional_expression, ahora cond_expression
                        string reg1 = qm.autoReg($1), reg2 = qm.autoReg($3);
                			gc("\t%s1 = %c(R7);\t\t\t// Condicion OR Condicion\n",reg2.c_str(),$3);
                			gc("\t%s0 = %c(R7+%d);\n",reg1.c_str(),$1,qm.sizeOfType($3));
                			gc("\t%s0 = %s0 || %s1;\n",reg1.c_str(),reg1.c_str(),reg2.c_str());
                			gc("\tR7 = R7 + %d;\n",qm.sizeOfType($1)+qm.sizeOfType($3)-4);
                			gc("\t%c(R7) = %s0;\n",$3,reg1.c_str());
                			$$ = $3;
                      printf("%d :: <cond_expression> cond_expression OP_OR \n",numlin);
                  }    
                | cond_expression OP_AND cond_expression 
                  {
                        //Se ha modificado: antes era conditional_expression, ahora cond_expression
                        string reg1 = qm.autoReg($1), reg2 = qm.autoReg($3);
              			gc("\t%s1 = %c(R7);\t\t\t// Condicion AND Condicion\n",reg2.c_str(),$3);
              			gc("\t%s0 = %c(R7+%d);\n",reg1.c_str(),$1,qm.sizeOfType($3));
              			gc("\t%s0 = %s0 && %s1;\n",reg1.c_str(),reg1.c_str(),reg2.c_str());
              			gc("\tR7 = R7 + %d;\n",qm.sizeOfType($1)+qm.sizeOfType($3)-4);
              			gc("\t%c(R7) = %s0;\n",$3,reg1.c_str());
              			$$ = $3;
                      printf("%d :: <cond_expression> cond_expression OP_AND \n",numlin);
                  }    
                | conditional_expression 
                  {
                      $$ = $1;
                      printf("%d :: <cond_expression> cond_expression \n",numlin);
                  }    
                | OP_NOT conditional_expression 
                  {
                      string reg2 = qm.autoReg($2);
                			gc("\t%s0 = %c(R7);\t\t\t// NOT Condicion\n",reg2.c_str(),$2);
                			gc("\t%s0 = !%s0;\n",reg2.c_str(),reg2.c_str());
                			gc("\tR7 = R7 + %d;\n",qm.sizeOfType($2)-4);
                			gc("\t%c(R7) = %s0;\n",$2,reg2.c_str());
                			$$ = $2;
                      printf("%d :: <cond_expression> cond_expression OP_NOT \n",numlin);
                  }    
                ;

conditional_expression : conditional_expression cond_op math_expression 
                         {
                          {string reg1 = qm.autoReg($1), reg2 = qm.autoReg($3);
                    			  gc("\t%s1 = %c(R7);\t\t\t// conditional_expression op_condicion expression\n",reg2.c_str(),$3);
                    			  gc("\t%s0 = %c(R7+%d);\n",reg1.c_str(),$1,qm.sizeOfType($3));
                    			  if (operador == "="){
                    		                gc("\t%s0 = %s0 - %s1;\n",reg1.c_str(),reg1.c_str(),reg2.c_str());
                    		                gc("\t%s0 = !%s0;\n",reg1.c_str(), reg1.c_str());
                    		    }
                    			  else{
                    				  gc("\t%s0 = %s0 %s %s1;\n",reg1.c_str(),reg1.c_str(),operador.c_str(),reg2.c_str());
                    			  }
                    			  gc("\t%c(R7 + %d) = %s0;\n",$3,qm.sizeOfType($1)+qm.sizeOfType($3)-4, reg1.c_str());
                    			  gc("\tR7 = R7 + %d;\n",qm.sizeOfType($1)+qm.sizeOfType($3)-4);
                    			  $$ = 'I';}

                          printf("%d :: <conditional_expression> conditional_expression \n",numlin);
                         }    
                       | math_expression 
                         {
                             $$ = $1;
                             printf("%d :: <conditional_expression> math_expression \n",numlin);
                         }    
                       ;
        
operation_expression : operation_expression multiplicative_operation factor_mas_menos
                       {

                           printf("%d :: <operation_expression> operation_expression \n",numlin);
                           string reg1 = qm.autoReg($1), reg2 = qm.autoReg($3);
                           gc("\t%s1 = %c(R7);\t\t\t// operation_expression multiplicative_operation factor\n",reg2.c_str(),$3);
                           gc("\t%s0 = %c(R7+%d);\n",reg1.c_str(),$1,qm.sizeOfType($3));
                           gc("\t%s0 = %s0 %c %s1;\n",reg1.c_str(),reg1.c_str(),$2,reg2.c_str());
                           gc("\tR7 = R7 + %d;\n",qm.sizeOfType($1)+qm.sizeOfType($3)-4); //Se pone -4 para almacenar en la primera pos, R0.
                           gc("\t%c(R7) = %s0;\n",$3, reg1.c_str());
                           $$=$3;
                       } 

                     | factor_mas_menos
                       {
                           $$=$1;
                           printf("%d :: <operation_expression> factor_mas_menos \n",numlin);
                       }
                      |
                        function_call_statement
                        {
                          $$=$1;
                          printf("%d :: <operation_expression> function_call_statement \n",numlin);
                        }

                     | operation_expression multiplicative_operation function_call_statement
                       {
                           $$=$3;
                           printf("%d :: <operation_expression> operation_expression multiplicative_operation function_call_statement\n",numlin);
                       }
                     ;

factor_mas_menos: factor
                  {$$=$1;
		   printf("%d :: <factor_mas_menos> factor \n",numlin);
		  }
                 |
                  OP_MENOS {negativo=true;} factor
		              {
                    $$=$3;
                  printf("%d :: <factor_mas_menos> menos factor \n",numlin); 
                  }
                  ;

math_expression : math_expression additive_operation operation_expression 
                  {
                      printf("%d :: <math_expression> math_expression \n",numlin);
                      string reg1 = qm.autoReg($1), reg2 = qm.autoReg($3);
                      gc("\t%s1 = %c(R7);\t\t\t// math_expression additive_operation operation_expression\n",reg2.c_str(),$3);
                      gc("\t%s0 = %c(R7+%d);\n",reg1.c_str(),$1,qm.sizeOfType($3));
                      gc("\t%s0 = %s0 %c %s1;\n",reg1.c_str(),reg1.c_str(),$2,reg2.c_str());
                      gc("\tR7 = R7 + %d;\n",qm.sizeOfType($1)+qm.sizeOfType($3)-4); //Se pone -4 para almacenar en la primera pos, R0.
                      gc("\t%c(R7) = %s0;\n",$3,reg1.c_str());
                      $$=$3;
                  }

                | operation_expression 
                  {
                      $$ = $1;
                      printf("%d :: <math_expression> operation_expression \n",numlin);
                  }
                ;
             
factor : SEP_APARENTESIS expression SEP_CPARENTESIS 
         {
             $$=$2;
             printf("%d :: <factor> SEP_APARENTESIS \n",numlin);
         }
       | ID
         {
             if (!tabla.existeSimbolo(nombre[indice-1])) 
                 yyerror((char*)("El identificador no existe"));
             else 
             {
                 if(tabla.tipoSym(nombre[0])==_ENUM) 
                 {
                     if (!tabla.checkEnum(nombre[0],nombre[indice-1]))  yyerror((char*)("Valor de enumerado incompatible")); 
					 if(tabla.es_variable(nombre[indice-1])){
						gc("\tR0 = %s;\t\t\t// factor ID (var enum)\n" , tabla.dirVar(nombre[indice-1])); //Si es var, accede a memoria
					 }
					 else{
		         	 	gc("\tR0 = %d;\t\t\t// factor: ID (campo enum)\n" , tabla.nnumparam(nombre[indice-1])); //Sino, es valor
                     }
					 $$='I';
	                 gc("\tR7 = R7 - 4;\n\tI(R7) = R0;\n");
                 } 
                 else 
                 {
                     //printf("factor id %s", nombre[indice-1].c_str());

                     tipo = tabla.tipoSym(nombre[indice-1]); 
                     if (!paso_params){check_type[ind_type++]=tabla.tipoSym(nombre[indice-1]);}
                     printf("%d :: <factor> ID \n",numlin);
                     if(tipo == _INT){

                          gc("\tR0 = %s;\t\t\t// factor ID (int)\n" , tabla.dirVar(nombre[indice-1])); $$='I';
                          gc("\tR7 = R7 - 4;\n\tI(R7) = R0;\n");
                     }
                     else if(tipo == _FLOAT){
                          gc("\tRR0 = %s;\t\t\t// factor ID (float)\n" , tabla.dirVar(nombre[indice-1])); $$='F';
                          gc("\tR7 = R7 - 4;\n\tF(R7) = RR0;\n");
                     }
                     else if(tipo == _STRING){
                          gc("\tR0 = %s;\t\t\t// factor ID (string)\n" , tabla.dirVar(nombre[indice-1])); $$='P';
                          gc("\tR7 = R7 - 4;\n\tP(R7) = R0;\n");
                     }
                     else if(tipo == _CHAR){
                          gc("\tR0 = %s;\t\t\t// factor ID (char)\n" , tabla.dirVar(nombre[indice-1])); $$='U';
                          gc("\tR7 = R7 - 4;\n\tU(R7) = R0;\n");
                     }

                     indice=0; 
                 }
             }
         }
       | INT                                         
         {
             tipo = _INT; 
             if (!paso_params){check_type[ind_type++]=_INT;} 
             printf("%d :: <factor> INT \n",numlin);
             if (negativo) valEntero= -valEntero;
             negativo=false;
             if (sizeOfVector == -1) gc("\tR7 = R7 - 4;\n\tI(R7) = %d;\t\t\t// factor INT\n", valEntero); $$='I';
         }
       | FLO
         {
             tipo = _FLOAT; 
             if (!paso_params){check_type[ind_type++]=_FLOAT; }
             printf("%d :: <factor> FLO \n",numlin);
             if (negativo) valFlotante= -valFlotante;
             negativo=false;
             if (sizeOfVector == -1)gc("\tR7 = R7 - 4;\n\tF(R7) = %f;\t\t\t// factor FLOAT\n", valFlotante); $$='F';
         }
       | ID {asigna_vec= nombre[indice-1]; ind_type_aux=ind_type;} SEP_ACORCHETE expression SEP_CCORCHETE
         {
              ind_type=ind_type_aux;
             tipo =tabla.tipoVec(asigna_vec);
             if (!paso_params){check_type[ind_type++]=tabla.tipoVec(asigna_vec);}
      	     gc("\tR0 = %s;\t\t\t// factor vector\n",tabla.dirVector(asigna_vec)); $$=qm.qTypeFromCpmType(tipo);
      	     gc("\tR3 = I(R7);\n");
      	     gc("\tR3 = R3 * 4;\n");
      	     gc("\tR3 = R3 - 4;\n");
      	     gc("\tR0 = R0 + R3;\t\t\t// R0 -> Direccion del valor\n");
      	     gc("\t%s0 = %c(R0);\n",qm.autoReg($$).c_str(),qm.qTypeFromCpmType(tipo));
             gc("\tR7 = R7 - 4;\n\t%c(R7) = %s0;\n", $$, qm.autoReg($$).c_str());
             printf("%d :: <factor> vector \n",numlin);
         }
        | CHAR
        {
             tipo = _CHAR; 
             if (!paso_params){check_type[ind_type++]=_CHAR;} 
             printf("%d :: <factor> CHAR \n",numlin);
             if (sizeOfVector == -1) gc("\tR7 = R7 - 4;\n\tU(R7) = %d;\t\t\t// factor CHAR\n", valEntero); $$='U';
        }
       ;

%% 

void Insertar()
{
    //Actualizar();
    
    if (cprocedure){ // si son parámetros de un procedimiento
        for (int i = 0; i<numparam;i++)
        {
            tabla.insertaParam(nombre[i], tipo, tipo_par);
        }
    }
    else if (cfuncion) // si son parámetros de una función
    { 
        for (int i = 0; i<1;i++)
        {
            printf("\n\n\n LLamo a insertaParam con: numparam= %d e i= %d - var: %s\n", numparam, i, nombre_param.c_str());
            printf("\nEn insertar entra en: cfuncion\n");
            tabla.insertaParam(nombre_param, tipo, 1); //Siempre son de entrada 
        }
    }
    else if(carray) // tipo array
    { 
        for (int i = 0; i<indice;i++)
            tabla.insertaArray(nombre[i],tipo,tam_vector);
        indice=0;
    }
    else if(cenum) // tipo enum
    { 
        for (int i = 0; i<indice;i++)
            tabla.insertaEnum(nombre[i]);
    }
    else if(venum) // tipo enum
    { 
        for (int i = 0; i<indice;i++)
            tabla.insertaCampoEnum(nombre[i],valor_enum++);
    }
    else if(enum_array) // tipo enum
    { 
        printf("\nEn insertar entra en: enum_array\n");
        tabla.insertaVariableTipo(nombre[0], nombre[1]);
        enum_array=0;    
    }
    else // Son variables normales, de tipos normales
    { 
        printf("\nEn insertar entra en: var normal\n");
        for (int i = 0; i<indice;i++) 
          tabla.insertaVar(nombre[i], tipo);
    }

    enum_array=0; 
}


void Comprueba_tipo(){

    for(int z=1;z<ind_type;z++)
    {
        if (check_type[z] != check_type[0])
        {
            printf("\n***** valor z: %d -- valor 0: %d  \n\n ", check_type[z],check_type[0] );
            if(error_tipo_fun) 
                yyerror((char*)("El tipo devuelto en la funcion no coincide"));
            else
                yyerror ((char*)("Tipos incompatibles"));
            break;
        }
    }    
}

bool Comprueba_numparam(string nombre) 
{
    printf("-- Comprueba_numparam = %s [%i] vs [%i]\n",nombre.c_str(), tabla.nnumparam(nombre),numparam);
    return (tabla.nnumparam(nombre)==numparam);
}


int ne() // nueva etiqueta
{
  DEBUG_PRINT("Label Count: %i\n",labelCount);
  return labelCount++;
}


int main() 
{ 
    
  fout = fopen("./codigo_generado.txt", "w");
  if(fout != NULL)
    DEBUG_PRINT("Fichero de salida abierto correctamente\n");
  else
  {
    printf("Error: no se ha podido abrir el fichero\n");
  }
  try{
    yyparse(); 
  }
  catch(char const *mensaje){ 
      printf ("%s. En la linea: %d\n", mensaje,numlin);   
  } 

} 

              
void yyerror (char *s) 
{ 
    gc("\n\n********** Fallo en la compilación **************\n\n");
    printf ("Error en linea %d: %s\n",numlin, s); 
}

/*
  COSAS PENDIENTES O A TENER EN CUENTA

  -Nota: No se contemplará -llamada_a_funcion (menos)
  -VECTORES
  -FUNCIONES Y PROCEDIMIENTOS (PARAMETROS!!!!!)
  -En las expresiones, llamadas a funciones
  -En insertar cfuncion hay q simplificar el codigo q esta medio raro para q funcionara rápido
  -En function_param hay mucho código comentado y comentarios q sobran.
  -En definicion de funcion tb codigo q sobra
  -Se ha arreglado: antes no se permitía parámetros de diferentes tipos, por eso fallaba enum

*/
