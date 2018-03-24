import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import "../Components" as Comps

Item {
    property int mscale: 1
    property int nrectheight: 52
    property int pad: 5

    Component.onCompleted: {
        /*
        switch (currenttype) {
        case "invtot":
            cb.enabled = false;
            break;
        case "invinctot":
            cb.enabled = false;
            break;
        }
        */
        var os = Qt.platform.os;
        if (os === "ios" || os === "android") {
            //Is mobile
            scroll.destroy();
        }else if (os === "windows" || os === "linux" || os === "osx") {
            flick.destroy();
        }

    }


    function sendByEmail() {
        var index;
        switch (currenttype) {
        case "docs":
            index = "9";
            break;
        case "inv":
            index = "9";
            break;
        case "inc":
            index = "23";
            break;
        case "invtot":
            index = "24";
            break;
        case "invinctot":
            index = "31";
            break;
        case "invinc":
            index = "23";
            break;
        }
        var message = '{"messageindex":"'+index+'","filename":"' + currentfilename + '"}';
        addMessage(message);
        sendSavedInformation();
        goback();
    }

    function deleteDocument() {
        var index;
        switch (currenttype) {
        case "docs":
            index = "10";
            break;
        case "inv":
            index = "10";
            break;
        case "inc":
            index = "25";
            break;
        case "invinc":
            index = "25";
            break;
        }
        var message = '{"messageindex":"'+index+'","filename":"' + currentfilename + '"}';
        addMessage(message);
        sendSavedInformation();
        goback();
    }

    function goback() {
        switch (currenttype) {
        case "docs":
            winchange(medimain);
            break;
        case "inv":
            winchange(medimain);
            break;
        case "invtot":
            winchange(medinventory);
            break;
        case "inc":
            winchange(incm);
            break;
        case "invinc":
            winchange(incm);
            break;
        case "invinctot":
            winchange(incinventory);
            break;
        }

    }

    Rectangle {
        id: m
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: settings.isadmin ? adminfooter.top : footer.top
        }

        color: "grey"
        Flickable {
            id: flick
            anchors.fill: parent
            contentWidth: m.width
            contentHeight: m.height
            PinchArea {
                width: Math.max(flick.contentWidth, flick.width)
                height: Math.max(flick.contentHeight, flick.height)

                property real initialWidth
                property real initialHeight
                onPinchStarted: {
                    initialWidth = flick.contentWidth
                    initialHeight = flick.contentHeight
                }

                onPinchUpdated: {
                    // adjust content pos due to drag
                    flick.contentX += pinch.previousCenter.x - pinch.center.x
                    flick.contentY += pinch.previousCenter.y - pinch.center.y

                    // resize content
                    flick.resizeContent(initialWidth * pinch.scale, initialHeight * pinch.scale, pinch.center)
                }

                onPinchFinished: {
                    // Move its content within bounds.
                    flick.returnToBounds()
                }

                Rectangle {
                    width: flick.contentWidth
                    height: flick.contentHeight
                    color: "white"
                    Image {
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                        source: imgurl
                        MouseArea {
                            anchors.fill: parent
                            onDoubleClicked: {
                                flick.contentWidth = m.width
                                flick.contentHeight = m.height
                            }
                            onClicked: {
                                console.log("I am flick");
                                mouse.accepted = false;
                            }
                        }
                    }
                }
            }
        }
        ScrollView {
            id: scroll
            anchors.fill: parent
            contentWidth: m.width
            contentHeight: im2.sourceSize.height * (m.width / im2.sourceSize.width)
                Rectangle {
                    id: rr
                    width:  scroll.contentWidth
                    height: scroll.contentHeight
                    x: width < scroll.width ? (scroll.width - width) / 2 : 0
                    y: height < scroll.height ? (scroll.height - height) / 2 : 0
                    color: "white"
                    Image {
                        id: im2
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectFit
                        source: imgurl
                        MouseArea {
                            anchors.fill: parent
                            onDoubleClicked: {
                                scroll.contentWidth = m.width
                                scroll.contentHeight = im2.sourceSize.height * (m.width / im2.sourceSize.width);
                            }
                            onClicked: {
                                console.log("I am scroll");
                                mouse.accepted = false;
                            }
                            onWheel: {
                                var dif = wheel.angleDelta.y
                                var sc = scroll.contentWidth + dif;
                                var sb = scroll.contentHeight + dif;

                                if (sb > 0 && sc > 0) {
                                    scroll.contentWidth += dif;
                                    scroll.contentHeight += dif * (im2.sourceSize.height / im2.sourceSize.width);
                                    console.log(scroll.contentHeight);
                                }else {
                                    wheel.accepted = false;
                                }
                            }
                        }
                    }
            }
        }
    }
    Comps.TwoButtonAdminFooter {
        id: adminfooter
        visible: settings.isadmin;
        anchors {
            left: parent.left
            right: parent.right
            bottom: footer.top
            bottomMargin: -1
            leftMargin: -1
            rightMargin: -1
        }

        firstButton {
            text: "Effacer"
            source: "../Icons/ic_delete_forever_white_24dp.png"
        }
        secondButton {
            text: "Envoyer"
            source: "../Icons/ic_drafts_white_24dp.png"
        }
        onFirstClicked: {
            deleteDocument();
        }
        onSecondClicked: {
            sendByEmail();
        }
    }
    Comps.BackPageFooter {
        id: footer
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        onBack: {
            goback();
        }
    }
}
