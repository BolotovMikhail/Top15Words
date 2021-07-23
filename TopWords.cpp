#include "TopWords.h"

TopWords::TopWords(QObject* parent) : QObject(parent)
{
    topWordsWorkerThread.setObjectName("TopWordsWorkerThread");
}

TopWords::~TopWords()
{
    topWordsWorkerThread.quit();
    topWordsWorkerThread.wait(7000);
    if (topWordsWorkerThread.isRunning())
    {
        topWordsWorkerThread.terminate();
    }
}

void TopWords::findTopWords(const QString& path)
{

    TopWordsWorker* worker = new TopWordsWorker;
    worker->setPath(path);
    worker->moveToThread(&topWordsWorkerThread);

    connect(worker, &TopWordsWorker::someWorkIsReady, this, &TopWords::updateChart);
    connect(worker, &TopWordsWorker::workIsCompleted, this, &TopWords::jobDone);
    connect(worker, &TopWordsWorker::errorReadingFile, this, &TopWords::errorReadingFile);
    connect(worker, &TopWordsWorker::workIsCompleted, worker, &QObject::deleteLater);
    connect(this, &TopWords::startJob, worker, &TopWordsWorker::startJobSlot);

    topWordsWorkerThread.start();

    emit startJob();
}
