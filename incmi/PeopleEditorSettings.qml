import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    height: parent.height
    width: parent.width
    property int pad: 5
    property int textboxheight: 30
    property bool cansave: false

    function ready() {
        if (!isnew) {
            tfirstname.textField.text = currentobj.firstname;
            tlastname.textField.text = currentobj.lastname;
            tmatricule.textField.text = currentobj.matricule;
            temail.textField.text = currentobj.email;
            trole.textField.text = currentobj.role;
            tpassword.textField.text = currentobj.password;
            if (currentobj.isadmin) {
                sadmin.checkState = Qt.Checked
            }
        }
    }


    Item {
        y: pad
        x: pad
        width: parent.width - 2*pad
        height: parent.height - 3*pad - buttonfooter.height

        CLabeledTextField {
            id: tfirstname
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: pad
            label.text: "First name :"
            labelLength: label.implicitWidth
            textField.onTextChanged: {
                checkSave();
            }

        }
        CLabeledTextField {
            id: tlastname
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: tfirstname.y + tfirstname.height + pad
            label.text: "Lastname :"
            labelLength: tfirstname.label.implicitWidth
            textField.onTextChanged: {
                checkSave();
            }

        }

        CLabeledTextField {
            id: tmatricule
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: tlastname.y + tlastname.height + pad
            label.text: "Matricule :"
            labelLength: tfirstname.label.implicitWidth
            textField.onTextChanged: {
                checkSave();
            }

        }



        CLabeledTextField {
            id: temail
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: tmatricule.y + tmatricule.height + pad
            label.text: "Email :"
            labelLength: tfirstname.label.implicitWidth
        }

        CLabeledTextField {
            id: trole
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: temail.y + temail.height + pad
            label.text: "Role :"
            labelLength: tfirstname.label.implicitWidth
        }

        CLabeledTextField {
            id: tpassword
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: trole.y + trole.height + pad
            label.text: "Password :"
            labelLength: tfirstname.label.implicitWidth
            textField.onTextChanged: {
                checkSave();
            }

        }
        CheckBox {
            id: sadmin
            x: 2*pad + tfirstname.label.implicitWidth
            y: tpassword.y + tpassword.height + pad
            height: textboxheight
            width: parent.width - 3*pad - tpassword.width
            text: "Is Administrator"
        }
    }

    Item {
        id: buttonfooter
        x: pad
        y: parent.height - buttonfooter.height - pad
        height: 70
        width: parent.width - 2*pad
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

    function checkSave() {
        if (tfirstname.textField.text == "" || tlastname.textField.text == "" || tmatricule.textField.text == ""){
            cansave = false;
        }
        else {
            cansave = true;
        }
    }

    function save() {
        var obj = JSON.parse(peoplebase);
        obj.firstname = tfirstname.textField.text;
        obj.lastname = tlastname.textField.text;
        obj.email = temail.textField.text;
        obj.role = trole.textField.text;
        obj.matricule = tmatricule.textField.text;
        obj.password = tpassword.textField.text;
        obj.isadmin = sadmin.checked;
        if (isnew) {
            addPerson(obj);
        }
        else{
            obj.filename = currentobj.filename;
            editPeople(obj);
        }
    }
}

