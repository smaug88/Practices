#include "Qmachine.h"

Qmachine::Qmachine() {
    nextregent = 0;
    nextregfloat = 0;   
    for (int i = 0; i < NUM_REGS_INT; i++)
        regent[i] = 0;
    for (int i = 0; i < NUM_REGS_FLOAT; i++)
        regfloat[i] = 0;
    reg5=H;
}

int Qmachine::newRegEnt(){ //true = ocupado
    for (int i = 0; i < 6; i++){  //el 7 no lo damos para calculos
        if(regent[i]==false){
            regent[i] = true;
            return i;
        }
    }
    throw "No quedan registros enteros";
}

int Qmachine::newRegFloat(){
    for (int i = 0; i < 4; i++){
        if(regfloat[i]==false){
            regfloat[i] = true;
            return i;
        }           
    }
    throw "No quedan registros flotantes";
}

    //libera registro entero
    void Qmachine::releaseRegEnt(int a){
        if (a < 6)
            regent[a]=false;
    }
    
    //libera registro flotante
    void Qmachine::releaseRegFloat(int a){
        if (a < 4)
            regfloat[a]=false;
    }
    
    //Devuelve una string del tipo "R1" o "RR2" con el registro a utilizar
    string Qmachine::newRegister(char a){
        string c;
        switch (a){
            case 'P': 
            case 'U': 
            case 'S': 
            case 'I': 
            case 'J':
                char b[3];
                sprintf(b, "R%d", newRegEnt());
                c=b;
            break;
            
            case 'F':
            case 'D':
            case 'E':
                char bb[4];
                sprintf(bb, "RR%d", newRegFloat());
                c=bb;
            break;
            default:
                throw "newRegister:Tipo de dato inexistente";
            }
        return c;
    }
    
string Qmachine::autoReg(char a){
    string c;
        switch (a){
            case 'P': 
            case 'U': 
            case 'S': 
            case 'I': 
            case 'J':
                char b[2];
                sprintf(b, "R");
                c=b;
            break;
            
            case 'F':
            case 'D':
            case 'E':
                char bb[3];
                sprintf(bb, "RR");
                c=bb;
            break;
            default:
            	DEBUG_PRINT("peta con %c\n", a);
                throw "autoReg:Tipo de dato inexistente";
            }
        return c;
}


// Inserta en la pila
// No hacen falta PA' NAAAAA
/*void Qmachine::push(int numBytes)
{
    if (R7 - numBytes < 0)
    {
        // No hay más espacio en la pila
        throw "No hay mas espacio en la pila";
    }
    else
        R7 += numBytes;
}

// Extrae de la pila
// Este tampoco hace falta PA' NAAA
void Qmachine::pop(int numBytes)
{
    if (R7 + numBytes > Z)
    {
    	// La pila está vacía
        throw "La pila esta vacia";
    }
    else
    	R7 -= numBytes;
}*/

/* El compilador dice "cannot declare member function xxxx to have static linkage... ¿Por qué? */
/*static*/ int Qmachine::sizeOfType(char qDataType)
{
	switch (qDataType)
	{
		case 'P':
			// P(e)   unsigned int    4 octetos   puntero (entero no negativo)
			return 4;
        case 'U':
            //  U(e)   unsigned char   1 octeto    carácter (entero no negativo)
            return 4;
		case 'S':
			// S(e)   short           2 octetos   entero
			return 2;
		case 'I':
			// I(e)   int             4 octetos   entero
			return 4;
		case 'J':
			// J(e)   long int        4 octetos   entero
			return 4;
		case 'F':
			// F(e)   float           4 octetos   coma flotante
			return 4;
		case 'D':
			// D(e)   double          8 octetos   coma flotante
			return 8;
		case 'E':
			// E(e)   long double    12 octetos   coma flotante
			return 12;
		default:
			throw "sizeOfType:No existe ese tipo de dato:";
	}
}

/* El compilador dice "cannot declare member function xxxx to have static linkage... ¿Por qué? */
/*static*/ char Qmachine::qTypeFromCpmType(vartype cpmType)
{
	DEBUG_PRINT("cpmType: %d\n", cpmType);
	switch (cpmType)
	{
		case _INT:	   	return 'I';
		case _CHAR:	   	return 'U'; // unsigned char
		case _FLOAT:	return 'F'; // float
		case _TFILE:	return 'P'; // unsigned int (descriptor de fichero)
		case _ENUM:		return 'I';
		case _ARRAY:	return 'I';
		default: throw "qTypeFromCpmType:No existe el tipo en nADA";
	}
}

/*static*/ char Qmachine::fixedQTypeFromCpmType(vartype cpmType)
{
	switch (cpmType)
	{
		case _INT:	   	return 'I';
		case _CHAR:	   	return 'U'; // unsigned char
		case _FLOAT:	return 'F'; // float
		case _TFILE:	return 'P'; // unsigned int (descriptor de fichero)
		case _ENUM:		return 'I';
		case _ARRAY:	return 'I';
		default: throw "fixedQTypeFromCpmType:No existe el tipo en nADA";
	}
}

// Decrementa R5 un número de bytes y devuelve la nueva dirección de R5
int Qmachine::desplazarR5(int bytes){
     reg5 -= bytes;
     return reg5;   
}
