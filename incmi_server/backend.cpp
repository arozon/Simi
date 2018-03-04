#include "backend.h"
#include "qjsondocument.h"
#include "qjsonobject.h"
#include "qjsonarray.h"
#include "qdatetime.h"
#include "qdebug.h"
#include "qmath.h"
#include "qtimer.h"



BackEnd::BackEnd(QObject *parent) : QObject(parent)
{
    _tm = new QTimer(this);
    connect(_tm, SIGNAL(timeout()),this,SLOT(timerTickSlot()));
    _db.setXfile(".incmi");
    QHash<QString,QJsonValue> defaultprops {
        {"sport", QJsonValue("443")},
        {"shost", QJsonValue("localhost")},
        {"smpush", QJsonValue("30")},
        {"semaccount", QJsonValue("")},
        {"sempassword", QJsonValue("")},
        {"scnew", QJsonValue(false)},
        {"scedit", QJsonValue(false)},
        {"scremind", QJsonValue(false)},
        {"scremove", QJsonValue(false)},
        {"scadmincommit", QJsonValue(false)},
        {"scbackup", QJsonValue(false)},
    };
    _st.Initialize("conf.incmi",defaultprops);
    QHash<QString,QString> fileswithdirs {
        {eventfilename,eventfolder},
        {invfilename,invfolder},
        {incinvfilename, invincfolder}
    };
    QStringList dirs = (QStringList() << eventfolder << invfolder << backupfolder << incdocsfolder << docsfolder << invincfolder << peoplefolder);
    _db.makeDirectories(dirs);
    _db.makeJsonListFiles(fileswithdirs);
}

void BackEnd::logMessage(const QString &message) {
    if (_consoleText.length() > _consoleLines) {
        _consoleText = "";
    }
    _consoleText = _consoleText + QString("\n") + QDateTime::currentDateTime().toString("hh:mm:ss ddd yyyy-MM-dd ---") + message;
    emit consoleTextChanged();
}

QString BackEnd::createInventory(const QString &dirname, const QString &filename) {
    logMessage("Generating the inventory and sending to request");
    return _db.getFileData(filename,dirname);
}

QString BackEnd::createChangesList(const QString &dirname, const QString &jssendbase, const QString &jschangebase){
    logMessage("Sending changes list to client");
    QList<QPair<QString,QString>> data = _db.getFilesData(dirname,"files","time");
    QJsonDocument jsdoc = QJsonDocument::fromJson(jssendbase.toUtf8());
    QJsonObject obj = jsdoc.object();
    QJsonArray arr = obj["items"].toArray();
    for (int i = 0; i < data.length(); i++){
        QJsonObject dataobj = QJsonDocument::fromJson(data[i].second.toUtf8()).object();
        QJsonObject chobj = QJsonDocument::fromJson(jschangebase.toUtf8()).object();
        QStringList kk = chobj.keys();
        for (int b = 0; b < kk.length(); b++) {
            QString tm = kk.at(b);
            if (tm == "filename") {
                chobj[tm] = data[i].first;
                continue;
            }
            chobj[tm] = dataobj[tm].toString();
        }
        arr.append(chobj);
    }
    obj["items"] = arr;
    jsdoc.setObject(obj);
    return QString(jsdoc.toJson(QJsonDocument::Compact));
}

QString BackEnd::createDocumentInformation(const QString &dirname, const QString &filename) {
    logMessage("Generating doc information for: " + filename + " to request");
    return _db.getFileData(filename,dirname);
}

QString BackEnd::createDocument(const QString &dirname, const QString &data) {
    logMessage("Client sent in a new document, processing...");
    return _db.addFile(dirname,data);
}


QString BackEnd::appendInventory(const QString &dirname, const QString &filename, const QString &data, const QString &changesdir) {
    logMessage("Client sent in new inventory commit, processing...");
    QString name = "";
    QString ddata = _db.getFileData(filename,dirname);
    if (ddata != "{}") {
        QJsonDocument maindoc = QJsonDocument::fromJson(ddata.toUtf8());
        QJsonObject mainobj = maindoc.object();
        QJsonObject odt = QJsonDocument::fromJson(data.toUtf8()).object();
        QJsonArray isave = mainobj["items"].toArray();
        QJsonArray ifrom = odt["items"].toArray();
        for (int i = 0; i < ifrom.size(); i++) {
            QJsonObject oifrom = QJsonDocument::fromJson(ifrom.at(i).toString().toUtf8()).object();
            for(int b = 0; b < isave.size(); b++) {
                QJsonObject oisave = isave[b].toObject();
                if (oisave["tag"] == oifrom["tag"]) {
                    oisave["count"] = oifrom["count"].toString();
                    isave.replace(b, oisave);
                }
            }
        }
        mainobj["items"] = isave;
        maindoc.setObject(mainobj);
        _db.modifyFile(dirname,filename,QString(maindoc.toJson(QJsonDocument::Compact)));
        name = _db.addFile(changesdir,data);
    }
    return name;
}

