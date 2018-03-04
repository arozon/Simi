import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

Item {
    height: parent.height
    width: parent.width
    property int ffont: 12
    property int pad: 5
    property int textboxheight: 30
    property string selectedmember: ""
    property string members: ""
    Material.accent: colora

    function ready() {
        selectedmember = settings.user
        settingssocket.active = true;
    }


    BaseSocket {
        port: sport
        host: shost
        id: settingssocket
        onTextMessageReceived: {
            mod.clear();
            console.log(message);
            var obj = JSON.parse(message);
            for (var i = 0; i < obj.items.length; i++){
                var t = obj.items[i];
                t["fname"] = t.firstname + " " + t.lastname;
                if (selectedmember != ""){
                    var c = JSON.parse(selectedmember)
                    if (c.filename === t.filename) {
                        cbox.currentIndex = i;
                    }
                }
                if (t.isadmin){
                    if (settings.isadmin) mod.append(t);
                }else {
                    mod.append(t);

                }
            }
            members = message;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                settingssocket.sendTextMessage('{"messageindex": "5"}');
                break;
            case WebSocket.Error:
                console.log("Error");
                settingssocket.active = false;
                break;
            }
        }
    }

    Flickable {
        id: body
        x: 0
        y: 0
        width: parent.width
        contentWidth: parent.width
        contentHeight: i2.height + i2.y + pad
        height: parent.height - footer.height
        Item {
            id: i1
            x: 0
            y: 0
            height:tbutton.height + tbutton.y + 5*pad
            width: parent.width
            Rectangle {
                anchors.fill: parent
                anchors.margins: pad
                border.color: "grey"
                border.width: 1
                radius: 3
                Item {
                    anchors.fill: parent
                    anchors.margins: pad
                    Button {
                        id: tbutton
                        width: parent.width > implicitWidth + pad ? implicitWidth : parent.width - 2*pad
                        x: parent.width - pad - width
                        y: pad
                        height: textboxheight + 15
                        Material.background: colordp
                        Material.foreground: colorlt
                        text: "Configure Access"
                        onClicked: {
                            pressedConfigureAccess();
                        }
                    }
                }
            }
        }

        Item {
            id: i2
            x: 0
            y: i1.height
            height: pass.y + pass.height + 5*pad
            width: parent.width
            Rectangle {
                anchors.fill: parent
                anchors.margins: pad
                color: "white"
                clip: true
                border.color: "grey"
                border.width: 1
                radius: 3
                Label {
                    x: pad * 4
                    y: pad * 4
                    height: textboxheight
                    width: implicitWidth
                    text: "Compte"
                    font.bold: true
                }
                ComboBox {
                    id: cbox
                    Material.elevation: 1
                    popup.implicitHeight: body.height * 2/3
                    textRole: "fname"
                    editable: false
                    currentIndex: 0
                    height: textboxheight * 1.5
                    width: parent.width * 2/ 3 < 171 ? 170 : parent.width * 2 / 3
                    x: parent.width - width - 2*pad
                    y: pad + textboxheight
                    model: ListModel { id: mod}
                    onActivated:  {
                        if (selectedmember != JSON.stringify(mod.get(index))) {
                            var sm = mod.get(index);
                            delete sm["fname"];
                            selectedmember = JSON.stringify(mod.get(index));
                        }
                    }
                }
                CLabeledTextField {
                    id: pass
                    height: textboxheight
                    width: cbox.width
                    x: cbox.x
                    spad: pad / 2
                    textField.text: settings.password
                    y: cbox.height + pad + cbox.y
                    label.text: "Password : "
                    labelLength: label.implicitWidth
                    textField.onTextChanged: {
                        settings.password = textField.text;
                    }
                }
            }
        }
    }


    Rectangle {
        id: footer
        width: parent.width
        y: body.height
        height: 50
        CButton {
            id: confb
            text: qsTr("Confirmer");
            width: implicitWidth + 3*pad + confc.implicitWidth > parent.width ? (parent.width - 3*pad) / 2 : implicitWidth
            x: parent.width - width - pad
            height: parent.height - 6
            source: "Icons/ic_play_for_work_white_24dp.png"
            Material.foreground: colorlt
            Material.background: colordp
            onClicked: {
                confirmSettings(selectedmember);
            }
        }

        CButton {
            id: confc
            text: qsTr("Conf. Serveur");
            width: implicitWidth + 3*pad + confb.implicitWidth > parent.width ? (parent.width - 3*pad) / 2 : implicitWidth
            x: confb.x - width - pad
            height: parent.height - 6
            source: "Icons/ic_bug_report_white_24dp.png"
            Material.foreground: colorlt
            Material.background: colordp
            visible: settings.isadmin
            onClicked: {
                serverSettings();
            }
        }
    }
}
