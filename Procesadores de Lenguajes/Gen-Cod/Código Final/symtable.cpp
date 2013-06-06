#include "symtable.h"

#include <cstdio>
#include <cassert>
#include <cstring>
#include <algorithm>

#include <iostream>
using namespace std;
#include "Qmachine.h"
extern Qmachine qm;

#define PREFIX_IMPLICIT "0sys_" // prefix of implicit symbol name

symtable::symtable() {
    sysVarCount = 0;
    ambitoActual = 0;
    scima = Z;
    rcima = 0;
}

/**
 * Calcula el valor de la función de hash para el nombre del identificar.
 *
 * @param  nombre Nombre del identificador que representa el símbolo
 * @return Valor de hash para el identificor, resultante de aplicar la función
 *         de hash
 */
int symtable::valorHash(string nombre) {
    int valorhash = 0;
    for (unsigned int i = 0; i < 3 && i < nombre.size(); i++)
        valorhash = valorhash + nombre[i];
    return valorhash % SYMTBLSIZE;
}


/**
 * Inserta un nuevo símbolo que representa una variable.
 *
 * @param nombre  Nombre del símbolo (identificador de la variable)
 * @param tipovar Tipo de variable (int, char, ...)
 *
 * @return Puntero a la estructura symrec insertada
 */
symrec * symtable::insertaVar(string nombre, vartype tipovar)
{
	#ifdef D_BISON
		cout << "insertaVar" << endl;
		cout <<" nombre: "<< nombre << endl;
	#endif
    symrec *retval = NULL;
    if (existeSimbolo(nombre) && (ambito() == ambitoSimbolo(nombre)) ) //Si el simbolo ya existe al insertar y estamos en el 
    {								       //mismo ambito que el simbolo insertado, se genera un error
        string msg = "El simbolo \"" + nombre + "\" ya existe";
        cout << msg << endl;
    }
    else
    {
        symrec simbolo;
        simbolo.nombre = nombre;
        simbolo.tiposim = VAR;
        simbolo.tipovar = tipovar;
        simbolo.ambito = ambitoActual;
        if (tipovar == _INT){
            simbolo.memcar = 'I';
            simbolo.tam = 4;
        }
        else if (tipovar == _FLOAT){
            simbolo.memcar = 'F';
            simbolo.tam = 4;
        }
        else if (tipovar == _CHAR){
            simbolo.memcar = 'U';
            simbolo.tam = 4;
        }
        else if(tipovar==_STRING)
        {
            simbolo.memcar = 'P';
            simbolo.tam = 4;
            //Puede que se quite de aqui
           // simbolo.dir = qm.desplazarR5(escaped.size()+1); // dirección absoluta en heap
        }

        // Depende de si es global o local
        // direccion global o relativa a R6
        if (ambitoActual == 0){
            scima -=  simbolo.tam;
            simbolo.dir = scima;
        }
        else{
            rcima += simbolo.tam; // R6-%d
            simbolo.dir = rcima;
        }

        //Insertamos el registro
        tabla[valorHash(nombre)].push_back(simbolo);
        retval = &tabla[valorHash(nombre)].back();

    }
    
    // Para depurar
    if (DEPURANDO) printState();
    
    return retval;
}


bool compare_string_literal(symrec symA, symrec symB)
{
    // para ordenar en orden creciente de dirección de memoria, debe devolver
    // symA.dir < symB.dir
    // para ordenar en orden decreciente de dirección de memoria, debe devolver
    // symA.dir > symB.dir
    return symA.dir > symB.dir;
}

/** 
 *  Recorre la tabla hash y, para cada posición de la tabla, busca los símbolos
 *  que representan un literal string
*/
vector<symrec> symtable::listaString()
{
    vector<symrec> lista;
    for (int pos = 0; pos < SYMTBLSIZE; pos++)
    {
        list<symrec>::iterator it;
        for (it = tabla[pos].begin(); it != tabla[pos].end(); it++)
        {
            if (it->tipovar == _STRING)
                lista.push_back(*it);
        }
    }
    sort(lista.begin(), lista.end(), compare_string_literal);
    
    return lista;
}



