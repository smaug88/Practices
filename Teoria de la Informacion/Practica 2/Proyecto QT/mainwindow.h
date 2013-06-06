#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private:
    Ui::MainWindow *ui;

private slots:
    void on_actionCuarta_aproximacion_triggered();
    void on_actionSegunda_aproximacion_triggered();
    void on_actionAproximacion_cero_triggered();
    void on_pushButton_clicked();
    void on_actionInsertar_texto_triggered();
};

#endif // MAINWINDOW_H
