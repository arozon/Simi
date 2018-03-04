import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Rectangle {
    property string currentText: ""
    property bool padBothSides: false
    property int sidePadding: 15
    property alias input: inp

    Behavior on color {
        ColorAnimation {
            duration: 300
        }
    }
    onEnabledChanged: {
        switch (enabled) {
        case true:
            color =  "white";
            break;
        case false:
            color = "#efefef"
        }
    }

    color: "white"
    border.color: "grey"
    border.width: 1
    radius: 1
    clip: true
    TextInput {
        id: inp
        focus: true
        selectByMouse: true
        anchors {
            fill: parent
            margins: 3
            leftMargin: sidePadding
            rightMargin: padBothSides ? sidePadding : 15
        }
        verticalAlignment: Text.AlignVCenter
        text: currentText
        onTextChanged: {
            currentText = text;
        }
    }
}
