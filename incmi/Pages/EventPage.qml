import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1
import "../Components" as Comps
import "../EventComponents" as EventPages

Item {
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height
    property int pad: 5
    property var currentpeople: []
    property bool editing: false;
    property int day;
    property int month;
    property int year;
    property string currentevent: eventitembase
    property string currenthour
    property string currentdetails
    property string currentlieu
    property string currenttag
    property string currenttype
    property string currentdate: new Date().toLocaleDateString(Qt.locale(),"dd:M:yyyy");


    function reset() {
        footer.enabled = true;
        editing = false;
        currentevent = eventitembase;
        currentpeople = [];
        currenthour = "";
        currentdetails = "";
        currentlieu = "";
        currenttag = "";
        currenttype = "";
        year = 0;
        day = 0;
        month = 0;
    }

    function editEvent(obj) {
        editing = true;
        currentpeople = obj.people;
        currentevent = JSON.stringify(obj);
        currenthour = obj.hour;
        currentdetails = obj.details;
        currentlieu = obj.lieu;
        currentdate = obj.date
        currenttag = obj.tag;
        currenttype = obj.type;
        tabBar.setCurrentIndex(2);
    }

    function doneMembers(){
        changeStackPage(cev);
    }

    function dclicked(obj){
        changeStackPage(ppl);
    }

    function ddclicked(obj) {
        if (settings.isadmin) {
            editEvent(obj);
        }
    }

    function saveEvent(obj){
        switch(editing){
        case true:
            editEventItem(obj);
            editing = false;
            break;
        case false:
            createEventItem(obj);
            break;
        }
        tabBar.setCurrentIndex(0);
    }

    function editEventItem(obj) {
        var message = JSON.stringify(obj).slice(0,-1) + ',"messageindex":"12"}';
        addMessage(message);
        sendSavedInformation();
    }

    function createEventItem(obj) {
        var message = JSON.stringify(obj).slice(0,-1) + ',"messageindex":"13"}';
        addMessage(message);
        sendSavedInformation();
    }

    function removeEventItem(obj) {
        var message = JSON.stringify(obj).slice(0,-1) + ',"messageindex":"14"}';
        addMessage(message);
        sendSavedInformation();
    }

    function removeEvent(obj) {
        removeEventItem(obj);
        tabBar.setCurrentIndex(0);
    }

    function cancel() {
        tabBar.setCurrentIndex(0);
    }

    function changeStackPage(page) {
        //ld.replace(ld.get(0),page,StackView.PopTransition);
        //ld.pop(null);

        ld.push(page);
    }

    function modifyPeople(condition, obj) {
        switch (condition) {
        case true:
            var exists = false;
            for (var b = 0; b < currentpeople.length; b++){
                var oi = currentpeople[b];
                console.log(obj.filename);
                if (obj.filename === oi.filename) {
                    exists = true;
                }
            }
            if (!exists){
                currentpeople.push(obj);
            }
            break;
        case false:
            for (var i = currentpeople.length; i > 0; i--){
                var ot = currentpeople[i-1];
                console.log(obj.filename);
                if (ot.filename === obj.filename) {
                    currentpeople.splice(i - 1,1);
                }
            }
            break;
        }
    }

    Component {
        id: prev
        EventPages.PreviousEvent {}
    }

    Component {
        id: upc
        EventPages.UpcomingEvent {}
    }

    Component {
        id: cev
        EventPages.ConfigureEvent {}
    }

    Component {
        id: ppl
        EventPages.MembersEvent {}
    }

    Component.onCompleted:  {
        if (!settings.isadmin) {
            tabBar.removeItem(2);
        }
    }

    Connections {
        target: window
        onDoEvents: {
            ld.currentItem.ready();
        }
    }

    ColumnLayout {
        id: columnLayout
        spacing: 0
        anchors.fill: parent
        Item {
            Layout.minimumHeight: tabBar.implicitHeight + 16
            Layout.maximumHeight: tabBar.implicitHeight + 16
            Layout.fillHeight: true
            Layout.fillWidth: true
            Pane {
                anchors.fill: parent
                anchors.margins: 2
                Material.elevation: 5
                Material.foreground: colorlt
                Material.background: colordp
                TabBar {
                    id: tabBar
                    width: parent.width
                    height: implicitHeight
                    y: ( parent.height - implicitHeight ) / 2
                    font.capitalization: Font.SmallCaps
                    font.bold: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    Material.accent: colorlt

                    TabButton {
                        text: qsTr("Precedent")
                    }
                    TabButton {
                        text: qsTr("Future")
                    }
                    TabButton {
                        text: qsTr("Configure")
                    }

                    onCurrentIndexChanged: {
                        switch(tabBar.currentIndex){
                        case 0:
                            reset()
                            changeStackPage(prev);
                            break;
                        case 1:
                            reset()
                            changeStackPage(upc);
                            break;
                        case 2:
                            footer.enabled = false;
                            changeStackPage(cev);
                            break;
                        }
                    }
                }
            }
        }
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            StackView {
                anchors {
                    fill: parent
                    topMargin: 3
                    bottomMargin: 3
                }

                id: ld
                clip: true;
                initialItem: prev
                onBusyChanged: {
                    if (!busy) {
                        ld.currentItem.ready();
                    }
                }
            }
        }

        Comps.BackPageFooter {
            id: footer
            Layout.minimumHeight: height
            Layout.fillHeight: true
            Layout.maximumHeight: height
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        }
    }

}
