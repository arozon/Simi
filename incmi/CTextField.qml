import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Rectangle {
    property alias textBox: tfield;
    property int lPad: 15
    color: "white"
    border.color: "grey"
    border.width: 1
    radius: 1
    clip: true;
    TextInput {
        id: tfield
        selectByMouse: true
        anchors.fill: parent
        anchors.margins: 3
        anchors.leftMargin: lPad
        verticalAlignment: Text.AlignVCenter
        text: ""
    }
}
