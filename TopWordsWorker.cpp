#include "TopWordsWorker.h"
#include <QThread>
#include <QFile>
#include <Words.h>

TopWordsWorker::TopWordsWorker()
{
}

TopWordsWorker::~TopWordsWorker()
{
}

void TopWordsWorker::setPath(const QString chosenPath)
{
    if (chosenPath.startsWith("file:///"))
        mPath = chosenPath.split("file:///")[1];
    else
        mPath = chosenPath;
}

void TopWordsWorker::startJobSlot()
{
    QFile file(mPath);
    Words words;
    try
    {
        if (file.exists() && (file.open(QIODevice::ReadOnly)))
        {
            int updateCounter = 0;
            // Read the file line by line to be able to update the diagram in "real" time
            while(!file.atEnd())
            {
                QString line = file.readLine();
                // Extract words from string and add them to multimap to sort by number of occurrences
                words.appendString(line);
                // Sorting the top 15 words alphabetically and preparing the resulting lists
                words.prepareOutput();
                // Sending intermediate top 15 words and their number of occurrences to update the diagram
                /* Little optimization:
                 * int counter = 0;
                 * in while increment counter
                 * and sending signals if (counter%20 == 0)
                 * this way, sorting will occur less frequently
                 */
                if (updateCounter%20 == 0)
                    emit someWorkIsReady(words, words.getLabels());
                updateCounter+=1;
            }
            file.close();
        }
        else
        {
            // If for some reason we could not open the file
            emit errorReadingFile("The file cannot be opened for reading");
        }
        emit workIsCompleted(words, words.getLabels());
    } catch (...)
    {
        file.close();
        emit errorReadingFile("Unexpected errors while reading the file");
    }
}
