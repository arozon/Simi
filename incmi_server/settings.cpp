#include "settings.h"
#include "qjsondocument.h"
#include "qjsonobject.h"

Settings::Settings(QObject *parent) : QObject(parent)
{

}

QJsonValue Settings::readProperty(const QString &propname) {
    QJsonValue result;
    if (_io.fileExists(_filename)) {
        QJsonObject obj = QJsonDocument::fromJson(_io.readFile(_filename).toUtf8()).object();
        if (obj.keys().contains(propname)) {
            result = obj[propname];
        }
    }
    return result;
}

QList<QString> Settings::checkMissingProperties(const QList<QString> &props) {
    if (!_io.fileExists(_filename)) return props;
    QList<QString> missing;
    QJsonObject obj = QJsonDocument::fromJson(_io.readFile(_filename).toUtf8()).object();
    foreach (const QString prop, props) {
        if (!obj.keys().contains(prop)) missing.append(prop);
    }
    return missing;
}

QString Settings::getSettings() {
    return _io.readFile(_filename);
}

void Settings::Initialize(const QString &filename, const QHash<QString, QJsonValue> defaultprops) {
    _filename = filename;
    QList<QString> mprops = checkMissingProperties(defaultprops.keys());
    foreach (const QString pr, mprops) {
        writeProperty(pr,defaultprops.value(pr));
    }
}

void Settings::writeProperty(const QString &propstring, const QJsonValue &value) {
    if (!_io.fileExists(_filename)) _io.writeFile(QString("{}"),_filename);
    QJsonDocument doc = QJsonDocument::fromJson(_io.readFile(_filename).toUtf8());
    QJsonObject obj = doc.object();
    obj[propstring] = value;
    doc.setObject(obj);
    _io.writeFile(QString(doc.toJson(QJsonDocument::Compact)),_filename);
}
