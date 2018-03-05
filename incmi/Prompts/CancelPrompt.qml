import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

BasePrompt {
    property int labelMargin: parent.width / 8
    property int rowHeight: 60
    property string labelText: "Êtes vous sur de vouloir quitter? Les changements non sauvegarder seronts effacer.."
    property string cancelText: "Non"
    property string confirmText: "Oui"
    signal cancelDialog()
    signal confirmDialog()

    Material.background: colora
    Material.elevation: 8
    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: parent.width/15
        anchors.rightMargin: parent.width/15
        anchors.bottomMargin: (parent.height/20) * 3
        anchors.topMargin: (parent.height/20) * 3
        spacing: 5
        Label {
            text: labelText
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap
            Layout.maximumHeight: 50
            Layout.fillHeight: true
            Layout.fillWidth: true
            font.pointSize: 14
            Material.foreground: colorlt
        }
        RowLayout{
            spacing: 15
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.maximumHeight: 50
            Button {
                text: cancelText
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colorp
                onClicked: {
                    mview.enabled = true;
                    promptconfirmleave.hide();
                }
            }
            Button {
                text: confirmText
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colorp
                onClicked: {
                    winchange(medimain);
                }
            }
        }
    }
}
