#ifndef SYMTABLE_H
#define SYMTABLE_H

#include <string>
#include <list>
using namespace std;

#include "/usr/include/c++/4.4.4/ext/pb_ds/exception.hpp"

#define SYMTBLSIZE 16
#define D_BISON
// Para activar o desactivar la depuración (muestra tabla en inserciones)
#define DEPURANDO true

/**
 * Enumerado para especificar el tipo de un símbolo.
 */
enum symtype
{
    CENUM,   ///< El símbolo representa una constante de un enumerado
    VAR,   ///< El símbolo representa una variable
    FUN,   ///< El símbolo representa la declaración de una función
    PRO,   ///< El símbolo representa la declaración de un procedimiento
    PIN, ///< El símbolo representa un parámetro IN
    POUT, ///< El símbolo representa un parámetro OUT
    PINOUT, ///< El símbolo representa un parámetro INOUT
    ETYPE,  ///< El símbolo representa la declaración de un enumerado
    ATYPE   ///< El símbolo representa la declaración de un array
};

/**
 * Enumerado para especificar el tipo de una variable.
 */
enum vartype    // Mantener este orden, es importante para el chequeo de tipos desde bison
{
    _INT ,      ///< Indica tipo int
    _CHAR,     ///< Indica tipo char
    _FLOAT,    ///< Indica tipo float
    _TFILE,    ///< Indica tipo FILE
    _ENUM,     ///< Indica tipo enumerado
    _ARRAY,    ///< Indica tipo array
    _STRING    ///< Indica tipo string
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
    
    int ambito; ///< Ámbito del símbolo.
                /**< Este entero identifica el ámbito en el que el símbolo es accesible.
                     
                 */
    
  
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

    symtable();
    
    // Devuelve un identificador de variable implícita (interna) de la forma"0sys_%d"
    string generaNombreVar();
    
    symrec * insertaVar(string nombre, vartype tipovar);
    
    symrec * insertaParam(string nombre, vartype tipovar, int tipopar);
    
    symrec * insertaFun(string nombre);
    symrec * insertaPro(string nombre);

    symrec * insertaArray(string tnombre,vartype tipoelemento);
    symrec * insertaCampoEnum(string tnombre);
    symrec * insertaEnum(string tnombre); 
    symrec * insertaVariableTipo(string variable, string tipo);
    vartype tipoVec(string nombre);

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
    
    // int escribeFichero();
    
	const list<symrec> * const tablaHash() { return tabla; }; // devuelve la tabla hash para las pruebas
	int ambito() { return ambitoActual; }; // devuelve el ambito actual para las pruebas
	int ambitoSimbolo(string nombre); //devuelve el ambito de un simbolo
	
	//Funciones para depuración
	void printState(); // Imprime el contenido de la tabla
	void printSymbol(symrec * s); // Imprime la representación de un símbolo
};


#endif
