import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "../Components" as Comps
Item {
    property int pad: 5
    property int xd: 5
    property int sidePadding: 5
    property int headerheight: 50
    property int footerheight: 70
    property int textboxheight: 35
    property bool cansave: false

    function ready() {}

    function checkSave() {
        if (tname.textInputText === "" || tcount.textInputText === "" || trcount.textInputText === "") {
            cansave = false;
        }else {
            cansave = true;
        }
    }

    function getObj() {
        var obj = JSON.parse(inventoryitembase);
        obj.name = tname.textInputText;
        obj.count = tcount.textInputText;
        obj.rcount = trcount.textInputText;
        return obj;
    }

    function add() {
        addInvItem(getObj());
    }

    height: parent.height
    width: parent.width
    Flickable {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: footer.top
        }
        contentHeight: lay.height
        contentWidth: width
        Column {
            id: lay
            anchors {
                top: parent.top
                right: parent.right
                left: parent.left
            }


            Comps.SectionHeader {
                x: (-1 * sidePadding) / 2
                width: parent.width + sidePadding
                headerText: "New Inventory Item"
            }

            Comps.LabeledTextInput {
                id: tname
                height: textboxheight
                width: parent.width
                labelText: "Name "
                KeyNavigation.tab: tcount.mIntputText
                onTextInputTextChanged: {
                    checkSave();
                }
            }

            Comps.LabeledTextInput {
                id: tcount
                height: textboxheight
                width: parent.width
                labelText: "Count "
                KeyNavigation.tab: trcount.mInputText
                onTextInputTextChanged: {
                    checkSave();
                }
            }
            Comps.LabeledTextInput {
                id: trcount
                height: textboxheight
                width: parent.width
                labelText: "Recommended Count "
                KeyNavigation.tab: tname.mInputText
                onTextInputTextChanged: {
                    checkSave();
                }
            }

        }
    }
    RowLayout {
        id: footer
        property int childrenWidth: addbut.implicitWidth + canbut.implicitWidth + spacing
        property int sMargins: 4
        height: footerheight
        spacing: 3
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: sMargins
            leftMargin: sMargins
        }
        width: childrenWidth > parent.width ? parent.width : childrenWidth
        Button {
            id: addbut
            text: "Add"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumHeight: implicitHeight
            Material.background: colordp
            Material.foreground: colorlt
            enabled: cansave
            onClicked: {
                add();
            }
        }

        Button {
            id: canbut
            text: "Cancel"
            Layout.maximumHeight: implicitHeight
            Layout.fillHeight: true
            Layout.fillWidth: true
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                cancelNew();
            }
        }
    }

}
