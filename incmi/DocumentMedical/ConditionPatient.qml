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
        spacing: 12
        anchors {
            fill: parent
            leftMargin: sidePadding
            rightMargin: sidePadding
        }

        SectionHeader {
            x: (-1 * sidePadding) / 2
            width: parent.width + sidePadding
            headerText: "Médicament"
        }

        MultilineTextInput {
            height: itemHeight * 4
            onCurrentTextChanged: {
                medicaments = currentText;
            }
        }

        SectionHeader {
            x: (-1 * sidePadding) / 2
            width: parent.width + sidePadding
            headerText: "Allergies"
        }

        CheckBox {
            height: itemHeight
            width: parent.width
            text: "Allergies Inconnue"
            onCheckStateChanged: {
                switch (checkState) {
                case (Qt.Checked):
                    t1.enabled = false;
                    break;
                case (Qt.Unchecked):
                    t1.enabled = true;
                    break;
                }
                ainconnu = checked.toString();
            }
        }

        CustomTextBox {
            id: t1
            height: itemHeight
            width: parent.width
            onCurrentTextChanged: {
                alergies = currentText;
            }
            onEnabledChanged: {
                if (!enabled) alergies = "";
            }
        }

        CheckBox {
            height: itemHeight
            width: parent.width
            text: "Non Applicable"
            onCheckStateChanged: {
                switch (checkState) {
                case (Qt.Checked):
                    t2.enabled = true;
                    break;
                case (Qt.Unchecked):
                    t2.enabled = false;
                    break;
                }
                ana = checked.toString();
            }
        }

        CustomTextBox {
            id: t2
            height: itemHeight
            width: parent.width
            enabled: false
            onCurrentTextChanged: {
                alergies2 = currentText;
            }

            onEnabledChanged: {
                if (!enabled) alergies2 = "";
            }
        }

        SectionHeader {
            x: (-1 * sidePadding) / 2
            width: parent.width + sidePadding
            headerText: "Antécédents Médicaux"
        }

        Flow {
            width: parent.width
            height: childrenRect.height

            Repeater {
                id: rep
                model: ["AVC","Cardiaque","Diabète","Épliepsie","Hyper/Hypo Tension","Autre"]
                CheckBox {
                    text: modelData
                    Layout.maximumHeight: itemHeight
                    Layout.minimumWidth: implicitWidth
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    onCheckStateChanged: {
                        switch(index) {
                        case 0:
                            amacv = checked.toString();
                            break;
                        case 1:
                            amcardiaque = checked.toString();
                            break;
                        case 2:
                            amdiabete = checked.toString();
                            break;
                        case 3:
                            amepliepsie = checked.toString();
                            break;
                        case 4:
                            amhyperhypo = checked.toString();
                            break;
                        case 5:
                            switch (checkState) {
                            case (Qt.Checked):
                                t3.enabled = true;
                                break;
                            case (Qt.Unchecked):
                                t3.enabled = false;
                                break;
                            }
                            amautre = checked.toString();
                            break;
                        default:

                            break;
                        }
                    }
                }
            }
        }

        MultilineTextInput {
            id: t3
            height: itemHeight * 4
            enabled: false
            onCurrentTextChanged: {
                amdescription = currentText;
            }
            onEnabledChanged: {
                if (!enabled) amdescription = "";
            }
        }
    }

}