/**
 * Inserta un nuevo símbolo que representa un parámetro de una función o procedimiento.
 *
 * @param nombre  Nombre del símbolo (identificador del parámetro)
 * @param tipovar Tipo de variable (int, char, ...)
 *
 * @return Puntero a la estructura symrec insertada, o NULL si no se ha insertado un nuevo símbolo
 */
symrec * symtable::insertaParam(string nombre, vartype tipovar, int tipopar)
{
	#ifdef D_BISON
		cout << "insertaParam" << endl;
        switch (tipovar){
            case _INT:
                cout <<"tipo: INT, nombre: "<< nombre << " tipopar: "<< tipopar << " "<< ambitoActual << endl;
                break;
            case _CHAR:
                cout <<"tipo: CHAR, nombre: "<< nombre << " tipopar: "<< tipopar << " "<< ambitoActual<< endl;
                break;
            case _FLOAT:
                cout <<"tipo: FLOAT, nombre: "<< nombre << " tipopar: "<< tipopar<< " "<< ambitoActual << endl;
                break;
            case _TFILE:
                cout <<"tipo: TFILE, nombre: "<< nombre << " tipopar: "<< tipopar<< " "<< ambitoActual << endl;
                break;
            case _ENUM:
                cout <<"tipo: ENUM, nombre: "<< nombre << " tipopar: "<< tipopar<< " "<< ambitoActual << endl;
                break;
            case _ARRAY:
                cout <<"tipo: ARRAY, nombre: "<< nombre << " tipopar: "<< tipopar<< " "<< ambitoActual << endl;
                break;
            case _STRING:
                cout <<"tipo: STRING, nombre: "<< nombre << " tipopar: "<< tipopar<< " "<< ambitoActual << endl;
                break;
        }
	#endif
    symrec simbolo, *retval = NULL;
    simbolo.nombre = nombre;
    switch (tipopar) {
        case 1: simbolo.tiposim = PIN;
                break;
        case 2: simbolo.tiposim = POUT;
                break;
        case 3: simbolo.tiposim = PINOUT;
                break;
    } 

    simbolo.tipovar = tipovar;
    simbolo.ambito = ambitoActual;
    simbolo.tEnumerado = NULL;
    unsigned int pos = valorHash(nombreSimParams);
    

        // Buscamos el símbolo función. Está sí o sí.
        list<symrec>::reverse_iterator it;
        for (it = tabla[pos].rbegin();
             it != tabla[pos].rend() && it->nombre != nombreSimParams;
             it++);
        
        // Comprobamos la existencia del parámetro
        bool existe = existeParam(&(*it), nombre);
        // Si el parámetro no existe
        if (it != tabla[pos].rend() && !existe)
        {
        	it->paramlist.push_back(simbolo);
		it->nparam++;
		cout << "---- Aumento nparam, ahora vale " << it->nparam << endl;
        if(tipovar == _ENUM || tipovar == _ARRAY) insertaVariableTipo(nombre,ea_param);
        else insertaVar(nombre,tipovar); //Se duplican los parametros en la tabla
	}
        // El parámetro existe
        else if (it != tabla[pos].rend() && existe) 
        {
            string msg = "El parametro \"" + nombre + 
                       + "\" del simbolo \"" + it->nombre + "\" ya existe";
            cout << msg << endl;
        }
    // Para depurar
    if (DEPURANDO) printState();
    
    return retval;
}



/*
 * Devuelve el caracter que corresponde a un argumento de funcion
 */
vartype symtable::tipoParam(string nombre, int indice){
    int i = valorHash(nombre);
    
    list<symrec>::reverse_iterator s;
    // Busco funcion
    for (s = tabla[i].rbegin(); (*s).nombre != nombre; ++s);
    // Busco parametro
    list<symrec>::iterator p;
    p = (*s).paramlist.begin();
    for (int i=0; i<indice; ++i) ++p;

    return (*p).tipovar;
}


/**
 * Inserta un nuevo símbolo que representa una función.
 *
 * @param nombre Nombre del símbolo (identificador de la función)
 * @param devol  Tipo de dato devuelto por la función (int, char, ...)
 *
 * @return Puntero a la estructura symrec insertada, o NULL si no se ha insertado un nuevo símbolo
 */
