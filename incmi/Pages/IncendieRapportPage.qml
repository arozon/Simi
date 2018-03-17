import QtQuick 2.7
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../Components" as Comps
import "../Prompts" as Dialogs
import "../DocumentIncendie" as Pages

Rectangle {
    property int xd: 30
    property int labellength
    property int lrectheight: 40
    property bool contentEnabled: true

    // All properties to write to for saving...

    property string date
    property string time
    property string adresse
    property string ville
    property string type: "docs"
    property string nature
    property var people: []
    property var other: []
    property string femme
    property string homme
    property string enfant
    Material.accent: colora



    function save() {
        // do all the saving work to create a JSON file and send it to the websocket.
        var obj = JSON.parse(incdocumentbase.slice(0,-1) + ',"messageindex":"20"}');
        obj.date = date;
        var person = JSON.parse(settings.user);
        obj.name = person.firstname + " " + person.lastname;
        obj.matricule = person.matricule;
        obj.time = time;
        obj.adresse = adresse;
        obj.ville = ville;
        obj.type = type;
        obj.nature = nature;
        obj.people = people;
        obj.other = other;
        obj.femme = femme;
        obj.homme = homme;
        obj.enfant = enfant;
        addMessage(JSON.stringify(obj));
        sendSavedInformation();
    }

    Component.onCompleted: {
        if (useSafeAreaPadding) {
            view.topPadding = safeAreaSize;
        }
    }

    SwipeView {
        id: view
        clip: true
        visible: contentEnabled
        topPadding: 10
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: indicator.top
        }

        currentIndex: 0
        Item {
            Loader {
                width: parent.width
                height: parent.height
                active: true
                sourceComponent: firstpage
            }
        }
        Item {
            Loader {
                width: parent.width
                height: parent.height
                active: true
                sourceComponent: secondpage
            }
        }
        Item {
            Loader {
                width: parent.width
                height: parent.height
                active: true
                sourceComponent: thirdpage
            }
        }

    }
    PageIndicator {
        id: indicator
        count: view.count
        currentIndex: view.currentIndex
        height: implicitHeight
        visible: contentEnabled
        width: implicitWidth > parent.width ? parent.width : implicitWidth
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: footer.top
        }
    }
    Comps.ConfirmationPageFooter {
        id: footer
        enabled: contentEnabled
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        onConfirm: {
            contentEnabled = false;
            promptconfirmsave.show();
        }
        onCancel: {
            contentEnabled = false;
            promptconfirmleave.show();
        }

    }


    Component {
        id: firstpage
        Pages.IncRapportFirstPage {}
    }
    Component {
        id: secondpage
        Pages.IncRapportSecondPage {}
    }
    Component {
        id: thirdpage
        Pages.IncRapportThirdPage {}
    }


    Dialogs.ConfirmPrompt {
        id: promptconfirmsave
        onCancelDialog: {
            contentEnabled = true;
            promptconfirmsave.hide();
        }

        onConfirmDialog: {
            save();
            winchange(incm);
        }
    }
    Dialogs.CancelPrompt {
        id: promptconfirmleave
        onCancelDialog: {
            contentEnabled = true;
            promptconfirmleave.hide();
        }

        onConfirmDialog: {
            winchange(incm);
        }

    }
}

