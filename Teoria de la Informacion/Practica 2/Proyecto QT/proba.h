#ifndef PROBA_H
#define PROBA_H


#include <QDialog>
#include <map>
using namespace std;

namespace Ui {
    class proba;
}

class proba : public QDialog
{
    Q_OBJECT
public:
    explicit proba(int aprox,  map<QString, float> *m = 0, QWidget *parent = 0);
    explicit proba(int aprox,  float *prob = 0, QWidget *parent = 0);
    ~proba();

private:
    Ui::proba *ui;

private slots:
    void on_pushButton_clicked();
    void on_abrir_clicked();
};

#endif // PROBA_H
