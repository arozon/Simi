import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1

Item {
    width: parent.width
    height: parent.height
    property int nrectheight: 52
    property int pad: 5
    clip: true

    function ready() {
        invsocket.active = true;
    }

    BaseSocket {
        port: sport
        host: shost
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
                var ms = JSON.parse('{"messageindex": "29","account":["",""]}')
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
        x: 0
        y: 0
        width: parent.width
        height: settings.isadmin ? parent.height - nrectheight : parent.height
        headerPositioning: ListView.PullBackHeader
        orientation: ListView.Vertical
        flickableDirection: Flickable.VerticalFlick
        header: IncInvViewHeader {}
        spacing: 3
        delegate: IncInvViewDelegate {}
        model: ListModel { id: mod}
        add: Transition { NumberAnimation { properties: "x"; from: width; duration: 250; easing.type: Easing.OutQuad }}
    }
    Rectangle {
        height: nrectheight + 1
        width: parent.width + 2
        x: -1
        y: parent.height - nrectheight
        visible: settings.isadmin
        border.color: "grey"
        border.width: 1
        CButton {
            id: nb
            width: nc.implicitWidth + nb.implicitWidth + 3*pad > parent.width? (parent.width - 3*pad) / 2 : implicitWidth
            height: parent.height - pad
            y: pad / 2
            x: parent.width - width - pad
            text: "Ajouter"
            source: "Icons/ic_add_circle_white_24dp.png"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                newInvItem();
            }
        }
        CButton {
            id: nc
            width: nc.implicitWidth + nb.implicitWidth + 3*pad > parent.width ? (parent.width - 3*pad) / 2 : implicitWidth
            height: parent.height - pad
            x: nb.x - width - pad
            y: pad / 2
            text: "Inventaire"
            source: "Icons/ic_description_white_24dp.png"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                getDocImage("","invinctot");
            }
        }

    }
}
