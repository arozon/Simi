#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <fileio.h>

class Settings : public QObject
{
    Q_OBJECT
public:
    explicit Settings(QObject *parent = nullptr);
    QJsonValue readProperty(const QString &propstring);
    void Initialize(const QString &filename, const QHash<QString,QJsonValue> defaultprops);
    QString getSettings();
    QList<QString> checkMissingProperties(const QList<QString> &props);
    void writeProperty(const QString &propstring, const QJsonValue &value);

signals:

private:
    FileIO _io;
    QString _filename;

public slots:
};

#endif // SETTINGS_H
