#ifndef VENT_INIC_H
#define VENT_INIC_H

#include <QMainWindow>

namespace Ui {
    class vent_inic;
}

class vent_inic : public QMainWindow
{
    Q_OBJECT

public:
    explicit vent_inic(QWidget *parent = 0);
    ~vent_inic();

private:
    Ui::vent_inic *ui;

private slots:
    void on_pushButton_clicked();
};

#endif // VENT_INIC_H
