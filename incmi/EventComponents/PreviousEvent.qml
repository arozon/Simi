import QtQuick 2.0
import QtWebSockets 1.1
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "../Components" as Comps

EventBase {
    function ready () {
        preve.active = true;
    }

    function setModel(message) {
        if (defstr != "") {
            var current = new Date();
            var sl = []
            var obj = JSON.parse(message);
            for (var i = 0; i < obj.items.length; i++){
                var tobj = obj.items[i];
                var dd = Date.fromLocaleDateString(locale, tobj.date, 'dd:M:yyyy');

                if ((dd.getFullYear() - current.getFullYear()) > 0){
                    continue;
                }else if ((dd.getMonth() - current.getMonth()) > 0 && (dd.getFullYear() - current.getFullYear()) > -1) {
                    continue;
                }else if ((dd.getDate() - current.getDate()) > 0 && (dd.getMonth() - current.getMonth()) > -1){
                    continue;
                }
                var inserted = false;
                for (var b = 0; b < sl.length; b++) {
                    var it = sl[b];
                    var tdate = Date.fromLocaleDateString(locale, it.date, 'dd:M:yyyy');
                    if ((dd.getFullYear() - tdate.getFullYear()) > 0){
                        sl.splice(b,0,tobj);
                        inserted = true;
                        break;
                    }else if ((dd.getMonth() - tdate.getMonth()) > 0 &&(dd.getFullYear() - tdate.getFullYear()) > -1) {
                        sl.splice(b,0,tobj);
                        sl.join();
                        inserted = true;
                        break;
                    }else{
                        if ((dd.getDate() - tdate.getDate()) > 0 && (dd.getMonth() - tdate.getMonth()) > -1){
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
        id: preve
        onTextMessageReceived: {
            defstr = message;
            setModel(message);
            preve.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                var ms = JSON.parse('{"messageindex": "11","account":["",""]}');
                ms.account[0] = JSON.parse(settings.user).filename;
                ms.account[1] = settings.password;
                preve.sendTextMessage(JSON.stringify(ms));
                break;
            }
        }
    }
}
