#include <algorithm>
#include "Words.h"

Words::Words()
{
};

Words::~Words()
{
};

void Words::appendString(QString& line)
{
    line = line.toLower().simplified(); // Removing extra spaces, tabs
    for (auto mark : {".", ",", ":", ";", "!", "?", "\""})
        line.remove(mark); // Remove punctuation marks
    for (auto word : line.split(QLatin1Char(' '), Qt::SkipEmptyParts))
    {
        // Get an iterator by value from mainMap
        // In this case, the values are unique
        auto it = std::find_if(std::begin(mainMap), std::end(mainMap),
           [word](std::pair<int, QString> targetPair) -> bool
        {
            return targetPair.second == word;
        });
        if (it != mainMap.end())
        {
            // The value is found, add to the key + 1 occurrence
            int newKey = it->first + 1;
            mainMap.erase(it);
            mainMap.insert(std::make_pair(newKey, word));
        }
        else
        {
            // New entry, add value to mainMap with key "1"
            mainMap.insert(std::make_pair(1, word));
        }
    }
}

void Words::prepareOutput()
{
    // Clearing previous results
    resultNumber.clear();
    resultLabel.clear();
    alphabetMap.clear();
    auto rIt = mainMap.rbegin();
    // Multimap sorted the words by key, so let's take the last 15 occurrences and add them to alphabetMap to sort alphabetically
    for (int i = 0; i < 15 && rIt != mainMap.rend(); ++rIt, ++i)
        alphabetMap.insert(std::make_pair(rIt->second, std::make_pair(rIt->first, rIt->second)));
    // If there are less than 15 words, then fill the remaining space with default values, that is (0, "none")
    for (int i = alphabetMap.size(); i < 15; i++)
        alphabetMap.insert(std::make_pair("zz", std::make_pair(0, "none"))); // ASCII code "z" is 122. No words starting with "zz"
    // Add the alphabetically sorted values to the resulting lists
    for (auto itAtalphabet = alphabetMap.begin(); itAtalphabet != alphabetMap.end(); ++itAtalphabet)
    {
        resultNumber.append(itAtalphabet->second.first);
        resultLabel.append(itAtalphabet->second.second);
    }
}

Words::operator QVariantList()
{
    return resultNumber;
}

QVariantList Words::getLabels()
{
    return resultLabel;
}
