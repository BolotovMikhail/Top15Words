#ifndef TOPWORDS_H
#define TOPWORDS_H

#include <QObject>
#include <QVariant>
#include <QString>
#include <QThread>
#include "TopWordsWorker.h"

/**
 * @brief The TopWords class provides the TopWordsWorker worker management which run in a separate thread
 * @brief Also, the class connects the QML level with c ++ logic
 */

class TopWords: public QObject
{
    Q_OBJECT

    QThread topWordsWorkerThread; // the thread to which the object of the TopWordsWorker class is moved
public:
    explicit TopWords(QObject *parent = nullptr);
    ~TopWords();

signals:
    /**
     * @brief updateChart - signal with ready data for updating the diagram
     * @brief Sent from TopWordsWorker when some part of data is ready
     * @param const QVariantList& numbers - refference to a list with alphabetically sorted number of occurrences of words
     * @param const QVariantList& labels - refference to a list with alphabetically sorted labels of occurrences of words
     */
    void updateChart(const QVariantList& numbers, const QVariantList& labels);
    /**
     * @brief errorReadingFile signal is sent when an error is caught while reading the file
     * @brief The error popup dialog will be called
     * @param QString error - description of the error that will be displayed on the popup error dialog
     */
    void errorReadingFile(const QString& error);
    /**
     * @brief startJob - signal that is associated with the TopWordsWorker::startJobSlot slot
     * @brief TopWordsWorker will start working
     * @brief The file path must be set by TopWordsWorker
     */
    void startJob();
    /**
     * @brief jobDone - signal is sent when the job is finished
     * @brief Contains the most relevant data for updating the chart
     * @brief Connects the TopWordsWorker::workIsCompleted signal to the onJobDone slot in QML
     * @param const QVariantList& numbers - refference to a most relevant list with alphabetically sorted number of occurrences of words
     * @param const QVariantList& labels - refference to a most relevant list with alphabetically sorted labels of occurrences of words
     */
    void jobDone(const QVariantList& numbers, const QVariantList& labels);

public slots:
    /**
     * @brief findTopWords - slot in which the TopWordsWorker object is created and passed the path to the file
     * @brief The created object is moved to the topWordsWorkerThread
     * @param const QString& path - received from file dialog
     */
    void findTopWords(const QString& path);
};

#endif // TOPWORDS_H
