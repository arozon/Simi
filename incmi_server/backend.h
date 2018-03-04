#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <database.h>
#include <settings.h>
#include <email.h>


class BackEnd : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString consoleText READ consoleText WRITE setConsoleText NOTIFY consoleTextChanged)
    Q_PROPERTY(int consoleLines READ consoleLines WRITE setConsoleLines NOTIFY consoleLinesChanged)
public:
    explicit BackEnd(QObject *parent = nullptr);
    Q_INVOKABLE void setSettings(const QJsonObject &settingsjs);
    Q_INVOKABLE QVariant getSetting(const QString &prop);
    Q_INVOKABLE QString getSettings();
    Q_INVOKABLE void logMessage(const QString &message);
    Q_INVOKABLE void appendSettings(const QJsonObject &obj);
    Q_INVOKABLE QString createInventory(const QString &dirname, const QString &filename);
    Q_INVOKABLE QString createChangesList(const QString &dirname, const QString &jssendbase, const QString &jschangebase);
    Q_INVOKABLE QString createDocumentInformation(const QString &dirname, const QString &filename);
    Q_INVOKABLE QString createDocument(const QString &dirname,const QString &data);
    Q_INVOKABLE void removeDocument(const QString  &dirname, const QString &filename);
    Q_INVOKABLE QString appendInventory(const QString &dirname, const QString &filename, const QString &data, const QString &changesdir);
    Q_INVOKABLE QString createPeopleList(const QString &dirname, const QString &changeslist);
    Q_INVOKABLE void editInventoryItem(const QString &dirname, const QString &filename, const QString &item);
    Q_INVOKABLE void removeInventoryItem(const QString &dirname, const QString &filename, const QString &item);
    Q_INVOKABLE void createInventoryItem(const QString &dirname, const QString &filename, const QString &item);
    Q_INVOKABLE void editEventItem(const QString &dirname, const QString& filename, const QString &data);
    Q_INVOKABLE void createEventItem(const QString &dirname, const QString& filename, const QString &item);
    Q_INVOKABLE void removeEventItem(const QString &dirname, const QString& filename, const QString &item);
    Q_INVOKABLE void removePeople(const QString &dirname, const QString &data);
    Q_INVOKABLE void editDocument(const QString &dirname, const QString &data);
    Q_INVOKABLE void serverActiveChanged(const bool &cond);

private:
    //Console Lines
    void setConsoleLines(const int &st) {
        if (st != _consoleLines) {
            _consoleLines = st;
            emit consoleLinesChanged();
        }
    }
    int consoleLines() const { return _consoleLines; }

    //Console Text
    void setConsoleText(const QString &st) {
        if (st != _consoleText) {
            _consoleText = st;
            emit consoleTextChanged();
        }
    }
    QString consoleText() const { return _consoleText; }

    // Properties
    QString _consoleText;
    int _consoleLines = 2000;

    //Directories
    QString eventfolder = "evt";
    QString invfolder = "invitems";
    QString backupfolder = "backups";
    QString incdocsfolder = "incd";
    QString docsfolder = "docs";
    QString peoplefolder = "ppl";
    QString invincfolder = "invincitems";


    //Filenames
    QString eventfilename = "events.incmi";
    QString incinvfilename = "invinctots.incmi";
    QString invfilename = "invtots.incmi";



    //objects
    DataBase _db;
    Settings _st;
    Email _em;
    QTimer *_tm;
    //Private methods
    QString getDateString(const QString &date);
    QString getRandomTag(const QString &dirname, const QString &filename);
    QStringList getEmailsFromObj(const QJsonObject &obj);
    void backupDataFolders();
    void sendEmailEventEdited(const QJsonObject &save, const QJsonObject &from);
    void sendEmailEventRemoved(const QString &objdeleted);
    void sendEmailEventAdded(const QString &item);
    void sendEmailEventReminder();




signals:
    void consoleTextChanged();
    void consoleLinesChanged();

public slots:
    void timerTickSlot();
};

#endif // BACKEND_H