symrec * symtable::insertaFun(string nombre)
{
    #ifdef D_BISON
        cout << "InsertaFun" << endl;
        cout <<"tipo: pte. nombre: "<< nombre << endl;
    #endif
    
    symrec * retval = NULL;
    int pos = valorHash(nombre);

    if (existeSimbolo(nombre)){
        throw "Error: Intento de redefinir una funcion.";
    }
    else{
        symrec simbolo;
        simbolo.nombre = nombre;
        simbolo.tiposim = FUN;
        simbolo.ambito = ambitoActual;
        simbolo.tipovar = _INT;
        simbolo.nparam = 0;
        cout << "Inicializo nparam, ahora vale " << simbolo.nparam << endl;
        tabla[pos].push_back(simbolo);
        nombreSimParams = nombre;
        retval = &tabla[pos].back(); 

        // Para depurar
       // if (DEPURANDO) printState();

        return retval;
    }
}

/**
 * Inserta un nuevo símbolo que representa un procedimiento.
 *
 * @param nombre Nombre del símbolo (identificador de la función)
 *
 * @return Puntero a la estructura symrec insertada, o NULL si no se ha insertado un nuevo símbolo
 */
symrec * symtable::insertaPro(string nombre)
{
    #ifdef D_BISON
        cout << "InsertaPro" << endl;
        cout <<" nombre: "<< nombre << endl;
    #endif
    
    symrec * retval = NULL;
    unsigned int pos = valorHash(nombre);

    if (existeSimbolo(nombre)){
        throw "Error: Intento de redefinir un procedimiento.";
    }
    else{
        symrec simbolo;
        simbolo.nombre = nombre;
        simbolo.tiposim = PRO;
        simbolo.ambito=ambitoActual;
        simbolo.nparam = 0;
        cout << "Inicializo nparam, ahora vale " << simbolo.nparam << endl;
        tabla[pos].push_back(simbolo);
        nombreSimParams = nombre;
        retval = &tabla[pos].back();

        // Para depurar
        if (DEPURANDO) printState();
        
        return retval; 
    }
    
    
}

/**
 *Inserta tipo enum
**/
symrec * symtable::insertaEnum(string tnombre) { //Revisar
    #ifdef D_BISON
        cout << "insertaEnum" << endl;
        cout <<" nombre: "<< tnombre <<endl;
    #endif
    // primero se inserta el tipo
    int i = valorHash(tnombre);
    symrec ts;
    ts.nombre = tnombre;
    ts.tiposim = ETYPE;
    ts.ambito = ambitoActual;
    ts.tipovar = _ENUM;
    
    tabla[i].push_back(ts);
     
    //se guarda el puntero este (padre) para que los hijos lo guarden al crearse
    EnumParent = &tabla[i].back();
    
    // Para depurar
    if (DEPURANDO) printState();
    
    return &tabla[i].back();
}

/**
 *Inserta campo de un enumerado
**/
symrec * symtable::insertaCampoEnum(string tnombre, int valor) { //Revisar
    #ifdef D_BISON
        cout << "insertaCampoEnum" << endl;
        cout <<" nombre: "<< tnombre <<endl;
    #endif
    // primero se inserta el tipo
    int i = valorHash(tnombre);
    symrec ts;
    ts.nombre = tnombre;
    ts.tiposim = CENUM;
    ts.ambito = ambitoActual;
    ts.tEnumerado= EnumParent;
    ts.nparam = valor;
    
    tabla[i].push_back(ts);
    
    // Para depurar
    if (DEPURANDO) printState();
    
    return &tabla[i].back();
}


/**
 *Inserta un tipo array
**/
symrec * symtable::insertaArray(string tnombre, vartype tipoelemento, int tam_vector) { 
    #ifdef D_BISON
        cout << "insertaTipoArray" << endl;
        cout <<"tipo: "<< tipoelemento<<" nombre: "<< tnombre << endl;
    #endif
    // primero se inserta el tipo
    int i = valorHash(tnombre);
    symrec ts;
    ts.nombre = tnombre;
    ts.tiposim = ATYPE;
    ts.ambito = ambitoActual;
    ts.tipovar = tipoelemento;
    ts.nparam = tam_vector;
    
    tabla[i].push_back(ts);
    
    // Para depurar
    if (DEPURANDO) printState();
    
    return &tabla[i].back();
}


