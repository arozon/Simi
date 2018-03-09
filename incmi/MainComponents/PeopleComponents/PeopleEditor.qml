import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "../../Components" as Comps

Item {
    property int pad: 5
    property int footerHeight: 70
    property int textboxheight: 36
    property bool cansave: false
    property int itemSpacing: 12

    function ready() {
        if (!isnew) {
            console.log(JSON.stringify(currentobj));
            tfirstname.mTextInput.text = currentobj.firstname;
            tlastname.mTextInput.text = currentobj.lastname;
            tmatricule.mTextInput.text = currentobj.matricule;
            temail.mTextInput.text = currentobj.email;
            trole.mTextInput.text = currentobj.role;
            if (currentobj.isadmin) {
                sadmin.checkState = Qt.Checked
            }
        }
    }

    function checkSave() {
        if (tfirstname.textInputText === "" || tlastname.textInputText === "" || tmatricule.textInputText === ""){
            cansave = false;
        }
        else {
            cansave = true;
        }
    }

    function save() {
        var obj = {};
        obj.firstname = tfirstname.textInputText;
        obj.lastname = tlastname.textInputText;
        obj.email = temail.textInputText;
        obj.role = trole.textInputText;
        obj.matricule = tmatricule.textInputText;
        obj.password = tpassword.textInputText;
        obj.isadmin = sadmin.checked;
        if (isnew) {
            addPerson(obj);
        }
        else{
            obj.filename = currentobj.filename;
            editPeople(obj);
        }
    }

    Flickable {
        id: body
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: footer.top
            rightMargin: pad
            leftMargin: pad
            topMargin: pad
        }

        contentHeight: lay.childrenRect.height

        Column {
            id: lay
            anchors.fill: parent
            spacing: itemSpacing
            Comps.LabeledTextInput {
                id: tfirstname
                height: textboxheight
                labelText: "First name"
                onTextInputTextChanged: {
                    checkSave();
                }

            }
            Comps.LabeledTextInput {
                id: tlastname
                height: textboxheight
                labelText: "Last name"
                onTextInputTextChanged: {
                    checkSave();
                }

            }
            Comps.LabeledTextInput {
                id: tmatricule
                height: textboxheight
                labelText: "Matricule"
                onTextInputTextChanged: {
                    checkSave();
                }

            }
            Comps.LabeledTextInput {
                id: temail
                height: textboxheight
                labelText: "Email"
                onTextInputTextChanged: {
                    checkSave();
                }

            }
            Comps.LabeledTextInput {
                id: trole
                height: textboxheight
                labelText: "First name"
                onTextInputTextChanged: {
                    checkSave();
                }

            }
            Comps.LabeledTextInput {
                id: tpassword
                height: textboxheight
                labelText: "Password"
                onTextInputTextChanged: {
                    checkSave();
                }

            }
            CheckBox {
                id: sadmin
                height: textboxheight
                width: implicitWidth > parent.width ? parent.width : implicitWidth
                text: "Is Administrator"
                anchors {
                    right: parent.right
                }
            }

        }
    }

    Rectangle {
        id: footer

        anchors {
            left:parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: 1
            rightMargin: 1
            bottomMargin: 1
        }
        height: footerHeight

        Button {
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width * 3 / 4 - pad
            text: "Cancel"
            Material.background: colorp
            Material.foreground: colorlt
            onClicked: {
                seeList();
            }
        }
        Button {
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width / 2 - pad
            Material.background: colorp
            Material.foreground: colorlt
            enabled: cansave
            text: "Save"
            onClicked: {
                save();
                seeList();
            }
        }
    }
}

