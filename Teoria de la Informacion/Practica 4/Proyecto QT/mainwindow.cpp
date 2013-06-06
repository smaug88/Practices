#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <stdio.h>
#include <QFileDialog>
#include <QFileSystemModel>
#include <cmath>
#include <stdio.h>
#include <stdlib.h>

typedef struct nodo
{
   char letra;      /* Letra a la que hace referencia el nodo */
   int frecuencia;  /* veces que aparece la letra en el texto o las letras */
                    /* de los nodos de las ramas cero y uno */
   nodo *sig;      /* Puntero a siguiente nodo de una lista enlazada */
   nodo *cero;     /* Puntero a la rama cero de un á¡rbol */
   nodo *uno;      /* Puntero a la rama uno de un á¡rbol */
} tipoNodo;         /* Nombre de tipo */

/* Nodo para construir una lista para la tabla de codigos */
typedef struct tabla
{
   char letra;      /* Letra a la que hace referencia el nodo */
   unsigned long int bits; /* Valor de la codificaciá³n de la letra */
   char nbits;      /* Náºmero de bits de la codificaciá³n */
   tabla *sig;     /* Siguiente elemento de la tabla */
} tipoTabla;        /* Nombre del tipo */


tipoTabla *Tabla;
QString texto;


MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->tableWidget->setRowCount(50);
    ui->tableWidget->setColumnCount(3);

    QStringList encabezado;
    encabezado << "Letra" << "Frecuencia" << "Código";
    ui->tableWidget->setHorizontalHeaderLabels(encabezado);
    ui->tableWidget->setColumnWidth(0, 40);
    ui->tableWidget->setColumnWidth(1, 50);
    ui->tableWidget->setColumnWidth(2, 100);
}

MainWindow::~MainWindow()
{
    delete ui;
}

char letra (QChar letra)
{
    int s = letra.toAscii();
    switch (s)
    {
    case -63: //Á
        return 'a';
        break;
    case -31: //á
        return 'a';
        break;
    case -55: //É
        return 'e';
        break;
    case -23: //é
        return 'e';
        break;
    case -51: //Í
        return 'i';
        break;
    case -19: //í
        return 'i';
        break;
    case -45: //Ó
        return 'o';
        break;
    case -13: //ó
        return 'o';
        break;
    case -8: //Ú
        return 'u';
        break;
    case -6: //ú
        return 'u';
        break;
    case -4: //ü
        return 'u';
        break;
    case -47: //Ñ
        return 'ñ';
        break;
    case -15: //ñ
        return 'ñ';
        break;
    default:
        return letra.toLower().toLatin1();
    }
}

void Cuenta(tipoNodo* &Lista, char c)
{
   tipoNodo *p, *a, *q;

   if(!Lista)  /* Si la lista estÃ¡ vacÃ­a, el nuevo nodo serÃ¡ Lista */
   {
      Lista = (tipoNodo *)malloc(sizeof(tipoNodo)); /* Un nodo nuevo */
      Lista->letra = c;                             /* Para c */
      Lista->frecuencia = 1;                        /* en su 1Âª apariciÃ³n */
      Lista->sig = Lista->cero = Lista->uno = NULL;
   }
   else
   {
      /* Buscar el caracter en la lista (ordenada por letra) */
      p = Lista;
      a = NULL;
      while(p && p->letra < c)
      {
         a = p;      /* Guardamos el elemento actual para insertar */
         p = p->sig; /* Avanzamos al siguiente */
      }
      /* Dos casos: */
      /* 1) La letra es c se encontrÃ³ */
      if(p && p->letra == c) p->frecuencia++; /* Actualizar frecuencia */
      else
      /* 2) La letra c no se encontrÃ³*/
      {
         /* Insertar un elemento nuevo */
         q = (tipoNodo *)malloc(sizeof(tipoNodo));
         q->letra = c;
         q->frecuencia = 1;
         q->cero = q->uno = NULL;
         q->sig = p;        /* Insertar entre los nodos p */
         if(a) a->sig = q;  /* y a */
         else Lista = q;    /* Si a es NULL el nuevo es el primero */
      }
   }
}