/**
 *Inserta una variable que puede ser de un tipo array o enum
**/
symrec * symtable::insertaVariableTipo(string variable, string tipo){
    #ifdef D_BISON
        cout << "insertaVariableTipo" << endl;
        cout <<"tipo: "<< tipo<<" nombre: "<< variable << endl;
    #endif

    if(existeSimbolo(tipo)){
        vartype tipo_variable,tipo_elemento;
	
        int i = valorHash(tipo);
        list<symrec>::reverse_iterator s;
        for (s = tabla[i].rbegin(); s != tabla[i].rend(); ++s) {
            if (s->nombre == tipo){
                tipo_variable=(s->tiposim == ETYPE)?_ENUM:_ARRAY;
                break;
            }
        }
	

        symrec ts;

	if(tipo_variable == _ARRAY){
	   tipo_elemento=s->tipovar;
	   if(tipo_elemento==_INT)         ts.memcar = 'I';
	   else if(tipo_elemento== _FLOAT) ts.memcar = 'F';
	   else if(tipo_elemento == _CHAR) ts.memcar = 'U';
	   ts.tam = (4 * s->nparam); //Se ha quitado el +4
	}
	else{
	     ts.memcar = 'I';
    	     ts.tam = 4;
	}
        i = valorHash(variable);;
        ts.nombre = variable;
        ts.tiposim = VAR;
        ts.ambito = ambitoActual;
        ts.tipovar = tipo_variable;
        ts.nombreTipo=tipo;

	//Hay que comprobar el tipo_var del padre (=tipo), esto es para saber el tipo y poner memcar al
	//valor correcto, a su vez hay que ver el tamaño del vector y ponerlo en ts.tam
	

	// Depende de si es global o local
        // direccion global o relativa a R6
        cout << endl << "------------------------------ Rcima antes: " << rcima << endl;
        rcima += ts.tam; // R6-%d
        ts.dir = rcima;
        cout << endl << "------------------------------ Rcima después: " << rcima << endl;
        tabla[i].push_back(ts);
        
        // Para depurar
        if (DEPURANDO) printState();
        
        return &tabla[i].back();
    }
    else
        throw "Asignacion de un tipo no existente";
}


/**
 *Modifica la funcion para poner el tipo devuelto
**/
void symtable::modificaFun(string nombre, vartype tipo){
    int i = valorHash(nombre);

    // Buscamos la variable
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); s != tabla[i].rend(); ++s){
        // Si se llama igual y está en un ámbito referenciable.
        // Que sea una variable o parámetro de la función
        if ((*s).nombre == nombre && (*s).ambito == (ambitoActual - 1)){
            (*s).tipovar= tipo;
            break;
        }
    }
    if (s == tabla[i].rend())
        throw "modificaFun:No se encuentra la funcion en el ambito";
    
    // Para depurar
    if (DEPURANDO) printState();
}

/**
 *Devuelve el tipo de elementos del vector
**/
vartype symtable::tipoVec(string nombre){

    cout << "Nombre pasado " << nombre << endl;
   int i = valorHash(nombre);
    string padre;
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); s != tabla[i].rend(); ++s) {
        if (s->nombre == nombre)
        { 
            padre = s->nombreTipo;            
            cout << "------ Algo del padre " << padre << endl;            
            break;
        }
    }
    int j = valorHash(s->nombreTipo);
    
    
    for (s = tabla[j].rbegin(); s != tabla[j].rend(); ++s) {
        if (s->nombre == padre)
        { 
            cout << "------ s->tipovar " << s->tipovar << endl; 
          return s->tipovar;
        }
    }
}


