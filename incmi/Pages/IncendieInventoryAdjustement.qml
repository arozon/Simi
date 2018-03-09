import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1
import "../Components" as Comps

InvertoryAdjustmentBase {
    function saveData(){
        var tsend = JSON.parse('{"messageindex":"30","matricule":"","type":"inv","name":"","date":"","filename":"","items":[]}');
        for (var i = 0; i < viewModel.count; i++) {
            var item = viewModel.get(i);
            if (parseInt(item.difference) != 0) {
                var temp = JSON.parse('{"name":"","count":"","rcount":"","tag":"","difference":""}');
                temp.name = item.name;
                temp.rcount = item.rcount
                temp.tag = item.tag;
                temp.difference = item.difference;
                temp.count = (parseInt(item.count) + parseInt(item.difference)).toString();
                tsend.items.push(JSON.stringify(temp));
            }
        }
        tsend.name = getFullName();
        tsend.matricule = getMatricule();
        tsend.date = new Date().toLocaleDateString(Qt.locale(),"dd:M:yyyy");
        addMessage(JSON.stringify(tsend));
        sendSavedInformation();

    }

    Comps.BaseSocket {
        id: adjsocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
                //Correct object..
                for (var i = 0; i < obj.items.length; i++) {
                    var item = obj.items[i];
                    item["difference"] = "0";
                    viewModel.append(item);
                }
            adjsocket.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                var ms = JSON.parse('{"messageindex": "29","account":["",""]}');
                ms.account[0] = JSON.parse(settings.user).filename;
                ms.account[1] = settings.password;
                adjsocket.sendTextMessage(JSON.stringify(ms));
                break;
            }
        }
    }

    onSave: {
        saveData();
        winchange(incinventory);
    }

    onReady: {
        adjsocket.active = true;
    }

    onBack: {
        winchange(incinventory);
    }
}
