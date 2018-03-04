import QtQuick 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Item {
    x: 5
    width: parent.width - 10
    height: type == "docs" ? 100 : 35
    property int xd: 1
    property int pad: 10
    property int rpad: 9



    function formatText(text) {
        var ntext = text.replace(":","/");
        ntext = ntext.replace(":","/");
        return ntext;
    }

    /*

    function formatNate(text) {
        var ntext;
        switch(text) {
        case "1":
            ntext = "Leger"
            break;
        case "2":
            ntext = "Moderer"
            break;
        case "3":
            ntext = "Sever"
            break;
        case "":
            ntext = ""
            break;
        }
        return ntext;
    }

    */

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

    Pane {
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

        Material.elevation: 2
        anchors.fill: parent

        Item {
            id: leftpanel
            width: type == "docs" ? lb.implicitWidth + pad : blabel.implicitWidth + pad
            height: parent.height
            Label {
                id: l1
                width: parent.width - pad / 2
                height: parent.height / 4
                text: "Date"
                font.bold: true
                fontSizeMode: Text.Fit
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }

            Label {
                id: l2
                y: parent.height /5
                height: parent.height / 5
                width: parent.width - pad / 2
                text: "Heure"
                font.bold: true
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }

            Label {
                id: lb
                y: parent.height *2/ 5
                height: parent.height / 5
                width: parent.width - pad / 2
                text: "Adresse"
                font.bold: true
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }

            Label {
                id: l3
                y: parent.height * 3 / 5
                height:  parent.height / 5
                width: parent.width - pad / 2
                text: "Ville"
                font.bold: true
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }

            Label {
                id: l4
                y: parent.height * 4/5
                height: parent.height / 5
                width: parent.width - pad / 2
                text: "Nature"
                font.bold: true
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                id: blabel
                height:  parent.height
                width: parent.width - pad / 2
                text: "Changements d'inventaires"
                font.bold: true
                fontSizeMode: Text.Fit
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
                wrapMode: Text.NoWrap
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
                fontSizeMode: Text.HorizontalFit
                wrapMode: Text.NoWrap
                leftPadding: pad
                text: time
                y: parent.height / 5
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }
            Label {
                id: bl3
                width: parent.width
                height: parent.height / 5
                fontSizeMode: Text.HorizontalFit
                elide: "ElideRight"
                wrapMode: Text.NoWrap
                leftPadding: pad
                text: adresse
                y: parent.height *2 / 5
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }

            Label {
                id: bl4
                width: parent.width
                height: parent.height / 5
                fontSizeMode: Text.HorizontalFit
                wrapMode: Text.NoWrap
                elide: "ElideRight"
                leftPadding: pad
                text: ville
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
                fontSizeMode: Text.HorizontalFit
                wrapMode: Text.NoWrap
                leftPadding: pad
                text: nature
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
        /*
        Label {
            id: dat
            height: parent.height;
            x: xd;
            elide: "ElideRight"
            width: ((parent.width - 8) / 5)
            text: date
            leftPadding: pad
            horizontalAlignment: Text.AlignLeft;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            id: r1
            height: parent.height - rpad*2;
            y: rpad;
            x: dat.x + dat.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            id: tim
            elide: "ElideRight"
            height: parent.height;
            x: xd + r1.width + r1.x;
            width: ((parent.width - 8) / 5);
            text: time
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            id: r2
            height: parent.height - rpad*2;
            y: rpad;
            x: tim.x + tim.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            id: adress
            elide: "ElideRight"
            height: parent.height;
            x: xd + r2.width + r2.x;
            width: ((parent.width - 8) / 5);
            text: adresse
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            id: r3
            height: parent.height - rpad*2;
            y: rpad;
            x: adress.x + adress.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            id: vill
            elide: "ElideRight"
            height: parent.height;
            x: xd + r3.width + r3.x;
            width: ((parent.width - 8) / 5);
            text: ville
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }

        Rectangle {
            id: r4
            height: parent.height - rpad*2;
            y: rpad;
            x: vill.x + vill.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            id: typ
            elide: "ElideRight"
            height: parent.height;
            x: xd + r4.width + r4.x;
            width: ((parent.width - 5*xd) / 5) - 5*xd;
            text: type
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
        */
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
