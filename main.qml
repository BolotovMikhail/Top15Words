import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtCharts 2.15
import QtQml 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.0

Window
{
    id: mainWindow
    minimumWidth: 900
    minimumHeight: 700
    visible: true
    title: qsTr("Top 15 words")

    property bool operationInProgress: false // true if the operation is to find words in progress
    property bool openFileDialog: false // it is set to true by clicking on the "Choose file" button. A file dialog opens.
    property bool updateDelay: false // set to true when the timer interval is reached. Needed for smooth chart updates.
    property int chartMaxScale: 2 // default value

    Timer
    {
        interval: 500; running: true; repeat: true
        onTriggered: mainWindow.updateDelay = true
    }

    Connections
    {
        target: topWords
        function onUpdateChart(numbers, labels)
        {
            // Word counts and labels come in sorted order so that numbers[0] match labels[0]
            if (mainWindow.updateDelay)
            {
                updateChart(numbers, labels)
                mainWindow.updateDelay = false
            }
        }
        function onJobDone(numbers, labels)
        {
            updateChart(numbers, labels)
            mainWindow.operationInProgress = false
        }
        function onErrorReadingFile(error)
        {
            errorPopup.messageHeader = "Some errors occurred while reading the file"
            errorPopup.bodyTextError = error
            errorPopup.visible = true
            mainWindow.operationInProgress = false
        }
    }

    GridLayout
    {
        anchors.fill: parent
        anchors.margins: 10
        columns: 1
        rows: 2

        Rectangle
        {
            id: rectangle1
            Layout.fillWidth: true
            Layout.fillHeight: true
            width: 800
            height: 660

            ChartView
            {
                id: myChart
                Text
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 18
                    text: qsTr("The most frequent words:")
                    color: "#041329"
                }
                theme: ChartView.ChartThemeLight
                anchors.fill: rectangle1
                legend.alignment: Qt.AlignBottom
                antialiasing: true
                animationOptions: ChartView.SeriesAnimations
                animationDuration: 350

                ValueAxis
                {
                    id: axisY
                    min: 0
                    max: mainWindow.chartMaxScale
                    labelsFont.pointSize: 10
                    labelsColor: "#041329"
                }

                StackedBarSeries
                {
                    id: mySeries
                    axisX: BarCategoryAxis { categories: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"];
                        labelsColor: "#041329"; labelsFont.pointSize: 10}
                    axisY: axisY
                    BarSet{ id: top1Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        borderWidth: 2; borderColor: "#1683b8"}
                    BarSet{ id: top2Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        borderWidth: 2; borderColor: "#769c3e"}
                    BarSet{ id: top3Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        borderWidth: 2; borderColor: "#cf8d1b"}
                    BarSet{ id: top4Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        borderWidth: 2; borderColor: "#594db0"}
                    BarSet{ id: top5Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        borderWidth: 2; borderColor: "#99472f"}
                    BarSet{ id: top6Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        borderWidth: 2; borderColor: "#095173"}
                    BarSet{ id: top7Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        borderWidth: 2; borderColor: "#536e2b"}
                    BarSet{ id: top8Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        borderWidth: 2; borderColor: "#78500b"}
                    BarSet{ id: top9Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        borderWidth: 2; borderColor: "#3b3278"}
                    BarSet{ id: top10Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        borderWidth: 2; borderColor: "#6b2e1e"}
                    BarSet{ id: top11Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        color: "#d57ae6"; borderWidth: 2; borderColor: "#bb6bc9"}
                    BarSet{ id: top12Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        color: "#7b877d"; borderWidth: 2; borderColor: "#6b756d"}
                    BarSet{ id: top13Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        color: "#afc452"; borderWidth: 2; borderColor: "#9bad49"}
                    BarSet{ id: top14Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        color: "#b82e1f"; borderWidth: 2; borderColor: "#9c271a"}
                    BarSet{ id: top15Word; label: "none"; values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                        color: "#6adec1"; borderWidth: 2; borderColor: "#5cbfa6"}
                }
            }
        }

        Button
        {
            id: buttonOpenFile
            Layout.alignment: Qt.AlignCenter
            implicitHeight: 40
            implicitWidth: 200
            enabled: !mainWindow.operationInProgress
            MouseArea
            {
                id: buttonOpenFileMouseArea
                anchors.fill: buttonOpenFile
                hoverEnabled: true
                onClicked:
                {
                    // call file dialog
                    mainWindow.openFileDialog = true
                }
            }

            background: Rectangle
            {
                id: buttonOpenFileBgColor
                border.width: 2
                color: mainWindow.operationInProgress ? "#a6a6a6" : (buttonOpenFileMouseArea.pressed ? "#a9bfc9" : "#d5e4e6")
                border.color: buttonOpenFileMouseArea.containsMouse ? "#1d3661" : "#6b8f7a"
                radius: 7
            }
            Text
            {
                anchors.centerIn: buttonOpenFileMouseArea
                font.pointSize: 14
                text: qsTr("Choose file")
                color: "#041329"
            }
            Layout.fillHeight: true
        }

        Rectangle
        {
            id: spinner
            anchors.right: buttonOpenFile.left
            anchors.bottom: buttonOpenFile.verticalCenter
            anchors.rightMargin: -10
            anchors.bottomMargin: 14
            visible: mainWindow.operationInProgress
            ProgressSpinner
            {
                id: progressSpinner
                lineThickness: 5
                fillValue: 0.3
                size: 30
            }
            PropertyAnimation
            {
                id: rotationProgressSpinner
                duration: 1000
                target: progressSpinner
                property: "rotation"
                from: 0
                to: 360
                loops: Animation.Infinite
                running: mainWindow.operationInProgress
            }
        }
    }

    ErrorPopup
    {
        id: errorPopup
        maxWidth: mainWindow.width - 4
    }

    FileDialog
    {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        visible: mainWindow.openFileDialog
        onAccepted:
        {
            mainWindow.operationInProgress = true
            mainWindow.openFileDialog = false
            topWords.findTopWords(fileDialog.fileUrls)
        }
        onRejected:
        {
            console.log("Canceled")
            mainWindow.openFileDialog = false
        }
    }

    function findScale(list)
    {
        var max = list[0];
        list.forEach(function(obj)
        {
            max = obj > max ? obj : max
        });
        return max
    }

    function updateChart(numbers, labels)
    {
        // Finding the maximum number from the set for changing the scale of the chart
        mainWindow.chartMaxScale = mainWindow.findScale(numbers)

        // Updating the word count in a chart
        top1Word.replace(0, numbers[0])
        top2Word.replace(1, numbers[1])
        top3Word.replace(2, numbers[2])
        top4Word.replace(3, numbers[3])
        top5Word.replace(4, numbers[4])
        top6Word.replace(5, numbers[5])
        top7Word.replace(6, numbers[6])
        top8Word.replace(7, numbers[7])
        top9Word.replace(8, numbers[8])
        top10Word.replace(9, numbers[9])
        top11Word.replace(10, numbers[10])
        top12Word.replace(11, numbers[11])
        top13Word.replace(12, numbers[12])
        top14Word.replace(13, numbers[13])
        top15Word.replace(14, numbers[14])

        // Updating chart labels
        top1Word.label = labels[0]
        top2Word.label = labels[1]
        top3Word.label = labels[2]
        top4Word.label = labels[3]
        top5Word.label = labels[4]
        top6Word.label = labels[5]
        top7Word.label = labels[6]
        top8Word.label = labels[7]
        top9Word.label = labels[8]
        top10Word.label = labels[9]
        top11Word.label = labels[10]
        top12Word.label = labels[11]
        top13Word.label = labels[12]
        top14Word.label = labels[13]
        top15Word.label = labels[14]
    }
}
