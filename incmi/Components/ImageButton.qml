import QtQuick 2.8
import QtQuick.Controls 2.2

Button {
    property int trueWidth: implicitWidth + 28
    property int swidth: 24
    property int sheight: 24
    property alias source: im.source
    property int leftPad: (width - implicitWidth) / 2
    property int topPad: height - sheight
    leftPadding: swidth + 4
    clip: true
    Image {
        id: im
        x: (leftPad - swidth) / 2 < 4 ? 4 : (leftPad - swidth) / 2
        width: swidth
        height: sheight
        y: topPad < 0 ? 0 : topPad / 2
        fillMode: Image.PreserveAspectFit
        clip: true
    }
}

