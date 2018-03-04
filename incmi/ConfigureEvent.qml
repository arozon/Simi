import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3


Item {
    property int textboxheight: 35
    property int pad: 5
    property bool isready: false;
    property int footerheight: 70
    property bool cansave: false

    function ready() {
        for (var i = 0; i < currentpeople.length; i++){
            var obj = currentpeople[i];
            console.log(currentpeople[i]);
            tmembers.text += obj.firstname + " " + obj.lastname + "; ";
        }
        var ob = JSON.parse(currentevent);
        datenv3.currentIndex = year;
        datenv2.currentIndex = month;
        datenv1.currentIndex = day;
        thour.textField.text = currenthour;
        tlieu.textField.text = currentlieu;
        tdetails.text = currentdetails;
        switch (currenttype) {
        case "inc":
            rbinc.checked = true;
            break;
        case "med":
            rbmed.checked = true;
            break;
        }
        var dd = Date.fromLocaleDateString(Qt.locale(), currentdate, "dd:M:yyyy");
        if (day == 0) datenv1.currentIndex = dd.getDate() - 1;
        if (month == 0)datenv2.currentIndex = dd.getMonth();
        if (year == 0) datenv3.currentIndex = dd.getFullYear() - new Date().getFullYear() + 5;

        isready = true;
    }

    function checkSave() {
        if (thour.textField.text == "" || tdetails.text == "" || tlieu.textField.text == "") {
            cansave = false;
        }else {
            cansave = true;
        }
    }

    function remove(){
        var obj = JSON.parse(eventitembase);
        obj.date = currentdate
        obj.hour = thour.textField.text;
        obj.people = currentpeople;
        obj.details = tdetails.text;
        obj.lieu = tlieu.textField.text;
        if (rbmed.checked) obj.type = "med";
        if (rbinc.checked) obj.type = "inc";
        obj.tag = currenttag;
        removeEvent(obj);
    }
    function save(){
        var obj = JSON.parse(eventitembase);
        if (editing){
            obj.tag = currenttag;
        }
        obj.date = datenv1.currentItem.text + ":" + datenv2.currentItem.text + ":" + datenv3.currentItem.text;
        obj.hour = thour.textField.text;
        obj.people = currentpeople;
        obj.details = tdetails.text;
        obj.lieu = tlieu.textField.text;
        if (rbmed.checked) obj.type = "med";
        if (rbinc.checked) obj.type = "inc";
        saveEvent(obj);
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

    width: parent.width
    height: parent.height
    Item {
        y: pad
        x: pad
        width: parent.width - 2*pad
        height: parent.height - 3*pad - footerheight
        Label {
            id: dlabel
            x: pad
            y: pad
            elide: "ElideRight"
            width: parent.width - 340 + 3*pad > 0 ? implicitWidth : parent.width - 3*pad - 170
            text: "Event date (dd/mm/yyyy): "
            renderType: Text.QtRendering
            fontSizeMode: Text.HorizontalFit
            verticalAlignment: Text.AlignVCenter
            height: textboxheight
        }
        Item {
            id: i1
            x: pad + dlabel.width + dlabel.x
            width: 170
            height: dlabel.height + 2*pad
            RowLayout{
                anchors.fill: parent
                Tumbler {
                    id: datenv1
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    visibleItemCount: 3
                    model: 31
                    delegate: Label {
                        text: formatDayText(modelData)
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onCurrentIndexChanged: {
                        if (isready) day = datenv1.currentIndex;
                        console.log(day)
                    }
                }

                Label {
                    id: label1
                    text: qsTr("/")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.maximumWidth: 15
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Tumbler {
                    id: datenv2
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    visibleItemCount: 3
                    model: 12
                    delegate: Label {
                        text: formatMonthText(modelData)
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onCurrentIndexChanged: {
                        if (isready) month = datenv2.currentIndex;
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
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillWidth: true
                    Layout.maximumWidth: 15
                }

                Tumbler {
                    id: datenv3
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    visibleItemCount: 3
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    delegate: Label {
                        text: formatYearText(modelData)
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onCurrentIndexChanged: {
                        if (isready) year = currentIndex;
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

        CLabeledTextField {
            id: thour
            height: textboxheight
            width: parent.width
            spad: pad
            y: dlabel.height + dlabel.y + pad * 5
            textField.text: ""
            label.text: "Heure : "
            labelLength: 50
            KeyNavigation.tab: tlieu
            textField.onTextChanged: {
                currenthour = thour.textField.text;
                checkSave();
            }
        }
        CLabeledTextField {
            id: tlieu
            height: textboxheight
            width: parent.width
            spad: pad
            textField.text: ""
            y: pad + thour.height + thour.y
            label.text: "Lieu : "
            labelLength: 50
            KeyNavigation.tab: tdetails
            textField.onTextChanged: {
                currentlieu = tlieu.textField.text;
                checkSave();
            }
        }
        Label {
            id: lb
            y: r3.y
            x: pad
            text: "Members invited : "
            verticalAlignment: Text.AlignVCenter
            height: textboxheight
        }
        Rectangle {
            id: r3
            x: lb.x + lb.width + pad
            y: pad + tlieu.height + tlieu.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight * 2
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            clip: true
            MouseArea {
                anchors.fill: parent
                onDoubleClicked: {
                    dclicked();
                }
            }
            Label {
                id: tmembers
                anchors.fill: parent
                anchors.margins: 3
                font.pointSize: tdetails.font.pointSize
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignTop
                text: ""
                fontSizeMode: Text.HorizontalFit
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }

        }
        Label {
            y: r4.y
            x: pad
            text: "Detailes : "
            verticalAlignment: Text.AlignVCenter
            height: textboxheight
        }
        Rectangle {
            id: r4
            x: lb.x + lb.width + pad
            y: pad + r3.height + r3.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight * 2
            color: "white"
            border.color: "grey"
            border.width: 1
            clip: true
            radius: 3
            TextInput {
                id: tdetails
                selectByMouse: true
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.fill: parent
                anchors.margins: 5
                anchors.leftMargin: 15
                KeyNavigation.tab: thour

                text: ""
                horizontalAlignment: Text.AlignLeft
                onTextChanged: {
                    currentdetails = tdetails.text;
                    checkSave();
                }
            }
        }

        Item {
            width: parent.width
            height: textboxheight
            y: r4.y + r4.height

            RadioButton {
                id: rbmed
                x: rbinc.x - pad - width
                height: parent.height
                width: rbinc.implicitWidth + rbmed.implicitWidth + 3 * pad > parent.width ? (parent.width - 3*pad) / 2 : implicitWidth
                text: "Médical"
            }

            RadioButton {
                id: rbinc
                x: parent.width - pad - width
                width: rbinc.implicitWidth + rbmed.implicitWidth + 3 * pad > parent.width ? (parent.width - 3*pad) / 2 : implicitWidth
                height: parent.height
                text: "Incendie"
            }
        }
    }


    Item {
        id: footer
        x: pad
        y: parent.height - footer.height - pad
        height: footerheight
        width: parent.width - 2*pad
        Button {
            id: bsave
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: rem.implicitWidth + bsave.implicitWidth + canc.implicitWidth + 5*pad > parent.width ? (parent.width - 5*pad) / 2 : implicitWidth
            x: parent.width - pad - width
            Material.background: colorp
            Material.foreground: colorlt
            enabled: cansave
            text: "Save"
            onClicked: {
                save();
            }
        }
        Button {
            id: rem
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: rem.implicitWidth + bsave.implicitWidth + canc.implicitWidth + 5*pad > parent.width ? (parent.width - 5*pad) / 2 : implicitWidth
            x: bsave.x - pad - width
            Material.background: colorp
            Material.foreground: colorlt
            enabled: editing
            text: "Remove"
            onClicked: {
                remove();
            }
        }
        Button {
            id: canc
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: rem.implicitWidth + bsave.implicitWidth + canc.implicitWidth + 5*pad > parent.width ? (parent.width - 5*pad) / 2 : implicitWidth
            x: rem.x - pad - width
            Material.background: colorp
            Material.foreground: colorlt
            text: "Cancel"
            onClicked: {
                cancel();
            }
        }
    }
}
