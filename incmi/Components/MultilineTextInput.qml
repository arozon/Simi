import QtQuick 2.9

Rectangle {
    color: enabled ? "white" : "#efefef"
    border.color: "silver"
    border.width: 1
    Behavior on color {
        ColorAnimation {
            duration: 300
        }
    }
    property string currentText: ""
    property int sideMargins: 10
    radius: 3
    height: 120
    width: parent.width
    TextInput {
        selectByMouse: true
        text: currentText
        wrapMode: Text.WordWrap
        anchors.margins: sideMargins
        anchors.fill: parent
        onTextChanged: {
            currentText = text;
        }

    }
}
