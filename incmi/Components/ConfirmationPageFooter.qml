import QtQuick 2.9
import QtQuick.Controls.Material 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Pane {
    property int buttonMargin: 10
    height: 70
    signal cancel()
    signal confirm()
    Material.background: "#0288D1"
    GridLayout {
        rows: 1
        columns: 2
        anchors.fill: parent
        ImageButton {
            id: cancelbutton
            text: "Annuler"
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.maximumWidth: 150
            Layout.maximumHeight: implicitHeight
            Layout.minimumHeight: implicitHeight
            Layout.fillWidth: true
            Layout.fillHeight: true
            Material.foreground: colorlt
            Material.background: "#006da9"
            source: "../Icons/ic_highlight_off_white_24dp.png"
            onClicked: {
                cancel();
            }
        }
        ImageButton {
            text: "Envoyer"
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: 150
            Layout.maximumHeight: implicitHeight
            Layout.minimumHeight: implicitHeight
            Material.foreground: colorlt
            Material.background: "#006da9"
            source: "../Icons/ic_cloud_upload_white_24dp.png"
            onClicked: {
                confirm();
            }
        }
    }
}
