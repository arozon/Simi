#ifndef EMAIL_H
#define EMAIL_H

#include <QObject>
#include <smtp.h>

class Email : public QObject
{
    Q_OBJECT
public:
    explicit Email(QObject *parent = nullptr);
    Q_INVOKABLE bool sendEmail(const QString &username, const QString &password, const QStringList &recepients, const QString &subject, const QString &body);
    Q_INVOKABLE bool sendEmailWithAttachment(const QString &username, const QString &password, const QStringList &recepients, const QString &subject, const QString &body, const QStringList &filepathwithname);

signals:

public slots:
};

#endif // EMAIL_H
