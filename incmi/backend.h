#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
static bool isLight = false;
class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);


    Q_INVOKABLE void setIOSStyle(const QString& style);

signals:

public slots:
};

#endif // BACKEND_H
