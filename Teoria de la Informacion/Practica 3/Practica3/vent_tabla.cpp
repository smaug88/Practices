#include "vent_tabla.h"
#include "ui_vent_tabla.h"
#include "vent_sol.h"

int total;
float suma_prob;

vent_tabla::vent_tabla(int n,QWidget *parent) :
    QWidget(parent),
    ui(new Ui::vent_tabla)
{
    ui->setupUi(this);
    ui->tableWidget->setRowCount(n);
    ui->tableWidget->setColumnCount(2);

    total = n;

    QStringList encabezado;
    encabezado << "Nombre" << "Probabilidad";
    ui->tableWidget->setHorizontalHeaderLabels(encabezado);
    ui->tableWidget->setColumnWidth(0, 100);
    ui->tableWidget->setColumnWidth(1, 100);
}

vent_tabla::~vent_tabla()
{
    delete ui;
}

void vent_tabla::on_pushButton_clicked()
{
    //QString *palabras = new QString[total];
    QString palabras[total];
    float probs[total];
    int k = 0;
    bool repeat = false;
    //float *probs = new float[total];
    for(int i=0; i<total; i++)
    {
        QTableWidgetItem *p1 = ui->tableWidget->item(i, 0);
        QTableWidgetItem *p2 = ui->tableWidget->item(i, 1);
        if((p1!=0)&&(p2!=0))
        {
            palabras[k] = p1->text();
            probs[k] = p2->text().toFloat();
            if(probs[k]<=0.)
                repeat = true;
            k++;
        }
    }

    //comprobamos probabilidades
    suma_prob=0.;
    for(int i=0;i<k;i++)
    {
        suma_prob+=probs[i];
    }

    if ((suma_prob <=1.0003)&&(!repeat))
    {
        vent_sol *nv = new vent_sol(palabras, probs, k);
        nv->show();
        this->close();
    }
}

void vent_tabla::on_pushButton_2_clicked()
{
    int p = 100;
    for(int i=0; i<total; i++)
    {
        int k = rand()%p;
        p-=k;
        QString pal;

        QTableWidgetItem *codigo = new QTableWidgetItem(pal.sprintf("%d",i));

        codigo->setFlags(codigo->flags() & (~Qt::ItemIsEditable));
        codigo->setTextColor(Qt::blue);
        ui->tableWidget->setItem(i,0,codigo);

        QTableWidgetItem *codigo2 = new QTableWidgetItem(pal.sprintf("%f",k/100.));

        codigo->setFlags(codigo2->flags() & (~Qt::ItemIsEditable));
        codigo->setTextColor(Qt::blue);
        ui->tableWidget->setItem(i,1,codigo2);
    }
}
