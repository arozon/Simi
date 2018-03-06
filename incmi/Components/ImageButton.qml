import QtQuick 2.8
import QtQuick.Controls 2.2

Button {
    property int trueWidth: implicitWidth + leftPadding
    property int swidth: 24
    property int sheight: 24
    property alias source: im.source
    property int topPad: height - sheight
    property int displayposition: 4
    onWidthChanged: {
        if ((((width - implicitWidth)/2) - swidth)/2 < 4){
            displayposition = 4;
        } else {
            displayposition = (((parent.width - parent.implicitWidth) / 2) - swidth) / 2;
        };
    }

    leftPadding: swidth + 4
    clip: true
    Image {
        id: im
        x: displayposition
        width: swidth
        height: sheight
        y: topPad < 0 ? 0 : topPad / 2
        fillMode: Image.PreserveAspectFit
    }
}

