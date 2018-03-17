import QtQuick 2.9
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import "../InventoryComponents" as InvComps
import "../Components" as Comps

Item {
    property string currentInvItem

    function itemDoubleClicked(obj) {
        currentInvItem = JSON.stringify(obj);
        ldview.push(ledit);
        footer.enabled = false;
    }

    function removeInvItem(obj) {
        obj["messageindex"] = "7";
        addMessage(JSON.stringify(obj));
        sendSavedInformation();
        ldview.push(lmain);
        footer.enabled = true;
    }

    function editInvItem(obj) {
        obj["messageindex"] = "6";
        addMessage(JSON.stringify(obj));
        sendSavedInformation();
        ldview.push(lmain);
        footer.enabled = true;
    }

    function cancelInvEdit() {
        ldview.push(lmain);
        footer.enabled = true;
    }

    function newInvItem() {
        ldview.push(lnew);
        footer.enabled = false;
    }

    function cancelNew() {
        ldview.push(lmain);
        footer.enabled = true;
    }

    function addInvItem(obj) {
        obj["messageindex"] = "8";
        addMessage(JSON.stringify(obj));
        sendSavedInformation();
        ldview.push(lmain);
        footer.enabled = true;
    }

    Component {
        id: lmain
        InvComps.MedViewInventoryList {}
    }

    Component {
        id: ledit
        InvComps.ViewEditInventoryItem {}
    }

    Component {
        id: lnew
        InvComps.ViewCreateInventoryItem {}
    }

    Connections {
        target: window
        onDoEvents: {
            ldview.currentItem.ready();
        }
    }
    StackView {
        id: ldview
        clip: true;
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: footer.top
            topMargin: useSafeAreaPadding ? safeAreaSize : 0
        }

        initialItem: lmain
        onBusyChanged: {
            if (!busy) {
                ldview.currentItem.ready();
            }
        }
    }

    Comps.ConfirmationPageFooter {
        id: footer
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        confirmBut {
            text: "Adjustement"
            source: "../Icons/ic_note_add_white_24dp.png"
        }
        cancelBut {
            text: "Retour"
        }
        onConfirm: {
            winchange(adjinv);
        }
        onCancel: {
            winchange(medimain);
        }
    }
}
