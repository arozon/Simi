import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1
import "../Components" as Comps
import "../Delegates" as Delegs
import "../Prompts" as Dialogs

Item {
    id: pcontrol
    property int pad: 5
    property int checkiheight: 50
    property bool contentEnabled: true
    property string bmodel
    property int viewSpacing: 4
    property int viewMargins: 5
    property bool check1: true
    property bool check2: true
    Material.accent: colora

    onCheck1Changed: {
        checkChanged();
    }

    onCheck2Changed: {
        checkChanged();
    }


    Connections {
        id: c
        target: window
        onDoEvents: {
            medsocket.active = true;
        }
    }

    function setModel() {
        if (bmodel != "") {
            var md = JSON.parse(bmodel);
            for (var i = 0; i < md.items.length; i++) {
                mod.append(md.items[i]);
            }
        }
    }

    function checkChanged() {
        mod.clear();
        setModel();
        if (!check1){
            for (var b = mod.count; b > 0; b--){
                var objb = mod.get(b - 1);
                if (objb.type == "docs"){
                    mod.remove(b-1);
                }
            }
        }
        if (!check2){
            for (var c = mod.count; c > 0; c--){
                var obj = mod.get(c - 1);
                if (obj.type == "inv"){
                    mod.remove(c-1);
                }
            }
        }
    }

    Comps.BaseSocket {
        id: medsocket
        host: shost
        port: sport
        onStatusChanged: {
            switch(status) {
            case WebSocket.Open:
                var ms = JSON.parse('{"messageindex":"1","account":["",""]}');
                ms.account[0] = JSON.parse(settings.user).filename;
                ms.account[1] = settings.password;
                medsocket.sendTextMessage(JSON.stringify(ms));
                break;
            }
        }
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            console.log(message);
            bmodel = message;
            for (var i = 0; i < obj.items.length; i++) {
                mod.append(obj.items[i]);
            }
            medsocket.active = false;
        }
    }

    Component.onCompleted: {
        var os = Qt.platform.os;
        if (os === "windows" || os === "linux" || os === "osx") {
            // Set windows design;

            listView.anchors.leftMargin = Qt.binding(function () {
                return pcontrol.width / 10;
            });
            listView.anchors.rightMargin = Qt.binding(function () {
                return pcontrol.width / 10;
            });
            listView.anchors.topMargin = Qt.binding(function () {
                return 15;
            });
            newdprompt.x = Qt.binding(function () {
               return pcontrol.width / 5;
            });
        }
    }

    ListView {
        id: listView
        spacing: viewSpacing
        enabled: contentEnabled
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: filterRect.top
            topMargin: viewMargins
            bottomMargin: viewMargins
        }
        delegate: Delegs.MedicalList {}
        model: ListModel {id: mod}
        add: Transition { NumberAnimation { properties: "x"; from: width; duration: 350; easing.type: Easing.OutQuad }}
    }

    Comps.ListPageHeader {
        id: header
        enabled: contentEnabled
        onFirstSelected: {
            contentEnabled = false;
            newdprompt.show();
        }
        onSecondSelected: {
            winchange(medinventory);
        }
    }
    Comps.DocumentTypeFilter {
        id: filterRect
        enabled: contentEnabled
        anchors {
            left: parent.left
            right: parent.right
            bottom: footer.top
            leftMargin: -1
            bottomMargin: -1
            rightMargin: -1
        }
        onFirstCheck: {
            check1 = st;
        }
        onSecondCheck: {
            check2 = st;
        }
    }
    Comps.BackPageFooter {
        id: footer
        enabled: contentEnabled
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        onBack: {
            winchange(login);
        }
    }

    Dialogs.EmptyPrompt {
        id: newdprompt
        Material.background: colora
        Material.elevation: 5
        x: parent.width / 24
        visibleY: parent.height / 4
        width: parent.width - 2*x
        height: parent.height / 2
        GridLayout {
            anchors.rightMargin: parent.width / 16
            anchors.leftMargin: parent.width / 16
            anchors.bottomMargin: parent.height / 6.5
            anchors.topMargin: parent.height / 6.5
            flow: GridLayout.TopToBottom
            columnSpacing: 2
            anchors.fill: parent
            Button {
                text: qsTr("Leger")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colorp
                onClicked: {
                    naturedoc = "1";
                    winchange(meddocrs);
                }
            }

            Button {
                text: qsTr("Moderer")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colorp
                onClicked: {
                    naturedoc = "2";
                    winchange(meddocrs);
                }
            }

            Button {
                text: qsTr("Annuler")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colorp
                onClicked: {
                    contentEnabled = true;
                    newdprompt.hide();
                }
            }

        }
    }
}
