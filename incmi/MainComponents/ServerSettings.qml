import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1
import "../Components" as Comps

Item {
    Material.accent: colora
    property int xd: 3
    property int pad: 5
    property int textboxheight: 36
    property int footerheight: 56
    property bool hasselection: false
    property bool isnew: false
    property bool didload: false
    property var checkedobjects: []

    function ready() {
        setsocket.active = true;
    }

    function saveSettings() {
        if (didload) {
            var message = {};
            message.sport = port.textInputText;
            message.shost = host.textInputText;
            message.smpush = mcount.textInputText;
            message.semaccount = eaccount.textInputText;
            message.sempassword = epassword.textInputText;
            message.scnew = csnew.checked;
            message.scedit = csedit.checked;
            message.scremind = csremind.checked;
            message.scadmincommit = csadmincommit.checked;
            message.scremove = csremove.checked;
            message.scbackup = csbackup.checked;
            message.messageindex = "18";
            message = JSON.stringify(message);
            addMessage(message);
            sendSavedInformation();
        }
        doneServerSettings();
    }

    Comps.BaseSocket {
        id: setsocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            port.mTextInput.text = obj.sport;
            host.mTextInput.text = obj.shost;
            mcount.mTextInput.text = obj.smpush;
            eaccount.mTextInput.text = obj.semaccount;
            epassword.mTextInput.text = obj.sempassword;
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
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
            bottom: footer.top
        }
        contentHeight: lay.childrenRect.height + pad
        clip: true

        Column {
            id: lay
            spacing: 8
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                leftMargin: pad
                rightMargin: pad
                topMargin: pad
            }

            Comps.SectionHeader{
                width: parent.width
                headerText: "Account and Password Settings"
            }

            Comps.LabeledTextInput {
                id: eaccount
                height: textboxheight
                labelText: "Server Email Account"
                KeyNavigation.tab: epassword
            }

            Comps.LabeledTextInput {
                id: epassword
                height: textboxheight
                labelText: "Email Password"
                KeyNavigation.tab: host
            }

            Comps.SectionHeader {
                width: parent.width
                headerText: "Server Settings"
            }
            Comps.LabeledTextInput {
                id: host
                height: textboxheight
                labelText: "Host"
                KeyNavigation.tab: port
            }
            Comps.LabeledTextInput {
                id: port
                height: textboxheight
                labelText: "Port"
                KeyNavigation.tab: mcount
            }
            Comps.LabeledTextInput {
                id: mcount
                height: textboxheight
                labelText: "Maximum docs to Sync"
                KeyNavigation.tab: epassword
            }
            CheckBox {
                id: csnew
                width: implicitWidth > parent.width ? parent.width: implicitWidth
                height: textboxheight
                text: "Notify on new Event"
                Material.accent: colora
                anchors {
                    right: parent.right
                }
            }
            CheckBox {
                id: csedit
                width: implicitWidth > parent.width ? parent.width: implicitWidth
                height: textboxheight
                text: "Notify on event Modified"
                Material.accent: colora
                anchors {
                    right: parent.right
                }
            }
            CheckBox {
                id: csremove
                width: implicitWidth > parent.width ? parent.width: implicitWidth
                height: textboxheight
                text: "Notify on event Cancellation"
                Material.accent: colora
                anchors {
                    right: parent.right
                }
            }
            CheckBox {
                id: csremind
                width: implicitWidth > parent.width ? parent.width: implicitWidth
                height: textboxheight
                text: "Remind prior to event Date"
                Material.accent: colora
                anchors {
                    right: parent.right
                }
            }
            CheckBox {
                id: csadmincommit
                width: implicitWidth > parent.width ? parent.width: implicitWidth
                height: textboxheight
                text: "Notify admins on doc Commit"
                Material.accent: colora
                anchors {
                    right: parent.right
                }
            }
            CheckBox {
                id: csbackup
                width: implicitWidth > parent.width ? parent.width: implicitWidth
                height: textboxheight
                text: "Perform automatic data backup"
                Material.accent: colora
                anchors {
                    right: parent.right
                }
            }
            Comps.ImageButton {
                text: qsTr("Configure People");
                width: implicitWidth + 32
                height: textboxheight + 10
                anchors {
                    right: parent.right
                }
                source: "../Icons/ic_supervisor_account_white_24dp.png"
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                    showPeopleSettings();
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
            leftMargin: -1
            rightMargin: -1
            bottomMargin: -1
        }
        height: footerheight
        border.width: 1
        border.color: "grey"
        Comps.ImageButton {
            id: confb
            text: qsTr("Savegarder");
            width: confb.implicitWidth + confr.implicitWidth + 2*xd > parent.width - 30 ? (parent.width - 2*15) / 2 : implicitWidth
            x: parent.width - width - 10
            y: 2*xd
            height: parent.height - 4*xd
            source: "../Icons/ic_play_for_work_white_24dp.png"
            Material.foreground: colorlt
            Material.background: colordp
            enabled: didload
            onClicked: {
                saveSettings();
            }
        }
        Comps.ImageButton {
            id: confr
            text: qsTr("Retour");
            width: confb.implicitWidth + confr.implicitWidth + 2*xd > parent.width - 30 ? (parent.width - 2*15) / 2 : implicitWidth + 5
            x: confb.x - width - 10
            y: 2*xd
            height: parent.height - 4*xd
            source: "../Icons/ic_backspace_white_24dp.png"
            Material.foreground: colorlt
            Material.background: colordp
            onClicked: {
                doneServerSettings();
            }
        }
    }
}
