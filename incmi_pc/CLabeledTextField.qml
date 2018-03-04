import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    property int spad: 4
    property int labelLength: 0
    property alias textField: cfield.textBox
    property alias label: clabel

    Label {
        id: clabel
        x: spad
        text: "Default : "
        verticalAlignment: Text.AlignVCenter
        width: labelLength
        height: parent.height
    }
    CTextField {
        id: cfield
        x: labelLength + 2 * spad
        width: parent.width - 3*spad - labelLength
        height: parent.height
        textBox.text: ""
    }

}
