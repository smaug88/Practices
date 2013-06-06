#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "proba.h"


float prob[28],prob2[784];
map<QString, float> word;
int n=0;

char letra(int i)
{
    switch(i)
    {
        case 0:
            return 'a';
        case 1:
            return 'b';
        case 2:
            return 'c';
        case 3:
            return 'd';
        case 4:
            return 'e';
        case 5:
            return 'f';
        case 6:
            return 'g';
        case 7:
            return 'h';
        case 8:
            return 'i';
        case 9:
            return 'j';
        case 10:
            return 'k';
        case 11:
            return 'l';
        case 12:
            return 'm';
        case 13:
            return 'n';
        case 14:
            return 'ñ'; //corregir
        case 15:
            return 'o';
        case 16:
            return 'p';
        case 17:
            return 'q';
        case 18:
            return 'r';
        case 19:
            return 's';
        case 20:
            return 't';
        case 21:
            return 'u';
        case 22:
            return 'v';
        case 23:
            return 'w';
        case 24:
            return 'x';
        case 25:
            return 'y';
        case 26:
            return 'z';
        case 27:
            return ' ';
        default:
            return 0;
    }
}

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_actionInsertar_texto_triggered()
{
    for(int i=0; i<28; i++)
        prob[i] = 0.;
    proba *nv = new proba(1, prob);
    n=28;
    nv->show();
}

void MainWindow::on_pushButton_clicked()
{
    ui->textBrowser->clear();
    if(n==28)
        {
            int k = 0, i;
            float probn[28];
            for(i = 0; i<28; i++)
                probn[i] = prob[i];
            for(i = 0; i<n; i++)
            {
                int aux = k;
                k += probn[i]*100;
                probn[i] = aux;
            }
            int n = ui->iteraciones->toPlainText().toInt();
            for(int h=0;h<n;h++)
            {
                int aleatorio = rand()%100;
                for(i=0; i<28; i++)
                    if(probn[i]>aleatorio)
                        break;
                QString ristra = ui->textBrowser->toPlainText();
                ui->textBrowser->clear();
                ristra.append(QString("%1").arg(letra(i-1)));
                ui->textBrowser->append(ristra);
            }
        }
    else
    {
        if(n==784)
        {
            int k=0, i;
            float aux, q=0;
            float probn[784];
            for(i=0; i<784; i++)
                probn[i] = prob2[i];
            for(int j =0; j<28; j++)
            {
                for(i = 0; i<28; i++)
                {
                    aux = q;
                    q += probn[j*28+i]*100;
                    probn[j*28+i] = aux;
                }
                q = 0;
            }
            int n = ui->iteraciones->toPlainText().toInt();
            for(int h=0;h<n;h++)
            {
                int aleatorio = rand()%100;
                for(i=0; i<28; i++)
                    if(probn[k*28+i]>aleatorio)
                        break;
                QString ristra = ui->textBrowser->toPlainText();
                ui->textBrowser->clear();
                ristra.append(QString("%1").arg(letra(i-1)));
                ui->textBrowser->append(ristra);
                k = i-1;
            }
        }
        else
        {
            map<QString, float> palabros;
            palabros = word;
            map<QString, float>::iterator iter=palabros.begin();
            int i=palabros.size();
            float aux=0, aux2=0;
            for(int j=0; j<i; j++, iter++)
            {
                aux = aux2;
                aux2 += iter->second*100;
                iter->second = aux;
            }
            int n = ui->iteraciones->toPlainText().toInt();
            for(int h=0;h<n;h++)
            {
                iter=palabros.begin();
                int aleatorio = rand()%100;
                for(int j=0; j<i; j++, iter++)
                {
                    float q = iter->second;
                    if((iter->second) >(float)aleatorio)
                        break;
                }
                iter--;
                QString ristra = ui->textBrowser->toPlainText();
                ui->textBrowser->clear();
                ristra.append(iter->first);
                ristra.append(" ");
                ui->textBrowser->append(ristra);
            }
        }
    }
}
void MainWindow::on_actionAproximacion_cero_triggered()
{
    for(int i=0; i<28; i++)
        prob[i] = 1/28.;
    n=28;
}

void MainWindow::on_actionSegunda_aproximacion_triggered()
{
    for(int i=0; i<784; i++)
        prob2[i] = 0.;
    proba *nv = new proba(2, prob2);
    n=784;
    nv->show();
}

void MainWindow::on_actionCuarta_aproximacion_triggered()
{
    word.clear();
    proba *nv = new proba(4, &word);
    n=78;
    nv->show();
}
