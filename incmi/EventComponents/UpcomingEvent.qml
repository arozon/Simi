import QtQuick 2.0
import QtWebSockets 1.1
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "../Components" as Comps

EventBase {
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
                viewModel.append(tb);
            }
        }
    }

    Comps.BaseSocket {
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
}
