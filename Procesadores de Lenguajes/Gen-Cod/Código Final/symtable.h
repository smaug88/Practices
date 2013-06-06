#ifndef SYMTABLE_H
#define SYMTABLE_H

#include <string>
#include <list>
#include <vector>
using namespace std;

#include "/usr/include/c++/4.4.4/ext/pb_ds/exception.hpp"

#define SYMTBLSIZE 16
#define Z 0x00012000
#define D_BISON
// Para activar o desactivar la depuración (muestra tabla en inserciones)
#define DEPURANDO true


#ifdef DEPURANDO
# include <cstdio>
# define DEBUG_PRINT(x...) printf(x)
#else
# define DEBUG_PRINT(x...) void (0)
#endif




/**
 * Enumerado para especificar el tipo de un símbolo.
 */

enum symtype
{
    CENUM,   ///< El símbolo representa una constante de un enumerado
    VAR,     ///< El símbolo representa una variable
    FUN,     ///< El símbolo representa la declaración de una función
    PRO,     ///< El símbolo representa la declaración de un procedimiento
    PIN,     ///< El símbolo representa un parámetro IN
    POUT,    ///< El símbolo representa un parámetro OUT
    PINOUT,  ///< El símbolo representa un parámetro INOUT
    ETYPE,   ///< El símbolo representa la declaración de un enumerado
    ATYPE,   ///< El símbolo representa la declaración de un array
    LSTRING  ///< El símbolo representa un literal String
};

/**
 * Enumerado para especificar el tipo de una variable.
 */
enum vartype   // Mantener este orden, es importante para el chequeo de tipos desde bison
{
    _INT ,     ///< Indica tipo int
    _CHAR,     ///< Indica tipo char
    _FLOAT,    ///< Indica tipo float
    _TFILE,    ///< Indica tipo FILE
    _ENUM,     ///< Indica tipo enumerado
    _ARRAY,    ///< Indica tipo array
    _STRING,    ///< Indica tipo string
};

/**
 * Registro para almacenar un símbolo.
 */

struct symrec {
    string nombre; ///< Nombre del identificador del símbolo.
    
    symtype tiposim; ///< Tipo de símbolo.
                     /**< El tipo de símbolo puede ser:
                            - VAR: variable
                            - FUN: función
                            - PRO: procedimiento
                            - PIN, POUT, PINOUT: parámetro de una función, o procedimiento
                            - ETYPE: enumerado
                            - ATYPE: array
                     */
    
    vartype tipovar; ///< Tipo de dato.
                     /**< Representa el tipo de una variable (si tiposim=VAR)
                          o el tipo devuelvo por una función (si tiposim=FUN),
                          o el tipo de elementos de un array.
                      */
    
    // list<symrec *> paramlist;
    list<symrec> paramlist; ///< Lista de parámetros.
                            /**< Representa la lista de parámetros de una función (si tiposim=FUN).
                             */

    symrec *tEnumerado;

    string nombreTipo;

    string ristra;
    
    int ambito; // Ámbito del símbolo.

    // Contador para número de parámetros o valor enumerado para el caso de los enum o tamaño para tipovec
    int nparam;
                                                                                   
    char memcar; // Para codegen: caracter para acceder a memoria (P,U,S,I,J,F,D,E)
    unsigned int dir; // Direccion de memoria absoluta (global) o relativa a R6
                      // E
    unsigned int tam;   // tamaño en bytes en memoria (array -> tamaño del array entero)
    unsigned int etam;  // tamaño en bytes de cada elemento (array)

};

/**
 * Clase para representar una tabla de símbolos usando una tabla hash de
 * SYMTBLSIZE elementos (por defecto, SYMTBLSIZE = 16).
 */
class symtable
{
    // Tabla hash de SYMTBLSIZE elementos.
    // Cada posición de la tabla almacena una lista con las colisiones.
    list<symrec> tabla[SYMTBLSIZE];
    
    // contador de variables implícitas, usado por 'string sysVarName()'
    int sysVarCount;

