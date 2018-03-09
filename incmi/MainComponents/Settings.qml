import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1
import "../Components" as Comps

Item {
    property int footerHeight: 50

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


    Comps.BaseSocket {
        id: settingssocket
        onTextMessageReceived: {
            mod.clear();
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
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: footer.top
        }
        contentWidth: parent.width
        contentHeight: lay.childrenRect.height
        Column {
            id: lay
            spacing: 12
            anchors {
                topMargin: pad
                leftMargin: pad
                rightMargin: pad
                fill: parent
            }

            Rectangle {
                height: tbutton.height + 2 * pad
                width: parent.width
                border.color: "grey"
                border.width: 1
                radius: 3
                Button {
                    id: tbutton
                    width: parent.width > implicitWidth + 2*pad ? implicitWidth : parent.width - 2*pad
                    anchors {
                        right: parent.right
                        rightMargin: pad
                        verticalCenter: parent.verticalCenter
                    }
                    height: implicitHeight
                    Material.background: colordp
                    Material.foreground: colorlt
                    text: "Configure Access"
                    onClicked: {
                        pressedConfigureAccess();
                    }
                }
            }
            Rectangle {
                height: pass.y + pass.height + 5*pad
                width: parent.width
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
                Comps.LabeledTextInput {
                    id: pass
                    height: textboxheight
                    width: cbox.width
                    x: cbox.x
                    mTextInput.text: settings.password
                    y: cbox.height + pad + cbox.y
                    labelText: "Password : "
                    onTextInputTextChanged:  {
                        settings.password = textInputText;
                    }
                }
            }
        }
    }


    Rectangle {
        id: footer
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        height: footerHeight
        Comps.ImageButton {
            id: confb
            text: qsTr("Confirmer");
            width: implicitWidth + 3*pad + confc.implicitWidth > parent.width ? (parent.width - 3*pad) / 2 : implicitWidth
            x: parent.width - width - pad
            height: parent.height - 6
            source: "../Icons/ic_play_for_work_white_24dp.png"
            Material.foreground: colorlt
            Material.background: colordp
            onClicked: {
                confirmSettings(selectedmember);
            }
        }

        Comps.ImageButton {
            id: confc
            text: qsTr("Conf. Serveur");
            width: implicitWidth + 3*pad + confb.implicitWidth > parent.width ? (parent.width - 3*pad) / 2 : implicitWidth
            x: confb.x - width - pad
            height: parent.height - 6
            source: "../Icons/ic_bug_report_white_24dp.png"
            Material.foreground: colorlt
            Material.background: colordp
            visible: settings.isadmin
            onClicked: {
                serverSettings();
            }
        }
    }
}
