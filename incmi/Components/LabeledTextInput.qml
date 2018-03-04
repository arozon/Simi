import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

RowLayout {
    spacing: 5
    height: 35
    width: parent.width
    property int labelWidth: 0
    property alias mLabel: lb1
    property alias mTextInput: t1.input
    property int textInputPadding: 2
    property string labelText: "Default"
    property string textInputText: ""
    Label {
        id: lb1
        verticalAlignment: Text.AlignVCenter
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.minimumWidth: labelWidth <= 0 ? implicitWidth : labelWidth
        Layout.maximumWidth: labelWidth <= 0 ? implicitWidth : labelWidth
        text: labelText
    }
    CustomTextBox {
        id: t1
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.topMargin: textInputPadding
        Layout.bottomMargin: textInputPadding
        onCurrentTextChanged: {
            textInputText = currentText;
        }
    }

}
