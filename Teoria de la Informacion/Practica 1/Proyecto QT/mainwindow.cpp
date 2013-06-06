#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QString>
#include <QTableWidgetItem>
#include "math.h"
#include <QFileDialog>
#include <QFileSystemModel>
#include <stdio.h>



float probabilidades[28];
float prob_par[12];

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    for(int i = 0; i<28; i++)
        probabilidades[i]=0;
    for(int i=0; i<12; i++)
        prob_par[i]=0;

    ui->tableWidget->setRowCount(14);
    ui->tableWidget->setColumnCount(4);

    ui->tableWidget_2->setRowCount(12);
    ui->tableWidget_2->setColumnCount(2);

    QStringList encabezado, encabezado2;
    encabezado << "Letra" << "Probabilidad" << "Letra" << "Probabilidad";
    encabezado2 << "Par" << "Probabilidad";
    ui->tableWidget->setHorizontalHeaderLabels(encabezado);
    ui->tableWidget->setColumnWidth(0, 40);
    ui->tableWidget->setColumnWidth(1, 100);
    ui->tableWidget->setColumnWidth(2, 40);
    ui->tableWidget->setColumnWidth(3, 100);

    ui->tableWidget_2->setHorizontalHeaderLabels(encabezado2);
    ui->tableWidget_2->setColumnWidth(0, 40);
    ui->tableWidget_2->setColumnWidth(1, 100);

    QTableWidgetItem *letras0 = new QTableWidgetItem("A");
    QTableWidgetItem *letras1 = new QTableWidgetItem("B");
    QTableWidgetItem *letras2 = new QTableWidgetItem("C");
    QTableWidgetItem *letras3 = new QTableWidgetItem("D");
    QTableWidgetItem *letras4 = new QTableWidgetItem("E");
    QTableWidgetItem *letras5 = new QTableWidgetItem("F");
    QTableWidgetItem *letras6 = new QTableWidgetItem("G");
    QTableWidgetItem *letras7 = new QTableWidgetItem("H");
    QTableWidgetItem *letras8 = new QTableWidgetItem("I");
    QTableWidgetItem *letras9 = new QTableWidgetItem("J");
    QTableWidgetItem *letras10 = new QTableWidgetItem("K");
    QTableWidgetItem *letras11 = new QTableWidgetItem("L");
    QTableWidgetItem *letras12 = new QTableWidgetItem("M");
    QTableWidgetItem *letras13 = new QTableWidgetItem("N");
    QTableWidgetItem *letras14 = new QTableWidgetItem(QString::fromUtf8("Ñ"));
    QTableWidgetItem *letras15 = new QTableWidgetItem("O");
    QTableWidgetItem *letras16 = new QTableWidgetItem("P");
    QTableWidgetItem *letras17 = new QTableWidgetItem("Q");
    QTableWidgetItem *letras18 = new QTableWidgetItem("R");
    QTableWidgetItem *letras19 = new QTableWidgetItem("S");
    QTableWidgetItem *letras20 = new QTableWidgetItem("T");
    QTableWidgetItem *letras21 = new QTableWidgetItem("U");
    QTableWidgetItem *letras22 = new QTableWidgetItem("V");
    QTableWidgetItem *letras23 = new QTableWidgetItem("W");
    QTableWidgetItem *letras24 = new QTableWidgetItem("X");
    QTableWidgetItem *letras25 = new QTableWidgetItem("Y");
    QTableWidgetItem *letras26 = new QTableWidgetItem("Z");

    // para que los elementos no sean editables
    letras0->setFlags(letras0->flags() & (~Qt::ItemIsEditable));
    letras0->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(0,0,letras0);

    letras1->setFlags(letras1->flags() & (~Qt::ItemIsEditable));
    letras1->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(1,0,letras1);

    letras2->setFlags(letras2->flags() & (~Qt::ItemIsEditable));
    letras2->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(2,0,letras2);

    letras3->setFlags(letras3->flags() & (~Qt::ItemIsEditable));
    letras3->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(3,0,letras3);

    letras4->setFlags(letras4->flags() & (~Qt::ItemIsEditable));
    letras4->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(4,0,letras4);

    letras5->setFlags(letras5->flags() & (~Qt::ItemIsEditable));
    letras5->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(5,0,letras5);

    letras6->setFlags(letras6->flags() & (~Qt::ItemIsEditable));
    letras6->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(6,0,letras6);

    letras7->setFlags(letras7->flags() & (~Qt::ItemIsEditable));
    letras7->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(7,0,letras7);

    letras8->setFlags(letras8->flags() & (~Qt::ItemIsEditable));
    letras8->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(8,0,letras8);

    letras9->setFlags(letras9->flags() & (~Qt::ItemIsEditable));
    letras9->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(9,0,letras9);

    letras10->setFlags(letras10->flags() & (~Qt::ItemIsEditable));
    letras10->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(10,0,letras10);

    letras11->setFlags(letras11->flags() & (~Qt::ItemIsEditable));
    letras11->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(11,0,letras11);

    letras12->setFlags(letras12->flags() & (~Qt::ItemIsEditable));
    letras12->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(12,0,letras12);

    letras13->setFlags(letras13->flags() & (~Qt::ItemIsEditable));
    letras13->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(13,0,letras13);

    letras14->setFlags(letras14->flags() & (~Qt::ItemIsEditable));
    letras14->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(0,2,letras14);

    letras15->setFlags(letras15->flags() & (~Qt::ItemIsEditable));
    letras15->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(1,2,letras15);

    letras16->setFlags(letras16->flags() & (~Qt::ItemIsEditable));
    letras16->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(2,2,letras16);

    letras17->setFlags(letras17->flags() & (~Qt::ItemIsEditable));
    letras17->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(3,2,letras17);

    letras18->setFlags(letras18->flags() & (~Qt::ItemIsEditable));
    letras18->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(4,2,letras18);

    letras19->setFlags(letras19->flags() & (~Qt::ItemIsEditable));
    letras19->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(5,2,letras19);

    letras20->setFlags(letras20->flags() & (~Qt::ItemIsEditable));
    letras20->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(6,2,letras20);

    letras21->setFlags(letras21->flags() & (~Qt::ItemIsEditable));
    letras21->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(7,2,letras21);

    letras22->setFlags(letras22->flags() & (~Qt::ItemIsEditable));
    letras22->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(8,2,letras22);

    letras23->setFlags(letras23->flags() & (~Qt::ItemIsEditable));
    letras23->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(9,2,letras23);

    letras24->setFlags(letras24->flags() & (~Qt::ItemIsEditable));
    letras24->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(10,2,letras24);

    letras25->setFlags(letras25->flags() & (~Qt::ItemIsEditable));
    letras25->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(11,2,letras25);

    letras26->setFlags(letras26->flags() & (~Qt::ItemIsEditable));
    letras26->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(12,2,letras26);


    QTableWidgetItem *par0 = new QTableWidgetItem("de");
    QTableWidgetItem *par1 = new QTableWidgetItem("el");
    QTableWidgetItem *par2 = new QTableWidgetItem("si");
    QTableWidgetItem *par3 = new QTableWidgetItem("ne");
    QTableWidgetItem *par4 = new QTableWidgetItem("qu");
    QTableWidgetItem *par5 = new QTableWidgetItem("ca");
    QTableWidgetItem *par6 = new QTableWidgetItem("di");
    QTableWidgetItem *par7 = new QTableWidgetItem("su");
    QTableWidgetItem *par8 = new QTableWidgetItem("ra");
    QTableWidgetItem *par9 = new QTableWidgetItem("no");
    QTableWidgetItem *par10 = new QTableWidgetItem("ll");
    QTableWidgetItem *par11 = new QTableWidgetItem("ch");

    par0->setFlags(par0->flags() & (~Qt::ItemIsEditable));
    par0->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(0,0,par0);

    par1->setFlags(par1->flags() & (~Qt::ItemIsEditable));
    par1->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(1,0,par1);

    par2->setFlags(par2->flags() & (~Qt::ItemIsEditable));
    par2->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(2,0,par2);

    par3->setFlags(par3->flags() & (~Qt::ItemIsEditable));
    par3->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(3,0,par3);

    par4->setFlags(par4->flags() & (~Qt::ItemIsEditable));
    par4->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(4,0,par4);

    par5->setFlags(par5->flags() & (~Qt::ItemIsEditable));
    par5->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(5,0,par5);

    par6->setFlags(par6->flags() & (~Qt::ItemIsEditable));
    par6->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(6,0,par6);

    par7->setFlags(par7->flags() & (~Qt::ItemIsEditable));
    par7->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(7,0,par7);

    par8->setFlags(par8->flags() & (~Qt::ItemIsEditable));
    par8->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(8,0,par8);

    par9->setFlags(par9->flags() & (~Qt::ItemIsEditable));
    par9->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(9,0,par9);

    par10->setFlags(par10->flags() & (~Qt::ItemIsEditable));
    par10->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(10,0,par10);

    par11->setFlags(par11->flags() & (~Qt::ItemIsEditable));
    par11->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(11,0,par11);

}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_plainTextEdit_textChanged()
{

}