void InsertarOrden(tipoNodo* &Cabeza, tipoNodo *e)
{
   tipoNodo *p, *a;

   if(!Cabeza) /* Si Cabeza en NULL, e es el primer elemento */
   {
      Cabeza = e;
      Cabeza->sig = NULL;
   }
   else
   {
       /* Buscar el caracter en la lista (ordenada por frecuencia) */
       p = Cabeza;
       a = NULL;
       while((p) && (p->frecuencia < e->frecuencia))
       {
          a = p;      /* Guardamos el elemento actual para insertar */
          p = p->sig; /* Avanzamos al siguiente */
       }
       /* Insertar el elemento */
       e->sig = p;
       if(a) a->sig = e;   /* Insertar entre a y p */
       else Cabeza = e;    /* el nuevo es el primero */
    }
}

void Ordenar(tipoNodo* &Lista)
{
   tipoNodo *Lista2, *a;

   if(!Lista) return; /* Lista vacia */
   Lista2 = Lista;
   Lista = NULL;
   while(Lista2)
   {
      a = Lista2;              /* Toma los elementos de Lista2 */
      Lista2 = a->sig;
      InsertarOrden(Lista, a); /* Y los inserta por orden en Lista */
   }
}

void InsertarTabla(char c, int l, int v)
{
   tipoTabla *t, *p, *a;

   t = (tipoTabla *)malloc(sizeof(tipoTabla)); /* Crea un elemento de tabla */
   t->letra = c;                               /* Y lo inicializa */
   t->bits = v;
   t->nbits = l;

   if(!Tabla)         /* Si tabla es NULL, entonces el elemento t es el 1Âº */
   {
      Tabla = t;
      Tabla->sig = NULL;
   }
   else
   {
       /* Buscar el caracter en la lista (ordenada por frecuencia) */
       p = Tabla;
       a = NULL;
       while(p && p->letra < t->letra)
       {
          a = p;      /* Guardamos el elemento actual para insertar */
          p = p->sig; /* Avanzamos al siguiente */
       }
       /* Insertar el elemento */
       t->sig = p;
       if(a) a->sig = t;  /* Insertar entre a y p */
       else Tabla = t;    /* el nuevo es el primero */
    }
}

void CrearTabla(tipoNodo *n, int l, int v)
{
   if(n->uno)  CrearTabla(n->uno, l+1, (v<<1)|1);
   if(n->cero) CrearTabla(n->cero, l+1, v<<1);
   if(!n->uno && !n->cero) InsertarTabla(n->letra, l, v);
}

tipoTabla *BuscaCaracter(tipoTabla *Tabla, char c)
{
   tipoTabla *t;

   t = Tabla;
   while(t && t->letra != c) t = t->sig;
   return t;
}

void BorrarArbol(tipoNodo *n)
{
   if(n->cero) BorrarArbol(n->cero);
   if(n->uno)  BorrarArbol(n->uno);
   free(n);
   n = NULL;
}

void binario(int numero, int tam, QString *salidax)
{
    int resto=numero, aux;
    salidax->clear();
    for(int i=0; i<tam; i++)
    {
        aux = resto%2;
        QString miniristra;
        miniristra.sprintf("%d", aux);
        salidax->prepend(miniristra);
        resto = floor(resto/2);
    }
}

void copia (tipoNodo *nuevo, tipoNodo *viejo)
{
    tipoNodo *aux = nuevo;
    while(viejo!=NULL)
    {
        aux->frecuencia = viejo->frecuencia;
        aux->letra = viejo->letra;
        aux->cero = NULL;
        aux->uno = NULL;
        tipoNodo *novo = new tipoNodo;
        aux->sig = novo;
        aux = aux->sig;
        viejo = viejo->sig;
    }
    aux->sig = NULL;
}

