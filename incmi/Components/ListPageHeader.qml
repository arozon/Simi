import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

Pane {
    height: 110
    width: parent.width + 10
    x: - 5
    Material.elevation: 3
    Material.background: colordp

    property string firstInputText: "Nouveau Dossier"
    property string secondInputText: "Inventaire"


    signal firstSelected
    signal secondSelected



    RowLayout {
        anchors.fill: parent
        Image {
            Layout.maximumWidth: 150
            fillMode: Image.PreserveAspectFit
            source: "../Images/ucmu_100h.png"
            Layout.minimumWidth: 100
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        ColumnLayout {
            width: 100
            height: 100
            Layout.maximumWidth: 250
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            ImageButton {
                text: firstInputText
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumHeight: 50
                source: "../Icons/ic_line_style_white_24dp.png"
                Material.foreground: colorlt
                Material.background: colordp
                Material.elevation: 1
                onClicked: {
                    firstSelected();
                }
            }
            ImageButton {
                text: secondInputText
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumHeight: 50
                source: "../Icons/ic_line_style_white_24dp.png"
                Material.foreground: colorlt
                Material.background: colordp
                Material.elevation: 1
                onClicked: {
                    secondSelected();
                }
            }
        }

    }
}
