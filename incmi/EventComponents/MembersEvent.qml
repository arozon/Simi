import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1
import "../Components" as Comps
import "../Delegates" as Delegs

Item {
    property int pad: 5
    property int footerheight: 70
    property int sidePadding: ld.contentMargins !== 0 ? ld.contentMargins : pad

    function ready() {
        memberssocket.active = true;
    }

    Comps.BaseSocket {
        id: memberssocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            for (var i = 0; i < obj.items.length; i++){
                var t = obj.items[i];
                mod.append(obj.items[i]);
            }
            memberssocket.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                memberssocket.sendTextMessage('{"messageindex": "5"}');
                break;
            case WebSocket.Error:
                console.log(errorString);
                break;
            }
        }
    }


    ListView {
        clip: true
        interactive: true
        spacing: 1
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: footer.top
            margins: pad
            rightMargin: sidePadding
            leftMargin: sidePadding
        }

        model: ListModel { id: mod}
        delegate: Delegs.EventMember {}
    }

    Item {
        id: footer
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: pad
        }

        height: footerheight
        Button {
            height: implicitHeight
            width: implicitWidth > parent.width - 2 * pad ? parent.width - 2 * pad : implicitWidth
            anchors {
                right: parent.right
                margins: pad
                verticalCenter: parent.verticalCenter
            }

            text: "Confirm"
            Material.foreground: colorlt
            Material.background: colorp

            onClicked: {
                doneMembers();
            }
        }
    }

}
