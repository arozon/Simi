import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1

Item {
    id: tpa
    width: parent.width
    height: parent.height
    Material.accent: colora
    property int xd: 3
    property int pad: 5
    property int textboxheight: 30
    property int footerheight: 55
    property bool hasselection: false
    property bool isnew: false
    property var currentobj
    property var checkedobjects: []

    function ready() {
        ld.currentItem.ready();
    }

    function newPerson() {
        isnew = true;
        ld.push(peditor);
    }

    function seeList() {
        clearObjects();
        ld.push(plist);
    }

    function editPerson(jobj) {
        currentobj = jobj
        isnew = false;
        ld.push(peditor);
    }
    function checkRemove() {
        if (checkedobjects.length > 0){
            hasselection = true;
        }else {
            hasselection = false;
        }
    }

    function removeObjects() {
        removePeople();
        checkedobjects = [];
        checkRemove();
    }

    function clearObjects() {
        checkedobjects = [];
        checkRemove();
    }

    function removePeople() {
        var message = JSON.parse('{"messageindex":"15", "items":[]}');
        for (var i = 0; i < checkedobjects.length; i++) {
            message.items.push(checkedobjects[i]);
        }
        addMessage(JSON.stringify(message));
        sendSavedInformation();
    }

    function editPeople(obj) {
        var message = JSON.stringify(obj);
        message = message.slice(0,-1) + ',"messageindex":"16"}';
        addMessage(message);
        sendSavedInformation();
    }

    function addPerson(obj) {
        var message = JSON.stringify(obj);
        message = message.slice(0,-1) + ',"messageindex":"17"}';
        addMessage(message);
        sendSavedInformation();
    }

    function retourSettings() {
        donePeopleSettings();
    }

    Flickable {
        id: body
        width: parent.width
        height: parent.height - footer.height
        contentWidth: parent.width
        contentHeight: prect.height + prect.y + 2*pad
        clip: true
        Pane {
            id: title3
            x: pad
            y: pad
            width: parent.width - 2*pad
            height: textboxheight
            Material.background: colordp
            Material.elevation: 2
            Label {
                x: pad * 5
                text: "People Management"
                width: parent.width - 2*x
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                Material.foreground: colorlt
            }
        }
        Rectangle {
            id: prect
            x: pad
            width: parent.width - 2*pad
            height: tpa.height - 4*pad - title3.height - footerheight > 400 ? tpa.height - 4*pad - title3.height - footerheight : 400
            y: title3.y + title3.height + pad
            border.color: "lightgrey"
            border.width: 1
            StackView {
                anchors.fill: parent
                clip: true
                id: ld
                initialItem: plist
                onBusyChanged:  {
                    if (!busy) {
                        ld.currentItem.ready();
                    }
                }
            }
        }

        Component {
            id: plist
            PeopleListSettings {}
        }

        Component {
            id: peditor
            PeopleEditorSettings {}
        }
    }

    Item {
        id: footer
        width: parent.width
        y: body.height
        height: footerheight
        Rectangle {
            anchors.fill: parent
            anchors.margins: xd
            border.width: 1
            border.color: "grey"
            CButton {
                id: confb
                text: qsTr("Retour");
                width: implicitWidth + 20
                x: parent.width - width - 10
                y: parent.anchors.margins
                height: parent.height - 2*parent.anchors.margins
                source: "Icons/ic_play_for_work_white_24dp.png"
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                    retourSettings();
                }
            }
        }
    }
}
