import QtQuick 2.9
import QtQuick.Layouts 1.3

RowLayout {
    property int animationDuration: 200
    property string currentDate: ""
    property string v1: ""
    property string v2: ""
    property string v3: ""
    property alias firstInput: f1.input
    property alias secondInput: f2.input
    property alias thirdInput: f3.input
    property var nextInput


    property int boxSidePadding: 2



    onV1Changed: {
        setCurrentDate();
    }
    onV2Changed: {
        setCurrentDate();
    }
    onV3Changed: {
        setCurrentDate();
    }

    function setCurrentDate() {
        currentDate = v1 + ":" + v2 + ":" + v3;
    }

    CustomTextBox {
        id: f1
        focus: true
        Layout.fillHeight: true;
        Layout.fillWidth: true;
        sidePadding: boxSidePadding
        padBothSides: true
        input.horizontalAlignment: Text.AlignHCenter;
        input.inputMask: "99"
        KeyNavigation.tab: f2.input
        input.maximumLength: 2
        input.onFocusChanged: {
            if (input.activeFocus) input.cursorPosition = 0
        }

        onCurrentTextChanged: {
            v1 = currentText;
        }

    }
    CustomTextBox {
        id: f2
        focus: true
        Layout.fillHeight: true;
        Layout.fillWidth: true;
        padBothSides: true
        KeyNavigation.tab: f3.input
        sidePadding: boxSidePadding
        input.horizontalAlignment: Text.AlignHCenter;
        input.inputMask: "99"
        input.onFocusChanged: {
            if (input.activeFocus) input.cursorPosition = 0
        }

        input.maximumLength: 2

        onCurrentTextChanged: {
            v2 = currentText;
        }
    }
    CustomTextBox {
        id: f3
        focus: true
        Layout.fillHeight: true;
        padBothSides: true
        Layout.fillWidth: true;
        sidePadding: boxSidePadding
        KeyNavigation.tab: nextInput !== null ? nextInput : null;
        input.horizontalAlignment: Text.AlignHCenter;
        input.inputMask: "9999"
        input.maximumLength: 4
        input.onFocusChanged: {
            if (input.activeFocus) input.cursorPosition = 0
        }

        onCurrentTextChanged: {
            v3 = currentText;
        }
    }
}
