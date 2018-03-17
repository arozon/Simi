#include "backend.h"
#include "qdebug.h"

Backend::Backend(QObject *parent) : QObject(parent)
{

}

void Backend::setIOSStyle(const QString &style){
    if (style== "light")
        isLight = true;
    if (style == "dark")
        isLight = false;
    qDebug() << "This is the text sent to c++ : " << style << "\n" << isLight;
}
