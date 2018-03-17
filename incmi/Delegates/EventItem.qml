import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import "../Components" as Comps


Pane {
    id: rectangle
    property string peoples
    property int itemPadding: 3

    height: lay.height + 2 * padding
    x: itemPadding
    width: parent.width - 2 * itemPadding
    Material.elevation: 4
    padding: 15

    Material.background: {
        if (typeview.currentIndex === index) {
            return colordp
        }
        else {
            return "white"
        }
    }
    Material.foreground: {
        if (typeview.currentIndex === index) {
            return colorlt
        }
        else {
            return "black"
        }
    }



    Component.onCompleted: {
        for (var i = 0; i < people.count; i++){
            peoples += people.get(i).firstname + " " + people.get(i).lastname + "; ";
        }
        var da = Date.fromLocaleDateString(locale, date, 'dd:M:yyyy');
        ndate.text = da.getDate();
        mydate.text = da.toLocaleDateString(locale, 'MMMM yyyy');
        height = Qt.binding(function () {return lay.height + 2*padding;});
        typeview.forceLayout();
    }

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
        onClicked: {
            typeview.currentIndex = index;
        }
    }


    Label {
        id: ndate
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
        }
        padding: itemPadding

        width: parent.width / 4 < implicitWidth ? implicitWidth : parent.width / 4
        text: "22"
        font.pixelSize: 60
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Column {
        id: lay
        spacing: itemPadding
        height: childrenRect.height + spacing
        anchors {
            left: ndate.right
            right: parent.right
            top: parent.top
        }

    Label {
        id: mydate
        height: implicitHeight
        padding: itemPadding
        anchors {
            right: parent.right
            left: parent.left
        }
        wrapMode: Text.WordWrap
        topPadding: 5
        text: date
        verticalAlignment: Text.AlignVCenter
        font.family: "Verdana"
        font.underline: false
        font.bold: true
        leftPadding: 10
        font.pixelSize: 17
    }

    Label {
        id: dlab
        padding: itemPadding
        height: implicitHeight
        wrapMode: Text.WordWrap
        anchors {
            left: parent.left
            right: parent.right
        }

        text: "Heure : " + hour
        font.pixelSize: 15
        leftPadding: 10
        verticalAlignment: Text.AlignVCenter
    }

    Label {
        id: llieu
        padding: itemPadding
        wrapMode: Text.WordWrap
        anchors {
            right: parent.right
            left: parent.left
        }

        height: implicitHeight
        text: "Lieu : " + lieu
        font.pixelSize: 15
        leftPadding: 10
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: drect
        height: drectl.height + drectl.anchors.margins*2
        anchors {
            margins: itemPadding
            left: parent.left
            right: parent.right
        }

        border.color: "darkgrey"
        color: "whitesmoke"
        border.width: 1
        clip: true
        radius: 3
        Label {
            id: drectl
            anchors {
                margins: 2*itemPadding
                top: parent.top
                left: parent.left
                right: parent.right

            }
            Material.foreground: "black"
            text: "Details de l'evenements: " + details
            font.pixelSize: 15
            wrapMode: Text.WordWrap
            height: implicitHeight
            padding: 5
        }
    }
    Rectangle {
        id: prect
        height: prect1.height + prect1.anchors.margins*2
        anchors {
            margins: itemPadding
            left: parent.left
            right: parent.right

        }
        border.color: "darkgrey"
        color: "whitesmoke"
        border.width: 1
        radius: 3
        clip: true
        Label {
            id: prect1
            anchors {
                margins: 2*itemPadding
                left: parent.left
                right: parent.right
                top: parent.top
            }
            Material.foreground: "black"
            height: implicitHeight
            text: "Membres: " + peoples
            font.pixelSize: 15
            wrapMode: Text.WordWrap
            padding: 5
        }
    }
    }
}
