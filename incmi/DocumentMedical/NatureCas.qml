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
            headerText: "Nature Du Cas"
        }

        GridLayout{
            width: parent.width
            columns: Math.floor((parent.width)/150) < 0 ? 1 : Math.floor((parent.width)/150)
            Behavior on height {
                NumberAnimation { duration: 200 }
            }
            Repeater {
                model:[
                    "Abrassion",
                    "Acr / Code",
                    "Convulsion",
                    "Diabète",
                    "Douler Thoracique",
                    "Faibless",
                    "Hyperthermie",
                    "Hypothermie",
                    "Intoxication",
                    "Mal de Tête",
                    "Obstr. Voies Resp.",
                    "Trauma",
                    "Autre",
                ]
                CheckBox {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumHeight: implicitHeight
                    Layout.maximumWidth: implicitWidth
                    text: modelData
                    onCheckStateChanged: {
                        var sch = false;
                        switch(checkState) {
                        case (Qt.Unchecked):
                            sch = false;
                            break;
                        case (Qt.Checked):
                            sch = true;
                            break;
                        default:
                            sch = false;
                            break;
                        }
                        switch (index) {
                        case 0:
                            nabraission = sch.toString();
                            break;
                        case 1:
                            nacr = sch.toString();
                            break;
                        case 2:
                            nconvulsion = sch.toString();
                            break;
                        case 3:
                            ndiabete = sch.toString();
                            break;
                        case 4:
                            ndouleurt = sch.toString();
                            break;
                        case 5:
                            nfaibless = sch.toString();
                            break;
                        case 6:
                            nhyperthermie = sch.toString();
                            break;
                        case 7:
                            nhypothermie = sch.toString();
                            break;
                        case 8:
                            nintoxication = sch.toString();
                            break;
                        case 9:
                            nmaltete = sch.toString();
                            break;
                        case 10:
                            nobstr = sch.toString();
                            break;
                        case 11:
                            ntrauma = sch.toString();
                            break;
                        case 12:
                            ma.enabled = checked;
                            nautre = sch.toString();
                            break;
                        default:
                            break;
                        }
                    }
                }
            }
        }


        MultilineTextInput {
            id: ma
            width: parent.width
            enabled: false;
            height: itemHeight * 3
            onCurrentTextChanged: {
                ndescription = currentText;
            }

            onEnabledChanged: {
                if (!enabled) ndescription = "";
            }

        }
    }
}
