import QtQuick 2.8
import QtQuick.Window 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

Pane {
    id: base
    visible: false
    x: parent.width / 14
    width: parent.width - 2*x
    height: parent.height / 3
    property int visibleY: parent.height / 3
    property int hiddenY: parent.height
    property int animationDuration: 300
    property int labelMargin: parent.width / 8
    property string labelText: ""
    property string cancelText: ""
    property string confirmText: ""
    property int minimumDialogWidth: 200
    property int verticalSideMargins: parent.width / 20
    property int horizontalSideMargins: parent.height / 45
    property int buttonAreaHeight: 50
    signal cancelDialog()
    signal confirmDialog()

    Material.background: colora
    Material.elevation: 8
    state: "hidden"

    Component.onCompleted: {
        var os = Qt.platform.os;
        if (os === "windows" || os === "linux" || os === "osx") {
            // Set windows design;

            x = Qt.binding(function () {
                return parent.width / 5;
            });
        }
    }

    function checkstate(){
        if (state == "hidden"){
            visible = false;
        }
    }

    function show() {
        visible = true;
        state = "visible"
    }

    function hide() {
        state = "hidden"
    }
    states: [
        State { name: "visible";  PropertyChanges {target: base; y: visibleY}},
        State { name: "hidden"; PropertyChanges {target: base; y: hiddenY}}
    ]

    transitions: [
        Transition {
            from: "visible"
            to: "hidden"
            SequentialAnimation {
                NumberAnimation { properties: "y"; duration: animationDuration; easing.type: Easing.OutQuad }
                ScriptAction {
                    script: checkstate();
                }
            }
        },
        Transition {
            from: "hidden"
            to: "visible"
            SequentialAnimation {
                NumberAnimation { properties: "y"; duration: animationDuration; easing.type: Easing.OutQuad }
                ScriptAction {
                    script: checkstate();
                }
            }
        }
    ]

    Behavior on opacity {
        SequentialAnimation{
            NumberAnimation { duration: 240; easing.type: Easing.Linear; }
            ScriptAction { script: checkstate(); }
        }
    }


    ColumnLayout {
        anchors {
            fill: parent
            leftMargin: verticalSideMargins
            rightMargin: verticalSideMargins
            topMargin: horizontalSideMargins
            bottomMargin: horizontalSideMargins
        }

        spacing: 5

        Flickable {
            contentWidth: width
            contentHeight: dial.height
            clip: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            Label {
                id: dial
                width: parent.width
                height: implicitHeight
                text: labelText
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
                font.pointSize: 14
                Material.foreground: colorlt
            }

        }
        RowLayout{
            Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            spacing: 15
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumHeight: buttonAreaHeight
            Layout.minimumHeight: buttonAreaHeight
            Button {
                text: cancelText
                Layout.maximumWidth: implicitWidth
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colorp
                onClicked: {
                    cancelDialog();
                }
            }
            Button {
                text: confirmText
                Layout.maximumWidth: implicitWidth
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colorp
                onClicked: {
                    confirmDialog();
                }
            }
        }
    }
}