void MainWindow::on_pushButton_clicked()
{
    int veces[28], par[12];
    int ncaracteres=0;
    int npar=0;
    for(int j = 0; j<28; j++)
        veces[j] = 0;
    for(int j=0; j<12; j++)
        par[j] = 0;
    //Leemos el texto
    QString texto = ui->plainTextEdit->toPlainText();
    QByteArray bytes  = texto.toAscii();
    char* frase = bytes.data();
    int lon = strlen(frase);
    if(lon==0)
        return ;
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
                if((frase[i+1]=='a')||(frase[i+1]=='A'))
                {
                    npar++;
                    par[5]++;
                }
                if((frase[i+1]=='h')||(frase[i+1]=='H'))
                {
                    npar++;
                    par[11]++;
                }
                break;
            case 'd':
                veces[3]++;
                ncaracteres++;
                if((frase[i+1]=='e')||(frase[i+1]=='E'))
                {
                    npar++;
                    par[0]++;
                }
                if((frase[i+1]=='i')||(frase[i+1]=='I'))
                {
                    npar++;
                    par[6]++;
                }
                break;
            case 'e':
                veces[4]++;
                ncaracteres++;
                break;
            case 'f':
                veces[5]++;
                ncaracteres++;
                if((frase[i+1]=='l')||(frase[i+1]=='L'))
                {
                    npar++;
                    par[1]++;
                }
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
                if((frase[i+1]=='l')||(frase[i+1]=='L'))
                {
                    npar++;
                    par[10]++;
                }
                break;
            case 'm':
                veces[12]++;
                ncaracteres++;
                break;
            case 'n':
                veces[13]++;
                ncaracteres++;
                if((frase[i+1]=='e')||(frase[i+1]=='E'))
                {
                    npar++;
                    par[3]++;
                }
                if((frase[i+1]=='o')||(frase[i+1]=='O'))
                {
                    npar++;
                    par[9]++;
                }
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
                if((frase[i+1]=='u')||(frase[i+1]=='U'))
                {
                    npar++;
                    par[4]++;
                }
                break;
            case 'r':
                veces[18]++;
                ncaracteres++;
                if((frase[i+1]=='a')||(frase[i+1]=='A'))
                {
                    npar++;
                    par[8]++;
                }
                break;
            case 's':
                veces[19]++;
                ncaracteres++;
                if((frase[i+1]=='i')||(frase[i+1]=='i'))
                {
                    npar++;
                    par[2]++;
                }
                if((frase[i+1]=='u')||(frase[i+1]=='U'))
                {
                    npar++;
                    par[7]++;
                }
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
                if((frase[i+1]=='a')||(frase[i+1]=='A'))
                {
                    npar++;
                    par[0]++;
                }
                if((frase[i+1]=='h')||(frase[i+1]=='H'))
                {
                    npar++;
                    par[11]++;
                }
                break;
            case 'D':
                veces[3]++;
                ncaracteres++;
                if((frase[i+1]=='e')||(frase[i+1]=='E'))
                {
                    npar++;
                    par[0]++;
                }
                if((frase[i+1]=='i')||(frase[i+1]=='I'))
                {
                    npar++;
                    par[6]++;
                }
                break;
            case 'E':
                veces[4]++;
                ncaracteres++;
                if((frase[i+1]=='L')||(frase[i+1]=='l'))
                {
                    npar++;
                    par[1]++;
                }
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
                if((frase[i+1]=='L')||(frase[i+1]=='l'))
                {
                    npar++;
                    par[10]++;
                }
                break;
            case 'N':
                veces[13]++;
                ncaracteres++;
                if((frase[i+1]=='e')||(frase[i+1]=='E'))
                {
                    npar++;
                    par[3]++;
                }
                if((frase[i+1]=='o')||(frase[i+1]=='O'))
                {
                    npar++;
                    par[9]++;
                }
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
                if((frase[i+1]=='u')||(frase[i+1]=='U'))
                {
                    npar++;
                    par[4]++;
                }
                break;
            case 'R':
                veces[18]++;
                ncaracteres++;
                if((frase[i+1]=='a')||(frase[i+1]=='A'))
                {
                    npar++;
                    par[8]++;
                }
                break;
            case 'S':
                veces[19]++;
                ncaracteres++;
                if((frase[i+1]=='i')||(frase[i+1]=='I'))
                {
                    npar++;
                    par[2]++;
                }
                if((frase[i+1]=='u')||(frase[i+1]=='U'))
                {
                    npar++;
                    par[7]++;
                }
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
            probabilidades[k] = (veces[k])*((1.)/ncaracteres);
    if(npar!=0)
        for(int k=0; k<12; k++)
            prob_par[k] = (par[k])*((1.)/npar);

    QString proba;

    QTableWidgetItem *prob0 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[0]));
    QTableWidgetItem *prob1 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[1]));
    QTableWidgetItem *prob2 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[2]));
    QTableWidgetItem *prob3 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[3]));
    QTableWidgetItem *prob4 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[4]));
    QTableWidgetItem *prob5 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[5]));
    QTableWidgetItem *prob6 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[6]));
    QTableWidgetItem *prob7 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[7]));
    QTableWidgetItem *prob8 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[8]));
    QTableWidgetItem *prob9 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[9]));
    QTableWidgetItem *prob10 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[10]));
    QTableWidgetItem *prob11 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[11]));
    QTableWidgetItem *prob12 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[12]));
    QTableWidgetItem *prob13 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[13]));
    QTableWidgetItem *prob14 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[14]));
    QTableWidgetItem *prob15 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[15]));
    QTableWidgetItem *prob16 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[16]));
    QTableWidgetItem *prob17 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[17]));
    QTableWidgetItem *prob18 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[18]));
    QTableWidgetItem *prob19 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[19]));
    QTableWidgetItem *prob20 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[20]));
    QTableWidgetItem *prob21 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[21]));
    QTableWidgetItem *prob22 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[22]));
    QTableWidgetItem *prob23 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[23]));
    QTableWidgetItem *prob24 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[24]));
    QTableWidgetItem *prob25 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[25]));
    QTableWidgetItem *prob26 = new QTableWidgetItem(proba.sprintf("%f",probabilidades[26]));


    prob0->setFlags(prob0->flags() & (~Qt::ItemIsEditable));
    prob0->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(0,1,prob0);

    prob1->setFlags(prob1->flags() & (~Qt::ItemIsEditable));
    prob1->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(1,1,prob1);

    prob2->setFlags(prob2->flags() & (~Qt::ItemIsEditable));
    prob2->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(2,1,prob2);

    prob3->setFlags(prob3->flags() & (~Qt::ItemIsEditable));
    prob3->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(3,1,prob3);

    prob4->setFlags(prob4->flags() & (~Qt::ItemIsEditable));
    prob4->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(4,1,prob4);

    prob5->setFlags(prob5->flags() & (~Qt::ItemIsEditable));
    prob5->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(5,1,prob5);

    prob6->setFlags(prob6->flags() & (~Qt::ItemIsEditable));
    prob6->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(6,1,prob6);

    prob7->setFlags(prob7->flags() & (~Qt::ItemIsEditable));
    prob7->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(7,1,prob7);

    prob8->setFlags(prob8->flags() & (~Qt::ItemIsEditable));
    prob8->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(8,1,prob8);

    prob9->setFlags(prob9->flags() & (~Qt::ItemIsEditable));
    prob9->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(9,1,prob9);

    prob10->setFlags(prob10->flags() & (~Qt::ItemIsEditable));
    prob10->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(10,1,prob10);

    prob11->setFlags(prob11->flags() & (~Qt::ItemIsEditable));
    prob11->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(11,1,prob11);

    prob12->setFlags(prob12->flags() & (~Qt::ItemIsEditable));
    prob12->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(12,1,prob12);

    prob13->setFlags(prob13->flags() & (~Qt::ItemIsEditable));
    prob13->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(13,1,prob13);

    prob14->setFlags(prob14->flags() & (~Qt::ItemIsEditable));
    prob14->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(0,3,prob14);

    prob15->setFlags(prob15->flags() & (~Qt::ItemIsEditable));
    prob15->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(1,3,prob15);

    prob16->setFlags(prob16->flags() & (~Qt::ItemIsEditable));
    prob16->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(2,3,prob16);

    prob17->setFlags(prob17->flags() & (~Qt::ItemIsEditable));
    prob17->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(3,3,prob17);

    prob18->setFlags(prob18->flags() & (~Qt::ItemIsEditable));
    prob18->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(4,3,prob18);

    prob19->setFlags(prob19->flags() & (~Qt::ItemIsEditable));
    prob19->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(5,3,prob19);

    prob20->setFlags(prob20->flags() & (~Qt::ItemIsEditable));
    prob20->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(6,3,prob20);

    prob21->setFlags(prob21->flags() & (~Qt::ItemIsEditable));
    prob21->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(7,3,prob21);

    prob22->setFlags(prob22->flags() & (~Qt::ItemIsEditable));
    prob22->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(8,3,prob22);

    prob23->setFlags(prob23->flags() & (~Qt::ItemIsEditable));
    prob23->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(9,3,prob23);

    prob24->setFlags(prob24->flags() & (~Qt::ItemIsEditable));
    prob24->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(10,3,prob24);

    prob25->setFlags(prob25->flags() & (~Qt::ItemIsEditable));
    prob25->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(11,3,prob25);

    prob26->setFlags(prob26->flags() & (~Qt::ItemIsEditable));
    prob26->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(12,3,prob26);

    float entropia = 0.;
    for(int j=0; j<27; j++)
        if(probabilidades[j]>0.)
            entropia+=(probabilidades[j]*log2(probabilidades[j]));
    entropia *=-1.;
    ui->label_2->setText(proba.sprintf("%f",entropia));

    QTableWidgetItem *par0 = new QTableWidgetItem(proba.sprintf("%f",prob_par[0]));
    QTableWidgetItem *par1 = new QTableWidgetItem(proba.sprintf("%f",prob_par[1]));
    QTableWidgetItem *par2 = new QTableWidgetItem(proba.sprintf("%f",prob_par[2]));
    QTableWidgetItem *par3 = new QTableWidgetItem(proba.sprintf("%f",prob_par[3]));
    QTableWidgetItem *par4 = new QTableWidgetItem(proba.sprintf("%f",prob_par[4]));
    QTableWidgetItem *par5 = new QTableWidgetItem(proba.sprintf("%f",prob_par[5]));
    QTableWidgetItem *par6 = new QTableWidgetItem(proba.sprintf("%f",prob_par[6]));
    QTableWidgetItem *par7 = new QTableWidgetItem(proba.sprintf("%f",prob_par[7]));
    QTableWidgetItem *par8 = new QTableWidgetItem(proba.sprintf("%f",prob_par[8]));
    QTableWidgetItem *par9 = new QTableWidgetItem(proba.sprintf("%f",prob_par[9]));
    QTableWidgetItem *par10 = new QTableWidgetItem(proba.sprintf("%f",prob_par[10]));
    QTableWidgetItem *par11 = new QTableWidgetItem(proba.sprintf("%f",prob_par[11]));

    par0->setFlags(par0->flags() & (~Qt::ItemIsEditable));
    par0->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(0,1,par0);

    par1->setFlags(par1->flags() & (~Qt::ItemIsEditable));
    par1->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(1,1,par1);

    par2->setFlags(par2->flags() & (~Qt::ItemIsEditable));
    par2->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(2,1,par2);

    par3->setFlags(par3->flags() & (~Qt::ItemIsEditable));
    par3->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(3,1,par3);

    par4->setFlags(par4->flags() & (~Qt::ItemIsEditable));
    par4->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(4,1,par4);

    par5->setFlags(par5->flags() & (~Qt::ItemIsEditable));
    par5->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(5,1,par5);

    par6->setFlags(par6->flags() & (~Qt::ItemIsEditable));
    par6->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(6,1,par6);

    par7->setFlags(par7->flags() & (~Qt::ItemIsEditable));
    par7->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(7,1,par7);

    par8->setFlags(par8->flags() & (~Qt::ItemIsEditable));
    par8->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(8,1,par8);

    par9->setFlags(par9->flags() & (~Qt::ItemIsEditable));
    par9->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(9,1,par9);

    par10->setFlags(par10->flags() & (~Qt::ItemIsEditable));
    par10->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(10,1,par10);

    par11->setFlags(par11->flags() & (~Qt::ItemIsEditable));
    par11->setTextColor(Qt::blue); // color de los items
    ui->tableWidget_2->setItem(11,1,par11);

    entropia = 0;
    for(int j=0; j<12; j++)
        if(prob_par[j]!=0)
            entropia+=(prob_par[j]*log2(prob_par[j]));
    entropia *=-1;
    ui->label_4->setText(proba.sprintf("%f",entropia));
    ui->label_5->setText(proba.sprintf("%d",ncaracteres));

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
