import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Components"

Flickable {
    property int sidePadding: 5 // Padding from the sides of the view
    property int itemHeight: 80 // The height of each item
    property int itemMargins: 3 // The margins of the items in item rectangles
    property int bigLabelWidth: 50 // The width of the label on the left
    property double smallLabelOpacity: 0.6 // Opacity of the label at the top of items
    property int gridRowColFactor: 100
    property color rectBColor: colora
    property color bigLabelColor: colora
    property color smallLabelColor: colora
    contentHeight: lay.childrenRect.height

    Column {
        id: lay
        spacing: 12
        anchors {
            fill: parent
            leftMargin: sidePadding
            rightMargin: sidePadding
        }

        SectionHeader {
            x: (-1 * sidePadding) / 2
            width: parent.width + sidePadding
            headerText: "Évaluation Primaire"
        }


        Rectangle {
            width: parent.width
            color: "white"
            radius: 3
            border.width: 1
            border.color: rectBColor
            height: itemHeight

            RowLayout {
                anchors {
                    fill: parent
                    margins: itemMargins
                }
                Label {
                    font.pixelSize: itemHeight * 0.8
                    color: bigLabelColor
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: bigLabelWidth
                    elide: "ElideRight"
                    text: "L'"
                    Layout.minimumWidth: bigLabelWidth
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ColumnLayout {                                    
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Label {
                        font.pointSize: itemHeight * 0.15
                        Layout.minimumHeight: itemHeight * 0.4
                        text: "État de conscience"
                        font.italic: true
                        color: smallLabelColor
                        opacity: smallLabelOpacity
                        verticalAlignment: Text.AlignBottom
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        elide: "ElideRight"
                    }
                    RowLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        RadioButton {
                            text: "Reaction"
                            Layout.maximumWidth: implicitWidth
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                epreaction = "1";
                            }
                        }
                        RadioButton {
                            text: "Aucune Reaction"
                            Layout.maximumWidth: implicitWidth
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                epreaction = "0";
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            width: parent.width
            color: "white"
            radius: 3
            border.width: 1
            border.color: rectBColor
            height: itemHeight

            RowLayout {
                anchors {
                    fill: parent
                    margins: itemMargins
                }
                Label {
                    font.pixelSize: itemHeight * 0.8
                    color: bigLabelColor
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: bigLabelWidth
                    elide: "ElideRight"
                    text: "A"
                    Layout.minimumWidth: bigLabelWidth
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Label {
                        font.pointSize: itemHeight * 0.15
                        Layout.minimumHeight: itemHeight * 0.4
                        text: "Voies respiratoires"
                        font.italic: true
                        color: smallLabelColor
                        opacity: smallLabelOpacity
                        verticalAlignment: Text.AlignBottom
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        elide: "ElideRight"
                    }
                    RowLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        RadioButton {
                            text: "Ouvertes"
                            Layout.maximumWidth: implicitWidth
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                epvoiesr = "1";
                            }
                        }
                        RadioButton {
                            text: "Obstruées"
                            Layout.maximumWidth: implicitWidth
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                epvoiesr = "0";
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            width: parent.width
            color: "white"
            radius: 3
            border.width: 1
            border.color: rectBColor
            height: itemHeight

            RowLayout {
                anchors {
                    fill: parent
                    margins: itemMargins
                }
                Label {
                    font.pixelSize: itemHeight * 0.8
                    color: bigLabelColor
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: bigLabelWidth
                    elide: "ElideRight"
                    text: "B"
                    Layout.minimumWidth: bigLabelWidth
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Label {
                        font.pointSize: itemHeight * 0.15
                        Layout.minimumHeight: itemHeight * 0.4
                        text: "Respiration"
                        font.italic: true
                        color: smallLabelColor
                        opacity: smallLabelOpacity
                        verticalAlignment: Text.AlignBottom
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        elide: "ElideRight"
                    }
                    RowLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        RadioButton {
                            text: "Adéquate"
                            Layout.maximumWidth: implicitWidth
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                eprespiration = "1";
                            }
                        }
                        RadioButton {
                            text: "Inadéquate"
                            Layout.maximumWidth: implicitWidth
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                eprespiration = "0";
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            width: parent.width
            color: "white"
            radius: 3
            border.width: 1
            border.color: rectBColor
            height: itemHeight

            RowLayout {
                anchors {
                    fill: parent
                    margins: itemMargins
                }
                Label {
                    font.pixelSize: itemHeight * 0.8
                    color: bigLabelColor
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: bigLabelWidth
                    elide: "ElideRight"
                    text: "C"
                    Layout.minimumWidth: bigLabelWidth
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Label {
                        font.pointSize: itemHeight * 0.15
                        Layout.minimumHeight: itemHeight * 0.4
                        text: "Pouls"
                        font.italic: true
                        color: smallLabelColor
                        opacity: smallLabelOpacity
                        verticalAlignment: Text.AlignBottom
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        elide: "ElideRight"
                    }
                    RowLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        RadioButton {
                            text: "Présent"
                            Layout.maximumWidth: implicitWidth
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                eppouls = "1";
                            }
                        }
                        RadioButton {
                            text: "Abscent"
                            Layout.maximumWidth: implicitWidth
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                eppouls = "0";
                            }
                        }
                    }
                }
            }
        }


        Rectangle {
            // Set the height of the rectangle when the flow changes height
            id: r1
            clip: true
            width: parent.width
            color: "white"
            radius: 3
            border.width: 1
            border.color: rectBColor
            height: lay2.implicitHeight + 2*itemMargins
            Behavior on height {
                NumberAnimation {
                    duration: 400
                }
            }
            RowLayout {
                anchors {
                    fill: parent
                    margins: itemMargins
                }
                width: parent.width
                Label {
                    font.pixelSize: itemHeight * 0.8
                    color: bigLabelColor
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: bigLabelWidth
                    elide: "ElideRight"
                    text: "D"
                    Layout.minimumWidth: bigLabelWidth
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                ColumnLayout {
                    id: lay2
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Label {
                        text: "Niveau de conscience"
                        font.pointSize: itemHeight * 0.15
                        Layout.minimumHeight: itemHeight * 0.4
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        font.italic: true
                        color: smallLabelColor
                        opacity: smallLabelOpacity
                        verticalAlignment: Text.AlignBottom
                        Layout.fillHeight: false
                        Layout.fillWidth: true
                        elide: "ElideRight"
                    }
                    Flow {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        RadioButton {
                            text: "Alerte"
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                epnivecon = "0"
                            }
                        }
                        RadioButton {
                            text: "Verbal"
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                epnivecon = "1"
                            }
                        }
                        RadioButton {
                            text: "Stimuli Verbal"
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                epnivecon = "2"
                            }
                        }
                        RadioButton {
                            text: "Stimuli Douleur"
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                epnivecon = "2"
                            }
                        }
                        RadioButton {
                            text: "Reaction"
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            onClicked: {
                                epnivecon = "3"
                            }
                        }
                    }
                }
            }
        }
    }
}
