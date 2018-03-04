import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Components"

Flickable {
    property int sidePadding: 5
    property int itemHeight: 38
    contentHeight: lay.childrenRect.height

    Column {
        id: lay
        spacing: 6
        anchors {
            fill: parent
            leftMargin: sidePadding
            rightMargin: sidePadding
        }

        SectionHeader {
            x: (-1 * sidePadding) / 2
            width: parent.width + sidePadding
            headerText: "Information patient"
        }

        LabeledTextInput {
            id: k1
            focus: true
            height: itemHeight
            width: parent.width
            labelText: "Nom"
            KeyNavigation.tab: k2.mTextInput
            onTextInputTextChanged: {
                vnom = textInputText;
            }
        }
        LabeledTextInput {
            id: k2
            focus: true
            height: itemHeight
            KeyNavigation.tab: k3.mTextInput
            width: parent.width
            labelText: "Prénom"
            onTextInputTextChanged: {
                vprenom = textInputText;
            }
        }
        LabeledTextInput {
            id: k3
            focus: true
            height: itemHeight
            KeyNavigation.tab: k4.firstInput
            width: parent.width
            labelText: "Age"
            onTextInputTextChanged: {
                vage = textInputText
            }
        }
        Flow {
            height: childrenRect.height
            width: parent.width
            clip: true
            move: Transition { NumberAnimation { properties: "x,y"; duration: 300; } }
            Behavior on height {
                NumberAnimation { duration: 300 }
            }

            RadioButton {
                text: "Homme"
                width: implicitWidth > parent.width ? parent.width : implicitWidth
                onClicked: {
                    vsex = "m";
                }

            }
            RadioButton {
                text: "Femme"
                width: implicitWidth > parent.width ? parent.width : implicitWidth
                onClicked: {
                    vsex = "f"
                }

            }
        }
        Flow {
            spacing: 10
            clip: true
            width: parent.width
            height: childrenRect.height
            move: Transition { NumberAnimation { properties: "x,y"; duration: 300; } }
            Behavior on height {
                NumberAnimation { duration: 300 }
            }

            Label {
                id: l1
                height: itemHeight
                width: implicitWidth > parent.width ? parent.width : implicitWidth
                elide: "ElideRight"
                text: "Date de naissance (JJ/MM/YYYY)"
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: itemHeight * 0.4
            }

            DateInput {
                id: k4
                nextInput: k5.mTextInput
                width: 150 < l1.width ? l1.width : 150
                height: itemHeight
                spacing: 5
                onCurrentDateChanged: {
                    vnaiss = currentDate;
                }
            }

        }
        LabeledTextInput {
            id: k5
            KeyNavigation.tab: k6.mTextInput
            height: itemHeight
            width: parent.width
            labelText: "Adresse"
            onTextInputTextChanged: {
                vadresse = textInputText;
            }
        }
        LabeledTextInput {
            id: k6
            height: itemHeight
            KeyNavigation.tab: k7.mTextInput
            width: parent.width
            labelText: "Ville"
            onTextInputTextChanged: {
                vville = textInputText;
            }
        }
        LabeledTextInput {
            id: k7
            height: itemHeight
            KeyNavigation.tab: k8.mTextInput
            width: parent.width
            labelText: "Autre"
            onTextInputTextChanged: {
                console.log(textInputText);
                vautre = textInputText;
            }
        }
        LabeledTextInput {
            id: k8
            KeyNavigation.tab: k9.mTextInput
            height: itemHeight
            width: parent.width
            labelText: "Code Postal"
            onTextInputTextChanged: {
                vcodepostal = textInputText;
            }
        }
        LabeledTextInput {
            id: k9
            KeyNavigation.tab: k1.mTextInput
            height: itemHeight
            width: parent.width
            labelText: "Téléphone"
            onTextInputTextChanged: {
                vtelephone = textInputText;
            }
        }
    }
}
