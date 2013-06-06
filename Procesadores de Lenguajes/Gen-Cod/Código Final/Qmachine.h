#ifndef QMACHINE_H
#define QMACHINE_H

#include <stdio.h>

#include "symtable.h" // vartype

// #define Z 0x00100000         // base+1 de la zona estatica (1 MB máx)
// #define Z 0x00112000         // base+1 de la zona estatica (1096 KB máx)
#ifndef Z
#define Z 0x00012000            // base+1 de la zona estatica (72 KB máx)
#endif
// #define P TE                 // de la pila (implicita)
// #define H 0x00200000         // base+1 del heap (1 MB máx); ha de verificar H>>Z
// #define H 0x00224000         // base+1 del heap (1096 KB máx); ha de verificar H>>Z 
#ifndef H
#define H 0x00024000            // base+1 del heap (72 KB máx); ha de verificar H>>Z
#endif

#define NUM_REGS_INT      8
#define NUM_REGS_FLOAT    4

class Qmachine{
	int nextregent; // Primer registro entero libre
	int nextregfloat; // Primer registro flotante libre
    bool regent[NUM_REGS_INT]; //Vector del contenido de los registros enteros
    bool regfloat[NUM_REGS_FLOAT]; //Vector del contenido de los registros flotantes
    int reg5;
    
    // Dirección más alta de la memoria. El heap es la zona de la memoria
    // entre H y Z.
    //static const int H = 0x00024000;
    
    // Dirección límite de la base de la pila. La pila crece hacia direcciones
    // bajas de memoria y debe empezar en Z (la pila va desde Z hacia 0).
    // R7 almacena la dirección de la cima de la pila.
    // Por tanto: Z >= R7 >= 0
    //static const int Z = 0x00012000;

public:
    Qmachine();
    
    // Devuelve el primer registro entero libre
    int newRegEnt();
    
    // Devuelve el primer registro flotante libre
    int newRegFloat();
    
    //libera registro entero
    void releaseRegEnt(int);
    
    //libera registro flotante
    void releaseRegFloat(int);
    
    //Devuelve una string del tipo "R1" o "RR2" con el registro a utilizar
    string newRegister(char);
    
    /*static*/ int sizeOfType(char qDataType);
    
    /*static*/ char qTypeFromCpmType(vartype cpmType);
    //Arregalda para los punteros
    char fixedQTypeFromCpmType(vartype cmpType);
    
    // Devuelve R o RR, sin número, para que la regla lo ponga a mano
    string autoReg(char);
    
    // Decrementa R5 un número de bytes y devuelve la nueva dirección de R5
    int desplazarR5(int bytes);

};

#endif QMACHINE_H