QString BackEnd::createPeopleList(const QString &dirname, const QString &changeslist) {
    logMessage("Client requested for list of people");
    QHash<QString,QString> data = _db.getFilesData(dirname);
    QList<QString> list = data.keys();
    QJsonArray result;
    for (int i = 0; i < list.length(); i++) {
        QJsonObject obj = QJsonDocument::fromJson(data.value(list.value(i)).toUtf8()).object();
        obj["filename"] = list[i];
        obj["password"] = QString("");
        result.append(obj);
    }
    QJsonDocument rdoc = QJsonDocument::fromJson(changeslist.toUtf8());
    QJsonObject robj = rdoc.object();
    robj["items"] = result;
    rdoc.setObject(robj);
    return QString(rdoc.toJson(QJsonDocument::Compact));
}

void BackEnd::editInventoryItem(const QString &dirname, const QString &filename, const QString &item) {
    logMessage("Client requested to edit an inventory item - Admin accepted.");
    QString data = _db.getFileData(filename,dirname);
    QJsonDocument savedoc = QJsonDocument::fromJson(data.toUtf8());
    QJsonObject sobj = savedoc.object();
    QJsonArray items = sobj["items"].toArray();
    QJsonObject dobj = QJsonDocument::fromJson(item.toUtf8()).object();

    for (int i = 0; i < items.size(); i++) {
        QJsonObject it = items[i].toObject();
        if (dobj["tag"] == it["tag"]) {
            it["name"] = dobj["name"];
            it["count"] = dobj["count"];
            it["rcount"] = dobj["rcount"];
            items.replace(i, it);
            break;
        }
    }
    sobj["items"] = items;
    savedoc.setObject(sobj);
    _db.modifyFile(dirname,filename,QString(savedoc.toJson(QJsonDocument::Compact)));
}

void BackEnd::removeInventoryItem(const QString &dirname, const QString &filename, const QString &item) {
    logMessage("Client requested to remove an inventory item - Admin accepted.");
    QString _data = _db.getFileData(filename,dirname);
    QJsonDocument _savedoc = QJsonDocument::fromJson(_data.toUtf8());
    QJsonObject _sobj = _savedoc.object();
    QJsonArray items = _sobj["items"].toArray();
    QJsonObject _dobj = QJsonDocument::fromJson(item.toUtf8()).object();
    for (int i = items.size() - 1; i > -1; i--) {
        QJsonObject _it = items[i].toObject();
        if (_it["tag"] == _dobj["tag"]) {
            items.removeAt(i);
        }
    }
    _sobj["items"] = items;
    _savedoc.setObject(_sobj);
    _db.modifyFile(dirname,filename,QString(_savedoc.toJson(QJsonDocument::Compact)));
}

QString BackEnd::getRandomTag(const QString &dirname, const QString &filename){
    bool check = true;
    QString tag; // The tag to return
    QStringList tags; // List of present tags
    QString data = _db.getFileData(filename,dirname); // File data

    //Get the tags
    QJsonArray items = QJsonDocument::fromJson(data.toUtf8()).object()["items"].toArray();
    for (int i = 0; i < items.size(); i++) {
        tags.append(items[i].toString());
    }

    while (check) { // Loop until tag is unique
        tag = QString::number(abs(qFloor(qrand() * 1000000)));
        bool found = false;
        for (int i = 0; i < tags.length(); i++) {
            if (tags.at(i) == tag) found = true;
        }
        if (!found) check = false;
    }
    return tag;
}

void BackEnd::createInventoryItem(const QString &dirname, const QString &filename, const QString &item) {
    logMessage("Client is adding a new inventory item");
    QString tag = getRandomTag(dirname,filename);
    QString data = _db.getFileData(filename,dirname);
    QJsonDocument doc = QJsonDocument::fromJson(data.toUtf8());
    QJsonObject mobj = doc.object();
    QJsonArray ar = mobj["items"].toArray();
    QJsonObject toadd = QJsonDocument::fromJson(item.toUtf8()).object();
    toadd["tag"] = tag;
    ar.append(toadd);
    mobj["items"] = ar;
    doc.setObject(mobj);
    _db.modifyFile(dirname,filename, QString(doc.toJson(QJsonDocument::Compact)));
}


