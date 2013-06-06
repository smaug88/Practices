#ifndef VENT_SOL_H
#define VENT_SOL_H

#include <QWidget>

namespace Ui {
    class vent_sol;
}

class vent_sol : public QWidget
{
    Q_OBJECT

public:
    explicit vent_sol(QString* palabras = 0, float* probs=0, int n=0, QWidget *parent = 0);
    int decbin(float dec, int Li,int fila);
    ~vent_sol();

private:
    Ui::vent_sol *ui;

private slots:
    void on_pushButton_clicked();
};

#endif // VENT_SOL_H
