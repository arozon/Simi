import QtQuick 2.9
import QtQuick.Controls 2.2
import "../Components"

Flickable {
    property int sidePadding: 5
    property int itemHeight: 50
    property int labelsWidth: 60
    contentHeight: lay.childrenRect.height

    Column {
        id: lay
        spacing: 18
        anchors {
            fill: parent
            leftMargin: sidePadding
            rightMargin: sidePadding
        }

        SectionHeader {
            x: (-1 * sidePadding) / 2
            width: parent.width + sidePadding
            headerText: "OPQRST"
        }

        Repeater {
            id: rep
            model: ["O","P","Q","R","S","T"]
            LabeledTextInput {
                focus: true
                labelWidth: labelsWidth
                labelText: modelData
                mLabel.font.pixelSize: height
                mLabel.color: colora
                Keys.onTabPressed: {
                    var i = rep.itemAt(index + 1);
                    if (i != null) i.mTextInput.forceActiveFocus(); else; rep.itemAt(0).mTextInput.forceActiveFocus();
                }
                mLabel.horizontalAlignment: Text.AlignHCenter
                onTextInputTextChanged: {
                    switch (index) {
                    case 0:
                        o = textInputText;
                        break;
                    case 1:
                        p = textInputText;
                        break;
                    case 2:
                        q = textInputText;
                        break;
                    case 3:
                        r = textInputText;
                        break;
                    case 4:
                        s = textInputText;
                        break;
                    case 5:
                        t = textInputText;
                        break;
                    default:
                        break;
                    }
                }
            }
        }
    }
}
