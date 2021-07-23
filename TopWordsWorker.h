#ifndef TOPWORDSWORKER_H
#define TOPWORDSWORKER_H

#include <QObject>
#include <QVariant>

/**
 * @brief The TopWordsWorker class represents a worker that works in a separate thread
 * @brief This class uses methods of the Words class
 */

class TopWordsWorker: public QObject
{
    Q_OBJECT

    QString mPath; // File path, taken from the file dialog
public:
    TopWordsWorker();
    ~TopWordsWorker();

    /**
     * @brief setPath - removes the prefix, leaving a clean file path
     * @param chosenPath - selected path on file dialog
     */
    void setPath(const QString chosenPath);

public slots:
    /**
     * @brief startJob - slot that receives a signal to start work
     */
    void startJobSlot();

signals:
    /**
     * @brief someWorkIsReady - signal with ready data for updating the diagram
     * @brief Sent when some part of data is ready
     * @param const QVariantList& numbers - refference to a list with alphabetically sorted number of occurrences of words
     * @param const QVariantList& labels - refference to a list with alphabetically sorted labels of occurrences of words
     */
    void someWorkIsReady(const QVariantList& numbers, const QVariantList& labels);
    /**
     * @brief errorReadingFile signal is sent when an error is caught while reading the file
     * @brief The error popup dialog will be called
     * @param QString error - description of the error that will be displayed on the popup error dialog
     */
    void errorReadingFile(const QString& error);
    /**
     * @brief workIsCompleted - signal is sent when the job is finished
     * @brief Contains the most relevant data for updating the chart
     * @param const QVariantList& numbers - refference to a most relevant list with alphabetically sorted number of occurrences of words
     * @param const QVariantList& labels - refference to a most relevant list with alphabetically sorted labels of occurrences of words
     */
    void workIsCompleted(const QVariantList& numbers, const QVariantList& labels);
};

#endif // TOPWORDSWORKER_H
