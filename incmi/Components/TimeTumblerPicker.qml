import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Rectangle {
    property int index1: 0
    property int index2: 0
    property int itemMargin: 3

    property string currentTime

    function setCurrentTime() {
        currentTime = parseInt(index1) + ":" + parseInt(index2);
    }


    onIndex1Changed: {
        setCurrentTime();
    }
    onIndex2Changed: {
        setCurrentTime();
    }


    function formatHourText(modelData) {
        var data = modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }
    function formatMinuteText(modelData) {
        var data = modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }


    color: "white"
    border.color: colora
    border.width: 1
    radius: 3

RowLayout{
    anchors.fill: parent
    anchors {
        fill: parent
        margins: itemMargin
    }

    Tumbler {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.fillHeight: true
        Layout.fillWidth: true
        currentIndex: 0
        visibleItemCount: 3
        model: 24
        delegate: Label {
            text: formatHourText(modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
        }
        onCurrentIndexChanged: {
            index1  = currentIndex;
        }
    }

    Label {
        text: qsTr(":")
        Layout.minimumWidth: implicitWidth + 3
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Layout.maximumWidth: 5
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        Layout.fillHeight: true
        Layout.fillWidth: true
    }

    Tumbler {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        currentIndex: 0
        Layout.fillWidth: true
        Layout.fillHeight: true
        visibleItemCount: 3
        model: 60
        delegate: Label {
            text: formatMinuteText(modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
        }
        onCurrentIndexChanged: {
            index2 = currentIndex;
        }
    }
}
}
