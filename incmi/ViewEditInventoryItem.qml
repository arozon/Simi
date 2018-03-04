import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
Item {
    property int pad: 5
    property int headerheight: 50
    property int footerheight: 70
    property int textboxheight: 35
    property bool cansave: false
    property bool contentenabled: true
    property int xd: 5

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
        obj.tag = ttag.textField.text;
        return obj;
    }

    function save() {
        var obj = getObj();
        editInvItem(obj);
    }
    function confirmRemove(){
        var obj = getObj();
        removeInvItem(obj);
    }
    function cancel() {
        cancelInvEdit();
    }

    Component.onCompleted: {
        var obj = JSON.parse(currentInvItem);
        tname.textField.text = obj.name;
        tcount.textField.text = obj.count;
        trcount.textField.text = obj.rcount;
        ttag.textField.text = obj.tag;
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
            text: "Edit Inventory Item"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }
    }

    Item {
        id: center
        x: pad
        width: parent.width - pad
        height: parent.height - headerheight - footerheight - 4*pad
        y: header.y + header.height + pad
        enabled: contentenabled


        CLabeledTextField {
            id: tname
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: pad
            label.text: "Name :"
            labelLength: trcount.label.implicitWidth
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
            textField.onTextChanged: {
                checkSave();
            }

        }

        CLabeledTextField {
            id: ttag
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: trcount.y + trcount.height + pad
            label.text: "Unique Tag :"
            labelLength: trcount.label.implicitWidth
        }
    }

    Item {
        id: footer
        x: pad
        y: parent.height - height - pad
        width: parent.width - 2*pad
        height: footerheight
        enabled: contentenabled
        Button {
            id: canbut
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: canbut.implicitWidth + rembut.implicitWidth + addbut.implicitWidth + 4*pad > parent.width ? (parent.width - 4*pad) / 3 : implicitWidth
            x: parent.width - width - pad
            text: "Cancel"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                cancel();
            }
        }
        Button {
            id: rembut
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: canbut.implicitWidth + rembut.implicitWidth + addbut.implicitWidth + 4*pad > parent.width ? (parent.width - 4*pad) / 3 : implicitWidth
            x: canbut.x - width - pad
            text: "Remove"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                prm.show();
                contentenabled = false;
            }
        }
        Button {
            id: addbut
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: canbut.implicitWidth + rembut.implicitWidth + addbut.implicitWidth + 4*pad > parent.width ? (parent.width - 4*pad) / 3 : implicitWidth
            x: rembut.x - width - pad
            text: "Save"
            Material.background: colordp
            Material.foreground: colorlt
            enabled: cansave
            onClicked: {
                save();
            }
        }

    }
    Prompt {
        id: prm
        x: parent.width / 14
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
                text: qsTr("Êtes vous sur de vouloir effacer l'objet d'inventaires?")
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
                    onClicked: {
                        prm.hide();
                        contentenabled = true;
                    }
                }
                Button {
                    text: qsTr("Oui")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        confirmRemove();
                    }
                }
            }
        }
    }
}
