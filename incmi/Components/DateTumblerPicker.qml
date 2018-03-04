import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Rectangle {
    color: "white"
    border.width: 1
    border.color: colora
    radius: 3
    property string currentDate

    property int itemMargin: 3

    property int index1: (new Date().getDate() - 1)
    property int index2: (new Date().getMonth())
    property int index3: 5

    onIndex1Changed: {
        setCurrentDate();
    }
    onIndex2Changed: {
        setCurrentDate();
    }
    onIndex3Changed: {
        setCurrentDate();
    }

    function setCurrentDate() {
        currentDate = parseInt(index1 + 1) + ":" + parseInt(index2 + 1) + ":" + parseInt(index3 - 5 + new Date().getFullYear());
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


RowLayout{
    anchors {
        fill: parent
        margins: itemMargin
    }

    Tumbler {
        id: datenv1
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.fillHeight: true
        Layout.fillWidth: true
        currentIndex: (new Date().getDate()) - 1
        visibleItemCount: 3
        model: 31
        delegate: Label {
            text: formatDayText(modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
        }
        onCurrentIndexChanged: {
            index1 = currentIndex;
        }
    }

    Label {
        text: qsTr("/")
        Layout.minimumWidth: implicitWidth + 3
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        Layout.fillHeight: true
        Layout.fillWidth: true
    }

    Tumbler {
        id: datenv2
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        currentIndex: (new Date().getMonth())
        Layout.fillWidth: true
        Layout.fillHeight: true
        visibleItemCount: 3
        model: 12
        delegate: Label {
            text: formatMonthText(modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
        }
        onCurrentIndexChanged: {
            if(datenv1.currentItem != null){
                var dat = new Date(datenv3.currentIndex, currentIndex, 0).getDate();
                var index = datenv1.currentIndex
                datenv1.model = dat
                datenv1.currentIndex = index
            }
            index2 = currentIndex;
        }
    }

    Label {
        text: qsTr("/")
        Layout.minimumWidth: implicitWidth + 3
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.fillHeight: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        Layout.fillWidth: true
    }

    Tumbler {
        id: datenv3
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        currentIndex: 5
        visibleItemCount: 3
        Layout.fillWidth: true
        Layout.fillHeight: true
        delegate: Label {
            text: formatYearText(modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
        }
        onCurrentIndexChanged: {
            if(datenv1.currentItem != null){
                var dat = new Date(currentIndex, datenv2.currentIndex, 0).getDate();
                var index = datenv1.currentIndex
                datenv1.model = dat
                datenv1.currentIndex = index
            }
            index3 = currentIndex;
        }
        model: 25
    }
}
}
