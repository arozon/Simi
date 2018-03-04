import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1

Item {
    width: parent.width
    height: parent.height
    Material.accent: colora
    property int xd: 3
    property int pad: 5
    property int textboxheight: 30
    property int footerheight: 55
    property bool hasselection: false
    property bool isnew: false
    property bool didload: false
    property var checkedobjects: []

    function ready() {
        setsocket.active = true;
    }

    function saveSettings() {
        if (didload) {
            var message = JSON.parse(serversettingsbase);
            message.sport = port.textBox.text;
            message.shost = host.textBox.text;
            message.smpush = mcount.textBox.text;
            message.semaccount = eaccount.textBox.text;
            message.sempassword = epassword.textBox.text;
            message.scnew = csnew.checked;
            message.scedit = csedit.checked;
            message.scremind = csremind.checked;
            message.scadmincommit = csadmincommit.checked;
            message.scremove = csremove.checked;
            message.scbackup = csbackup.checked;
            message = JSON.stringify(message).slice(0,-1) + ',"messageindex":"18"}';
            addMessage(message);
            sendSavedInformation();
        }
        doneServerSettings();
    }

    BaseSocket {
        port: sport
        host: shost
        id: setsocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            port.textBox.text = obj.sport;
            host.textBox.text = obj.shost;
            mcount.textBox.text = obj.smpush;
            eaccount.textBox.text = obj.semaccount;
            epassword.textBox.text = obj.sempassword;
            csnew.checked = obj.scnew;
            csedit.checked = obj.scedit;
            csremove.checked = obj.scremove;
            csremind.checked = obj.scremind;
            csadmincommit.checked = obj.scadmincommit;
            csbackup.checked = obj.scbackup;
            setsocket.active = false;
            didload = true;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                var ms = JSON.parse('{"messageindex": "19","account":["",""]}');
                ms.account[0] = JSON.parse(settings.user).filename;
                ms.account[1] = settings.password;
                setsocket.sendTextMessage(JSON.stringify(ms));
                break;
            case WebSocket.Error:
                console.log(errorString);
                break;
            }
        }
    }

    Flickable {
        id: body
        width: parent.width
        height: parent.height - footer.height
        contentWidth: parent.width
        contentHeight: page2.height + page2.y + 2*pad
        clip: true

        Pane {
            id: title
            x: pad
            y: pad
            width: parent.width - 2*pad
            height: textboxheight
            Material.background: colordp
            Material.elevation: 2
            Label {
                x: pad * 5
                text: "Account and Password Settings"
                width: parent.width - 2*x
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                Material.foreground: colorlt
            }
        }

        Item {
            id: page
            x: xd
            y: xd + title.y + title.height
            width: parent.width - 2*x
            height: l4.y + l4.height + pad

            Item {
                x: xd
                width: parent.width - 2*x
                y: xd
                height: parent.height - 2*y
                Label {
                    id: l3
                    x: xd
                    y: xd
                    text: "Server Email Account:"
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                CTextField {
                    id: eaccount
                    y: l3.y
                    x: l3.width + l3.x + xd
                    width: parent.width - l3.width - 3*xd
                    height: textboxheight
                    KeyNavigation.tab: epassword
                }
                Label {
                    id: l4
                    x: xd
                    y: l3.height + l3.y + 2*xd
                    text: "Email Password:"
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                CTextField {
                    id: epassword
                    x: l3.width + l3.x + xd
                    y: l4.y
                    width: parent.width - l3.width - 3*xd
                    height: textboxheight
                    KeyNavigation.tab: host
                }
            }
        }

        Pane {
            id: title2
            x: pad
            y: pad + page.y + page.height
            Material.background: colordp
            Material.elevation: 2
            width: parent.width - 2*pad
            height: textboxheight
            Label {
                x: pad * 5
                text: "Server Settings"
                width: parent.width - 2*x
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                Material.foreground: colorlt
            }
        }

        Item {
            id: page2
            x: xd
            y: xd + title2.y + title2.height
            width: parent.width - 2*x
            height: confp.height + confp.y + pad

            Item {
                x: xd
                width: parent.width - 2*x
                y: xd
                height: parent.height *4 / 10
                Label {
                    id: l11
                    text: "Host:"
                    y: xd
                    x: xd
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                Label {
                    id: l22
                    y: l11.height + l11.y + 2*xd
                    text: "Port:"
                    x: xd
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                Label {
                    id: l33
                    y: l22.height + l22.y + 2*xd
                    text: "Maximum docs to Sync :"
                    x: xd
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                CTextField {
                    id: host
                    x: l33.width + l33.x + xd*2
                    y: l11.y
                    width: parent.width - l33.width - 3*xd
                    height: textboxheight
                    KeyNavigation.tab: port
                }
                CTextField {
                    id: port
                    x: l33.width + l33.x + xd*2
                    y: l22.y
                    width: parent.width - l33.width - 3*xd
                    height: textboxheight
                    KeyNavigation.tab: mcount
                }
                CTextField {
                    id: mcount
                    x: l33.width + l33.x + xd*2
                    y: l33.y
                    width: parent.width - l33.width - 3*xd
                    height: textboxheight
                    KeyNavigation.tab: eaccount
                }
                CheckBox {
                    id: csnew
                    y: l33.y + l33.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Notify on new Event"
                }
                CheckBox {
                    id: csedit
                    y: csnew.y + csnew.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Notify on event Modified"
                }
                CheckBox {
                    id: csremove
                    y: csedit.y + csedit.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Notify on event Cancellation"
                }
                CheckBox {
                    id: csremind
                    y: csremove.y + csremove.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Remind prior to event Date"
                }
                CheckBox {
                    id: csadmincommit
                    y: csremind.y + csremind.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Notify admins on doc Commit"
                }
                CheckBox {
                    id: csbackup
                    y: csadmincommit.y + csadmincommit.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Perform automatic data backup"
                }
                CButton {
                    id: confp
                    text: qsTr("Configure People");
                    width: implicitWidth + 32
                    x: parent.width - width - 2*xd
                    y: csbackup.height + csbackup.y + 2*xd
                    height: textboxheight + 10
                    source: "Icons/ic_supervisor_account_white_24dp.png"
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        showPeopleSettings();
                    }
                }
            }
        }
    }

    Item {
        clip: true;
        id: footer
        x: -2
        width: parent.width + 2
        y: body.height
        height: footerheight + 1
        Rectangle {
            anchors.fill: parent
            border.width: 1
            border.color: "grey"
            CButton {
                id: confb
                text: qsTr("Savegarder");
                width: confb.implicitWidth + confr.implicitWidth + 2*xd > parent.width - 30 ? (parent.width - 2*15) / 2 : implicitWidth
                x: parent.width - width - 10
                y: 2*xd
                height: parent.height - 4*xd
                source: "Icons/ic_play_for_work_white_24dp.png"
                Material.foreground: colorlt
                Material.background: colordp
                enabled: didload
                onClicked: {
                    saveSettings();
                }
            }
            CButton {
                id: confr
                text: qsTr("Retour");
                width: confb.implicitWidth + confr.implicitWidth + 2*xd > parent.width - 30 ? (parent.width - 2*15) / 2 : implicitWidth + 5
                x: confb.x - width - 10
                y: 2*xd
                height: parent.height - 4*xd
                source: "Icons/ic_backspace_white_24dp.png"
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                    doneServerSettings();
                }
            }
        }
    }
}
