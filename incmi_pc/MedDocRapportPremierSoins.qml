import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQml 2.2

Item {
    property int xd: 30
    property int labellength
    property int lrectheight: 40
    property int textboxheight: 35
    property int currentpage: 1
    property int lacdheight: 70
    property int widthspliter: parent.width < 801 ? 800 : parent.width * 4/5
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height
    Material.accent: colora
    Component.onCompleted: {
        switch (naturedoc) {
        case "1":
            fourthPage.visible = false;
            fifthPage.visible = false;
            sixthPage.visible = false;
            break;

        case "2":
            minorpage1.visible = false;
            break;
        }
    }
    function save() {
        // do all the saving work to create a JSON file and send it to the websocket.
        var obj = JSON.parse('{"messageindex":"3","matricule":"","name":"","type":"docs","dateint":"","tarriver":"","nature":"",
            "tappele":"","tdepart":"","nomoper":"","endroit":"","adresse":"","ville":"","evautre":"","vnom":"","vprenom":"","vage":"",
            "vsex":"","vnaiss":"","vadresse":"","vville":"","vautre":"","vcodepostal":"","vtelephone":"","nabraission":"","nacr":"",
            "nconvulsion":"","ndiabete":"","ndouleurt":"","nfaibless":"","nhypertermie":"","nhypothermie":"","nintoxication":"","nmaltete":"",
            "nobstr":"","ntrauma":"","nautre":"","ndescription":"","epreaction":"","epvoiesr":"","eprespiration":"","eppouls":"","epnivecon":"",
            "medicaments":"","alergies":"","ainconnu":"","alergies2":"","ana":"","amavc":"","amcardiaque":"","amdiabete":"","amepliepsie":"","amhyperhypo":"",
            "amautre":"","amdescription":"","o":"","p":"","q":"","r":"","s":"","t":"","descriptioncas":""}');
        obj.matricule = getMatricule();
        obj.nature = naturedoc;
        obj.name = getFullName();
        obj.dateint = datenv1.currentItem.text + ":" + datenv2.currentItem.text + ":" + datenv3.currentItem.text;
        obj.tarriver = tarriver1.currentItem.text + ":" + tarriver2.currentItem.text;
        obj.tappele = tappele1.currentItem.text + ":" + tappele2.currentItem.text;
        obj.tdepart = tdepart1.currentItem.text + ":" + tdepart2.currentItem.text;
        obj.nomoper = nomoper.textField.text;
        obj.endroit = endroit.textField.text;
        obj.adresse = adresse.textField.text;
        obj.ville = ville.textField.text;
        obj.evautre = evautre.textField.text;
        obj.vnom = vnom.textField.text;
        obj.vprenom = vprenom.textField.text;
        obj.vage = vage.textField.text;
        if (sexm.checked) obj.vsex = "m";
        if (sexf.checked) obj.vsex = "f";
        obj.vnaiss = vnaissjj.textBox.text + ":" + vnaissmm.textBox.text + ":" + vnaissyyyy.textBox.text;
        obj.vadresse = vadresse.textField.text;
        obj.vville = vville.textField.text;
        obj.vautre = vautre.textField.text;
        obj.vcodepostal = vcodepostal.textField.text;
        obj.vtelephone = vtelephone.textField.text;
        obj.nabraisson = nabrassion.checked.toString();
        obj.nacr = nacr.checked.toString();
        obj.nconvulsion = nconvulsion.checked.toString();
        obj.ndiabete = ndiabete.checked.toString();
        obj.ndouleurt = ndouleurt.checked.toString();
        obj.nfaibless = nfaibless.checked.toString();
        obj.nhypertermie = nhyperthermie.checked.toString();
        obj.nhypothermie = nhypothermie.checked.toString();
        obj.nintoxication = nintoxication.checked.toString();
        obj.nmaltete = nmaltete.checked.toString();
        obj.nobstr = nobstr.checked.toString();
        obj.ntrauma = ntrauma.checked.toString();
        obj.nautre = nautre.checked.toString();
        if (nautre.checked) obj.ndescription = ndescription.text;
        if (naturedoc == "2") {
            if (epreaction1.checked) obj.epreaction = "0";
            if (epreaction2.checked) obj.epreaction = "1";
            if (epvoiesr1.checked) obj.epvoiesr = "0";
            if (epvoiesr2.checked) obj.epvoiesr = "1";
            if (eprespiration1.checked) obj.eprespiration = "0";
            if (eprespiration2.checked) obj.eprespiration = "1";
            if (eppouls1.checked) obj.eppouls = "0";
            if (eppouls2.checked) obj.eppouls = "1";
            if (epnivecon1.checked) obj.epnivecon = "0";
            if (epnivecon2.checked) obj.epnivecon = "1";
            if (epnivecon3.checked) obj.epnivecon = "2";
            if (epnivecon4.checked) obj.epnivecon = "3";
            if (epnivecon5.checked) obj.epnivecon = "4";
            obj.medicaments = medicaments.text;
            obj.alergies = alergies1.textBox.text;
            obj.alergies2 = alergies2.textBox.text;
            obj.ainconnu = ainconnu.checked.toString();
            obj.ana = ana.checked.toString();
            obj.amavc = amavc.checked.toString();
            obj.amcardiaque = amcardiaque.checked.toString();
            obj.amdiabete = amdiabete.checked.toString();
            obj.amepliepsie = amepliepsie.checked.toString();
            obj.amhyperhypo = amhyperhyp.checked.toString();
            obj.amautre = amautre.checked.toString();
            if (amautre.checked) obj.amdescription = amdescription.text;
            obj.o = o.textBox.text;
            obj.p = p.textBox.text;
            obj.q = q.textBox.text;
            obj.r = r.textBox.text;
            obj.s = s.textBox.text;
            obj.t = t.textBox.text;
        }
        if (naturedoc == "1"){
            obj.descriptioncas = descriptioncas.text
        }
        addMessage(JSON.stringify(obj));
        sendSavedInformation();
    }


    function formatYearText(modelData) {
        var data = modelData + parseInt(new Date().getFullYear()) - 5;
        return data.toString().length < 2 ? "0" + data : data;
    }
    function formatDayText(modelData) {
        var data = modelData + 1;
        return data.toString().length < 2 ? "0" + data : data;
    }
    function formatMonthText(modelData) {
        var data = modelData + 1;
        return data.toString().length < 2 ? "0" + data : data;
    }
    function formatHourText(modelData) {
        var data = modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }
    function formatMinuteText(modelData) {
        var data = modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }


    ColumnLayout {
        id: mview
        spacing: 0
        anchors.fill: parent
        Flickable {
            id: view
            clip: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            contentWidth: parent.width
            contentHeight: naturedoc === "1" ? minorpage1.height + minorpage1.y + xd/2 : sixthPage.y + sixthPage.height + xd/2

            Item{
                id: firstPage
                clip: true
                width: parent.width
                height: evautre.y + evautre.height + xd/2
                Item {
                    id: r1
                    x: xd
                    width: parent.width > widthspliter/2 + 2*xd ? widthspliter/2 : parent.width - 2*xd
                    height: 80
                    RowLayout{
                        anchors.rightMargin: 5
                        anchors.topMargin: 0
                        anchors.fill: parent
                        Label {
                            id: labelx
                            text: qsTr("Date de l’intervention :")
                            Layout.maximumHeight: 30
                            elide: "ElideRight"
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignRight
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        Tumbler {
                            id: datenv1
                            Layout.maximumHeight: parent.height - 8
                            Layout.maximumWidth: 25
                            Layout.minimumWidth: 25
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            currentIndex: (new Date().getDate()) - 1
                            visibleItemCount: 3
                            model: 31
                            delegate: Label {
                                text: formatDayText(modelData)
                                opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 14
                            }
                        }

                        Label {
                            id: label1
                            text: qsTr("/")
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.maximumWidth: 15
                            Layout.minimumWidth: implicitWidth
                            Layout.maximumHeight: 40
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        Tumbler {
                            id: datenv2
                            Layout.maximumHeight: parent.height - 8
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.maximumWidth: 25
                            Layout.minimumWidth: 25
                            currentIndex: (new Date().getMonth())
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            visibleItemCount: 3
                            model: 12
                            delegate: Label {
                                text: formatMonthText(modelData)
                                opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 14
                            }
                            onCurrentIndexChanged: {
                                if(datenv1.currentItem != null){
                                    var dat = new Date(datenv3.currentIndex, currentIndex, 0).getDate();
                                    var index = datenv1.currentIndex
                                    datenv1.model = dat
                                    datenv1.currentIndex = index
                                }
                            }
                        }

                        Label {
                            id: label2
                            text: qsTr("/")
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.maximumHeight: 30
                            Layout.minimumWidth: implicitWidth
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Layout.fillWidth: true
                            Layout.maximumWidth: 15
                        }

                        Tumbler {
                            id: datenv3
                            Layout.maximumHeight: parent.height - 8
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.maximumWidth: 32
                            Layout.minimumWidth: 32
                            currentIndex: 5
                            visibleItemCount: 3
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            delegate: Label {
                                text: formatYearText(modelData)
                                opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 14
                            }
                            onCurrentIndexChanged: {
                                if(datenv1.currentItem != null){
                                    var dat = new Date(currentIndex, datenv2.currentIndex, 0).getDate();
                                    var index = datenv1.currentIndex
                                    datenv1.model = dat
                                    datenv1.currentIndex = index
                                }
                            }

                            model: 25
                        }
                    }
                }
                Pane {
                    id: r2
                    y: r1.height + r1.y + 8
                    x: xd/2
                    width: parent.width - xd
                    height: 25 + 8
                    Material.elevation: 1
                    Material.background: colordp
                    Label {
                        width: parent.width - 10
                        x: 5
                        y: 2
                        height: parent.height - 4
                        text: qsTr("ÉVÉNEMENT")
                        elide: "ElideRight"
                        color: colorlt
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: parent.width / 16
                        horizontalAlignment: Text.AlignLeft
                    }
                }
                Item {
                    id:r3
                    x: xd
                    y: r2.height + r2.y + xd/4
                    width: parent.width > widthspliter*3/4 + 2*xd ? widthspliter*3/4 : parent.width - 2*xd
                    height: 80
                    RowLayout{
                        spacing: 1
                        anchors.fill: parent
                        Item {
                            Layout.minimumWidth: 90
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            RowLayout{
                                spacing: 0
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Arriver")
                                    fontSizeMode: Text.Fit
                                    rightPadding: 2
                                    Layout.maximumHeight: 30
                                    elide: "ElideRight"
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignRight
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }

                                Tumbler {
                                    id: tarriver1
                                    Layout.minimumWidth: 25
                                    Layout.maximumWidth: 25
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    currentIndex: 0
                                    visibleItemCount: 3
                                    model: 24
                                    delegate: Label {
                                        text: formatHourText(modelData)
                                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.pixelSize: 14
                                    }
                                }

                                Label {
                                    text: qsTr(":")
                                    Layout.minimumWidth: 5
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.maximumWidth: 5
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }

                                Tumbler {
                                    id: tarriver2
                                    Layout.minimumWidth: 25
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.maximumWidth: 25
                                    currentIndex: 0
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    visibleItemCount: 3
                                    model: 60
                                    delegate: Label {
                                        text: formatMinuteText(modelData)
                                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.pixelSize: 14
                                    }
                                }
                            }
                        }
                        Item {
                            Layout.minimumWidth: 90
                            Layout.columnSpan: 1
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            RowLayout{
                                spacing: 0
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Appele")
                                    fontSizeMode: Text.Fit
                                    rightPadding: 2
                                    elide: "ElideRight"
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignRight
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }

                                Tumbler {
                                    id: tappele1
                                    Layout.maximumHeight: parent.height - 8
                                    Layout.maximumWidth: 25
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    currentIndex: 0
                                    visibleItemCount: 3
                                    model: 24
                                    delegate: Label {
                                        text: formatHourText(modelData)
                                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.pixelSize: 14
                                    }
                                }

                                Label {
                                    text: qsTr(":")
                                    Layout.minimumWidth: 5
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.maximumWidth: 5
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }

                                Tumbler {
                                    id: tappele2
                                    Layout.maximumHeight: parent.height - 8
                                    Layout.minimumWidth: 25
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.maximumWidth: 25
                                    currentIndex: 0
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    visibleItemCount: 3
                                    model: 60
                                    delegate: Label {
                                        text: formatMinuteText(modelData)
                                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.pixelSize: 14
                                    }
                                }
                            }
                        }
                        Item {
                            Layout.minimumWidth: 90
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            RowLayout{
                                spacing: 0
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Depart")
                                    fontSizeMode: Text.Fit
                                    rightPadding: 2
                                    Layout.maximumHeight: 30
                                    elide: "ElideRight"
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignRight
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }

                                Tumbler {
                                    id: tdepart1
                                    Layout.minimumWidth: 25
                                    Layout.maximumWidth: 25
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    currentIndex: 0
                                    visibleItemCount: 3
                                    model: 24
                                    delegate: Label {
                                        text: formatHourText(modelData)
                                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.pixelSize: 14
                                    }
                                }

                                Label {
                                    text: qsTr(":")
                                    Layout.minimumWidth: 5
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.maximumWidth: 5
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }

                                Tumbler {
                                    id: tdepart2
                                    Layout.minimumWidth: 25
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.maximumWidth: 25
                                    currentIndex: 0
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    visibleItemCount: 3
                                    model: 60
                                    delegate: Label {
                                        text: formatMinuteText(modelData)
                                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.pixelSize: 14
                                    }
                                }
                            }
                        }
                    }
                }

                CLabeledTextField {
                    id: nomoper
                    x: xd
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    label.text: "Nom de l'opération"
                    height: textboxheight
                    labelLength: label.implicitWidth
                    textField.text: ""
                    y: r3.height + r3.y + xd/4
                    spad: xd/4
                }
                CLabeledTextField {
                    id: endroit
                    x: xd
                    y: nomoper.height + nomoper.y + xd/4
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: textboxheight
                    labelLength: label.implicitWidth
                    label.text: "Endroit"
                    textField.text: ""
                    spad: xd/4
                }
                CLabeledTextField {
                    id: adresse
                    x: xd
                    y: endroit.y + endroit.height + xd/4
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: textboxheight
                    labelLength: label.implicitWidth
                    label.text: "Adresse"
                    textField.text: ""
                    spad: xd/4

                }
                CLabeledTextField {
                    id: ville
                    x: xd
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: textboxheight
                    y: adresse.y + adresse.height + xd/4
                    labelLength: label.implicitWidth
                    label.text: "Ville"
                    spad: xd/4
                    textField.text: ""
                }
                CLabeledTextField {
                    id: evautre
                    x: xd
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: textboxheight
                    y: ville.y + ville.height + xd/4
                    labelLength: label.implicitWidth
                    label.text: "Autre"
                    textField.text: ""
                    spad: xd/4
                }
            }
            Item {
                id: secondPage
                clip: true
                height: vtelephone.height + vtelephone.y + xd/2
                width: parent.width
                y: firstPage.height + firstPage.y + xd/2
                Pane {
                    id: p2r2
                    x: xd/2
                    y: 8
                    width: parent.width - xd
                    height: 25 + 8
                    Material.elevation: 1
                    Material.background: colordp
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("VICTIME")
                            leftPadding: 20
                            Layout.maximumHeight: 30
                            color: colorlt
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                    }
                }
                CLabeledTextField {
                    id: vnom
                    x: xd
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: textboxheight
                    label.text: "Nom"
                    labelLength: label.implicitWidth
                    y: p2r2.height + p2r2.y + xd/4
                    spad: xd/4
                    textField.text: ""
                }
                CLabeledTextField {
                    id: vprenom
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    x: xd
                    y:vnom.height + vnom.y + xd/4
                    height: textboxheight
                    label.text: "Prénom"
                    labelLength: label.implicitWidth
                    spad: xd/4
                    textField.text: ""
                }
                RowLayout {
                    id: p2r5
                    x: xd
                    y: vprenom.height + vprenom.y + xd/4
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: textboxheight
                    spacing: 0
                    CLabeledTextField {
                        id: vage
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        label.text: "Age"
                        labelLength: label.implicitWidth
                        textField.text: ""
                        spad: xd/4
                    }
                    RadioButton {
                        id: sexm
                        text: qsTr("M")
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.maximumWidth: 50
                    }

                    RadioButton {
                        id: sexf
                        text: qsTr("F")
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.maximumWidth: 50
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }
                }

                RowLayout {
                    id: p2r6
                    x: xd
                    y: p2r5.height + p2r5.y + xd/4
                    width: parent.width > widthspliter / 2 + 2.5*xd  ? widthspliter / 2: parent.width - 2.5*xd
                    height: textboxheight
                    scale: 1
                    spacing: 1
                    Label {
                        text: qsTr("Date de nais. (jj/mm/yy)")
                        Layout.maximumWidth: implicitWidth
                        fontSizeMode: Text.HorizontalFit
                        Layout.maximumHeight: 30
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        elide: "ElideRight"
                    }
                    CTextField {
                        id:vnaissjj
                        lPad: 8
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.maximumWidth: 35
                        Layout.minimumWidth: 30
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    Label {
                        text: qsTr("/")
                        Layout.maximumWidth: implicitWidth + 4
                        Layout.minimumWidth: implicitWidth + 3
                        Layout.maximumHeight: 30
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    CTextField {
                        id:vnaissmm
                        lPad: 8
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.maximumWidth: 35
                        Layout.minimumWidth: 30
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    Label {
                        text: qsTr("/")
                        Layout.minimumWidth: implicitWidth + 3
                        Layout.maximumWidth: implicitWidth + 4
                        Layout.maximumHeight: 30
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    CTextField {
                        id:vnaissyyyy
                        lPad: 8
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.maximumWidth: 50
                        Layout.minimumWidth: 45
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                }

                CLabeledTextField {
                    id: vadresse
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    x: xd
                    y:p2r6.height + p2r6.y + xd/4
                    height: textboxheight
                    textField.text: ""
                    label.text: "Adresse"
                    labelLength: label.implicitWidth
                    spad: xd/4
                }

                CLabeledTextField {
                    id: vville
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    x: xd
                    y:vadresse.height + vadresse.y + xd/4
                    height: textboxheight
                    label.text: "Ville"
                    labelLength: label.implicitWidth
                    spad: xd/4
                }

                CLabeledTextField {
                    id: vautre
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    x: xd
                    textField.text: ""
                    y:vville.height + vville.y + xd/4
                    height: textboxheight
                    label.text: "Autre"
                    labelLength: label.implicitWidth
                    spad: xd/4
                }


                CLabeledTextField {
                    id: vcodepostal
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    x: xd
                    y:vautre.height + vautre.y + xd/4
                    height: textboxheight
                    label.text: "Code Postal"
                    textField.text: ""
                    labelLength: label.implicitWidth
                    spad: xd/4
                }

                CLabeledTextField {
                    id: vtelephone
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    x: xd
                    y:vcodepostal.height + vcodepostal.y + xd/4
                    textField.text: ""
                    height: textboxheight
                    label.text: "Téléphone"
                    labelLength: label.implicitWidth
                    spad: xd/4
                }
            }
            Item {
                id: thirdPage
                clip: true
                height: p3r7.height + p3r7.y + xd/2
                width: parent.width
                y: secondPage.y + secondPage.height + xd/2
                Pane {
                    id:p3r3
                    x: xd/2
                    y: 8
                    width: parent.width - xd
                    height: 25 + 8
                    Material.elevation: 1
                    Material.background: colordp
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("NATURE DU CAS")
                            leftPadding: 20
                            Layout.maximumHeight: 30
                            color: colorlt
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                    }
                }

                Item {
                    id: p3r4
                    x: xd
                    y: p3r3.height + p3r3.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: (gridl.rows * nabrassion.implicitHeight) + xd
                    GridLayout{
                        id: gridl
                        columnSpacing: 0
                        rowSpacing: 0
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        columns: Math.floor((parent.width - 2*xd)/ndouleurt.implicitWidth)
                        rows: Math.floor(13/(Math.floor((parent.width - 2*xd)/ndouleurt.implicitWidth))) + 1
                        anchors.fill: parent

                        CheckBox {
                            id: nabrassion
                            text: qsTr("Abrassion")
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }

                        CheckBox {
                            id: nacr
                            text: qsTr("Acr / Code")
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }

                        CheckBox {
                            id: nconvulsion
                            text: qsTr("Convulsion")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: ndiabete
                            text: qsTr("Diabète")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: ndouleurt
                            text: qsTr("Douleur Thoracique")
                            Layout.fillHeight: false
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: nfaibless
                            text: qsTr("Faibless")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: nhyperthermie
                            text: qsTr("Hyperthermie")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: nhypothermie
                            text: qsTr("Hypothermie")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: nintoxication
                            text: qsTr("Intoxication")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: nmaltete
                            text: qsTr("Mal de Tête")
                            spacing: 7
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: nobstr
                            text: qsTr("Obstr. Voies Resp.")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: ntrauma
                            text: qsTr("Trauma")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: nautre
                            text: qsTr("Autre:")
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }
                    }
                }
                Rectangle {
                    id: p3r7
                    x: xd
                    y: p3r4.height + p3r4.y
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: ndescription.implicitHeight > 130 ? ndescription.implicitHeight : 130
                    color: "#efefef"
                    radius: 8
                    TextInput {
                        enabled: nautre.checked
                        id: ndescription
                        text: qsTr("")
                        padding: 5
                        wrapMode: Text.WordWrap
                        font.pointSize: 11
                        anchors.bottomMargin: xd/6
                        anchors.rightMargin: xd/2
                        anchors.leftMargin: xd/2
                        anchors.topMargin: xd/6
                        anchors.fill: parent

                    }
                }

            }
            Item {
                id: fourthPage
                clip: true
                width: parent.width
                height: p4r7.height + p4r7.y + xd/2
                y: thirdPage.height + thirdPage.y + xd/2
                Pane {
                    id:p4r2
                    x: xd/2
                    y: 8
                    width: parent.width - xd
                    height: 25 + 8
                    Material.elevation: 1
                    Material.background: colordp
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("ÉVALUATION PRIMAIRE")
                            leftPadding: 20
                            Layout.maximumHeight: 30
                            color: colorlt
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                    }
                }
                Rectangle {
                    id:p4r3
                    x: xd
                    y: p4r2.height + p4r2.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: lacdheight
                    radius: 3
                    border.width: 1
                    border.color: colora
                    clip: true
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("L'")
                            leftPadding: 5
                            Layout.rowSpan: 2
                            Layout.columnSpan: 2
                            font.pointSize: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: colora
                        }

                        ColumnLayout {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Label {
                                text: qsTr("État de conscience")
                                topPadding: 5
                                bottomPadding: 0
                                font.italic: true
                                Layout.fillHeight: true
                                leftPadding: xd
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillWidth: true
                                opacity: 0.6
                                color: colora
                            }
                            RowLayout {
                                spacing: 0
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true

                                RadioButton {
                                    id:epreaction1
                                    width: 120
                                    text: qsTr("Reaction")
                                    Layout.maximumWidth: 120
                                    rightPadding: 4
                                    leftPadding: 4
                                    bottomPadding: 8
                                    topPadding: 8
                                    font.pointSize: 8
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }

                                RadioButton {
                                    id:epreaction2
                                    width: 120
                                    text: qsTr("Aucune Reaction")
                                    rightPadding: 4
                                    leftPadding: 4
                                    bottomPadding: 8
                                    topPadding: 8
                                    font.pointSize: 8
                                    Layout.maximumWidth: 120
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    id: p4r4
                    x: xd
                    y: p4r3.height + p4r3.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    radius: 3
                    border.width: 1
                    border.color: colora
                    height: lacdheight
                    clip: true
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("A")
                            leftPadding: 5
                            font.pointSize: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: colora
                        }
                        ColumnLayout{
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Label {
                                text: qsTr("Voies respiratoires")
                                topPadding: 5
                                bottomPadding: 0
                                font.italic: true
                                Layout.fillHeight: true
                                leftPadding: xd
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillWidth: true
                                opacity: 0.6
                                color: colora
                            }
                            RowLayout {
                                spacing: 0
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                RadioButton {
                                    id: epvoiesr1
                                    text: qsTr("Ouvertes")
                                    rightPadding: 4
                                    leftPadding: 4
                                    bottomPadding: 8
                                    topPadding: 8
                                    font.pointSize: 8
                                    Layout.maximumWidth: 120
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }

                                RadioButton {
                                    id: epvoiesr2
                                    text: qsTr("Obstruées")
                                    rightPadding: 4
                                    leftPadding: 4
                                    bottomPadding: 8
                                    topPadding: 8
                                    font.pointSize: 8
                                    Layout.maximumWidth: 120
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    id: p4r5
                    x: xd
                    y: p4r4.height + p4r4.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    radius: 3
                    border.width: 1
                    border.color: colora
                    height: lacdheight
                    clip: true
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("B")
                            leftPadding: 5
                            font.pointSize: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: colora
                        }
                        ColumnLayout{
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Label {
                                text: qsTr("Respiration")
                                topPadding: 5
                                bottomPadding: 0
                                font.italic: true
                                Layout.fillHeight: true
                                leftPadding: xd
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillWidth: true
                                opacity: 0.6
                                color: colora
                            }
                            RowLayout {
                                spacing: 0
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                RadioButton {
                                    id: eprespiration1
                                    text: qsTr("Adéquate")
                                    rightPadding: 4
                                    leftPadding: 4
                                    bottomPadding: 8
                                    topPadding: 8
                                    font.pointSize: 8
                                    Layout.maximumWidth: 120
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                }
                                RadioButton {
                                    id: eprespiration2
                                    text: qsTr("Inadéquate")
                                    rightPadding: 4
                                    leftPadding: 4
                                    bottomPadding: 8
                                    topPadding: 8
                                    font.pointSize: 8
                                    Layout.maximumWidth: 120
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    id: p4r6
                    x: xd
                    y: p4r5.height + p4r5.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    radius: 3
                    border.width: 1
                    border.color: colora
                    height: lacdheight
                    clip: true
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("C")
                            leftPadding: 5
                            font.pointSize: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: colora
                        }
                        ColumnLayout{
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Label {
                                text: qsTr("Pouls")
                                topPadding: 5
                                bottomPadding: 0
                                font.italic: true
                                Layout.fillHeight: true
                                leftPadding: xd
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillWidth: true
                                opacity: 0.6
                                color: colora
                            }
                            RowLayout {
                                spacing: 0
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                RadioButton {
                                    id: eppouls1
                                    text: qsTr("Présent")
                                    rightPadding: 4
                                    leftPadding: 4
                                    bottomPadding: 8
                                    topPadding: 8
                                    font.pointSize: 8
                                    Layout.maximumWidth: 120
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }

                                RadioButton {
                                    id: eppouls2
                                    text: qsTr("Abscent")
                                    rightPadding: 4
                                    leftPadding: 4
                                    bottomPadding: 8
                                    topPadding: 8
                                    font.pointSize: 8
                                    Layout.maximumWidth: 120
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    id: p4r7
                    x: xd
                    y: p4r6.height + p4r6.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    radius: 3
                    border.width: 1
                    border.color: colora
                    height: lacdheight * 2 + xd/2
                    clip: true
                    ColumnLayout{
                        anchors.fill: parent
                        RowLayout {
                            Layout.maximumHeight: 38
                            Layout.minimumHeight: 38
                            spacing: 0
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Label {
                                text: qsTr("D")
                                leftPadding: 5
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                font.pointSize: 30
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillHeight: true
                                Layout.fillWidth: false
                                color: colora
                            }
                            Label {
                                text: qsTr("Niveau de conscience")
                                leftPadding: xd
                                topPadding: 10
                                font.italic: true
                                Layout.fillHeight: true
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.fillWidth: true
                                opacity: 0.6
                                color: colora
                            }
                        }
                        GridLayout {
                            width: 100
                            height: 100
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            layoutDirection: Qt.LeftToRight
                            rows: 3
                            columns: 2
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            RadioButton {
                                id: epnivecon1
                                text: qsTr("Alerte")
                                Layout.maximumWidth: 125
                                leftPadding: 4
                                rightPadding: 4
                                Layout.fillWidth: true
                                font.pointSize: 8
                                bottomPadding: 8
                                Layout.fillHeight: true
                                topPadding: 8
                            }

                            RadioButton {
                                id: epnivecon2
                                text: qsTr("Verbal")
                                leftPadding: 4
                                Layout.fillWidth: true
                                rightPadding: 4
                                font.pointSize: 8
                                Layout.maximumWidth: 125
                                bottomPadding: 8
                                Layout.fillHeight: true
                                topPadding: 8
                            }

                            RadioButton {
                                id: epnivecon3
                                text: qsTr("Stimuli Verbal")
                                leftPadding: 4
                                Layout.fillWidth: true
                                rightPadding: 4
                                font.pointSize: 8
                                Layout.maximumWidth: 125
                                bottomPadding: 8
                                Layout.fillHeight: true
                                topPadding: 8
                            }

                            RadioButton {
                                id: epnivecon4
                                text: qsTr("Stimuli Douleur")
                                leftPadding: 4
                                Layout.fillWidth: true
                                rightPadding: 4
                                font.pointSize: 8
                                Layout.maximumWidth: 125
                                bottomPadding: 8
                                Layout.fillHeight: true
                                topPadding: 8
                            }

                            RadioButton {
                                id: epnivecon5
                                text: qsTr("Reaction")
                                leftPadding: 4
                                Layout.fillWidth: true
                                rightPadding: 4
                                font.pointSize: 8
                                Layout.maximumWidth: 125
                                bottomPadding: 8
                                Layout.fillHeight: true
                                topPadding: 8
                            }
                        }
                    }
                }
            }
            Item {
                id: fifthPage
                clip: true
                height: p5r8.height + p5r8.y + xd/2
                width: parent.width
                y: fourthPage.height + fourthPage.y + xd/2
                Pane {
                    id:p5r2
                    x: xd/2
                    y: 8
                    width: parent.width - xd
                    height: 25 + 8
                    Material.elevation: 1
                    Material.background: colordp
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("MÉDICAMENTS")
                            leftPadding: 20
                            Layout.maximumHeight: 30
                            color: colorlt
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                    }
                }
                Rectangle {
                    id:p5r3
                    x: xd
                    y: p5r2.height + p5r2.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: medicaments.implicitHeight > 100 ? medicaments.implicitHeight : 100
                    color: "#efefef"
                    radius: 8
                    TextInput {
                        id: medicaments
                        text: qsTr("")
                        padding: 5
                        wrapMode: Text.WordWrap
                        font.pointSize: 11
                        anchors.bottomMargin: xd/6
                        anchors.rightMargin: xd/2
                        anchors.leftMargin: xd/2
                        anchors.topMargin: xd/6
                        anchors.fill: parent
                    }
                }
                Pane {
                    id:p5r4
                    x: xd/2
                    y: p5r3.height + p5r3.y + 8
                    width: parent.width - xd
                    height: 25 + 8
                    Material.elevation: 1
                    Material.background: colordp
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("ALLERGIES (A)")
                            leftPadding: 20
                            Layout.maximumHeight: 30
                            color: colorlt
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                    }
                }
                Item {
                    id: p5r5
                    x: xd
                    y: p5r4.height + p5r4.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: 70
                    RowLayout{
                        anchors.bottomMargin: 5
                        spacing: 1
                        anchors.fill: parent
                        ColumnLayout{
                            CTextField {
                                id: alergies1
                                Layout.maximumHeight: 40
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Material.accent: colora
                            }
                            CTextField {
                                id: alergies2
                                Layout.maximumHeight: 40
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Material.accent: colora
                            }
                        }
                        ColumnLayout{
                            RadioButton {
                                id: ainconnu
                                text: qsTr("?")
                                font.pointSize: 8
                                Layout.maximumWidth: 90
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }

                            RadioButton {
                                id: ana
                                text: qsTr("N/A")
                                font.pointSize: 8
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.maximumWidth: 90
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }
                        }
                    }
                }
                Pane {
                    id:p5r6
                    x: xd/2
                    y: p5r5.height + p5r5.y + 8
                    width: parent.width - xd
                    height: 25 + 8
                    Material.elevation: 1
                    Material.background: colordp
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("ANTÉCÉDENTS MÉDICAUX (P)")
                            leftPadding: 20
                            Layout.maximumHeight: 30
                            color: colorlt
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                    }
                }
                Item {
                    id: p5r7
                    x: xd
                    y: p5r6.height + p5r6.y
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: (gridb.rows * nabrassion.implicitHeight) + xd
                    GridLayout{
                        id: gridb
                        columnSpacing: 0
                        rowSpacing: 0
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        columns: Math.floor((parent.width - 2*xd)/amcardiaque.implicitWidth)
                        rows: Math.floor(6/(Math.floor((parent.width - 2*xd)/amcardiaque.implicitWidth))) + 1
                        anchors.fill: parent

                        CheckBox {
                            id: amavc
                            text: qsTr("AVC")
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }

                        CheckBox {
                            id: amcardiaque
                            text: qsTr("Cardiaque")
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }

                        CheckBox {
                            id: amdiabete
                            text: qsTr("Diabète")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: amepliepsie
                            text: qsTr("Épliepsie")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: amhyperhyp
                            text: qsTr("Hyper/Hypo Tension")
                            Layout.fillHeight: false
                            Layout.fillWidth: true
                        }

                        CheckBox {
                            id: amautre
                            text: qsTr("Autre")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                    }
                }
                Rectangle {
                    id: p5r8
                    x: xd
                    y: p5r7.height + p5r7.y
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: amdescription.implicitHeight > 90 ? amdescription.implicitHeight : 90
                    color: "#efefef"
                    radius: 8
                    TextInput {
                        id: amdescription
                        enabled: amautre.checked
                        text: qsTr("")
                        padding: 5
                        wrapMode: Text.WordWrap
                        font.pointSize: 11
                        anchors.bottomMargin: xd/6
                        anchors.rightMargin: xd/2
                        anchors.leftMargin: xd/2
                        anchors.topMargin: xd/6
                        anchors.fill: parent
                    }
                }
            }
            Item {
                id: sixthPage
                clip: true
                height: p6r8.height + p6r8.y + xd/2
                width: parent.width
                y: fifthPage.height + fifthPage.y + xd/2
                Pane {
                    id:p6r2
                    x: xd/2
                    y: 8
                    width: parent.width - xd
                    height: 25 + 8
                    Material.elevation: 1
                    Material.background: colordp
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("OPQRST")
                            leftPadding: 20
                            Layout.maximumHeight: 30
                            color: colorlt
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }
                    }
                }
                Item {
                    id:p6r3
                    x: xd
                    y: p6r2.height + p6r2.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: 40
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("O")
                            Layout.maximumWidth: 80
                            leftPadding: xd
                            font.pointSize: 25
                            Layout.maximumHeight: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: colora

                        }
                        CTextField {
                            id: o
                            Layout.maximumHeight: 40
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Material.accent: colora
                        }
                    }
                }
                Item {
                    id: p6r4
                    x: xd
                    y: p6r3.height + p6r3.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: 40
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("P")
                            Layout.maximumWidth: 80
                            leftPadding: xd
                            font.pointSize: 25
                            Layout.maximumHeight: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: colora

                        }
                        CTextField {
                            id: p
                            Layout.maximumHeight: 40
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Material.accent: colora
                        }
                    }
                }
                Item {
                    id: p6r5
                    x: xd
                    y: p6r4.height + p6r4.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: 40
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("Q")
                            Layout.maximumWidth: 80
                            leftPadding: xd
                            font.pointSize: 25
                            Layout.maximumHeight: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: colora

                        }
                        CTextField {
                            id:q
                            Layout.maximumHeight: 40
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Material.accent: colora
                        }
                    }
                }
                Item {
                    id: p6r6
                    x: xd
                    y: p6r5.height + p6r5.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: 40
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("R")
                            Layout.maximumWidth: 80
                            leftPadding: xd
                            font.pointSize: 25
                            Layout.maximumHeight: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: colora

                        }
                        CTextField {
                            id: r
                            Layout.maximumHeight: 40
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Material.accent: colora
                        }
                    }
                }
                Item {
                    id: p6r7
                    x: xd
                    y: p6r6.height + p6r6.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: 40
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("S")
                            Layout.maximumWidth: 80
                            leftPadding: xd
                            font.pointSize: 25
                            Layout.maximumHeight: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: colora

                        }
                        CTextField {
                            id: s
                            Layout.maximumHeight: 40
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Material.accent: colora
                        }
                    }
                }
                Item {
                    id: p6r8
                    x: xd
                    y: p6r7.height + p6r7.y + xd/2
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: 40
                    RowLayout{
                        anchors.fill: parent
                        Label {
                            text: qsTr("T")
                            Layout.maximumWidth: 80
                            leftPadding: xd
                            font.pointSize: 25
                            Layout.maximumHeight: 30
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            color: colora

                        }
                        CTextField {
                            id: t
                            Layout.maximumHeight: 40
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            Material.accent: colora
                        }
                    }
                }
            }
            Item {
                clip: true
                id: minorpage1
                height: p7r1.height + p7r1.y + xd/2
                width: parent.width
                y: thirdPage.y + thirdPage.height + xd/2
                Item {
                    id: p7r1
                    x: xd
                    width: parent.width > widthspliter + 2*xd ? widthspliter : parent.width - 2*xd
                    height: 140
                    Label {
                        id: lab
                        text: "Descriptions du cas"
                        width: parent.width
                        height: implicitHeight
                        font.pointSize: 11

                    }
                    Rectangle {
                        y: lab.height + xd/6
                        width: parent.width
                        height: parent.height - lab.height - xd/3
                        color: "#efefef"
                        radius: 8
                        TextInput {
                            id: descriptioncas
                            text: qsTr("")
                            padding: 5
                            wrapMode: Text.WordWrap
                            font.pointSize: 11
                            anchors.bottomMargin: xd/6
                            anchors.rightMargin: xd/2
                            anchors.leftMargin: xd/2
                            anchors.topMargin: xd/6
                            anchors.fill: parent

                        }
                    }
                }
            }
        }
        Pane {
            id: footer
            width: parent.width
            height: 70
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 70
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.background: "#0288D1"
            Material.elevation: 4
            GridLayout {
                anchors.fill: parent
                CButton {
                    id: cancelbutton
                    text: qsTr("Annuler")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: "#006da9"
                    source: "Icons/ic_highlight_off_white_24dp.png"
                    onClicked: {
                        mview.enabled = false;
                        promptconfirmleave.show();
                    }
                }
                CButton {
                    text: qsTr("Envoyer")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 150
                    Material.foreground: colorlt
                    Material.background: "#006da9"
                    source: "Icons/ic_cloud_upload_white_24dp.png"
                    onClicked: {
                        mview.enabled = false;
                        promptconfirmsave.show();
                    }
                }
            }
        }
    }

    Prompt {
        id: promptconfirmsave
        x: parent.width / 14
        y: parent.height / 4.0
        width: parent.width - 2*x
        height: parent.height - 2*(parent.height/4.5)
        Material.background: colora
        Material.elevation: 8
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: parent.width/15
            anchors.rightMargin: parent.width/15
            anchors.bottomMargin: (parent.height/20) * 3
            anchors.topMargin: (parent.height/20) * 3
            spacing: 5
            Label {
                text: settings.user == "" ? qsTr("Vous devez configurer votre compte avant tout... \n Merci!"): qsTr(
                                                "Êtes vous sur de vouloir sauvegarder les changements?\nNom: " +
                                                JSON.parse(settings.user).firstname + " " + JSON.parse(settings.user).lastname +
                                                "\nMatricule: " + JSON.parse(settings.user).matricule);
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                Material.foreground: colorlt
                wrapMode: Text.WordWrap
                Layout.maximumHeight: 50
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pointSize: 14
            }
            RowLayout{
                spacing: 15
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.maximumHeight: 50
                Button {
                    text: settings.user == "" ? qsTr("Ok") : qsTr("Non")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        mview.enabled = true;
                        promptconfirmsave.hide();
                    }
                }
                Button {
                    text: qsTr("Oui")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    enabled: settings.user == "" ? false: true;
                    onClicked: {
                        save();
                        winchange(medimain);
                    }
                }
            }
        }
    }
    Prompt {
        id: promptconfirmleave
        x: parent.width / 14
        y: parent.height / 4.0
        width: parent.width - 2*x
        height: parent.height - 2*(parent.height/4.5)
        Material.background: colora
        Material.elevation: 8
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: parent.width/15
            anchors.rightMargin: parent.width/15
            anchors.bottomMargin: (parent.height/20) * 3
            anchors.topMargin: (parent.height/20) * 3
            spacing: 5
            Label {
                text: qsTr("Êtes vous sur de vouloir quitter? Les changements non sauvegarder seronts effacer..")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
                Layout.maximumHeight: 50
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pointSize: 14
                Material.foreground: colorlt
            }
            RowLayout{
                spacing: 15
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.maximumHeight: 50
                Button {
                    text: qsTr("Non")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        mview.enabled = true;
                        promptconfirmleave.hide();
                    }
                }
                Button {
                    text: qsTr("Oui")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        winchange(medimain);
                    }
                }
            }
        }
    }
}

