import QtQuick 2.9
import QtQuick.Controls.Material 2.2
import QtQuick.Controls 2.2

Pane {
    property alias headerText: lab.text
    height: 33
    Material.elevation: 1
    Material.background: colordp
    Label {
        id: lab
        width: parent.width - 10 < 0 ? 0 : parent.width - 10
        x: 5
        y: 2
        height: parent.height - 4 < 0 ? 0 : parent.height - 4
        text: tt
        elide: "ElideRight"
        color: colorlt
        verticalAlignment: Text.AlignVCenter
        leftPadding: parent.width / 16
        horizontalAlignment: Text.AlignLeft
    }
}
