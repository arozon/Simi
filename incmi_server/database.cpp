#include "database.h"
#include "qmath.h"
#include "qdebug.h"
#include "qdatetime.h"


DataBase::DataBase(QObject *parent) : QObject(parent)
{

}

void DataBase::makeDirectories(const QStringList &dirnames) {
    foreach (const QString dir, dirnames) {
        if (!_io.dirExist(dir)) _io.makeDirectory(dir);
    }
}

void DataBase::makeJsonListFiles(const QHash<QString, QString> &fileswithdir) {
    QList<QString> keys = fileswithdir.keys();
    foreach (const QString &ks, keys) {
        if (_io.dirExist(fileswithdir.value(ks))) {
            _io.cd(fileswithdir.value(ks));
            if (!_io.fileExists(ks)) _io.writeFile("{" + QString(QChar('"')) + "items" + QString(QChar('"')) + ": []}", ks);
            _io.resetDirectory();
        }
    }
}


bool DataBase::modifyFile(const QString &dirname, QString filename, const QString &data) {
    if (!filename.contains(".", Qt::CaseInsensitive) && !filename.isEmpty()) filename += _xfile;
    if (!_io.dirExist(dirname)) {
        _io.makeDirectory(dirname);
        return false;
    }
    _io.cd(dirname);
    if  (!_io.fileExists(filename)) {
        _io.resetDirectory();
        return false;
    }
    bool tmp = _io.writeFile(data, filename);
    _io.resetDirectory();
    return tmp;
}



QString DataBase::addFile(const QString &dirname, const QString &data) {
    if (!_io.dirExist(dirname)) _io.makeDirectory(dirname);
    _io.cd(dirname);
    QString dt = data;
    QString name = GetRandomName() + _xfile;
    _io.writeFile(dt, name);
    _io.resetDirectory();
    return name;
}




bool DataBase::deleteFile(const QString &dirname, QString filename) {
    if (!filename.contains(".", Qt::CaseInsensitive) && !filename.isEmpty()) filename += _xfile;
    if (!_io.dirExist(dirname)) {
        _io.makeDirectory(dirname);
        return false;
    }
    _io.cd(dirname);
    if (!_io.fileExists(filename)) {
        _io.resetDirectory();
        return false;
    }
    bool tmp = _io.removeFile(filename);
    _io.resetDirectory();
    return tmp;
}



QString DataBase::getFileData(QString filename,const QString &dirname) {
    if (dirname.isEmpty()) return "{}";
    if (!filename.contains(".", Qt::CaseInsensitive) && !filename.isEmpty()) filename += _xfile;
    if (filename.isEmpty()) return "{}";
    if (!_io.dirExist(dirname)) {
        _io.makeDirectory(dirname);
        return "{}";
    }
    _io.cd(dirname);
    if (!_io.fileExists(filename)) {
        _io.resetDirectory();
        return "{}";
    }
    QString data = _io.readFile(filename);
    _io.resetDirectory();
    return data;

}

QList<QPair<QString,QString>> DataBase::getFilesData(const QString &dirname, const QString &filterString, const QString &sortString) {
    QList<QPair<QString,QString>> data;
    if (dirname.isEmpty()) return data;
    if (!_io.dirExist(dirname)) {
        _io.makeDirectory(dirname);
        return data;
    }
    _io.cd(dirname);
    QStringList names = _io.getFilteredNames(filterString,sortString);
    if (names.length() < 1) {
        _io.resetDirectory();
        return data;
    }
    for (int i = 0; i<names.length(); i++) {
        QString filename = names.at(i);
        if (filename.split(".").at(1) == _xfile.rightRef(_xfile.size() -1) && _io.fileExists(filename)) data.append(qMakePair(filename,_io.readFile(filename)));
    }
    _io.resetDirectory();
    return data;
}

QHash<QString,QString> DataBase::getFilesData(const QString &dirname) {
    QHash<QString,QString> data;
    if (dirname.isEmpty()) return data;
    if (!_io.dirExist(dirname)) {
        _io.makeDirectory(dirname);
        return data;
    }
    _io.cd(dirname);
    QStringList names = _io.getFileNames();
    if (names.length() < 1) {
        _io.resetDirectory();
        return data;
    }
    for (int i = 0; i<names.length(); i++) {
        QString filename = names.at(i);
        if (filename.split(".").at(1) == _xfile.rightRef(_xfile.size() - 1) && _io.fileExists(filename))
        {
            data.insert(filename,_io.readFile(filename));
        }
    }
    _io.resetDirectory();
    return data;
}

bool DataBase::backupFoldersWithDate(QStringList &dirnames, const QString &backupfolder){
    if (dirnames.length() < 1) return false;
    for (int i = dirnames.length() - 1; i > -1; i--) {
        if (!_io.dirExist(dirnames[i])) dirnames.removeAt(i);
    }
    if (dirnames.length() < 1) return false;
    if (!_io.dirExist(backupfolder)) _io.makeDirectory(backupfolder);
    _io.cd(backupfolder);
    QString folname = QDateTime::currentDateTime().date().toString("M_dd_yyyy") + "_bac";
    while(_io.dirExist(folname)) {
        folname += "1";
    }
    _io.makeDirectory(folname);
    _io.resetDirectory();
    foreach (QString dir, dirnames) {
        QList<QPair<QString,QString>> files = getFilesData(dir,"files","time");
        _io.cd(backupfolder);
        _io.cd(folname);
        _io.makeDirectory(dir);
        _io.cd(dir);
        for (int b = files.length() - 1; b > -1; b--) {
            QPair<QString,QString> pr = files[b];
            _io.writeFile(pr.second,pr.first);
        }
        _io.resetDirectory();
    }
    return true;
}



QString DataBase::GetRandomName() {
    bool check = true;
    QString name;
    QStringList names;
    while (check) {
        name = QString::number(abs(qFloor(qrand() * 1000000)));
        names = _io.getFileNames();
        bool found = false;
        for (int i = 0; i < names.length(); i++) {
            if (names.at(i).split(".").at(0) == name) found = true;
        }
        if (!found) check = false;
    }
    return name;
}

