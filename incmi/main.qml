import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import Qt.labs.settings 1.0
import QtQuick.Controls 2.2
import QtWebSockets 1.1


Window {
    id: window
    height: 640
    width: 360
    visible: true
    title: qsTr("Simi")

    property color colorb: "#BDBDBD"
    property color colorst: "#757575"
    property color colort: "#212121"
    property color colorlt: "#FFFFFF"
    property color colorp: "#03A9F4"
    property color colorlp: "#B3E5FC"
    property color colordp: "#006da9"
    property color colora: "#607D8B"



    //                              All global properties
    Material.accent: colora
    property var currentwindow
    property bool changes
    property string naturedoc: "0"
    property string currentfilename: ""
    property string imgurl: ""
    property variant mess: []
    property string currenttype
    property string peoplebase: '{"firstname":"","lastname":"","email":"","matricule":"","role":"","filename":"","isadmin":"false","password":""}'
    property string inventoryitembase: '{"name":"", "count":"", "rcount":"", "tag":""}'
    property string eventitembase: '{"date":"","hour":"","lieu":"","details":"","people":[],"tag":"","type":""}'
    property string serversettingsbase: '{"sport":"","shost":"","smpush":"","semaccount":"","sempassword":"","scnew":"","scedit":"","scremind":"","scremove":"","scadmincommit":"","scbackup":""}'
    property string incdocumentbase: '{"date":"","name":"","matricule":"","time":"","adresse":"","ville":"","type":"","nature":"","people":[],"other":[],"femme":"","homme":"","enfant":""}'
    property string incserviceslist: '{"items":["Blainville","Saint-Therese"]}'

    /*  Main material color scheme (to be applied to all controls.
        colorb  Border color / seperator /
        colorst Secondary text color
        colort  primary text color
        colorp  primary back color
        colorlp primary light color
        colordp dark primary back color
        colora  accentuated object color (accent)
    */

    onActiveChanged: {
        if (!active) {
            Qt.quit();
        }
    }



    //Saves the applications settings
    Settings {
        id: settings
        //Setting for the type of user. 0 - default, 1 - base, 2 - admin
        property bool isadmin: false;
        property variant messages: []
        property string user: "{}"
        property bool isfirstboot: true;
        property string password: ""
    }

    function resetSettings() {
        settings.isadmin = false;
        settings.user = "";
        settings.isfirstboot = true;
    }

    function getFullName() {
        var n = ""
        if (settings.user != "") {
            var obj = JSON.parse(settings.user);
            n = obj.firstname + " " + obj.lastname;
        }
        return n;
    }

    function getMatricule() {
        var n = ""
        if (settings.user != ""){
            var obj = JSON.parse(settings.user);
            n = obj.matricule;
        }
        return n;
    }


    function sendSavedInformation() {
        if (settings.messages.length > 0) {
            if (!msocket.active) {
                msocket.active = true;
            }
        }
    }

    function addMessage(message) {
        var ms = message.slice(0, message.length - 1) + ',"account":["'+JSON.parse(settings.user).filename + '","'+settings.password+'"]}';
        mess.push(ms);
        settings.messages = mess;
    }

    function winchange(win){
        windowloader.replace(windowloader.get(0),win,StackView.PopTransition);
        windowloader.pop(null);
    }

    signal doEvents();
    Rectangle {
        anchors.fill: parent
    }

    Component.onCompleted: {
        settings.messages = []
        doEvents();
    }


    // Window events
    onDoEvents: {
        mess = settings.messages;
        sendSavedInformation();
    }

    StackView {
        id: windowloader
        height: parent.height
        width: parent.width
        initialItem: meddocrs
        onBusyChanged: {
            if (!busy) {
                doEvents();
            }
        }
    }


    // All different pages (Placed in components so we can dynamically load them and avoid using system ram on cheap devices lol...
    Component {
        id : login
        MainForm { }
    }
    Component {
        id: medimain
        MedicMain { }
    }
    Component {
        id: medinventory
        MedViewInventory { }
    }
    Component {
        id: incinventory
        IncViewInventory { }
    }

    Component {
        id: adjinv
        MedInvAdjustment { }
    }
    Component {
        id: incadjinc
        IncInvAdjustement { }
    }

    Component {
        id:meddocrs
        MedDocRapportPremierSoins { }
    }

    Component {
        id:viewer
        DocumentViewer {}
    }

    Component {
        id:events
        EventView {}
    }

    Component {
        id:pcom
        DocumentPrintViewer {}
    }

    Component {
        id: pinvtot
        InventoryPrint {}
    }

    Component {
        id: pinv
        InvAdjustmentPrint {}
    }

    Component {
        id: incm
        IncendieMain {}
    }

    Component {
        id: incrapdoc
        IncRapportDocument {}
    }

    Component {
        id: pinc
        IncRapportDocumentPrint {}
    }

    function getDocImage(filename,typ) {
        currentfilename = filename;
        currenttype = typ;
        switch (typ) {
        case "docs":
            imgloader.sourceComponent = pcom;
            break;
        case "inv":
            imgloader.sourceComponent = pinv;
            break;
        case "inc":
            imgloader.sourceComponent = pinc;
            break;
        case "invtot":
            imgloader.sourceComponent = pinvtot;
            break;
        case "invinctot":
            imgloader.sourceComponent = pinvtot;
            break;
        case "invinc":
            imgloader.sourceComponent = pinv;
        }
        imgloader.active = true;
    }

    function gToImage() {
        if (imgloader.active) {
            imgloader.item.grabToImage(function(obj) {imageRendered(obj);});
        }
    }

    function imageRendered(obj) {
        if (imgloader.active) {
            imgurl = obj.url;
            winchange(viewer);
            imgloader.active = false;
        }
    }




    BaseSocket {
        id: msocket
        port: sport
        host: shost
        onStatusChanged: {
            switch(status) {
            case WebSocket.Open:
                for (var i = 0; i < mess.length; i++) {
                    msocket.sendTextMessage(mess[i]);
                }
                for (var b = mess.length; b > 0; b--) {
                    mess = mess.splice(b,1);
                }
                settings.messages = mess;
                msocket.active = false;
                break;
            case WebSocket.Error:
                console.log(errorString);
                break;
            }
        }
    }
    Loader {
        id: imgloader
        visible: false
        active: false
        sourceComponent: pcom
    }
}
