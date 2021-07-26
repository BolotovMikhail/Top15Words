#ifndef WORDS_H
#define WORDS_H

#include <QVariant>
#include <QString>
#include <map>

/**
 * @brief The Words class provides methods for working with strings. Used by TopWordsWorker
 */

class Words
{
    // multimap<int, QString> is used to sort words by the number of occurrences
    std::multimap<int, QString> mainMap; // multimap<numbers, labels>
    // Saves the intermediate result for updating the chart.
    // Contains 15 occurrences sorted alphabetically
    std::multimap<QString, std::pair<int, QString>> alphabetMap;
    // Used to provide results
    QVariantList resultNumber, resultLabel;
public:
    Words();
    ~Words();

    /**
     * @brief appendString - fills mainMap with lowercase words
     * @brief Updates the number of already known words
     * @param QSting& line - reference to a raw line from a file
     */
    void appendString(QString& line);
    /**
     * @brief prepareOutput - helper function that sorts alphabetically,
     * @brief clears and fills resultNumber and resultLabel lists
     */
    void prepareOutput();
    /**
     * @brief getLabels - returns a list of the 15 most common words, sorted alphabetically
     * @return QVariantList
     */
    QVariantList getLabels();
    /**
     * @brief operator QVariantList - implements the conversion of a Words object
     * @brief to a QVariantList. Returns resultNumber
     */
    operator QVariantList();
};

#endif // WORDS_H
