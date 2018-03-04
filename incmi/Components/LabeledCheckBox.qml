import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

RowLayout {
    height: 35
    width: parent.width
    property bool isChecked: false
    property string checkText: "Default"
    property string labelText: "Default"
    Label {
        text: labelText
        leftPadding: 3
        Layout.maximumWidth: implicitWidth
        Layout.fillHeight: true
        Layout.fillWidth: true
        verticalAlignment: Text.AlignVCenter
    }
    CheckBox {
        text: checkText
        Layout.fillHeight: true
        Layout.fillWidth: true
        onCheckedChanged:  {
            isChecked = checked;
        }
    }
}
