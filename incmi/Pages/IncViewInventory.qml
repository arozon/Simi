import QtQuick 2.9
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import "../InventoryComponents" as InvComps
import "../Components" as Comps

Item {
    id: pcontrol
    property string currentInvItem

    function itemDoubleClicked(obj) {
        currentInvItem = JSON.stringify(obj);
        ldview.push(ledit);
        footer.enabled = false;
    }

    function removeInvItem(obj) {
        obj["messageindex"] = "26";
        addMessage(JSON.stringify(obj));
        sendSavedInformation();
        ldview.push(lmain);
        footer.enabled = true;
    }

    function editInvItem(obj) {
        obj["messageindex"] = "27";
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
        obj["messageindex"] = "28";
        addMessage(JSON.stringify(obj));
        sendSavedInformation();
        ldview.push(lmain);
        footer.enabled = true;
    }

    Component.onCompleted: {
        var os = Qt.platform.os;
        if (os === "windows" || os === "linux" || os === "osx") {
            // Set windows design;

            ldview.anchors.leftMargin = Qt.binding(function () {
                return pcontrol.width / 10;
            });
            ldview.anchors.rightMargin = Qt.binding(function () {
                return pcontrol.width / 10;
            });
            ldview.anchors.topMargin = Qt.binding(function () {
                return 15;
            });
        }
    }

    Component {
        id: lmain
        InvComps.IncViewInventoryList {}
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
            winchange(incadjinc);
        }
        onCancel: {
            winchange(incm);
        }
    }
}
