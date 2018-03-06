import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2


Pane {
    Component.onCompleted: {
        for (var i = 0; i < people.count; i++){
            peoples += people.get(i).firstname + " " + people.get(i).lastname + "; ";
        }
        var da = Date.fromLocaleDateString(locale, date, 'dd:M:yyyy');
        ndate.text = da.getDate();
        mydate.text = da.toLocaleDateString(locale, 'MMMM yyyy');
    }
    height: 175
    width: parent.width - 2*drectpad
    x: drectpad
    property int drectpad: 3
    property string peoples
    id: rectangle
    Material.elevation: 4
    MouseArea {
        anchors.fill: parent
        onDoubleClicked: {
            var obj = {};
            obj.people = [];
            for (var i = 0; i < people.count; i++){
                obj.people.push(people.get(i));
            }
            obj.hour = hour;
            obj.date = date;
            obj.lieu = lieu;
            obj.details = details;
            obj.tag = tag;
            obj.type = type;
            ddclicked(obj);
        }
    }


    Label {
        id: ndate
        x:0
        y:0
        height: parent.height
        width: parent.width / 4
        color: colort
        text: "22"
        font.pixelSize: 44
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Label {
        id: mydate
        x: ndate.width
        y: 0
        width: parent.width - ndate.width
        height: parent.height / 6
        topPadding: 5
        text: date
        color: colort
        verticalAlignment: Text.AlignVCenter
        font.family: "Verdana"
        font.underline: false
        font.bold: true
        leftPadding: 10
        font.pointSize: 14
    }

    Label {
        id: dlab
        x: ndate.width
        y: mydate.height
        color: colort
        height: parent.height / 8
        width: parent.width - ndate.width
        elide: "ElideRight"
        text: "Heure : " + hour
        font.pointSize: 9
        leftPadding: 10
        verticalAlignment: Text.AlignVCenter
    }

    Label {
        id: llieu
        x: ndate.width
        y: dlab.height + dlab.y
        color: colort
        width: parent.width - ndate.width
        elide: "ElideRight"
        height: parent.height / 8
        text: "Lieu : " + lieu
        font.pointSize: 9
        leftPadding: 10
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: drect
        x: ndate.width + drectpad
        y: llieu.y + llieu.height + drectpad
        width: parent.width - ndate.width - 2*drectpad
        height: (parent.height - mydate.height - dlab.height - llieu.height) / 2 - 2*drectpad
        border.color: "darkgrey"
        color: "whitesmoke"
        border.width: 1
        clip: true
        radius: 3
        Label {
            anchors.fill: parent
            text: "Details de l'evenements: " + details
            font.pointSize: 9
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            elide: "ElideRight"
            padding: 5
        }
    }
    Rectangle {
        id: prect
        x: ndate.width + drectpad
        y: drect.y + drect.height + drectpad
        width: parent.width - ndate.width - 2*drectpad
        height: (parent.height - mydate.height - dlab.height - llieu.height) / 2 - 2*drectpad
        border.color: "darkgrey"
        color: "whitesmoke"
        border.width: 1
        radius: 3
        clip: true
        Label {
            anchors.fill: parent
            text: "Membres: " + peoples
            font.pointSize: 9
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            elide: "ElideRight"
            padding: 5
        }
    }
}
