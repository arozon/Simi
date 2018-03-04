import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Components"

Flickable {
    property int sidePadding: 5
    property int itemHeight: 38
    property int flowSpacing: 5
    property double fontSize: itemHeight * 0.4
    property double colSpacing: 2.5
    property int maxTimeWidth: 125
    property int maxDateWidth: 250
    property int animationDuration: 250
    contentHeight: lay.childrenRect.height

    Column {
        id: lay
        spacing: 12
        anchors {
            fill: parent
            leftMargin: sidePadding
            rightMargin: sidePadding
        }

        Column {
            spacing: colSpacing
            width: maxDateWidth > parent.width ? parent.width : maxDateWidth
            anchors {
                right: parent.right
            }

            Label {
                elide: "ElideRight"
                height: implicitHeight
                font.pixelSize: fontSize
                width: implicitWidth > parent.width ? parent.width : implicitWidth
                text: "Date de l'intervention"
                verticalAlignment: Text.AlignBottom
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
            }
            DateTumblerPicker {
                width: parent.width
                height: itemHeight * 2
                onCurrentDateChanged: {
                    dateint = currentDate;
                }
            }
        }
        SectionHeader {
            x: (-1 * sidePadding) / 2
            width: parent.width + sidePadding
            headerText: "Information Événement"
        }

        Flow {
            height: childrenRect.height
            move: Transition { NumberAnimation { properties: "x,y"; duration: animationDuration; } }
            Behavior on height {
                NumberAnimation { duration: animationDuration }
            }
            spacing: flowSpacing

            property int mwidth: (maxTimeWidth * 3) + 3 * spacing

            width: parent.width > mwidth ? mwidth : parent.width;
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            Column {
                spacing: colSpacing
                width: maxTimeWidth > parent.width ? parent.width : maxTimeWidth
                Label {
                    elide: "ElideRight"
                    height: implicitHeight
                    font.pixelSize: fontSize
                    width: implicitWidth > parent.width ? parent.width : implicitWidth
                    text: "Temps arriver"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                TimeTumblerPicker {
                    width: parent.width
                    height: itemHeight * 2
                    onCurrentTimeChanged: {
                        tarriver = currentTime;
                    }
                }
            }
            Column {
                spacing: colSpacing
                width: maxTimeWidth > parent.width ? parent.width : maxTimeWidth
                Label {
                    elide: "ElideRight"
                    height: implicitHeight
                    font.pixelSize: fontSize
                    width: implicitWidth > parent.width ? parent.width : implicitWidth
                    text: "Temps d'appele"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                TimeTumblerPicker {
                    width: parent.width
                    height: itemHeight * 2
                    onCurrentTimeChanged: {
                        tappele = currentTime;
                    }
                }
            }
            Column {
                spacing: colSpacing
                width: maxTimeWidth > parent.width ? parent.width : maxTimeWidth
                Label {
                    elide: "ElideRight"
                    height: implicitHeight
                    font.pixelSize: fontSize
                    width: implicitWidth > parent.width ? parent.width : implicitWidth
                    text: "Temps départs"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                TimeTumblerPicker {
                    width: parent.width
                    height: itemHeight * 2
                    onCurrentTimeChanged: {
                        tdepart = currentTime;
                    }
                }
            }

        }


        LabeledTextInput {
            width: parent.width
            height: itemHeight
            labelText: "Nom de l'opération"
            onTextInputTextChanged: {
                nomoper = textInputText;
            }

        }
        LabeledTextInput {
            width: parent.width
            height: itemHeight
            labelText: "Endroit"
            onTextInputTextChanged: {
                endroit = textInputText;
            }

        }
        LabeledTextInput {
            width: parent.width
            height: itemHeight
            labelText: "Adresse"
            onTextInputTextChanged: {
                adresse = textInputText;
            }

        }
        LabeledTextInput {
            width: parent.width
            height: itemHeight
            labelText: "Ville"
            onTextInputTextChanged: {
                ville = textInputText;
            }

        }
        LabeledTextInput {
            width: parent.width
            height: itemHeight
            labelText: "Autre"
            onTextInputTextChanged: {
                evautre = textInputText;
            }

        }

    }
}
