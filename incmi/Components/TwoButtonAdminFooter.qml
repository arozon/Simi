import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

Rectangle {
    id: rectangle
    property alias firstButton: button1
    property alias secondButton: button2
    property int sideMargins: 4
    height: 52
    width: parent.width
    border.color: "grey"
    border.width: 1
    signal firstClicked();
    signal secondClicked();
    RowLayout {
        property int childrenWidth: button1.trueWidth + button2.trueWidth + spacing
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            rightMargin: sideMargins
            leftMargin: sideMargins
        }
        width: childrenWidth > parent.width ? parent.width : childrenWidth
        ImageButton {
            id: button1
            text: "Ajouter"
            Layout.preferredWidth: trueWidth
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.maximumWidth: trueWidth
            Layout.maximumHeight: implicitHeight
            Layout.fillHeight: true
            Layout.fillWidth: true
            source: "../Icons/ic_add_circle_white_24dp.png"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                firstClicked()
            }
        }
        ImageButton {
            id: button2
            text: "Inventaire"
            Layout.preferredWidth: trueWidth
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.maximumWidth: trueWidth
            Layout.maximumHeight: implicitHeight
            Layout.fillHeight: true
            Layout.fillWidth: true
            source: "../Icons/ic_description_white_24dp.png"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                secondClicked();
            }
        }

    }
}