vartype symtable::tipoSym(string nombre){
	#ifdef D_BISON
		cout << "tipoSym" << endl;
		cout <<" nombre: "<< nombre<< endl;
	#endif
    int i = valorHash(nombre);
    cout << "ID: " << nombre << endl;
    
    // Buscamos la variable
    vartype t;
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); s != tabla[i].rend(); ++s){
        // Si se llama igual y está en un ámbito referenciable.
        // Que sea una variable o parámetro de la función
        if ((*s).nombre == nombre && (*s).ambito <= ambitoActual){
            t = (*s).tipovar;
			cout << "tipoSym(" << nombre << ") = " << t << endl;
            break;
        }
    }
    if (s == tabla[i].rend())
        throw "tipoSym:Referencia a variable inexistente o fuera de ámbito";
        
    return t; // Devolvemos el tipo
}


/***
Función que devuelve verdadero si el símbolo es una variable.
Se emplea para controlar los casos de los enumerados.
**/
bool symtable::es_variable(string nombre){
	#ifdef D_BISON
		cout << "es_variable" << endl;
		cout <<" nombre: "<< nombre<< endl;
	#endif
    int i = valorHash(nombre);
    cout << "ID: " << nombre << endl;
    
    // Buscamos la variable
    symtype t;
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); s != tabla[i].rend(); ++s){
        // Si se llama igual y está en un ámbito referenciable.
        // Que sea una variable o parámetro de la función
        if ((*s).nombre == nombre && (*s).ambito <= ambitoActual){
            t = (*s).tiposim;
            break;
        }
    }
    if (t == VAR) return true;
    return false;
}

/**
Funcion que comprueba si el campo se puede asignar a la variable de tipo enum
**/
bool symtable::checkEnum (string variable, string campo){

    int i = valorHash(variable);
    cout << "check enum: " << variable << "campo:" << campo << endl;
    if(variable==campo) return true;
    
    // Buscamos la variable
    string t;
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); s != tabla[i].rend(); ++s){
        // Si se llama igual y está en un ámbito referenciable.
        // Que sea una variable o parámetro de la función
        if ((*s).nombre == variable && (*s).ambito <= ambitoActual){
            t = (*s).nombreTipo;
            break;
        }
    }

    i = valorHash(campo);

    // Buscamos el campo
    for (s = tabla[i].rbegin(); s != tabla[i].rend(); ++s){
        // Si se llama igual y está en un ámbito referenciable.
        // Que sea una variable o parámetro de la función
        if ((*s).nombre == campo && (*s).ambito <= ambitoActual){
            if(t == (*s).tEnumerado->nombre) return true;
            break;
        }
    }
    return false;
}

/**
 * Abre un nuevo ámbito (scope) de variables al abrirse un nuevo bloque.
 */
void symtable::nuevoAmbito() {
	#ifdef D_BISON
		cout << "NuevoAmbito" << endl;
	#endif
    ambitoActual += 1;

    //Se pone rcima a 0 para los parámetros y variables de los
    //subprocedimientos, ya que R6 será modificado.

    //Puesto que los parámetros son los primeros en insertarse en los subprocedientos
    //Al bajar R6, las posiciones relativas a R6 estarán correctas, por lo que
    //se accede al valor correcto
    if (ambitoActual==2){
        rcima_aux = rcima;
        rcima = 0;
    }
}


/**
 * Cierra el último ámbito (scope) de variables al cerrarse el último bloque abierto.
 */
void symtable::finAmbito() {
	#ifdef D_BISON
		cout << "finAmbito" << endl;
	#endif

    //Si ámbito 2, tenemos que restaurar rcima
    if (ambitoActual==2){
        rcima = rcima_aux;
        rcima_aux = 0;
    }

    // Revisamos entradas de la tabla hash
    list<symrec>::reverse_iterator s;
    for (int i=0; i < SYMTBLSIZE; ++i){
        // Sacamos los elementos del ámbito actual
        
        for (s = tabla[i].rbegin(); s != tabla[i].rend(); ++s) {
           if ( s->ambito == ambitoActual){
            
            tabla[i].pop_back();
            s--;
          }
        }
          
    }
   
    // Una vez eliminados todos, reducimos el ámbito
    ambitoActual -= 1;
    assert(ambitoActual >= 0);
    
    // para depurar
    if (DEPURANDO) printState();
}

