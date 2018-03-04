import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    width: 580
    height: 431
    property int xd: 3
    property int pad: 5
    property int textboxheight: 30

    Pane {
        id: title
        x: pad
        y: pad
        width: parent.width - 2*pad
        height: (parent.height / 8) - 2*pad
        Material.background: colordp
        Material.elevation: 5
        Label {
            x: pad * 5
            text: "Account and Password Settings"
            font.pointSize: 14
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
        height: (parent.height - title.height ) - 3*xd

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
                font.pointSize: 10
                width: (parent.width/4) - 2*x
                height: textboxheight
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Rectangle{
                x: l3.width + l3.x + xd
                y: l3.y
                width: parent.width - l3.width - 3*xd
                height: textboxheight
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 3
                TextInput {
                    id: eaccount
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10
                    KeyNavigation.tab: epassword
                    text: _backend.getSetting("semaccount")
                }
            }
            Label {
                id: l4
                x: xd
                y: l3.height + l3.y + 2*xd
                text: "Email Password:"
                font.pointSize: 10
                width: (parent.width/4) - 2*x
                height: textboxheight
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Rectangle{
                x: l3.width + l3.x + xd
                y: l4.y
                width: parent.width - l3.width - 3*xd
                height: textboxheight
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 3
                TextInput {
                    id: epassword
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10
                    KeyNavigation.tab: eaccount
                    text: _backend.getSetting("sempassword");
                }
            }
        }
    }

    function save() {
        var obj = JSON.parse(_backend.getSettings());
        obj["semaccount"] =  eaccount.text;
        obj["sempassword"] = epassword.text;
        _backend.setSettings(obj);
    }
}
