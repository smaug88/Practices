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
    void on_NEXT_clicked();
    void on_IRDY_clicked();
    void on_FRAME_clicked();
    void on_checkBox_clicked();
};

#endif // MAINWINDOW_H