/**
 * Comprueba si existe un símbolo con el nombre 'nombre' en la tabla.
 *
 * @param nombre Nombre del símbolo a buscar en la tabla de símbolos
 *
 * @return Verdadero si existe un símbolo con ese nombre, y falso si no existe
 */
bool symtable::existeSimbolo(string nombre) {
    int i = valorHash(nombre);
    
    if ( tabla[i].empty() )
        return false;
    
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); s != tabla[i].rend(); ++s) {
        if (s->nombre == nombre)
            return true;
    }
    return false;
}

int symtable::ambitoSimbolo(string nombre) {

    int i = valorHash(nombre);
    
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); s != tabla[i].rend(); ++s) {
        if (s->nombre == nombre)
            return s->ambito;
    }
    return -1;
}

/**
 * Comprueba si existe un parámetro con el nombre 'nombre' en la lista de
 * parámetros de la función representada por el símbolo 's'.
 *
 * @param s      Estructura symrec de la función o procedimiento donde se debe comprobar si existe el parámetro
 * @param nombre Nombre del parámetro a buscar
 *
 * @return Verdadero si la función o procedimiento tiene un parámetro con nombre 'nombre'. Falso en caso contrario.
 */
bool symtable::existeParam(symrec * s, string nombre) {
    assert(s != NULL);
    
    if ( s->paramlist.empty() )
        return false;
    
    list<symrec>::iterator p;
    for (p = s->paramlist.begin(); p != s->paramlist.end(); ++p) {
        if (p->nombre == nombre)
            return true;
    }
    
    // No está
    return false;
}

// Devuelve el nº parametros de nombre
int symtable::nnumparam(string nombre) {

    int i = valorHash(nombre);
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); s != tabla[i].rend(); ++s) {
        if (s->nombre == nombre) {
            return s->nparam;
        }
    }
    return -1;	
}


/**
 * Devuelve un identificador de variable implícita (interna) de la forma "0sys_%d".
 */
string symtable::generaNombreRistra() {
    #ifdef D_BISON
        cout << "generaNombreVar" << endl;
    #endif
    char temp[16];
    sprintf(temp, "%d", sysVarCount++);
    string name = string(PREFIX_IMPLICIT) + temp;
    return name;
}


//Inserta un literal ristra en el heap y devuelve la dirección de memoria en el heap
int symtable::insertaString(string ristra){
    string nombre = generaNombreRistra();
    int hash = valorHash(nombre);
    int retval = -1;

    //Buscamos la string
    bool encontrado = false;
    list<symrec>::iterator it;
    for (int pos = 0; pos < SYMTBLSIZE && !encontrado; pos++)
    {
        for (it = tabla[pos].begin(); it != tabla[pos].end() && !encontrado;)
        {
            if (it->tiposim == LSTRING && it->ristra == ristra)
                encontrado = true;
            else
                it++;
        }
    }
    
    // si ya existe, no se hace nada
    if (encontrado)
    {
        retval = it->dir;
    }
    // si no existe la string, se inserta
    else
    {
        symrec sim;
        sim.nombre = nombre;
        sim.tiposim = LSTRING;
        sim.tipovar = _STRING;
        sim.ambito = 0;
        sim.dir = qm.desplazarR5(ristra.size()+1); // dirección absoluta en heap
        sim.ristra = ristra;
        tabla[hash].push_back(sim);
        retval = sim.dir;
    }
    if (DEPURANDO) printState();
    return retval;
}



/*
 * Imprime por pantalla el estado de la tabla: qué hay en ella.
 */
void symtable::printState(){
    cout << endl << endl <<"---  Estado de la tabla  ---" << endl;
    list<symrec>::iterator s;
    int i;
    
    // A recorrer la tabla se dijo
    for (i=0; i<SYMTBLSIZE; ++i){
        for (s = tabla[i].begin(); s != tabla[i].end(); ++s){
            printSymbol(&(*s));
        }
    }
    cout << "Scima: " << scima << " Rcima: " << rcima << endl;
    cout << "---  Fin de la tabla  ---" << endl << endl << endl;
}


/*
 * Asigna una etiqueta a una funcion
 * la función se presupone existente.
 */
