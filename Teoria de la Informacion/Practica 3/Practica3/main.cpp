#include <QtGui/QApplication>
#include "vent_inic.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    vent_inic w;
    w.show();

    return a.exec();
}
