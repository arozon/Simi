#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <fileio.h>

class DataBase : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString xfile READ xfile WRITE setXfile NOTIFY xfileChanged)
public:
    void setXfile(const QString &a) {
        if (a != _xfile) {
            _xfile = a;
            emit xfileChanged();

        }
    }
    QString xfile() const {
        return _xfile;
    }

    explicit DataBase(QObject *parent = nullptr);
    QString addFile(const QString &dirname, const QString &data);
    QString getFileData(QString filename,const QString &dirname);
    QHash<QString,QString> getFilesData(const QString &dirname);
    QList<QPair<QString,QString>> getFilesData(const QString &dirname, const QString &filterString, const QString &sortString);
    bool modifyFile(const QString &dirname, QString filename, const QString &data);
    bool deleteFile(const QString &dirname, QString filename);
    bool backupFoldersWithDate(QStringList &dirnames, const QString &backupfolder);
    void makeDirectories(const QStringList &dirnames);
    void makeJsonListFiles(const QHash<QString, QString> &fileswithdir);

signals:
    void xfileChanged();


private:
    FileIO _io;
    QString _xfile = ".ardb";
    QString GetRandomName();



public slots:
};

#endif // DATABASE_H
