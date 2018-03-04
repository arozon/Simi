import QtQuick 2.9
import QtQuick.Controls 2.2
import "../Components"

Flickable {
    property int sidePadding: 5
    property int itemHeight: 38
    contentHeight: lay.childrenRect.height

    Column {
        id: lay
        spacing: 8
        anchors {
            fill: parent
            leftMargin: sidePadding
            rightMargin: sidePadding
        }
        SectionHeader {
            x: (-1 * sidePadding) / 2
            width: parent.width  + sidePadding
            headerText: "Descriptions Cas"
        }

        MultilineTextInput {
            height: itemHeight * 8
            onCurrentTextChanged: {
                descriptioncas = currentText;
            }
        }
    }
}
