import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "../Components" as Comps
import "../Prompts" as Dialogs
Item {
    property int sidePadding: 12
    property int spaccing: 12
    property int footerheight: 70
    property int textboxheight: 50
    property bool cansave: false
    property bool contentenabled: true

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
        obj.tag = ttag.textInputText;
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
        tname.mTextInput.text = obj.name;
        tcount.mTextInput.text = obj.count;
        trcount.mTextInput.text = obj.rcount;
        ttag.mTextInput.text = obj.tag;
    }

    height: parent.height
    width: parent.width

    Flickable {
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
            bottom: footer.top
            topMargin: sidePadding
            leftMargin: sidePadding
            rightMargin: sidePadding
        }
        contentWidth: width
        contentHeight: lay.height

        Column {
            id: lay
            spacing: spaccing
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }
            enabled: contentenabled

            Comps.SectionHeader {
                x: (-1 * sidePadding) / 2
                width: parent.width + sidePadding
                height: textboxheight
                headerText: "Edit Inventory Item"
            }

            Comps.LabeledTextInput {
                id: tname
                height: textboxheight
                width: parent.width
                labelText: "Name "
                KeyNavigation.tab: tcount
                onTextInputTextChanged: {
                    checkSave();
                }
            }

            Comps.LabeledTextInput {
                id: tcount
                height: textboxheight
                width: parent.width
                labelText: "Count "
                KeyNavigation.tab: trcount
                onTextInputTextChanged: {
                    checkSave();
                }
            }
            Comps.LabeledTextInput {
                id: trcount
                height: textboxheight
                width: parent.width
                labelText: "Recommended Count "
                KeyNavigation.tab: tname
                onTextInputTextChanged: {
                    checkSave();
                }
            }
            Comps.LabeledTextInput {
                id: ttag
                height: textboxheight
                width: parent.width
                labelText: "Tag "
            }


        }
    }
    RowLayout {
        property int childrenWidth: canbut.implicitWidth + rembut.implicitWidth + addbut.implicitWidth + 2*spacing

        id: footer
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: sidePadding
            leftMargin: sidePadding
        }
        height: footerheight
        width: childrenWidth > parent.width ? parent.width : childrenWidth
        enabled: contentenabled

        Button {
            id: canbut
            text: "Cancel"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                cancel();
            }
        }
        Button {
            id: rembut
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
            text: "Save"
            Material.background: colordp
            Material.foreground: colorlt
            enabled: cansave
            onClicked: {
                save();
            }
        }
    }
    Dialogs.CancelPrompt {
        id: prm
        onCancelDialog: {
            prm.hide();
            contentenabled = true;
        }

        onConfirmDialog: {
            confirmRemove();
        }
        labelText: "Êtes vous sur de vouloir effacer l'objet d'inventaires?"
    }
}
