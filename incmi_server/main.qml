import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.0
import FileIO 1.0
import artools 1.0

ApplicationWindow {
    id: applic
    visible: true
    width: 1280
    height: 720
    title: qsTr("Simi Server")
    property bool senabled: false;

    Material.accent: colora
    property color colorb: "#BDBDBD"
    property color colorst: "#757575"
    property color colort: "#212121"
    property color colorlt: "#FFFFFF"
    property color colorp: "#03A9F4"
    property color colorlp: "#B3E5FC"
    property color colordp: "#006da9"
    property color colora: "#607D8B"
    property string textboxt: ""
    property string invfolder: "invitems"
    property string backupfolder: "backups"
    property string incdocfolder: "incd"
    property string docsfolder: "docs"
    property string peoplefolder: "ppl"
    property string invtotal: "invtots.incmi"
    property string invinctotal: "invinctots.incmi"
    property string invincfolder: "invincitems"
    property string eventfolder: "evt"
    property string eventsfilename: "events.incmi"
    property string invbase: '{"items": []}'
    property string eventbase: '{"items":[]}'
    property string eventitembase: '{"date":"","hour":"","lieu":"","details":"","people":[],"tag":"","type":""}'
    property string peoplebase: '{"firstname":"","lastname":"","email":"","matricule":"","role":"","filename":"","isadmin":"false","password":""}'
    property string changeslistbase: '{"items" : []}'
    property string documentitembase: '{"name":"","matricule":"","type":"","filename":"","nomoper":"","date":"","dateint":"","ville":"","nature":""}'
    property string peoplelistbase: '{"items":[]}'
    property string inventoryitembase: '{"name":"", "count":"", "rcount":"", "tag":""}'
    property string invadjustmentbase: '{"messageindex":"4","matricule":"","type":"inv","name":"","filename":"","date":"","items":[]}'
    property string serversettingsbase: '{"sport":"","shost":"","smpush":"","semaccount":"","sempassword":"","scnew":"","scedit":"","scremind":"","scremove":"","scadmincommit":"","scbackup":""}'
    property string incdocumentbase: '{"date":"","name":"","matricule":"","time":"","adresse":"","ville":"","type":"","nature":"","people":[],"other":[],"femme":"","homme":"","enfant":""}'
    property string incchangeslistbase: '{"date":"","time":"","adresse":"","ville":"","type":"","filename":"","nature":"","matricule":""}'
    property string incdocumentchangesbase: '{"items":[]}'
    property string fname
    property bool iscreated: true

    Component.onDestruction: {
        //Cleanup
        removeTempImage();
    }

    BackEnd {
        id: _backend
        onConsoleTextChanged: {
            textboxt = consoleText;
        }
    }


    Rectangle {
        anchors.fill: parent
        color: colorlt
    }

    AsyncQAnimatedLoader {
        id: load
        enabled: true;
        sourceComponent: wmain
    }

    Component {
        id: wmain
        MainWindow {
            id: cmain
        }
    }
    Component {
        id: pdocajust
        DocAjustementPrint {
        }
    }

    Component {
        id: pinvadjust
        InvAdjustmentPrint {}
    }

    Component {
        id: pinvadjinc
        IncInvAdjPrint {}
    }

    Component {
        id: pinvent
        InventairePrint {}
    }

    Component {
        id: pincprint
        IncRapportDocumentPrint {}
    }

    OptionsWindow {
        id: options
        anchors.fill: parent
    }


    WebSocketServer {
        id: server
        port: _backend.getSetting("sport") == null ? "2565" : _backend.getSetting("sport");
        host: _backend.getSetting("shost") == "localhost" ? "localhost" : _backend.getSetting("shost");
        listen: senabled
        onClientConnected: {
            webSocket.onTextMessageReceived.connect(function(message) {
                messReceived(message,webSocket);
            });
        }
        onErrorStringChanged: {
            onError(errorString);
        }
    }

    FileIO {
        id: file
    }


    function sendAdminsCommits(type,cname) {
        if (!pppload.active){
            if (_backend.getSetting("scadmincommit")) {
                switch (type) {
                case "docs":
                    pppload.sourceComponent = pdocajust;
                    break;
                case "inv":
                    pppload.sourceComponent = pinvadjust;
                    break;
                case "inc":
                    pppload.sourceComponent = pincprint;
                    break;
                }
                fname = cname;
                pppload.active = true;
            }
        }
    }

    function imRendered(obj) {
        obj.saveToFile(fname.split(".")[0] + ".png");
        file.printToPDF(fname.split(".")[0]);
        var ppl = JSON.parse(_backend.createPeopleList(peoplefolder,peoplelistbase));
        var pp = []
        for (var i = 0; i < ppl.items.length; i++) {
            var pers = ppl.items[i];
            if (pers.isadmin && pers.email != ""){
                pp.push(pers.email);
            }
        }
        var acc = _backend.getSetting("semaccount");
        var pass = _backend.getSetting("sempassword");
        if (acc != "" && pass != "") {
            if (!iscreated) {
                iscreated = true;
                file.sendEmailWithAttachment(acc, pass, pp, "Simi: Document", "The following document has been requested to be emailed",file.getApplicationPath() + "/" + fname.split(".")[0] + ".pdf");
            }else {
                file.sendEmailWithAttachment(acc, pass, pp, "Simi: Commit Added", "The following document has been added to the database",file.getApplicationPath() + "/" + fname.split(".")[0] + ".pdf");
            }
        }
        pppload.active = false;
        removeTempImage()
    }

    Loader {
        visible: false;
        active: false;
        id: pppload;
        sourceComponent: pdocajust

        onStatusChanged: {
            if (status == Loader.Ready) {
                if (active) {
                    pppload.item.setData(fname);
                    pppload.item.grabToImage(function (obt) {imRendered(obt);});
                }
            }
        }
    }

    function setServerState(cond) {
        senabled = cond;
        _backend.serverActiveChanged(cond);
    }

    function removeTempImage() {
        var items = file.getFileNames();
        for (var i = 0; i < items.length; i++) {
            if (items[i].split(".")[1] == "png") {
                file.removeFile(items[i]);
            }
            if (items[i].split(".")[1] == "pdf") {
                file.removeFile(items[i]);
            }
        }
    }

    function hasAccess(mess) {
        var ms = JSON.parse(mess);
        if (ms.messageindex == "5") {
            return true;
        }else{
            if (file.dirExist(peoplefolder)) {
                file.cd(peoplefolder);
                var cr;
                var didread = false;
                var fnames = file.getFileNames();
                for (var i = 0; i < fnames.length; i++) {
                    if (fnames[i] == ms.account[0]) {
                        cr = JSON.parse(file.readFile(fnames[i]));
                        didread = true;
                        break;
                    }
                }
                file.resetDirectory();
                if (didread) {
                    if (cr.password == ms.account[1]) {
                        return true;
                    }
                }
            }else {
                file.makeDirectory(peoplefolder);
            }
        }
        return false;
    }



    function messReceived(message, socket){
        if (hasAccess(message)) {
            var jsonobj = JSON.parse(message);
            delete jsonobj["account"];
            switch(parseInt(jsonobj.messageindex)){
            case 0:
                socket.sendTextMessage(_backend.createInventory(invfolder,invtotal));
                break;
            case 1:
                //Request list of latest doc and inv commits
                socket.sendTextMessage(_backend.createChangesList(docsfolder,changeslistbase,documentitembase));
                break;
            case 2:
                //Request doc information
                socket.sendTextMessage(_backend.createDocumentInformation(docsfolder,jsonobj.filename));
                break;
            case 3:
                //Add document
                delete jsonobj["messageindex"];
                sendAdminsCommits(jsonobj.type,_backend.createDocument(docsfolder,JSON.stringify(jsonobj)));
                break;
            case 4:
                delete jsonobj["messageindex"];
                sendAdminsCommits(jsonobj.type,_backend.appendInventory(invfolder,invtotal,JSON.stringify(jsonobj),docsfolder));
                break;
            case 5:
                socket.sendTextMessage(_backend.createPeopleList(peoplefolder,peoplelistbase));
                break;
            case 6:
                delete jsonobj["messageindex"];
                _backend.editInventoryItem(invfolder,invtotal,JSON.stringify(jsonobj));
                break;
            case 7:
                delete jsonobj["messageindex"];
                _backend.removeInventoryItem(invfolder,invtotal,JSON.stringify(jsonobj));
                break;
            case 8:
                delete jsonobj["messageindex"];
                _backend.createInventoryItem(invfolder,invtotal,JSON.stringify(jsonobj));
                break;
            case 9:
                sendDocumentEmailClient(jsonobj.filename);
                break;
            case 10:
                _backend.removeDocument(docsfolder,jsonobj.filename);
                break;
            case 11:
                socket.sendTextMessage(_backend.createDocumentInformation(eventfolder,eventsfilename));
                break;
            case 12:
                delete jsonobj["messageindex"];
                _backend.editEventItem(eventfolder,eventsfilename,JSON.stringify(jsonobj));
                break;
            case 13:
                delete jsonobj["messageindex"];
                _backend.createEventItem(eventfolder,eventsfilename,JSON.stringify(jsonobj));
                break;
            case 14:
                delete jsonobj["messageindex"];
                _backend.removeEventItem(eventfolder,eventsfilename,JSON.stringify(jsonobj));
                break;
            case 15:
                delete jsonobj["messageindex"];
                _backend.removePeople(peoplefolder,JSON.stringify(jsonobj));
                break;
            case 16:
                delete jsonobj["messageindex"];
                _backend.editDocument(peoplefolder,JSON.stringify(jsonobj));
                break;
            case 17:
                delete jsonobj["messageindex"];
                _backend.createDocument(peoplefolder,JSON.stringify(jsonobj));
                break;
            case 18:
                delete jsonobj["messageindex"];
                _backend.appendSettings(jsonobj);
                break;
            case 19:
                socket.sendTextMessage(_backend.getSettings());
                break;
            case 20:
                delete jsonobj["messageindex"];
                sendAdminsCommits("inc",_backend.createDocument(incdocfolder,JSON.stringify(jsonobj)));
                break;
            case 21:
                socket.sendTextMessage(_backend.createChangesList(incdocfolder,incdocumentchangesbase,incchangeslistbase));
                break;
            case 22:
                socket.sendTextMessage(_backend.createDocumentInformation(incdocfolder,jsonobj.filename));
                break;
            case 23:
                sendDocumentEmailClientInc(jsonobj.filename);
                break;
            case 24:
                sendDocumentEmailClientInv();
                break;
            case 25:
                _backend.removeDocument(incdocfolder,jsonobj.filename);
                break;
            case 26:
                delete jsonobj["messageindex"];
                _backend.removeInventoryItem(invincfolder,invinctotal,JSON.stringify(jsonobj));
                break;
            case 27:
                delete jsonobj["messageindex"];
                _backend.editInventoryItem(invincfolder,invinctotal,JSON.stringify(jsonobj));
                break;
            case 28:
                delete jsonobj["messageindex"];
                _backend.createInventoryItem(invincfolder,invinctotal,JSON.stringify(jsonobj));
                break;
            case 29:
                socket.sendTextMessage(_backend.createInventory(invincfolder,invinctotal));
                break;
            case 30:
                delete jsonobj["messageindex"];
                sendAdminsCommits(jsonobj.type,_backend.appendInventory(invincfolder,invinctotal,JSON.stringify(jsonobj),incdocfolder));
                break;
            case 31:
                sendDocumentEmailClientInvInc();
                break;
            }
        }
    }

    function onError(message){

    }

    function sendDocumentEmailClient(filename) {
        var obj = JSON.parse(_backend.createDocumentInformation(docsfolder,filename));
        if (!pppload.active){
            switch (obj.type) {
            case "docs":
                pppload.sourceComponent = pdocajust;
                break;
            case "inv":
                pppload.sourceComponent = pinvadjust;
                break;
            }
            fname = filename;
            iscreated = false;
            pppload.active = true;
        }
    }

    function sendDocumentEmailClientInc(filename) {
        var obj = JSON.parse(_backend.createDocumentInformation(incdocfolder,filename));
        if (!pppload.active){
            switch (obj.type) {
            case "docs":
                pppload.sourceComponent = pincprint;
                break;
            case "inv":
                pppload.sourceComponent = pinvadjinc;
                break;
            }


            fname = filename;
            iscreated = false;
            pppload.active = true;
        }
    }

    function sendDocumentEmailClientInv() {
        if (!pppload.active){
            pppload.sourceComponent = pinvent;
            fname = invtotal;
            iscreated = false;
            pppload.active = true;
        }
    }

    function sendDocumentEmailClientInvInc() {
        if (!pppload.active){
            pppload.sourceComponent = pinvent;
            fname = invinctotal;
            iscreated = false;
            pppload.active = true;
        }
    }
}
