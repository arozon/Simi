import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1
import "../Components" as Comps
import "../Delegates" as Delegs

Item {
    property int animationDuration: 250
    property alias modView: mod

    function ready() {
        invsocket.active = true;
    }

    signal newInventoryItem();
    signal viewInventoryPDF();

    Comps.BaseSocket {
        id: invsocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            for (var i = 0; i < obj.items.length; i++) {
                var item = obj.items[i];
                mod.append(item);
            }
            invsocket.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                var ms = JSON.parse('{"messageindex": "0","account":["",""]}');
                ms.account[0] = JSON.parse(settings.user).filename;
                ms.account[1] = settings.password;
                invsocket.sendTextMessage(JSON.stringify(ms));
                break;
            }

        }
    }

    ListView {
        clip: true
        id: invListView
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: adminFooter.top
        }
        headerPositioning: ListView.PullBackHeader
        header: Delegs.InventoryViewHeader {}
        spacing: 3
        delegate: Delegs.InventoryViewDelegate {}
        model: ListModel { id: mod}
        add: Transition { NumberAnimation { properties: "x"; from: width; duration: animationDuration; easing.type: Easing.OutQuad }}
    }

    Comps.TwoButtonAdminFooter {
        id: adminFooter
        visible: settings.isadmin
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            rightMargin: -1
            bottomMargin: -1
            leftMargin: -1
        }

        onFirstClicked: {
            newInventoryItem();
        }
        onSecondClicked: {
            viewInventoryPDF();
        }
    }
}
