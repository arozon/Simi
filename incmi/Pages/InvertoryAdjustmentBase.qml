import QtQuick 2.4
import QtQuick.Controls.Material 2.2
import QtQuick.Controls 2.2
import "../Components" as Comps
import "../Delegates" as Delegs
import "../Prompts" as Dialogs

Item {
    id: pcontrol
    property bool mEnabled: true
    property alias viewModel: mod

    signal ready()
    signal save()
    signal back()

    Connections {
        target: window
        onDoEvents: {
            ready();
        }
    }
    Component.onCompleted: {
        var os = Qt.platform.os;
        if (os === "windows" || os === "linux" || os === "osx") {
            // Set windows design;

            invListView.anchors.leftMargin = Qt.binding(function () {
                return pcontrol.width / 10;
            });
            invListView.anchors.rightMargin = Qt.binding(function () {
                return pcontrol.width / 10;
            });
            invListView.anchors.topMargin = Qt.binding(function () {
                return 15;
            });
        }
    }

    ListView {
        clip: true
        enabled: mEnabled
        id: invListView
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: pane.top
            topMargin: useSafeAreaPadding ? safeAreaSize : 10
        }
        header: Delegs.InventoryAdjustmentHeader {}
        headerPositioning: ListView.PullBackHeader
        spacing: 3
        delegate: Delegs.InventoryAdjustementDelegate {}
        model: ListModel {id: mod}
        add: Transition { NumberAnimation { properties: "x"; from: width; duration: 300; easing.type: Easing.OutQuad }}
    }

    Comps.ConfirmationPageFooter {
        enabled: mEnabled
        id: pane
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        onCancel: {
            mEnabled = false;
            promptconfirmleave.show();
        }
        onConfirm: {
            mEnabled = false;
            promptconfirmsave.show();
        }
    }
    Dialogs.ConfirmPrompt {
        id: promptconfirmsave
        onCancelDialog: {
            mEnabled = true;
            promptconfirmsave.hide();
        }

        onConfirmDialog: {
            save();
        }
    }
    Dialogs.CancelPrompt {
        id: promptconfirmleave
        onCancelDialog: {
            mEnabled = true;
            promptconfirmleave.hide();
        }

        onConfirmDialog: {
            back();
        }
    }
}
