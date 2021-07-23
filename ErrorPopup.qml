import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3

Popup {
    id: popup
    anchors.centerIn: parent
    width: 500
    height: 150
    padding: 0
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape

    property int maxWidth
    property alias messageHeader: errorText.text
    property alias bodyTextError: body.text

    Rectangle
    {
        id: popupContent
        focus: true
        width: popup.width
        height: popup.height
        color: "#fcfffc"
        border.color: "#a4b895"
        border.width: 1

        Keys.onPressed:
        {
            if (event.key == Qt.Key_Enter || event.key == Qt.Key_Return || event.key == Qt.Key_Space)
            {
                popup.close()
            }
        }

        Text
        {
            id: errorText
            font.pointSize: 16
            anchors.top: popupContent.top
            anchors.horizontalCenter: popupContent.horizontalCenter
            anchors.topMargin: 10
        }
        Text
        {
            id: body
            font.pointSize: 12
            font.bold: true
            anchors.top: errorText.top
            anchors.horizontalCenter: errorText.horizontalCenter
            anchors.topMargin: 45
        }
        Button
        {
            id: okButton
            anchors.bottom: popupContent.bottom
            anchors.horizontalCenter: popupContent.horizontalCenter
            anchors.bottomMargin: 10
            implicitHeight: 40
            implicitWidth: 120
            MouseArea
            {
                id: buttonOkMouseArea
                anchors.fill: okButton
                hoverEnabled: true
                onClicked:
                {
                    //topWords.findTopWords("this is must be path")
                    //mainWindow.operationInProgress = true;
                    popup.close()
                }
            }

            background: Rectangle
            {
                id: buttonOkBgColor
                border.width: 2
                color: buttonOkMouseArea.pressed ? "#9c6a60" : "#c9aea9"
                border.color: buttonOkMouseArea.containsMouse ? "#472119" : "#9e3723"
                radius: 7
            }
            Text
            {
                anchors.centerIn: buttonOkMouseArea
                font.pointSize: 14
                text: qsTr("Ok")
                color: "#041329"
            }
            //callback: function() { root.close() }
            activeFocusOnTab: true
        }
    }
}
