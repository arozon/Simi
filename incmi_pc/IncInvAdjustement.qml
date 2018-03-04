import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

Rectangle {
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height

    function save(){
        var tsend = JSON.parse('{"messageindex":"30","matricule":"","type":"inv","name":"","date":"","filename":"","items":[]}');
        for (var i = 0; i < mod.count; i++) {
            var item = mod.get(i);
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

    BaseSocket {
        port: sport
        host: shost
        id: adjsocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
                //Correct object..
                for (var i = 0; i < obj.items.length; i++) {
                    var item = obj.items[i];
                    item["difference"] = "0";
                    mod.append(item);
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

    Connections {
        target: window
        onDoEvents: {
            adjsocket.active = true;
        }
    }

    ColumnLayout {
        id: mview
        spacing: 0
        anchors.fill: parent
        ListView {
            bottomMargin: 3
            clip: true
            id: invListView
            x: 0
            y: 0
            width: 110
            height: 160
            header: AdjViewHeader {}
            headerPositioning: ListView.PullBackHeader
            orientation: ListView.Vertical
            flickableDirection: Flickable.VerticalFlick
            spacing: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: AdjViewDelegate {}
            model: ListModel {id: mod}
            add: Transition { NumberAnimation { properties: "x"; from: width; duration: 300; easing.type: Easing.OutQuad }}
        }



        Pane {
            id: pane
            width: parent.width
            height: 70
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 70
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.background: "#0288D1"
            RowLayout {
                id: gridLayout
                anchors.fill: parent
                CButton {
                    text: qsTr("Annuler")
                    source: "Icons/ic_highlight_off_white_24dp.png"
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        mview.enabled = false;
                        promptconfirmleave.show();
                    }
                }
                CButton {
                    text: qsTr("Envoyer")
                    source: "Icons/ic_cloud_upload_white_24dp.png"
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 150
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        mview.enabled = false;
                        promptconfirmsave.show();
                    }
                }
            }
        }
    }
    Prompt {
        id: promptconfirmsave
        x: parent.width / 8
        y: parent.height / 4.0
        width: parent.width - 2*x
        height: parent.height - 2*(parent.height/4.5)
        Material.background: colora
        Material.elevation: 8
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: parent.width/15
            anchors.rightMargin: parent.width/15
            anchors.bottomMargin: (parent.height/20) * 3
            anchors.topMargin: (parent.height/20) * 3
            spacing: 5
                Label {
                    text: settings.user == "" ? qsTr("Vous devez configurer votre compte avant tout... \n Merci!"): qsTr(
                                                    "Êtes vous sur de vouloir sauvegarder les changements?\nNom: " +
                                                    getFullName() + "\nMatricule: " + getMatricule());
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    Material.foreground: colorlt
                    wrapMode: Text.WordWrap
                    Layout.maximumHeight: 50
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            RowLayout{
                spacing: 15
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.maximumHeight: 50
                Button {
                    text: settings.user == "" ? qsTr("Ok") : qsTr("Non")
                    Layout.maximumWidth: implicitWidth
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        mview.enabled = true;
                        promptconfirmsave.hide();
                    }
                }
                Button {
                    text: qsTr("Oui")
                    Layout.maximumWidth: implicitWidth
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    enabled: settings.user == "" ? false: true;
                    onClicked: {
                        save();
                        winchange(incinventory);
                    }
                }
            }
        }
    }
    Prompt {
        id: promptconfirmleave
        x: parent.width / 8
        y: parent.height / 4.0
        width: parent.width - 2*x
        height: parent.height - 2*(parent.height/4.5)
        Material.background: colora
        Material.elevation: 8
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: parent.width/15
            anchors.rightMargin: parent.width/15
            anchors.bottomMargin: (parent.height/20) * 3
            anchors.topMargin: (parent.height/20) * 3
            spacing: 5
                Label {
                    text: qsTr("Êtes vous sur de vouloir quitter? Les changements non sauvegarder seronts effacer..")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    Material.foreground: colorlt
                    wrapMode: Text.WordWrap
                    Layout.maximumHeight: 50
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }
            RowLayout{
                spacing: 15
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.maximumHeight: 50
                Button {
                    text: qsTr("Non")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    Layout.maximumWidth: implicitWidth
                    onClicked: {
                        mview.enabled = true;
                        promptconfirmleave.hide();
                    }
                }
                Button {
                    text: qsTr("Oui")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: implicitWidth
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        winchange(incinventory);
                    }
                }
            }
        }
    }
}
