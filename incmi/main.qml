import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import Qt.labs.settings 1.0
import QtQuick.Controls 2.2
import QtWebSockets 1.1
import iostls 1.0
import "./Pages" as Pages
import "./PDFTemplates" as PDFDocs
import "./Components" as Comps


ApplicationWindow {
    id: window
    title: qsTr("Simi")

    //visibility: Window.Maximized;
    //flags: Qt.MaximizeUsingFullscreenGeometryHint;

    property bool useSafeAreaPadding: false
    property int safeAreaSize: 20

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
            //Qt.quit();
        }
    }

    Backend {
        id: _backend
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

    function setPCIntialPostion() {
        var wheight = Screen.height;
        var wwidth = Screen.width;
        console.log("This is the height " + wheight.toString() + "; This is the width " + wwidth.toString() );
        window.width = wwidth * 3 / 4;
        window.height = wheight * 3 / 4;
        window.x = wwidth / 8;
        window.y = wheight / 8;
        window.visibility = Window.Windowed;
    }

    function setMobile() {
        visibility = Window.Maximized;
        flags = Qt.MaximizeUsingFullscreenGeometryHint;
    }

    function addMessage(message) {
        //var ms = message.slice(0, message.length - 1) + ',"account":["'+JSON.parse(settings.user).filename + '","'+settings.password+'"]}';
        var ms = JSON.parse(message);
        ms.account = [];
        ms.account[0] = JSON.parse(settings.user).filename
        ms.account[1] = settings.password;
        mess.push(JSON.stringify(ms));
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
        var os = Qt.platform.os;
        if (os === "ios" && height === 812) {
            //Is iphone x, make sur to pad properly
            useSafeAreaPadding = true;
            safeAreaSize = 40;
        }else if (os === "ios") {
            useSafeAreaPadding = true;
        }else if (os === "windows" || os === "osx" || os === "unix") {
            setPCIntialPostion()
        }else if (os === "ios" || os === "android"){
            setMobile();
        }

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
        initialItem: login
        onBusyChanged: {
            if (!busy) {
                doEvents();
            }
        }
    }


    // All different pages (Placed in components so we can dynamically load them and avoid using system ram on cheap devices lol...
    Component {
        id : login
        Pages.MainPage { }
    }
    Component {
        id: medimain
        Pages.MedicalListPage { }
    }
    Component {
        id: medinventory
        Pages.MedViewInventory { }
    }
    Component {
        id: incinventory
        Pages.IncViewInventory { }
    }

    Component {
        id: adjinv
        Pages.MedicalInventoryAdjustement { }
    }
    Component {
        id: incadjinc
        Pages.IncendieInventoryAdjustement { }
    }

    Component {
        id:meddocrs
        Pages.MedicalDocumentPage { }
    }

    Component {
        id:viewer
        Pages.DocumentViewer {}
    }

    Component {
        id:events
        Pages.EventPage {}
    }

    Component {
        id:pcom
        PDFDocs.MedicalRapport {}
    }

    Component {
        id: pinvtot
        PDFDocs.Inventory {}
    }

    Component {
        id: pinv
        PDFDocs.InventoryAdjustement {}
    }

    Component {
        id: incm
        Pages.IncendieListPage {}
    }

    Component {
        id: incrapdoc
        Pages.IncendieRapportPage {}
    }

    Component {
        id: pinc
        PDFDocs.IncendieRapport {}
    }
    //Component asks for a document image, passing the filename.
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




    Comps.BaseSocket {
        id: msocket
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
