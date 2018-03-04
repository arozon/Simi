#include "email.h"
#include "smtp.h"

Email::Email(QObject *parent) : QObject(parent)
{

}

bool Email::sendEmail(const QString &username, const QString &password, const QStringList &recepients, const QString &subject, const QString &body){
    for (int i = 0; i < recepients.count(); i++){
        Smtp* smpt = new Smtp(username,password,"smtp.gmail.com",465,200000);
        smpt->sendMail(username,recepients[i],subject,body);
    }
    return true;
}

bool Email::sendEmailWithAttachment(const QString &username, const QString &password, const QStringList &recepients, const QString &subject, const QString &body, const QStringList &filepathwithname){
    for (int i = 0; i < recepients.count(); i++){
        Smtp* smpt = new Smtp(username,password,"smtp.gmail.com",465,200000);
        smpt->sendMailWithAttachments(username,recepients[i],subject,body, filepathwithname);
    }
    return true;
}
