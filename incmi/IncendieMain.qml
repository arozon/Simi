import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

Rectangle {
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height
    property int pad: 5
    property int checkiheight: 50
    property string bmodel
    Material.accent: colora

    function setModel() {
        if (bmodel != "") {
            var md = JSON.parse(bmodel);
            for (var i = 0; i < md.items.length; i++) {
                var item = md.items[i];
                mod.append(item);
            }
        }
    }

    function checkChanged() {
        mod.clear();
        setModel();
        if (!cdocs.checked){
            for (var b = mod.count; b > 0; b--){
                var objb = mod.get(b - 1);
                if (objb.type == "docs"){
                    mod.remove(b-1);
                }
            }
        }
        if (!cinv.checked){
            for (var c = mod.count; c > 0; c--){
                var obj = mod.get(c - 1);
                if (obj.type == "inv"){
                    mod.remove(c-1);
                }
            }
        }
    }

    Connections {
        target: window
        onDoEvents: {
            incsocket.active = true;
        }
    }

    BaseSocket {
        id: incsocket
        host: shost
        port: sport
        onStatusChanged: {
            switch(status) {
            case WebSocket.Open:
                var ms = JSON.parse('{"messageindex":"21","account":["",""]}');
                ms.account[0] = JSON.parse(settings.user).filename;
                ms.account[1] = settings.password;
                incsocket.sendTextMessage(JSON.stringify(ms));
                break;
            }
        }
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            bmodel = message;
            for (var i = 0; i < obj.items.length; i++) {
                mod.append(obj.items[i]);
            }
            incsocket.active = false;
        }
    }
    Pane {
        id: header
        height: 110
        width: parent.width + 10
        x: - 5
        Material.elevation: 5
        Material.background: colordp
        GridLayout {
            anchors.fill: parent
            Image {
                Layout.maximumWidth: 150
                fillMode: Image.PreserveAspectFit
                source: "Images/ucmu_100h.png"
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

                CButton {
                    text: qsTr("Nouveau Dossier")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumHeight: 50
                    source: "Icons/ic_line_style_white_24dp.png"
                    Material.foreground: colorlt
                    Material.background: colordp
                    Material.elevation: 1
                    onClicked: {
                        winchange(incrapdoc);
                    }
                }
                CButton {
                    text: qsTr("Inventaire")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumHeight: 50
                    source: "Icons/ic_line_style_white_24dp.png"
                    Material.foreground: colorlt
                    Material.background: colordp
                    Material.elevation: 1
                    onClicked: {
                        // Set inventory window
                        winchange(incinventory);
                    }
                }
            }

        }
    }
    ColumnLayout {
        id: mview
        y: header.height + pad
        width: parent.width
        height: parent.height - header.height - pad
        spacing: 0.5
        ListView {
            clip: true
            id: listView
            spacing: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: IncendieMainDelegate {}
            model: ListModel {id: mod}
            add: Transition { NumberAnimation { properties: "x"; from: width; duration: 350; easing.type: Easing.OutQuad }}
        }
        Rectangle {
            Layout.minimumHeight: checkiheight
            Layout.maximumHeight: checkiheight
            Layout.fillHeight: true;
            Layout.fillWidth: true;
            Layout.bottomMargin: -1;
            Layout.rightMargin: -1;
            Layout.leftMargin: -1;
            border.color: "grey"
            border.width: 1
            CheckBox {
                id: cdocs
                height: parent.height
                width: cdocs.implicitWidth + cinv.implicitWidth + 2*pad > parent.width ? (parent.width - 2*pad)/ 2 : implicitWidth
                x: parent.width - pad - width
                checked: true
                text: "Rapport"
                onCheckedChanged: {
                    checkChanged();
                }
            }

            CheckBox {
                id: cinv
                height: parent.height
                width: cdocs.implicitWidth + cinv.implicitWidth + 2*pad > parent.width ? (parent.width - 2*pad)/ 2 : implicitWidth
                x: cdocs.x - width - 2*pad
                checked: true
                text: "Inventaire"
                onCheckedChanged: {
                    checkChanged();
                }
            }
        }

        Pane {
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
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: implicitWidth + 50
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: qsTr("Retour")
                    source: "Icons/ic_backspace_white_24dp.png"
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        winchange(login);
                    }
                }
            }
        }
    }
}
