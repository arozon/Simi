#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QHostInfo>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseDesktopOpenGL,true);
    QGuiApplication app(argc, argv);
    QCoreApplication::setOrganizationName("ARproductions");
    QCoreApplication::setOrganizationDomain("simi.com");
    QCoreApplication::setApplicationName("Simi_Client");
    QHostAddress info = QHostInfo::fromName("sgci.ddns.net").addresses()[0];
    QQmlApplicationEngine engine;
    //engine.rootContext()->setContextProperty("shost","192.168.0.108");
    //engine.rootContext()->setContextProperty("sport",443);

    engine.rootContext()->setContextProperty("shost",info.toString());
    engine.rootContext()->setContextProperty("sport",30000);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (!engine.rootObjects().isEmpty()) {

    }else {
        return -1;
    }
    return app.exec();
}
