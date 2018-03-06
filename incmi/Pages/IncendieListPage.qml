import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1
import "../Components" as Comps
import "../Delegates" as Delegs

Item {
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height
    property int pad: 5
    property int checkiheight: 50
    property int viewSpacing: 4
    property int viewMargins: 5
    property bool check1: false
    property bool check2: false
    property string bmodel
    Material.accent: colora


    onCheck1Changed: {
        checkChanged();
    }

    onCheck2Changed: {
        checkChanged();
    }

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
        if (!check1.checked){
            for (var b = mod.count; b > 0; b--){
                var objb = mod.get(b - 1);
                if (objb.type == "docs"){
                    mod.remove(b-1);
                }
            }
        }
        if (!check2.checked){
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

    Comps.BaseSocket {
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
    ListView {
        clip: false
        id: listView
        spacing: viewSpacing

        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: filterRect.top
            topMargin: viewMargins
            bottomMargin: viewMargins
        }

        delegate: Delegs.IncendieList {}
        model: ListModel {id: mod}
        add: Transition { NumberAnimation { properties: "x"; from: width; duration: 350; easing.type: Easing.OutQuad }}
    }
    Comps.ListPageHeader {
        id: header
        onFirstSelected: {
            winchange(incrapdoc);
        }
        onSecondSelected: {
            winchange(incinventory);
        }
    }
    Comps.DocumentTypeFilter {
        id: filterRect
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
        height: 60
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        onBack: {
            winchange(login);
        }
    }
}
