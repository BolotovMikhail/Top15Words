import QtQuick 2.0

Item {
    id: spinner

    property int size: 100
    property int lineThickness: 7
    property real fillValue: 0

    property color mainColor: "#27a854"
    property color backgroundColor: "#a9bfc9"
    width: size
    height: size

    onFillValueChanged: {
        canvas.angle = fillValue * 360;
    }

    Canvas {
        id: canvas

        property real angle: 0

        anchors.fill: parent
        antialiasing: true

        onAngleChanged: {
            requestPaint();
        }

        onPaint: {
            var context = getContext("2d");

            var x = spinner.width/2;
            var y = spinner.height/2;

            var radius = spinner.size/2 - spinner.lineThickness
            var startingAngle = (Math.PI/180) * 270;
            var fullCircle = (Math.PI/180) * (270 + 360);
            var dynamicAngle = (Math.PI/180) * (270 + angle);

            context.reset()

            context.lineCap = 'round';
            context.lineWidth = spinner.lineThickness;

            context.beginPath();
            context.arc(x, y, radius, startingAngle, fullCircle);
            context.strokeStyle = spinner.backgroundColor;
            context.stroke();

            context.beginPath();
            context.arc(x, y, radius, startingAngle, dynamicAngle);
            context.strokeStyle = spinner.mainColor;
            context.stroke();
        }
    }
}
