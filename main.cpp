#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QThread>

#include <QLocale>
#include <QTranslator>

#include "TopWords.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QApplication app(argc, argv);

    app.setOrganizationName("noname");
    app.setOrganizationDomain("nodomain");

    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "Top15Words_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }

    TopWords topWords;
    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty("topWords", &topWords);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    QObject::connect(&engine, &QQmlApplicationEngine::quit, &QApplication::quit);

    engine.load(url);
    engine.thread()->setObjectName("GUI thread");

    return app.exec();
}
