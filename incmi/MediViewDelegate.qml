import QtQuick 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Item {
    x: pad / 2
    width: parent.width - pad
    height: type === "docs" ? 100 : 35
    property int xd: 1
    property int pad: 10
    property int labellength: 0
    property int rpad: 9

    function formatText(text) {
        var ntext = text.replace(":","/");
        ntext = ntext.replace(":","/");
        return ntext;
    }

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

    Component.onCompleted: {
        switch (type) {
        case "docs":
            blabel.visible = false;
            ilabel.visible = false;
            break;
        case "inv":
            l1.visible = false;
            lb.visible = false;
            l2.visible = false;
            l3.visible = false;
            bl.visible = false;
            bl2.visible = false;
            bl3.visible = false;
            bl4.visible = false;
            break;
        }
    }

    Pane {
        Material.background: {
            if (listView.currentIndex === index) {
                return colordp
            }
            else {
                return "white"
            }
        }
        Material.foreground: {
            if (listView.currentIndex === index) {
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
            width: type === "docs" ? lb.implicitWidth + pad : blabel.implicitWidth + pad
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
                id: lb
                y: parent.height /4
                height: parent.height / 4
                width: parent.width - pad / 2
                text: "Opération"
                font.bold: true
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }

            Label {
                id: l2
                y: parent.height / 2
                height: parent.height / 4
                width: parent.width - pad / 2
                text: "Ville"
                font.bold: true
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }

            Label {
                id: l3
                y: parent.height * 3 / 4
                height:  parent.height / 4
                width: parent.width - pad / 2
                text: "Nature"
                font.bold: true
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
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
                color: listView.currentIndex === index ? colorlt : colort
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
                height: parent.height / 4
                text: type === "docs" ? formatText(dateint) : ""
                fontSizeMode: Text.HorizontalFit
                wrapMode: Text.NoWrap
                leftPadding: pad
                elide: "ElideRight"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;

            }
            Label {
                id: bl2
                width: parent.width
                height: parent.height / 4
                fontSizeMode: Text.HorizontalFit
                wrapMode: Text.NoWrap
                leftPadding: pad
                text: type === "docs" ? nomoper : ""
                y: parent.height / 4
                elide: "ElideRight"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }
            Label {
                id: bl3
                width: parent.width
                height: parent.height / 4
                wrapMode: Text.NoWrap
                leftPadding: pad
                text: type === "docs" ? ville: ""
                fontSizeMode: Text.HorizontalFit
                y: parent.height / 2
                elide: "ElideRight"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }

            Label {
                id: bl4
                width: parent.width
                height: parent.height / 4
                wrapMode: Text.NoWrap
                leftPadding: pad
                elide: "ElideRight"
                text: type === "docs" ? formatNate(nature) : ""
                fontSizeMode: Text.HorizontalFit
                y: parent.height * 3 / 4
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }

            Label {
                id: ilabel
                elide: "ElideRight"
                width: parent.width
                height: parent.height
                wrapMode: Text.NoWrap
                leftPadding: pad
                text: type === "docs" ? "" : formatText(date)
                fontSizeMode: Text.HorizontalFit
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter;
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            listView.currentIndex = index;
        }

        onDoubleClicked: {
            getDocImage(filename,type);
        }
    }
}
