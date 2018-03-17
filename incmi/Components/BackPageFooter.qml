import QtQuick 2.9
import QtQuick.Controls.Material 2.2
import QtQuick.Controls 2.2

Pane {
    property int buttonMargin: 10
    height: 66
    signal back()
    Material.background: "#0288D1"
    ImageButton {
        x: buttonMargin
        width: parent.width < 2 * buttonMargin + trueWidth ? parent.width - 2*buttonMargin: trueWidth
        height: implicitHeight
        anchors {
            verticalCenter: parent.verticalCenter
        }
        text: "Retour"
        source: "../Icons/ic_backspace_white_24dp.png"
        Material.foreground: colorlt
        Material.background: colordp
        onClicked: {
            back();
        }
    }
}
