import QtQuick 2.8
import QtQuick.Window 2.0
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

Pane {
    id: base
    visible: false
    property int visibleY: parent.height / 4
    property int hiddenY: parent.height
    property int animationDuration: 300
    state: "hidden"

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
}
