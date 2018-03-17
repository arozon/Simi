import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1
import "../Components" as Comps

ViewInventoryListBase {

    onNewInventoryItem: {
        newInvItem();
    }

    onViewInventoryPDF: {
        getDocImage("","invtot");
    }

    function ready() {
        invsocket.active = true;
    }

    Comps.BaseSocket {
        id: invsocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            for (var i = 0; i < obj.items.length; i++) {
                var item = obj.items[i];
                modView.append(item);
            }
            invsocket.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                var ms = JSON.parse('{"messageindex": "29","account":["",""]}');
                ms.account[0] = JSON.parse(settings.user).filename;
                ms.account[1] = settings.password;
                invsocket.sendTextMessage(JSON.stringify(ms));
                break;
            }

        }
    }
}
