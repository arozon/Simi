import QtQuick 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Pane {
    property int viewItemMargins: 5
    width: parent.width - 2*viewItemMargins
    x: viewItemMargins
    height: type == "docs" ? 100 : 35
    property int xd: 1
    property int pad: 10
    property int rpad: 9



    function formatText(text) {
        var ntext = text.replace(":","/");
        ntext = ntext.replace(":","/");
        return ntext;
    }


    Material.background: {
        if (listView.currentIndex == index) {
            return colordp
        }
        else {
            return "white"
        }
    }
    Material.foreground: {
        if (listView.currentIndex == index) {
            return colorlt
        }
        else {
            return "black"
        }
    }
    Material.elevation: 3
    Component.onCompleted: {
        switch (type) {
        case "docs":
            blabel.destroy();
            ilabel.destroy();
            break;
        case "inv":
            l1.destroy();
            lb.destroy();
            l2.destroy();
            l3.destroy();
            l4.destroy();
            bl.destroy();
            bl2.destroy();
            bl3.destroy();
            bl4.destroy();
            bl5.destroy();
            break;
        }
    }

    Item {
        id: leftpanel
        width: type == "docs" ? (lb.implicitWidth + pad) > (parent.width / 2) ? parent.width /2 : (lb.implicitWidth + pad) : (blabel.implicitWidth + pad) > parent.width * 2 / 3 ? parent.width * 2 / 3 : (blabel.implicitWidth + pad)
        height: parent.height
        Label {
            id: l1
            width: parent.width - pad / 2
            height: parent.height / 4
            elide: "ElideRight"
            text: "Date"
            fontSizeMode: Text.HorizontalFit
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter;
        }

        Label {
            id: l2
            y: parent.height /5
            height: parent.height / 5
            width: parent.width - pad / 2
            elide: "ElideRight"
            text: "Heure"
            fontSizeMode: Text.HorizontalFit
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter;
        }

        Label {
            id: lb
            y: parent.height *2/ 5
            height: parent.height / 5
            width: parent.width - pad / 2
            elide: "ElideRight"
            text: "Adresse"
            fontSizeMode: Text.HorizontalFit
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter;
        }

        Label {
            id: l3
            y: parent.height * 3 / 5
            height:  parent.height / 5
            width: parent.width - pad / 2
            elide: "ElideRight"
            text: "Ville"
            fontSizeMode: Text.HorizontalFit
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter;
        }

        Label {
            id: l4
            y: parent.height * 4/5
            height: parent.height / 5
            width: parent.width - pad / 2
            elide: "ElideRight"
            text: "Nature"
            fontSizeMode: Text.HorizontalFit
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: blabel
            height:  parent.height
            width: parent.width - pad / 2
            text: "Changements d'inventaires"
            fontSizeMode: Text.HorizontalFit
            elide: "ElideRight"
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter;
        }

        Rectangle {
            width: 1
            x: parent.width - pad / 4
            height: parent.height
            color: listView.currentIndex == index ? colorlt : colort
        }
    }

    Item {
        id: rightsector
        width: parent.width - leftpanel.width
        x: leftpanel.width
        height: parent.height

        Label {
            id: bl
            width: parent.width
            height: parent.height / 5
            text: date
            fontSizeMode: Text.HorizontalFit
            elide: "ElideRight"
            leftPadding: pad
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter;

        }
        Label {
            id: bl2
            width: parent.width
            height: parent.height / 5
            elide: "ElideRight"
            leftPadding: pad
            text: time
            fontSizeMode: Text.HorizontalFit
            y: parent.height / 5
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter;
        }
        Label {
            id: bl3
            width: parent.width
            height: parent.height / 5
            elide: "ElideRight"
            leftPadding: pad
            text: adresse
            fontSizeMode: Text.HorizontalFit
            y: parent.height *2 / 5
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter;
        }

        Label {
            id: bl4
            width: parent.width
            height: parent.height / 5
            elide: "ElideRight"
            leftPadding: pad
            text: ville
            fontSizeMode: Text.HorizontalFit
            y: parent.height * 3 / 5
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter;
        }

        Label {
            id: bl5
            width: parent.width
            height: parent.height / 5
            y: parent.height * 4 / 5
            elide: "ElideRight"
            leftPadding: pad
            text: nature
            fontSizeMode: Text.HorizontalFit
        }

        Label {
            id: ilabel
            width: parent.width
            height: parent.height
            elide: "ElideRight"
            fontSizeMode: Text.HorizontalFit
            wrapMode: Text.NoWrap
            leftPadding: pad
            text: type == "docs" ? "" : matricule + ":" + formatText(date)
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter;
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            listView.currentIndex = index;
        }

        onDoubleClicked: {
            switch (type) {
            case "inv":
                getDocImage(filename, "invinc");
                break;

            case "docs":
                getDocImage(filename,"inc");
                break;
            }
        }
    }
}
