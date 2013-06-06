#include "vent_sol.h"
#include "ui_vent_sol.h"
#include "vent_inic.h"
#include <cmath>

int tota;


void shannon_fano(float probs[], int total, QString resp[], float proba)
{
    // Ordenamos en orden decreciente
    float aux = 0;
    for(int ind = 0, i=0; ind<total; ind++)
    {
        while(probs[i]>probs[ind])
            i++;
        aux = probs[i];
        probs[i] = probs[ind];
        probs[ind] = aux;
    }
    if(total>2)
    {
        // Dividimos en 2 subconjuntos con una probabilidad similar
        aux = 0;
        int ind;
        float auxiliar = 1., nuevo = 1., aux2 = 0., diff = 0., prob2=0.;
        for(ind = total-1; ind > 0; ind--)
        {
            for(int i=0; i<ind; i++)
                aux += probs[i];
            for(int i=ind; i<total; i++)
                aux2 += probs[i];
            diff = fabs(aux-aux2);
            if(diff>nuevo)
            {
                break;
            }
            nuevo = diff;
            prob2=aux2;
            aux = 0.;
            aux2 = 0.;
        }
        int t = ind+1;
        float vect[t];
        for(int i=0; i<t; i++)
            vect[i] = probs[i];
        float pf[total-t];
        for(int i=t; i<total;i++)
            pf[i-t]=probs[i];
        // Llamada recursiva
        QString resp2[total-t];
        shannon_fano(vect, t, resp,proba-prob2);
        shannon_fano(pf, total-t, resp2,prob2);
        // Ponemos en el codigo el nuevo valor al principio
        for(int i=t; i<total; i++)
            resp[i]=resp2[i-t];
        for(int i=0; i<t; i++)
        {
            resp[i].prepend(' ');
            resp[i].prepend('0');
        }
        for(int i=t; i<total; i++)
        {
            resp[i].prepend(' ');
            resp[i].prepend('1');
        }
    }
    else
    {
        if(total==2)
        {
            resp[0] = ' 0';
            resp[1] = ' 1';
        }
    }
}

int vent_sol::decbin(float dec, int Li,int fila)
{
    QString binario;
    for(int i=0;i<Li;i++)
    {
        QString bit;
        dec*=2;
        if(dec>=1)
        {
            dec-=1;
            bit="1";

        }
        else
        {
            bit="0";
        }
        binario.append(bit);
        binario.append(" ");
    }
    QTableWidgetItem *cod_bin = new QTableWidgetItem(binario);
    cod_bin->setFlags(cod_bin->flags() & (~Qt::ItemIsEditable));
    cod_bin->setTextColor(Qt::blue); // color de los items
    ui->tableWidget->setItem(fila,2,cod_bin);
}

vent_sol::vent_sol(QString* palabras, float* probs, int n, QWidget *parent) :
    QWidget(parent),
    ui(new Ui::vent_sol)
{
    ui->setupUi(this);
    ui->tableWidget->setRowCount(n);
    ui->tableWidget->setColumnCount(4);

    tota = n;

    QStringList encabezado;
    encabezado << "Nombre" << "Probabilidad" << "Código Bin" << "Código Fano";
    ui->tableWidget->setHorizontalHeaderLabels(encabezado);
    ui->tableWidget->setColumnWidth(0, 100);
    ui->tableWidget->setColumnWidth(1, 100);
    ui->tableWidget->setColumnWidth(2, 100);
    ui->tableWidget->setColumnWidth(3, 100);

    //Ordenamos en orden decreciente de probabilidades
    for(int i=0;i<tota-1;i++)
    {
        for(int j=i+1;j<tota;j++)
        {
            if(probs[j]>probs[i])
            {
                QString sim_temp= palabras[i];
                float prob_temp= probs[i];
                palabras[i]=palabras[j];
                probs[i]=probs[j];
                palabras[j]=sim_temp;
                probs[j]=prob_temp;
            }
        }
    }

    //SHANON BINARIO

    //Aplicamos alfa
    float prob[tota];
    prob[0]=0;
    for (int i=1;i<n;i++)
    {
        prob[i]=prob[i-1]+probs[i-1];
    }

    //Cálculo del Li

    float Li[n];
    for(int i=0;i<n;i++)
    {
        Li[i]=ceil((-log(probs[i]) / log(2)));
    }


    //Código binario
    for(int i=0;i<tota;i++)
    {
        decbin(prob[i],Li[i],i);
    }

    //Eficiencia

    float tot=0;
    double eficiencia=0;
    float entropia=0;

    for(int i=0;i<tota;i++)
        entropia+=-probs[i]*log2(probs[i]);
    for(int i=0;i<tota;i++)
        tot+=probs[i]*Li[i];
    eficiencia=entropia / (tot*log2(2));
    QString efi;
    ui->label_3->setText(efi.sprintf("%f",eficiencia));



    QString proba;
    for(int i=0; i<tota; i++)
    {
        QTableWidgetItem *palabra = new QTableWidgetItem(palabras[i]);
        QTableWidgetItem *prob = new QTableWidgetItem(proba.sprintf("%f",probs[i]));

        palabra->setFlags(palabra->flags() & (~Qt::ItemIsEditable));
        palabra->setTextColor(Qt::blue); // color de los items
        ui->tableWidget->setItem(i,0,palabra);
        prob->setFlags(prob->flags() & (~Qt::ItemIsEditable));
        prob->setTextColor(Qt::blue); // color de los items
        ui->tableWidget->setItem(i,1,prob);
    }  

    // SHANNON-FANO

    QString resp[tota];
    shannon_fano(probs, n, resp,1.);

    //Eficiencia

    for(int i=0;i<n;i++)
    {
        float k = floor((resp[i].length()+1)/2);
        QString num = resp[i];
        Li[i] = k;
    }

    tot=0;
    eficiencia=0;

    efi.clear();
    for(int i=0;i<n;i++)
        tot+=probs[i]*Li[i];
    eficiencia=entropia / (tot*log2(2));
    ui->label_4->setText(efi.sprintf("%f",eficiencia));

    // Codigo
    for(int i=0; i<tota; i++)
    {
        QTableWidgetItem *codigo = new QTableWidgetItem(resp[i]);

        codigo->setFlags(codigo->flags() & (~Qt::ItemIsEditable));
        codigo->setTextColor(Qt::blue);
        ui->tableWidget->setItem(i,3,codigo);
    }
}

vent_sol::~vent_sol()
{
    delete ui;
}

void vent_sol::on_pushButton_clicked()
{
    vent_inic *nv = new vent_inic;
    nv->show();
    this->close();
}