void BackEnd::removeDocument(const QString &dirname, const QString &filename){
    logMessage("Client is deleting the document: " + filename);
    _db.deleteFile(dirname,filename);
}

void BackEnd::editEventItem(const QString &dirname, const QString &filename, const QString &data) {
    logMessage("Client is editing an event");
    QString dd = _db.getFileData(filename,dirname);
    QJsonDocument doc = QJsonDocument::fromJson(dd.toUtf8());
    QJsonObject docobj = doc.object();
    QJsonObject from = QJsonDocument::fromJson(data.toUtf8()).object();
    QStringList ks = from.keys();
    QJsonArray arr = docobj["items"].toArray();
    for (int i = 0; i < arr.size(); i++) {
        QJsonObject ob = arr[i].toObject();
        if (ob["tag"] == from["tag"]) {
            bool changes = false;
            for (int b = 0; b < ks.length(); b++) {
                QString key = ks[b];
                if (ob.contains(key) && ob[key] != from[key]) changes = true;
                ob[key] = from[key];
            }
            if (changes) sendEmailEventEdited(arr[i].toObject(),from);
            arr.replace(i,ob);
            break;
        }
    }
    docobj["items"] = arr;
    doc.setObject(docobj);
    _db.modifyFile(dirname,filename,QString(doc.toJson(QJsonDocument::Compact)));
}

void BackEnd::createEventItem(const QString &dirname, const QString &filename, const QString &item) {
    logMessage("Client is adding a new event item");
    QString tag = getRandomTag(dirname,filename);
    QString data = _db.getFileData(filename,dirname);
    QJsonDocument doc = QJsonDocument::fromJson(data.toUtf8());
    QJsonObject mobj = doc.object();
    QJsonArray ar = mobj["items"].toArray();
    QJsonObject toadd = QJsonDocument::fromJson(item.toUtf8()).object();
    toadd["tag"] = tag;
    ar.append(toadd);
    mobj["items"] = ar;
    doc.setObject(mobj);
    _db.modifyFile(dirname,filename, QString(doc.toJson(QJsonDocument::Compact)));
    sendEmailEventAdded(item);
}



void BackEnd::removeEventItem(const QString &dirname, const QString &filename, const QString &item) {
    removeInventoryItem(dirname,filename,item);
    sendEmailEventRemoved(item);
}


void BackEnd::removePeople(const QString &dirname, const QString &data) {
    QJsonArray arr = QJsonDocument::fromJson(data.toUtf8()).object()["items"].toArray();
    for (int i = 0; i < arr.size(); i++) {
        QJsonObject obj = arr[i].toObject();
        _db.deleteFile(dirname,obj["filename"].toString());
    }

}

void BackEnd::editDocument(const QString &dirname, const QString &data) {
    QJsonDocument doc = QJsonDocument::fromJson(data.toUtf8());
    QJsonObject obj = doc.object();
    QString filename = obj["filename"].toString();
    obj.remove("filename");
    doc.setObject(obj);
    _db.modifyFile(dirname,filename,QString(doc.toJson(QJsonDocument::Compact)));
}



void BackEnd::sendEmailEventEdited(const QJsonObject &save, const QJsonObject &from) {
    if (_st.readProperty("scedit").toBool()) {
        if (_st.readProperty("semaccount").toString() != "" && _st.readProperty("sempassword").toString() != "") {
            QStringList emails = getEmailsFromObj(from);
            QString sb;
            if (save["date"].toString() != from["date"].toString()) sb.append("La date de l'evenements a ete changer. Il etait " + getDateString(save["date"].toString()) + ". L'evenements est maintenant ceduler pour, " + getDateString(from["date"].toString()) + "\n");
            if (save["hour"].toString() != from["hour"].toString()) sb.append("La nouvelle heur de l'evenements sera a: " + from["hour"].toString() + "\n");
            if (save["lieu"].toString() != from["lieu"].toString()) sb.append("L'evenements devait avoir lieu a " + save["lieu"].toString() + " mais il auras lieu finalement a " + from["lieu"].toString() + "\n\n");
            if (save["details"].toString() != from["details"].toString()) sb.append("Les details de l'evenements ont ete modifier: \n" + from["details"].toString());
            _em.sendEmail(_st.readProperty("semaccount").toString(),_st.readProperty("sempassword").toString(),emails, "Simi: Modification d'evenements | " + getDateString(save["date"].toString()),sb);
        }
    }
}

