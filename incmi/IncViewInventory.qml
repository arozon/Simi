import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

Rectangle {
    property string currentInvItem
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height

    function itemDoubleClicked(obj) {
        currentInvItem = JSON.stringify(obj);
        ldview.push(ledit);
        footer.enabled = false;
    }

    function removeInvItem(obj) {
        obj["messageindex"] = "26";
        var message = JSON.stringify(obj);
        addMessage(message);
        sendSavedInformation();
        ldview.push(lmain);
        footer.enabled = true;
    }

    function editInvItem(obj) {
        obj["messageindex"] = "27";
        var message = JSON.stringify(obj);
        addMessage(message);
        sendSavedInformation();
        ldview.push(lmain);
        footer.enabled = true;
    }

    function cancelInvEdit() {
        ldview.push(lmain);
        footer.enabled = true;
    }

    function newInvItem() {
        ldview.push(lnew);
        footer.enabled = false;
    }

    function cancelNew() {
        ldview.push(lmain);
        footer.enabled = true;
    }

    function addInvItem(obj) {
        var message = JSON.stringify(obj);
        message = message.slice(0,-1) + ',"messageindex":"28"}';
        addMessage(message);
        sendSavedInformation();
        ldview.push(lmain);
        footer.enabled = true;
    }

    Component {
        id: lmain
        IncViewInventoryList {}
    }

    Component {
        id: ledit
        ViewEditInventoryItem {}
    }

    Component {
        id: lnew
        ViewCreateInventoryItem {}
    }

    Connections {
        target: window
        onDoEvents: {
            ldview.currentItem.ready();
        }
    }

    ColumnLayout {
        id: columnLayout
        spacing: 0.5
        anchors.fill: parent
        StackView {
            id: ldview
            clip: true;
            Layout.fillHeight: true
            Layout.fillWidth: true
            initialItem: lmain
            onBusyChanged: {
                if (!busy) {
                    ldview.currentItem.ready();
                }
            }
        }

        Pane {
            id: footer
            width: parent.width
            height: 70
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 70
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.background: "#0288D1"
            RowLayout {
                anchors.fill: parent
                CButton {
                    text: qsTr("Retour")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    source: "Icons/ic_backspace_white_24dp.png"
                    onClicked: {
                        winchange(incm);
                    }
                }
                CButton {
                    text: qsTr("Ajustement")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.maximumWidth: 160
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    source: "Icons/ic_note_add_white_24dp.png"
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        winchange(incadjinc);
                    }
                }
            }
        }
    }

}
