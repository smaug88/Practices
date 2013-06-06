#include "mainwindow.h"
#include "ui_mainwindow.h"

bool frame=false, irdy=false, trdy=false, devset=true, LECTURA, inic=false;
int dir, escrito;

MainWindow::MainWindow(QWidget *parent) :
        QMainWindow(parent),
        ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->tabla->setRowCount(10);
    ui->tabla->setColumnCount(1);
    QStringList encabezado;
    encabezado << "Valor" ;
    ui->tabla->setHorizontalHeaderLabels(encabezado);
    ui->tabla->setColumnWidth(0, 105);
    ui->tabla->setRowHeight(0, 20);
    ui->tabla->setRowHeight(1, 20);
    ui->tabla->setRowHeight(2, 20);
    ui->tabla->setRowHeight(3, 20);
    ui->tabla->setRowHeight(4, 20);
    ui->tabla->setRowHeight(5, 20);
    ui->tabla->setRowHeight(6, 20);
    ui->tabla->setRowHeight(7, 20);
    ui->tabla->setRowHeight(8, 20);
    ui->tabla->setRowHeight(9, 20);
}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_FRAME_clicked()
{
    if(!frame)
    {            // Iniciamos el proceso
        dir = ui->DIR->toPlainText().toInt();
        // Si intentamos insertar en una memoria no válida
        // no lo permitimos
        if((dir<0)||(dir>9))
            return;
        frame = true;
        ui->IRDY->setChecked(true);
        ui->TRDY->setChecked(true);
        ui->DEVSEL->setChecked(true);
        inic = true;
        irdy = true;
        trdy = true;
        devset = true;
    }
    else
    {
        frame = false;
    }
}

void MainWindow::on_IRDY_clicked()
{
    if(frame)
    {
        if(irdy)
            irdy = false;
        else
            irdy = true;
    }
}

void MainWindow::on_NEXT_clicked()
{

    if((frame)&&(devset))
    {
        if((irdy)&&(trdy))
        {
            if(LECTURA)
            {       // Si estamos leyendo
                    // Ponemos al principio de lo escrito lo nuevo
                    // Y lo guardamos en su posición del vector
                QString mascara = ui->MASK->toPlainText();
                int i;
                for(i=0; i<4; i++)
                    if(mascara[i]=='1')
                        break;
                if(i==4)
                {
                    irdy = false;
                    trdy = false;
                    frame = false;
                    devset = false;
                    ui->IRDY->setChecked(false);
                    ui->TRDY->setChecked(false);
                    ui->FRAME->setChecked(false);
                    ui->DEVSEL->setChecked(false);
                    ui->DIR->clear();
                    ui->MASK->clear();
                    return;
                }
                mascara[i] = '0';
                ui->MASK->insertPlainText(mascara);
                QString palabro = ui->DATA->toPlainText();
                QTableWidgetItem *p1 = ui->tabla->item(i, 0);
                palabro[i] = p1->text()[i];
                ui->DATA->insertPlainText(palabro);
            }
            else
            {       // Si estamos escribiendo
                    // Ponemos el dato en su hueco debido
                QString mascara = ui->MASK->toPlainText();
                int i;
                for(i=0; i<4; i++)
                    if(mascara[i]=='1')
                        break;
                if(i==4)
                {
                    irdy = false;
                    trdy = false;
                    frame = false;
                    devset = false;
                    ui->IRDY->setChecked(false);
                    ui->TRDY->setChecked(false);
                    ui->FRAME->setChecked(false);
                    ui->DEVSEL->setChecked(false);
                    ui->DIR->clear();
                    ui->MASK->clear();
                }
                mascara[i] = '0';
                ui->MASK->insertPlainText(mascara);
                QTableWidgetItem *p1 = ui->tabla->item(i, 0);
                QString palabro = p1->text();
                palabro[i] = ui->DATA->toPlainText()[i];
                QTableWidgetItem *palabra = new QTableWidgetItem(palabro);

                palabra->setFlags(palabra->flags() & (~Qt::ItemIsEditable));
                palabra->setTextColor(Qt::blue); // color de los items
                ui->tabla->setItem(dir,0,palabra);
            }
        }
    }
}