void BackEnd::sendEmailEventRemoved(const QString &objdeleted) {
    if (_st.readProperty("scremove").toBool()) {
        if (_st.readProperty("semaccount").toString() != "" && _st.readProperty("sempassword").toString() != "") {
            QJsonObject obj = QJsonDocument::fromJson(objdeleted.toUtf8()).object();
            QStringList emails = getEmailsFromObj(obj);
            _em.sendEmail(_st.readProperty("semaccount").toString(),_st.readProperty("sempassword").toString(),emails, "Simi: Evenement Annuler | " + getDateString(obj["date"].toString()), "L'evenements qui etait ceduler pour " + getDateString(obj["date"].toString()) + " a ete annuler, merci.");
        }
    }
}

void BackEnd::sendEmailEventAdded(const QString &item) {
    if (_st.readProperty("scremove").toBool()) {
        if (_st.readProperty("semaccount").toString() != "" && _st.readProperty("sempassword").toString() != "") {
            QJsonObject obj = QJsonDocument::fromJson(item.toUtf8()).object();
            QStringList emails = getEmailsFromObj(obj);
            _em.sendEmail(_st.readProperty("semaccount").toString(),_st.readProperty("sempassword").toString(),emails,"Simi: Nouvelle evenements | le " + getDateString(obj["date"].toString()), "L'evenements est ceduler a: " + obj["hour"].toString() + "\n A: " + obj["lieu"].toString() + "\n" + obj["details"].toString());
        }
    }
}

void BackEnd::appendSettings(const QJsonObject &obj) {
    logMessage("Client has made changes to the server settings.. Appending...");
    setSettings(obj);
}

void BackEnd::setSettings(const QJsonObject &settingsjs) {
    QStringList ks = settingsjs.keys();
    for (int i = 0; i < ks.length(); i++) {
        _st.writeProperty(ks[i],settingsjs[ks[i]]);
    }
}

QVariant BackEnd::getSetting(const QString &prop) {
    return _st.readProperty(prop).toVariant();
}

QString BackEnd::getSettings() {
    return _st.getSettings();
}

void BackEnd::sendEmailEventReminder() {
    if (_st.readProperty("scremind").toBool()) {
       QJsonArray arr = QJsonDocument::fromJson(_db.getFileData(eventfolder,eventfilename).toUtf8()).object()["items"].toArray();
       QDate date = QDateTime::currentDateTime().date();
       for (int i = 0; i < arr.size(); i++) {
           QJsonObject obj = arr[i].toObject();
           QStringList db = obj["date"].toString().split(":");
           if (db[0].toInt() == date.day() + 1 && db[1].toInt() == date.month() && db[1].toInt() == date.year()) {
               QStringList ppl = getEmailsFromObj(obj);
               QString pass = _st.readProperty("sempassword").toString();
               QString acc = _st.readProperty("semaccount").toString();
               if (pass != "" && acc != "") {
                   _em.sendEmail(acc,pass,ppl,"Simi: Rappel d'evenements | " + getDateString(obj["date"].toString()),"Ceci est un rappel que vous avez un evenements qui est ceduler a: " + obj["hour"].toString() + "\n A: " + obj["lieu"].toString() + "\n" + obj["details"].toString());
               }
           }
       }
    }
}


QStringList BackEnd::getEmailsFromObj(const QJsonObject &obj) {
    QStringList emails;
    QJsonArray arr = obj["people"].toArray();
    for (int i = 0; i < arr.size(); i++) {
        QJsonObject ob = arr[i].toObject();
        if (ob["email"].toString() != "") {
            emails.append(ob["email"].toString());
        }
    }
    return emails;
}

void BackEnd::serverActiveChanged(const bool &cond) {
    if (cond) {
        QTime time = QDateTime::currentDateTime().time();
        int mil = time.hour()*60 + time.minute()*60 + time.second()*1000 + time.msec();
        int val;
        if (mil <= 21600000) {
            val = 21600000 - mil;
        }else {
            val = 86400000 - mil + 21600000;
        }
        _tm->start(val);
    }else {
        _tm->stop();
    }
}

void BackEnd::timerTickSlot() {
    _tm->start(86400000);
    sendEmailEventReminder();
    backupDataFolders();

}

void BackEnd::backupDataFolders() {
    QStringList dirs;
    dirs.append(eventfolder);
    dirs.append(docsfolder);
    dirs.append(invfolder);
    dirs.append(invincfolder);
    dirs.append(incdocsfolder);
    dirs.append(peoplefolder);
    _db.backupFoldersWithDate(dirs,backupfolder);
}



QString BackEnd::getDateString(const QString &date) {
    QStringList st = date.split(":");
    QDate time = QDate(st[2].toInt(),st[1].toInt(),st[0].toInt());
    return time.toString("ddd dd MMMM yyyy");
}
