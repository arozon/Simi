import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
Item {
    property int pad: 5
    property int xd: 5
    property int headerheight: 50
    property int footerheight: 70
    property int textboxheight: 35
    property bool cansave: false

    function ready() {}

    function checkSave() {
        if (tname.textField.text == "" || tcount.textField.text == "" || trcount.textField.text == "") {
            cansave = false;
        }else {
            cansave = true;
        }
    }

    function getObj() {
        var obj = JSON.parse(inventoryitembase);
        obj.name = tname.textField.text;
        obj.count = tcount.textField.text;
        obj.rcount = trcount.textField.text;
        return obj;
    }

    function add() {
        addInvItem(getObj());
    }

    height: parent.height
    width: parent.width
    Pane {
        id: header
        x: pad
        y: pad
        width: parent.width - 2*pad
        height: headerheight
        Material.background: colordp
        Material.elevation: 1
        Label {
            anchors.fill: parent
            leftPadding: xd*2
            Material.foreground: colorlt
            text: "New Inventory Item"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }
    }

    Item {
        id: center
        y: header.y + header.height + pad
        x: pad
        width: parent.width - pad
        height: parent.height - headerheight - footerheight - 4*pad
        CLabeledTextField {
            id: tname
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: pad
            label.text: "Name :"
            labelLength: trcount.label.implicitWidth
            KeyNavigation.tab: tcount.textField
            textField.onTextChanged: {
                checkSave();
            }
        }
        CLabeledTextField {
            id: tcount
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: tname.y + tname.height + pad
            label.text: "Count :"
            labelLength: trcount.label.implicitWidth
            KeyNavigation.tab: trcount.textField
            textField.onTextChanged: {
                checkSave();
            }
        }
        CLabeledTextField {
            id: trcount
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: tcount.y + tcount.height + pad
            label.text: "Recommended Count :"
            labelLength: label.implicitWidth
            KeyNavigation.tab: tname.textField
            textField.onTextChanged: {
                checkSave();
            }
        }
    }

    Item {
        id: footer
        x: pad
        y: parent.height - height - pad
        width: parent.width - 2*pad
        height: footerheight
        Button {
            id: addbut
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: addbut.implicitWidth + canbut.implicitWidth + 3 * pad > parent.width ? (parent.width - 3*pad) / 2 : implicitWidth
            x: parent.width - width - pad
            text: "Add"
            Material.background: colordp
            Material.foreground: colorlt
            enabled: cansave
            onClicked: {
                add();
            }
        }

        Button {
            id: canbut
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: addbut.implicitWidth + canbut.implicitWidth + 3 * pad > parent.width ? (parent.width - 3*pad) / 2 : implicitWidth
            x: addbut.x - width - pad
            text: "Cancel"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                cancelNew();
            }
        }
    }
}
