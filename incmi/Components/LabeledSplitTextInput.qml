import QtQuick 2.9
import QtQuick.Controls.Material 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
RowLayout {
    height: 35
    width: parent.width
    property int inputCount: 2
    property var strList: []
    property string labelText: "Default"
    property string currentText: ""
    function setCurrentText() {
        var i = 1;
        var text = "";
        if (strList[0] !== undefined) text = strList[0];
        while (i < inputCount) {
            if (strList[i] !== undefined) text += ":" + strList[i];
            i++;
        };
        currentText = text;
    }
    spacing: 8
    Label {
        text: labelText
        verticalAlignment: Text.AlignVCenter
        elide: "ElideRight"
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.minimumWidth: implicitWidth
        Layout.maximumWidth: implicitWidth
    }
    Repeater {
        model: inputCount
        CustomTextBox {
            Layout.fillWidth: true
            Layout.fillHeight: true
            onCurrentTextChanged: {
                strList[index] = currentText;
                setCurrentText();
            }
        }
        onItemAdded: {
            strList[index] = ""
        }
    }
}

