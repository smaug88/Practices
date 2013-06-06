#include "proba.h"
#include "ui_proba.h"
#include <QString>
#include <QTableWidgetItem>
#include "math.h"
#include <QFileDialog>
#include <QFileSystemModel>
#include <stdio.h>
#include <QByteArray>

float *probabilidades;
int aprox, total;
QString *palabras;
map<QString, float> *words;

proba::proba(int a, float *prob, QWidget *parent) :
    QDialog(parent),
    ui(new Ui::proba)
{
    ui->setupUi(this);

    aprox = a;
    probabilidades = prob;

    if(aprox == 1)
        for(int i = 0; i<28; i++)
            probabilidades[i]=0.;
    else
    {
        if(aprox == 0)
        {
            for(int i = 0; i<28; i++)
                probabilidades[i] = 1./28;
            this->close();
        }
        else
        {
            if(aprox == 2)
            {
                for(int i=0; i<784; i++)
                    probabilidades[i] = 0.;
            }
        }
    }




}

proba::proba(int a, map<QString, float> *m, QWidget *parent) :
    QDialog(parent),
    ui(new Ui::proba)
{
    ui->setupUi(this);

    aprox = a;
    words = m;

}

proba::~proba()
{
    delete ui;
}

void proba::on_abrir_clicked()
{
    QFileDialog *dialog=new QFileDialog(this,"Seleccione un fichero","");
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

int indice (char next)
{
    switch(next)
    {
                  case 'A':
                  case 'a':
        return 0;
        break;
                  case 'b':
                  case 'B':
        return 1;
        break;
                  case 'c':
                  case 'C':
        return 2;
        break;
                  case 'd':
                  case 'D':
        return 3;
        break;
                  case 'e':
                  case 'E':
        return 4;
        break;
                  case 'f':
                  case 'F':
        return 5;
        break;
                  case 'g':
                  case 'G':
        return 6;
        break;
                  case 'h':
                  case 'H':
        return 7;
        break;
                  case 'i':
                  case 'I':
        return 8;
        break;
                  case 'j':
                  case 'J':
        return 9;
        break;
                  case 'k':
                  case 'K':
        return 10;
        break;
                  case 'l':
                  case 'L':
        return 11;
        break;
                  case 'm':
                  case 'M':
        return 12;
        break;
                  case 'n':
                  case 'N':
        return 13;
        break;
                  case 'o':
                  case 'O':
        return 15;
        break;
                  case 'p':
                  case 'P':
        return 16;
        break;
                  case 'q':
                  case 'Q':
        return 17;
        break;
                  case 'r':
                  case 'R':
        return 18;
        break;
                  case 's':
                  case 'S':
        return 19;
        break;
                  case 't':
                  case 'T':
        return 20;
        break;
                  case 'u':
                  case 'U':
        return 21;
        break;
                  case 'v':
                  case 'V':
        return 22;
        break;
                  case 'w':
                  case 'W':
        return 23;
        break;
                  case 'x':
                  case 'X':
        return 24;
        break;
                  case 'y':
                  case 'Y':
        return 25;
        break;
                  case 'z':
                  case 'Z':
        return 26;
        break;
                  case ' ':
        return 27;
    default:
        return -1;
        break;
    }
  return 27;
}
int indice2(int s){
    switch (s)
    {
    case -63:
    case -31:
        return 0;
        break;
    case -55:
    case -23:
        return 4;
        break;
    case -51:
    case -19:
        return 8;
        break;
    case -45:
    case -13:
        return 15;
        break;
    case -4:
    case -8:
    case -6:
        return 21;
        break;
    case -47:
    case -15:
        return 14;
        break;
    default:
        return -1;
    }
}

void cuno(float *prob, QString &texto, int lon)
{
    QByteArray bytes  = texto.toAscii();
    char* frase = bytes.data();
    int veces[28];
    int ncaracteres=0;
    for(int j = 0; j<28; j++)
        veces[j] = 0;
    int i;
    for(i = 0; i<lon; i++)
    {
        switch(frase[i])
        {
            case 'a':
                veces[0]++;
                ncaracteres++;
                break;
            case 'b':
                veces[1]++;
                ncaracteres++;
                break;
            case 'c':
                veces[2]++;
                ncaracteres++;
                break;
            case 'd':
                veces[3]++;
                ncaracteres++;
                break;
            case 'e':
                veces[4]++;
                ncaracteres++;
                break;
            case 'f':
                veces[5]++;
                ncaracteres++;
                break;
            case 'g':
                veces[6]++;
                ncaracteres++;
                break;
            case 'h':
                veces[7]++;
                ncaracteres++;
                break;
            case 'i':
                veces[8]++;
                ncaracteres++;
                break;
            case 'j':
                veces[9]++;
                ncaracteres++;
                break;
            case 'k':
                veces[10]++;
                ncaracteres++;
                break;
            case 'l':
                veces[11]++;
                ncaracteres++;
                break;
            case 'm':
                veces[12]++;
                ncaracteres++;
                break;
            case 'n':
                veces[13]++;
                ncaracteres++;
                break;
            case 'o':
                veces[15]++;
                ncaracteres++;
                break;
            case 'p':
                veces[16]++;
                ncaracteres++;
                break;
            case 'q':
                veces[17]++;
                ncaracteres++;
                break;
            case 'r':
                veces[18]++;
                ncaracteres++;
                break;
            case 's':
                veces[19]++;
                ncaracteres++;
                break;
            case 't':
                veces[20]++;
                ncaracteres++;
                break;
            case 'u':
                veces[21]++;
                ncaracteres++;
                break;
            case 'v':
                veces[22]++;
                ncaracteres++;
                break;
            case 'w':
                veces[23]++;
                ncaracteres++;
                break;
            case 'x':
                veces[24]++;
                ncaracteres++;
                break;
            case 'y':
                veces[25]++;
                ncaracteres++;
                break;
            case 'z':
                veces[26]++;
                ncaracteres++;
                break;
            case 'A':
                veces[0]++;
                ncaracteres++;
                break;
            case 'B':
                veces[1]++;
                ncaracteres++;
                break;
            case 'C':
                veces[2]++;
                ncaracteres++;
                break;
            case 'D':
                veces[3]++;
                ncaracteres++;
                break;
            case 'E':
                veces[4]++;
                ncaracteres++;
                break;
            case 'F':
                veces[5]++;
                ncaracteres++;
                break;
            case 'G':
                veces[6]++;
                ncaracteres++;
                break;
            case 'H':
                veces[7]++;
                ncaracteres++;
                break;
            case 'I':
                veces[8]++;
                ncaracteres++;
                break;
            case 'J':
                veces[9]++;
                ncaracteres++;
                break;
            case 'K':
                veces[10]++;
                ncaracteres++;
                break;
            case 'L':
                veces[11]++;
                ncaracteres++;
                break;
            case 'M':
                veces[12]++;
                ncaracteres++;
                break;
            case 'N':
                veces[13]++;
                ncaracteres++;
                break;
            case 'O':
                veces[15]++;
                ncaracteres++;
                break;
            case 'P':
                veces[16]++;
                ncaracteres++;
                break;
            case 'Q':
                veces[17]++;
                ncaracteres++;
                break;
            case 'R':
                veces[18]++;
                ncaracteres++;
                break;
            case 'S':
                veces[19]++;
                ncaracteres++;
                break;
            case 'T':
                veces[20]++;
                ncaracteres++;
                break;
            case 'U':
                veces[21]++;
                ncaracteres++;
                break;
            case 'V':
                veces[22]++;
                ncaracteres++;
                break;
            case 'W':
                veces[23]++;
                ncaracteres++;
                break;
            case 'X':
                veces[24]++;
                ncaracteres++;
                break;
            case 'Y':
                veces[25]++;
                ncaracteres++;
                break;
            case 'Z':
                veces[26]++;
                ncaracteres++;
                break;
            case ' ':
                veces[27]++;
               // ncaracteres++;
                break;
            default:
                int s = texto.at(i).toAscii();
                switch (s)
                {
                case -63: //Á
                    veces[0]++;
                    ncaracteres++;
                    break;
                case -31: //á
                    veces[0]++;
                    ncaracteres++;
                    break;
                case -55: //É
                    veces[4]++;
                    ncaracteres++;
                    break;
                case -23: //é
                    veces[4]++;
                    ncaracteres++;
                    break;
                case -51: //Í
                    veces[8]++;
                    ncaracteres++;
                    break;
                case -19: //í
                    veces[8]++;
                    ncaracteres++;
                    break;
                case -45: //Ó
                    veces[15]++;
                    ncaracteres++;
                    break;
                case -13: //ó
                    veces[15]++;
                    ncaracteres++;
                    break;
                case -8: //Ú
                    veces[21]++;
                    ncaracteres++;
                    break;
                case -6: //ú
                    veces[21]++;
                    ncaracteres++;
                    break;
                case -4: //ü
                    veces[21]++;
                    ncaracteres++;
                    break;
                case -47: //Ñ
                    veces[14]++;
                    ncaracteres++;
                    break;
                case -15: //ñ
                    veces[14]++;
                    ncaracteres++;
                    break;
                }
                break;
        }
    }
    if(ncaracteres!=0)
        for(int k=0; k<28; k++)
            prob[k] = veces[k]*((1.)/ncaracteres);
}

void cdos(float *prob, QString &texto, int lon)
{
    int n_letras[28];
    for(int i = 0; i<28; i++)
        n_letras[i]=0;
    QByteArray bytes  = texto.toAscii();
    char* frase = bytes.data();
    int i=0, n=0;
    int ind=indice(frase[0]);
    while((ind==-1)&&(i<lon))
    {
        ind=indice2(texto[i].toAscii());
        if(ind==-1)
        {
            i++;
            indice(frase[i]);
        }
    }
    int aux = ind;
    for(; i<lon;)
    {
        while(ind==-1)
        {
            ind=indice2(texto[i].toAscii());
            if(ind==-1)
            {
                i++;
                ind = indice(frase[i]);
            }
        }
        i++;
        if(i==lon)
            break;
        aux = ind;
        ind = indice(frase[i]);
        if(ind==-1)
            ind=indice2(texto[i].toAscii());
        if(ind !=-1)
        {
            prob[aux*28+ind]++;
            n_letras[aux]++;
            n++;
        }
    }
    for(int j=0; j<28; j++)
        if(n_letras[j]!=0)
            for(i=0; i<28; i++)
                prob[j*28+i] /= (float)n_letras[j];
    i = i;
}


void cmap(map<QString, float> *mapeo, QString &texto, int lon)
{
    QByteArray bytes  = texto.toAscii();
    char* frase = bytes.data();
    int i=0, n=0, m=0;
    while(i<lon){
        QString palabra;
        while((frase[i]!=' ')&&((indice(frase[i])!=-1)||(indice2(texto[i].toAscii())!=-1))){
            palabra.append(frase[i]);
            i++;
        }
        i++;
        palabra = palabra.toLower();
        if(palabra.size()>0)
        {
            map<QString, float>::iterator it = mapeo->find(palabra);
            if(it==mapeo->end())
            {
                (*mapeo).insert(pair<QString,float>(palabra,1));
                m++;
            }
            else
                (*mapeo)[palabra]++;
            n++;
        }
    }
    map<QString,float>::iterator it = (*mapeo).begin();
    for(int j=0; j<m; j++, it++)
        it->second /=n;
}
void proba::on_pushButton_clicked()
{
       //Leemos el texto
       QString texto = ui->plainTextEdit->toPlainText();
       QByteArray bytes  = texto.toAscii();
       char* frase = bytes.data();
       int lon = strlen(frase);
       if(lon==0)
           this->close();
       if(aprox == 4)
       {
           cmap(words, texto, lon);
           this->close();
       }
       if(aprox == 1)
       {
           cuno(probabilidades, texto, lon);
           this->close();
       }
       if(aprox == 2)
       {
           cdos(probabilidades, texto, lon);
           this->close();
       }
}

