#include "vent_inic.h"
#include "ui_vent_inic.h"
#include "vent_tabla.h"

vent_inic::vent_inic(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::vent_inic)
{
    ui->setupUi(this);
}

vent_inic::~vent_inic()
{
    delete ui;
}

void vent_inic::on_pushButton_clicked()
{
    int n = ui->lineEdit->text().toInt();
    if(n>1)
    {
        // llamamos vent_tabla y le pasamos el número de sí­mbolos
        vent_tabla *nv = new vent_tabla(n);
        nv->show();
        this->close();
    }
}
