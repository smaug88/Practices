#ifndef VENT_TABLA_H
#define VENT_TABLA_H

#include <QWidget>

namespace Ui {
    class vent_tabla;
}

class vent_tabla : public QWidget
{
    Q_OBJECT

public:
    explicit vent_tabla(int n=0,QWidget *parent = 0);
    ~vent_tabla();

private:
    Ui::vent_tabla *ui;

private slots:
    void on_pushButton_2_clicked();
    void on_pushButton_clicked();
};

#endif // VENT_TABLA_H