void symtable::asignaEtiqueta(string nombre, int etiqueta){
    int i = valorHash(nombre);
    
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); (*s).nombre != nombre; ++s);
    (*s).dir = etiqueta;
}

int symtable::Cima(){
    return scima-rcima;
}


/*
 * Devuelve la etiqueta de entrada a una funcion o procedimiento
 */
int symtable::etiqueta(string nombre){
    int i = valorHash(nombre);
    
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); (*s).nombre != nombre; ++s);
    
    return (*s).dir;
}


/*
 * Devuelve la dirección de memoria de una variable
 */
const char * symtable::dirVar(string nombre){
    int i = valorHash(nombre);
    
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); (*s).nombre != nombre; ++s);
    
    char *temp = new char[16];
    printf("%d\n",(*s).ambito );
    if ((*s).ambito == 0){
        sprintf(temp, "%c(%#.8x)", (*s).memcar, (*s).dir);
    }
    else{
        if ((*s).ambito == 1 && ambitoActual== 2 ){
                sprintf(temp, "%c(0x00012000-%d)", (*s).memcar,rcima_aux, (*s).dir);       
        }
        else sprintf(temp, "%c(R6-%d)", (*s).memcar, (*s).dir);
    }
    return temp;
}

int symtable::valorRcima(){
        return rcima;
}


const char * symtable::dirVector(string nombre){
    int i = valorHash(nombre);
    
    list<symrec>::reverse_iterator s;
    for (s = tabla[i].rbegin(); (*s).nombre != nombre; ++s);
    
    char *temp = new char[16];
  
    sprintf(temp, "R6-%d",(*s).dir);
    return temp;
}



void symtable::printSymbol(symrec * s){
    string nom_tipo[7];
    nom_tipo[_INT] = "int";
    nom_tipo[_CHAR] = "char";     ///< Indica tipo char
    nom_tipo[_FLOAT] = "float";   ///< Indica tipo float
    nom_tipo[_TFILE] = "FILE";    ///< Indica tipo FILE
    nom_tipo[_ENUM] = "enum";     ///< Indica tipo enum
    nom_tipo[_ARRAY] = "array";   ///< Indica tipo array
    nom_tipo[_STRING] = "string"; ///< Indica tipo string
    
    // Se imprime primero el ambito
    cout << "---   ";
    for (int e=0; e < s->ambito; e++) cout << "  ";
    cout << "a" << s->ambito << ": ";
    // Función o procedimiento
    if (s->tiposim == FUN || s->tiposim == PRO){ //Hay que separarlos para que proc no devuelva int como tipovar
        cout << s->nombre << "(";
        list<symrec>::iterator p;
        for (p = s->paramlist.begin(); p != s->paramlist.end(); p++){
            if (p != s->paramlist.begin())
                cout << ", ";
            cout << (*p).nombre << " : " << nom_tipo[(*p).tipovar]; //Hay que pasarlo al estilo de C
        }
        cout << ") ";
        if(s->tiposim== FUN)
            cout << "returns " << nom_tipo[s->tipovar] ;
        cout << endl;
        return;
    }
   	
	//Valor de un enumerado
	if (s->tiposim == CENUM){
		cout << s->tEnumerado->nombre << " valor: " << s->nombre << endl;
        return;
	}
	
	//Tipo enumerado
	if (s->tiposim == ETYPE){
        cout << "Enum: " << s->nombre << endl;
        return;
	}
	
	//Tipo array
	if (s->tiposim == ATYPE){
        cout << "Array: " << s->nombre << " tipo: " << nom_tipo[s->tipovar] << endl;
        return;
	}
	
    // Variable
    // --- Añadir dentro del if los array y enum ---
    if (s->tiposim == VAR  || s->tiposim == PIN || 
        s->tiposim == POUT || s->tiposim == PINOUT || s->tiposim == LSTRING){
            cout << nom_tipo[s->tipovar] << " ";
            if (s->tipovar == _ENUM || s->tipovar ==_ARRAY) cout << s->nombreTipo << ": ";
            cout << s->nombre << " " << s->dir << endl;
            return;
    }
    // Cosa desconocida
    cout << "-- simbolo desconocido" << endl;
}

