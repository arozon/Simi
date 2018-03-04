import QtQuick 2.0
import QtWebSockets 1.1
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    property int checkiheight: 50
    Material.accent: colora
    width: parent.width
    height: parent.height
    property string defstr;
    clip: true

    function ready () {
        upce.active = true;
    }

    function setModel(message) {
        if (defstr != "") {
            var current = new Date();
            var sl = []
            var obj = JSON.parse(message);
            for (var i = 0; i < obj.items.length; i++){
                var tobj = obj.items[i];
                var dd = Date.fromLocaleDateString(locale, tobj.date, 'dd:M:yyyy');

                if ((current.getFullYear() - dd.getFullYear()) > 0){
                    continue;
                }else if ((current.getMonth() - dd.getMonth()) > 0 && (current.getFullYear() - dd.getFullYear()) > -1) {
                    continue;
                }else if ((current.getDate() - dd.getDate()) > 0 && (current.getMonth() - dd.getMonth()) > -1){
                    continue;
                }

                //Date is before
                var inserted = false;
                for (var b = 0; b < sl.length; b++) {
                    var it = sl[b];
                    var tdate = Date.fromLocaleDateString(locale, it.date, 'dd:M:yyyy');
                    if ((tdate.getFullYear() - dd.getFullYear()) > 0){
                        sl.splice(b,0,tobj);
                        inserted = true;
                        break;
                    }else if ((tdate.getMonth() - dd.getMonth()) > 0 &&(tdate.getFullYear() - dd.getFullYear()) > -1) {
                        sl.splice(b,0,tobj);
                        sl.join();
                        inserted = true;
                        break;
                    }else{
                        if ((tdate.getDate() - dd.getDate()) > 0 && (tdate.getMonth() - dd.getMonth()) > -1){
                            sl.splice(b,0,tobj);
                            sl.join();
                            inserted = true;
                            break;
                        }
                    }
                }
                if(!inserted){
                    sl.push(tobj);
                }
            }

            for (var c = 0; c < sl.length; c++){
                var tb = sl[c]
                mod.append(tb);
            }
        }
    }

    function prevcheckChanged() {
        mod.clear();
        setModel(defstr);
        if (!cmed.checked){
            for (var b = mod.count; b > 0; b--){
                var objb = mod.get(b - 1);
                if (objb.type == "med"){
                    mod.remove(b-1);
                }
            }
        }
        if (!cinc.checked){
            for (var c = mod.count; c > 0; c--){
                var obj = mod.get(c - 1);
                if (obj.type == "inc"){
                    mod.remove(c-1);
                }
            }
        }
    }

    BaseSocket {
        port: sport
        host: shost
        id: upce
        onTextMessageReceived: {
            defstr = message;
            setModel(message);
            upce.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                var ms = JSON.parse('{"messageindex": "11","account":["",""]}');
                ms.account[0] = JSON.parse(settings.user).filename;
                ms.account[1] = settings.password;
                upce.sendTextMessage(JSON.stringify(ms));
                break;
            }
        }
    }


    ListView {
        id: typeview
        interactive: true
        width: parent.width
        height: parent.height - checkiheight
        clip: true
        model: ListModel {id: mod}
        delegate: EventDelegate {}
        spacing: 3
        add: Transition { NumberAnimation { properties: "x"; from: width; duration: 300; easing.type: Easing.OutQuad }}
        onCurrentIndexChanged: {
            // Change the values of the boxes.
        }
    }
    Rectangle {
        y: typeview.height
        height: checkiheight + 1
        width: parent.width + 2
        x: -1
        border.color: "grey"
        border.width: 1
        CheckBox {
            id: cmed
            height: parent.height
            width: cmed.implicitWidth + cinc.implicitWidth + 2*pad > parent.width ? (parent.width - 2*pad)/ 2 : implicitWidth
            x: parent.width - pad - width
            checked: true
            text: "Médical"
            onCheckedChanged: {
                prevcheckChanged();
            }
        }

        CheckBox {
            id: cinc
            height: parent.height
            width: cmed.implicitWidth + cinc.implicitWidth + 2*pad > parent.width ? (parent.width - 2*pad)/ 2 : implicitWidth
            x: cmed.x - width - 2*pad
            checked: true
            text: "Incendie"
            onCheckedChanged: {
                prevcheckChanged();
            }

        }
    }
}
