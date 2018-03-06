import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    property int sidePadding: 5

    property string firstCheckText: "Rapport"
    property string secondCheckText: "Inventaire"

    signal firstCheck(bool st)
    signal secondCheck(bool st)


    border.color: "grey"
    height: 50
    border.width: 1
    CheckBox {
        id: docs
        height: implicitHeight
        width: docs.implicitWidth + inv.implicitWidth + 2*sidePadding > parent.width ? (parent.width - 2*sidePadding)/ 2 : implicitWidth
        x: parent.width - sidePadding - width
        checked: true
        text: firstCheckText
        onCheckedChanged: {
            firstCheck(checked);
        }
    }

    CheckBox {
        id: inv
        height: implicitHeight
        width: docs.implicitWidth + inv.implicitWidth + 2*sidePadding > parent.width ? (parent.width - 2*sidePadding)/ 2 : implicitWidth
        x: docs.x - width - 2*sidePadding
        checked: true
        text: secondCheckText
        onCheckedChanged: {
            secondCheck(checked);
        }
    }
}