void MainWindow::on_pushButton_clicked()
{
    tipoNodo *Lista;
    Lista = NULL;
    tipoNodo *Arbol;
    Arbol = NULL;

    tipoNodo *p;
    tipoTabla *t;
    unsigned long int dWORD;
    int nBits;

    int longitud = 0;
    QString texto = ui->plainTextEdit->toPlainText();
    for(int i=0; i< texto.length(); i++)
    {
        longitud++;
        char letr = letra(texto[i]);
        Cuenta(Lista, letr);
    }
    Ordenar(Lista);

    tipoNodo *Copia = new tipoNodo;
    copia(Copia, Lista);

    Arbol = Lista;

    while(Arbol && Arbol->sig) /* Mientras existan al menos dos elementos en la lista */
    {
       p = (tipoNodo *)malloc(sizeof(tipoNodo)); /* Un nuevo Ã¡rbol */
       p->letra = 0;                             /* No corresponde a ninguna letra */
       p->uno = Arbol;                           /* Rama uno */
       Arbol = Arbol->sig;                       /* Siguiente nodo en */
       p->cero = Arbol;                          /* Rama cero */
       Arbol = Arbol->sig;                       /* Siguiente nodo */
       p->frecuencia = p->uno->frecuencia +
                       p->cero->frecuencia;      /* Suma de frecuencias */
       InsertarOrden(Arbol, p);                  /* Inserta en nuevo nodo */
    }

    Tabla = NULL;
    CrearTabla(Arbol, 0, 0);


    float suma = 0.;
    int cositas = 0;
    for(int i=0; i< texto.length(); i++)
    {
       char letr = letra(texto[i]);
       t = BuscaCaracter(Tabla, letr);
       cositas++;
       suma += (float)(t->nbits)/8.;
       t = NULL;
    }

    suma = (suma /(float)cositas)*100.;
    QString proba;
    ui->label_2->setText(proba.sprintf("%f", suma));
    //cout << "Ratio de compresion del texto: " << suma << "%" << endl;

    FILE *fs;

    fs = fopen("TablaCod.txt", "wb");
    fwrite(&longitud, sizeof(long int), 1, fs);
    /* Cuenta el nÃºmero de elementos de tabla */
    int nElementos = 0;
    t = Tabla;
    while(t)
    {
       nElementos++;
       t = t->sig;
    }
    /* Escribir el nÃºmero de elemenos de tabla */
    fwrite(&nElementos, sizeof(int), 1, fs);
    /* Escribir tabla en fichero */
    t = Tabla;
    while(t)
    {
       fwrite(&t->letra, sizeof(char), 1, fs);
       fwrite(&t->bits, sizeof(unsigned long int), 1, fs);
       fwrite(&t->nbits, sizeof(char), 1, fs);
       t = t->sig;
    }
    fclose(fs);


    fs = fopen("Salida.txt", "wb");

    QString tsalida;
    for(int j=0; i<texto.length(); j++)
    {
        t = BuscaCaracter(Tabla, texto(texto[i]));
        QString aux;
        binario(t->bits, t->nbits, &aux);
        tsalida.append(aux);
    }
    fwrite(&tsalida,sizeof(QChar)*tsalida.length(), 1, fs);

    fclose(fs);

    /* Borrar Tabla */
    tipoNodo *lista = Copia;

    for(int j=0; j<nElementos; j++)
    {
        if(lista->letra != '\0')
        {
            QTableWidgetItem *palabra = new QTableWidgetItem(proba.sprintf("%c", lista->letra));

            QTableWidgetItem *frec = new QTableWidgetItem(proba.sprintf("%d",lista->frecuencia));
            tipoTabla *f = BuscaCaracter(Tabla, lista->letra);
            QString salida;
            binario(f->bits, f->nbits, &salida);
            QTableWidgetItem *cod = new QTableWidgetItem(salida);

            palabra->setFlags(palabra->flags() & (~Qt::ItemIsEditable));
            palabra->setTextColor(Qt::blue); // color de los items
            ui->tableWidget->setItem(j,0,palabra);
            frec->setFlags(frec->flags() & (~Qt::ItemIsEditable));
            frec->setTextColor(Qt::blue); // color de los items
            ui->tableWidget->setItem(j,1,frec);

            cod->setFlags(cod->flags() & (~Qt::ItemIsEditable));
            cod->setTextColor(Qt::blue); // color de los items
            ui->tableWidget->setItem(j,2,cod);
        }
        lista = lista->sig;
    }
    BorrarArbol(Arbol);
    while(Tabla)
    {
       t = Tabla;
       Tabla = t->sig;
       free(t);
    }
    //free(lista);
    Arbol = NULL;
    Lista = NULL;
    Copia = NULL;
    fs = NULL;
    lista = NULL;
    p = NULL;
    t = NULL;
    return;
}

void MainWindow::on_abrir_clicked()
{
    QFileDialog *dialog=new QFileDialog(this,"Seleccione un fichero","/.");
    dialog->exec();
    QStringList fileNames = dialog->selectedFiles();
    QFile pfile(fileNames.first());
    if (pfile.open(QIODevice::ReadOnly))
      {
        QString salida(pfile.readAll());
        ui->plainTextEdit->setPlainText(salida);
        pfile.close();
      }
    delete dialog;
}
