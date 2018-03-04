import QtQuick 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.2
import Qt.labs.calendar 1.0

Item {
    width: parent.width
    height: parent.height
    Rectangle {
        id: rect
        anchors.fill: parent
        antialiasing: false
        border.width: 1
        color: "black"
        clip: true
        TextEdit {
            id: textArea
            text: textboxt
            x: 10
            y: 10
            width: parent.width - 20
            height: parent.height - 20
            color: "white"
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.pointSize: 10
            enabled: false
            onContentHeightChanged: {
                if (contentHeight > height) {
                    y = height - contentHeight;
                }else {
                    y = 0;
                }
            }
            onHeightChanged: {
                if (contentHeight > height) {
                    y = height - contentHeight;
                }else {
                    y = 0;
                }
            }
        }
    }
}

