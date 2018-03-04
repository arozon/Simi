import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "../Components"

Flickable {
    width: 360
    height: 760
    contentHeight: lay.childrenRect.height
    property int textBoxHeight: 38
    property int sidePadding: 5
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
            width: parent.width + sidePadding
            headerText: "1. Signes Vitaux et État de Consience"
        }

        LabeledSplitTextInput {
            inputCount: 2
            labelText: "HRE"
            height: textBoxHeight
            onCurrentTextChanged: {
                console.log(currentText);
                svep1hre = currentText;
            }
        }
        LabeledTextInput {
            labelText: "RESP (60:100) / Min"
            height: textBoxHeight
            onTextInputTextChanged: {
                svep1resp = textInputText
            }
        }
        LabeledTextInput {
            labelText: "POULS (60:100) / Min"
            height: textBoxHeight
            onTextInputTextChanged: {
                svep1pouls = textInputText
            }
        }
        LabeledSplitTextInput {
            inputCount: 2
            labelText: "T.A (120:80)"
            height: textBoxHeight
            onCurrentTextChanged: {
                svep1ta = currentText
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "A"
            checkText: "ALERTE"
            onIsCheckedChanged: {
                svep1alert = isChecked.toString()
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "V"
            checkText: "STI. VERBAL"
            onIsCheckedChanged: {
                svep1stv = isChecked.toString();
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "P"
            checkText: "STI. DOULEUR"
            onIsCheckedChanged: {
                svep1std = isChecked.toString();
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "U"
            checkText: "AUCUNE REACTION"
            onIsCheckedChanged: {
                svep1nr = isChecked.toString();
            }
        }
        Item {
            width: parent.width
            height: textBoxHeight * 1.5
        }

        SectionHeader {
            x: -1 * sidePadding / 2
            width: parent.width + sidePadding
            headerText: "2. Signes Vitaux et État de Consience"
        }

        LabeledSplitTextInput {
            inputCount: 2
            labelText: "HRE"
            height: textBoxHeight
            onCurrentTextChanged: {
                svep2hre = currentText;
            }
        }
        LabeledTextInput {
            labelText: "RESP (60:100) / Min"
            height: textBoxHeight
            onTextInputTextChanged: {
                svep2resp = textInputText
            }
        }
        LabeledTextInput {
            labelText: "POULS (60:100) / Min"
            height: textBoxHeight
            onTextInputTextChanged: {
                svep2pouls = textInputText
            }
        }
        LabeledSplitTextInput {
            inputCount: 2
            labelText: "T.A (120:80)"
            height: textBoxHeight
            onCurrentTextChanged: {
                svep2ta = currentText
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "A"
            checkText: "ALERTE"
            onIsCheckedChanged: {
                svep2alert = isChecked.toString()
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "V"
            checkText: "STI. VERBAL"
            onIsCheckedChanged: {
                svep2stv = isChecked.toString();
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "P"
            checkText: "STI. DOULEUR"
            onIsCheckedChanged: {
                svep2std = isChecked.toString();
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "U"
            checkText: "AUCUNE REACTION"
            onIsCheckedChanged: {
                svep2nr = isChecked.toString();
            }
        }

        Item {
            width: parent.width
            height: textBoxHeight * 1.5
        }

        SectionHeader {
            x: -1 * sidePadding / 2
            width: parent.width + sidePadding
            headerText: "2. Signes Vitaux et État de Consience"
        }

        LabeledSplitTextInput {
            inputCount: 2
            labelText: "HRE"
            height: textBoxHeight
            onCurrentTextChanged: {
                svep3hre = currentText;
            }
        }
        LabeledTextInput {
            labelText: "RESP (60:100) / Min"
            height: textBoxHeight
            onTextInputTextChanged: {
                svep3resp = textInputText
            }
        }
        LabeledTextInput {
            labelText: "POULS (60:100) / Min"
            height: textBoxHeight
            onTextInputTextChanged: {
                svep3pouls = textInputText
            }
        }
        LabeledSplitTextInput {
            inputCount: 2
            labelText: "T.A (120:80)"
            height: textBoxHeight
            onCurrentTextChanged: {
                svep3ta = currentText
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "A"
            checkText: "ALERTE"
            onIsCheckedChanged: {
                svep3alert = isChecked.toString()
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "V"
            checkText: "STI. VERBAL"
            onIsCheckedChanged: {
                svep3stv = isChecked.toString();
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "P"
            checkText: "STI. DOULEUR"
            onIsCheckedChanged: {
                svep3std = isChecked.toString();
            }
        }
        LabeledCheckBox {
            height: textBoxHeight
            labelText: "U"
            checkText: "AUCUNE REACTION"
            onIsCheckedChanged: {
                svep3nr = isChecked.toString();
            }
        }
    }
}

