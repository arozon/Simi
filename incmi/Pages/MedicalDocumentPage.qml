import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQml 2.2
import "../DocumentMedical" as MedPages
import "../Prompts" as Dialogs
import "../Components" as Comps

Item {
    // Field properties

    //EtatSigne -- First
    property string svep1hre
    property string svep1resp
    property string svep1pouls
    property string svep1ta
    property string svep1alert
    property string svep1stv
    property string svep1std
    property string svep1nr
    // -- Second
    property string svep2hre
    property string svep2resp
    property string svep2pouls
    property string svep2ta
    property string svep2alert
    property string svep2stv
    property string svep2std
    property string svep2nr
    // -- Third
    property string svep3hre
    property string svep3resp
    property string svep3pouls
    property string svep3ta
    property string svep3alert
    property string svep3stv
    property string svep3std
    property string svep3nr


    //DescriptionsCas
    property string descriptioncas

    //OPQRST
    property string o
    property string p
    property string q
    property string r
    property string s
    property string t

    //ConditionPatient
    property string medicaments
    property string alergies
    property string ainconnu
    property string alergies2
    //property string alergies
    property string ana
    property string amacv
    property string amcardiaque
    property string amdiabete
    property string amepliepsie
    property string amhyperhypo
    property string amautre
    property string amdescription

    //EvalPrimaire
    property string epreaction
    property string epvoiesr
    property string eprespiration
    property string eppouls
    property string epnivecon

    //Nature cas
    property string nabraission
    property string nacr
    property string nconvulsion
    property string ndiabete
    property string ndouleurt
    property string nfaibless
    property string nhyperthermie
    property string nintoxication
    property string nhypothermie
    property string nmaltete
    property string nobstr
    property string ntrauma
    property string nautre
    property string ndescription

    //Information patient
    property string vnom
    property string vprenom
    property string vage
    property string vsex
    property string vnaiss
    property string vadresse
    property string vville
    property string vcodepostal
    property string vtelephone
    property string vautre

    //Information evenement
    property string dateint
    property string tarriver
    property string tappele
    property string tdepart
    property string nomoper
    property string endroit
    property string adresse
    property string ville
    property string evautre


    property int xd: 30
    property int labellength
    property int lrectheight: 40
    property int textboxheight: 35
    property int currentpage: 0
    property int lacdheight: 70
    property int widthspliter: 800
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height
    Material.accent: colora
    Component.onCompleted: {
        switch (naturedoc) {
        case "1":
            view.removeItem(7);
            view.removeItem(5);
            view.removeItem(4);
            view.removeItem(3);
            break;

        case "2":
            view.removeItem(6);
            break;
        }
    }
    function save() {
        var obj = {}
        obj.matricule = getMatricule();
        obj.nature = naturedoc;
        obj.name = getFullName();
        obj.dateint = dateint;
        obj.tarriver = tarriver;
        obj.tdepart = tdepart;
        obj.nomoper = nomoper;
        obj.endroit = endroit;
        obj.adresse = adresse;
        obj.ville = ville;
        obj.evautre = evautre;
        obj.vnom = vnom;
        obj.vprenom = vprenom;
        obj.vage = vage;
        obj.vsex = vsex;
        obj.vnaiss = vnaiss;
        obj.vadresse = vadresse;
        obj.vville = vville;
        obj.vautre = vautre;
        obj.vcodepostal = vcodepostal;
        obj.vtelephone = vtelephone;
        obj.nabraisson = nabraission;
        obj.nacr = nacr;
        obj.nconvulsion = nconvulsion;
        obj.ndiabete = ndiabete;
        obj.ndouleurt = ndouleurt;
        obj.nfaibless = nfaibless;
        obj.nhypertermie = nhyperthermie;
        obj.nhypothermie = nhypothermie;
        obj.nintoxication = nintoxication;
        obj.nmaltete = nmaltete;
        obj.nobstr = nobstr;
        obj.ntrauma = ntrauma;
        obj.nautre = nautre;
        if (naturedoc == "2") {
            obj.epreaction = epreaction;
            obj.epvoiesr = epvoiesr;
            obj.eprespiration = eprespiration;
            obj.eppouls = eppouls;
            obj.epnivecon = epnivecon;
            obj.medicaments = medicaments;
            obj.alergies = alergies;
            obj.alergies2 = alergies2;
            obj.ainconnu = ainconnu;
            obj.ana = ana;
            obj.amavc = amacv;
            obj.amcardiaque = amcardiaque;
            obj.amdiabete = amdiabete;
            obj.amepliepsie = amepliepsie;
            obj.amhyperhypo = amhyperhypo;
            obj.amautre = amautre;
            obj.amdescription = amdescription;
            obj.o = o;
            obj.p = p;
            obj.q = q;
            obj.r = r;
            obj.s = s;
            obj.t = t;
            obj.svep1hre = svep1hre;
            obj.svep1resp = svep1resp;
            obj.svep1pouls = svep1pouls;
            obj.svep1ta = svep1ta;
            obj.svep1alert = svep1alert;
            obj.svep1stv = svep1stv;
            obj.svep1std = svep1std;
            obj.svep1nr = svep1nr;

            obj.svep2hre = svep2hre;
            obj.svep2resp = svep2resp;
            obj.svep2pouls = svep2pouls;
            obj.svep2ta = svep2ta;
            obj.svep2alert = svep2alert;
            obj.svep2stv = svep2stv;
            obj.svep2std = svep2std;
            obj.svep2nr = svep2nr;

            obj.svep3hre = svep3hre;
            obj.svep3resp = svep3resp;
            obj.svep3pouls = svep3pouls;
            obj.svep3ta = svep3ta;
            obj.svep3alert = svep3alert;
            obj.svep3stv = svep3stv;
            obj.svep3std = svep3std;
            obj.svep3nr = svep3nr;
        }
        if (naturedoc == "1") {
            obj.descriptioncas = descriptioncas;
        }
        addMessage(JSON.stringify(obj));
        sendSavedInformation();
    }
    Item {
        id: mview
        anchors.fill: parent
        SwipeView {
            id: view
            clip: true
            anchors {
                topMargin: 10
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: indicator.top
            }

            currentIndex: currentpage
            onCurrentIndexChanged: {
                currentItem.forceActiveFocus();
            }

            MedPages.InformationEvenement {
                id: firstPage
                clip: true
                sidePadding: xd
            }

            MedPages.InformationPatient {
                id: secondPage
                clip: true
                sidePadding: xd
            }

            MedPages.NatureCas {
                id: thirdPage
                clip: true
                sidePadding: xd
            }

            MedPages.EvalPrimaire {
                id: fourthPage
                clip: true
                sidePadding: xd
            }

            MedPages.ConditionPatient {
                id: fifthPage
                clip: true
                sidePadding: xd
            }

            MedPages.OPQRST {
                id: sixthPage
                clip: true
                sidePadding: xd
            }
            MedPages.DescriptionsCas {
                id: seventhPage
                clip: true
                sidePadding: xd
            }

            MedPages.EtatSigne {
                id: eightPage
                clip: true
                sidePadding: xd
            }
        }
        PageIndicator {
            id: indicator
            width: implicitWidth
            height: implicitHeight
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: footer.top
            }
            count: view.count
            currentIndex: view.currentIndex
        }

        Comps.ConfirmationPageFooter {
            id: footer
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            onConfirm: {
                mview.enabled = false;
                promptconfirmsave.show();
            }
            onCancel: {
                mview.enabled = false;
                promptconfirmleave.show();
            }

        }

    }

    Dialogs.ConfirmPrompt {
        id: promptconfirmsave
        onCancelDialog: {
            mview.enabled = true;
            promptconfirmsave.hide();
        }

        onConfirmDialog: {
            save();
            winchange(medimain);
        }
    }
    Dialogs.CancelPrompt {
        id: promptconfirmleave
        onCancelDialog: {
            mview.enabled = true;
            promptconfirmleave.hide();
        }

        onConfirmDialog: {
            winchange(medimain);
        }

    }
}

