import QtQuick 2.0
import QtWebSockets 1.1
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "../Components" as Comps
import "../Delegates" as Delegs

Item {
    Material.accent: colora
    property alias viewModel: mod
    property int animationDuration: 300
    property bool showMedical: true
    property bool showIncendie: true
    property string defstr: ""
    clip: true

    onShowMedicalChanged: {
        checkChanged();
    }
    onShowIncendieChanged: {
        checkChanged();
    }


    function checkChanged() {
        mod.clear();
        setModel(defstr);
        if (!showMedical){
            for (var b = mod.count; b > 0; b--){
                var objb = mod.get(b - 1);
                if (objb.type == "med"){
                    mod.remove(b-1);
                }
            }
        }
        if (!showIncendie){
            for (var c = mod.count; c > 0; c--){
                var obj = mod.get(c - 1);
                if (obj.type == "inc"){
                    mod.remove(c-1);
                }
            }
        }
    }
    ListView {
        id: typeview
        interactive: true
        clip: true
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: filterRect.top
        }
        model: ListModel {id: mod}
        delegate: Delegs.EventItem {}
        add: Transition { NumberAnimation { properties: "x"; from: width; duration: animationDuration; easing.type: Easing.OutQuad }}
        spacing: 3
    }
    Comps.DocumentTypeFilter {
        id: filterRect
        firstCheckText: "Médicale"
        secondCheckText: "Incendie"
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: -1
            bottomMargin: -1
            rightMargin: -1
        }
        onFirstCheck: {
            showMedical = st;
        }
        onSecondCheck: {
            showIncendie = st;
        }
    }
}