    // contador de crecimiento de pila estatica y con respecto a R6
    unsigned int scima;
    unsigned int rcima;
    unsigned int rcima_aux;
    
    // ámbito vigente actualmente
    public: int ambitoActual;
    
    // nombre de símbolo que tiene parámetros
    string nombreSimParams;

    // puntero al padre del enumerado
    symrec *EnumParent;

    // indica si debe insertar los parámetros automáticamente a 'nombreSimParams'
    bool insertaParams;

    // siguiente parámetro a reemplazar
    list<symrec>::iterator sigParam;
    
public:
    // función de hash
    int valorHash(string);
    string ea_param;

    symtable();

	//Devuelve verdadero si es una variable
    bool es_variable(string nombre);
    
    // Devuelve un identificador de ristra implícita (interna) de la forma"0sys_%d"
    string generaNombreRistra();

    // Devuelve el tipo de variable del parámetro
    vartype tipoParam(string nombre, int indice);
    
    symrec * insertaVar(string nombre, vartype tipovar);
    
    //Inserta en la tabla de símbolos los parámetros de una función o procedimiento
    symrec * insertaParam(string nombre, vartype tipovar, int tipopar);
    
    symrec * insertaFun(string nombre);
    symrec * insertaPro(string nombre);

    symrec * insertaArray(string tnombre,vartype tipoelemento, int tam_vector);
    symrec * insertaCampoEnum(string tnombre, int valor);
    symrec * insertaEnum(string tnombre); 

    //Se emplea para insertar una variable de un tipo array o enum definida anteriormente en type
    symrec * insertaVariableTipo(string variable, string tipo);

    //Devuelve el tipo de elemento del vector
    vartype tipoVec(string nombre);

    int Cima();
    int valorRcima();

    // Devuelve la direccion de una variable
    const char * dirVar(string nombre);
	
    //Devuelve la dirección de un vector a la hora de asignarle un valor
    const char * dirVector(string nombre);

    //Modifica la función en la tabla de simbolos para poner el tipo devuelto
    void modificaFun(string nombre, vartype tipo);
    
    // symrec * devuelveSymRec(string nombre); // FALTA POR HACER!! ¿hace falta?
    // Devuelve el tipo de un simbolo.
    vartype tipoSym(string nombre);
    
    // Entrada y salida de ámbito
    void nuevoAmbito();
    void finAmbito(); // elimina símbolos y sale del ámbito
    
    // Comprueba si existe un símbolo con el nombre <nombre> en la tabla
    bool existeSimbolo(string nombre);

    //Comprueba si un campo puede asignarse a una variable enumerada
    bool checkEnum (string variable, string campo);
    
    // Comprueba si existe un parámetro con el mismo nombre en la tabla
    bool existeParam(symrec * s, string nombre);
    
    // Devuelve el número de parámetros de nombre
    // Si es un enumerado, devuelve el valor que corresponde a el campo
    int nnumparam(string nombre);

    // int escribeFichero();
    
    const list<symrec> * const tablaHash() { return tabla; }; // devuelve la tabla hash para las pruebas
    int ambito() { return ambitoActual; }; // devuelve el ambito actual para las pruebas
    int ambitoSimbolo(string nombre); //devuelve el ambito de un simbolo
    
    //Funciones para depuración
    void printState(); // Imprime el contenido de la tabla
    void printSymbol(symrec * s); // Imprime la representación de un símbolo


    //Funciones para generación de código

    //Asigna una etiqueta a una función
    void asignaEtiqueta(string nombre, int etiqueta);

    //Devuelve la etiqueta asociada al subprocedimiento o función
    int etiqueta(string nombre);

    //Almacena un literal ristra en el heap y devuelve su dirección de memoria en el heap
    //symrec * insertaString(string nombre);
    int insertaString(string ristra);
    int dirString(string ristra);
    // devuelve una lista de los literales string que deben meterse en heap,
    // ordenados por direccion de memoria en orden decreciente
    vector<symrec> listaString();


};

#endif
