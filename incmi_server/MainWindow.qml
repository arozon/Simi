import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

Item {
    width: 1280
    height: 720

    Pane {
        id:header
        width: parent.width
        height: 78
        Material.background: colordp
        Material.elevation: 1
        GridLayout {
            anchors.rightMargin: parent.width / 5
            anchors.leftMargin: parent.width / 5
            anchors.fill: parent
            Image {
                Layout.maximumWidth: 200
                fillMode: Image.PreserveAspectFit
                Layout.minimumWidth: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }
            Label {
                text: "Simi Server"
                font.pointSize: 28
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt

            }

            Image {
                Layout.maximumWidth: 200
                fillMode: Image.PreserveAspectFit
                Layout.minimumWidth: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }


        }

    }
    Rectangle{
        id: loadrec
        y: header.height
        width: parent.width
        height: parent.height - header.height - footer.height
        Loader {
            clip: true
            id: ld
            anchors.fill: parent
            sourceComponent: log;
        }
    }


    Pane {
        id: footer
        y: parent.height - height
        width: parent.width
        height: 100
        Material.background: "#0288D1"
        RowLayout {
            id: frlayout
            spacing: 0
            anchors.fill: parent
            Item {
                Layout.minimumWidth: frlayout.width/2
                Layout.maximumWidth: frlayout.width/2
                Layout.fillHeight: true
                Layout.fillWidth: true
                RowLayout{
                    anchors.fill: parent
                    ColumnLayout {
                        Layout.minimumWidth: 150
                        spacing: 0
                        Layout.maximumWidth: 150
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Button {
                            text: qsTr("Start")
                            Layout.minimumWidth: implicitWidth
                            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            enabled: !senabled
                            Material.foreground: colorlt
                            Material.background: colordp
                            Material.elevation: 0
                            onClicked: {
                                setServerState(true);
                            }
                        }
                        Button {
                            text: qsTr("Stop")
                            Layout.minimumWidth: implicitWidth
                            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            enabled: senabled
                            Material.foreground: colorlt
                            Material.background: colordp
                            Material.elevation: 0
                            onClicked: {
                                setServerState(false);
                            }
                        }
                    }
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Label {
                            x: 15
                            y: 5
                            id: stlab
                            text: "Server status"
                            font.pointSize: 16
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Material.foreground: colorlt
                        }

                        Label
                        {
                            y: stlab.implicitHeight + stlab.y + 3
                            x: 30
                            id: statuslabel
                            elide: "ElideRight"
                            text: senabled ? "-- Enabled" : "-- Disabled"
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Material.foreground: senabled ? "darkgreen" : colorlt
                        }


                    }
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Label {
                            x: 15
                            y: 10
                            id: stip
                            text: "IP: " + server.host
                            elide: "ElideRight"
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Material.foreground: colorlt
                        }

                        Label
                        {
                            y: stip.implicitHeight + stip.y + 3
                            x: 15
                            id: stport
                            text: "Port: " + server.port
                            elide: "ElideRight"
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Material.foreground: colorlt
                        }
                        Label
                        {
                            y: stport.implicitHeight + stport.y + 3
                            x: 15
                            id: sturl
                            text: "Url: " + server.url
                            elide: "ElideRight"
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Material.foreground: colorlt
                        }


                    }
                }
            }
            Item {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.maximumWidth: (frlayout.width)/8
                Layout.minimumWidth: (frlayout.width)/8
                Layout.fillHeight: true
                Layout.fillWidth: true

                CButton {
                    id: obutton
                    x: 15
                    y: parent.height - obutton.height - 5
                    height: parent.height *3 / 5
                    width: parent.width - 30
                    text: qsTr("Options")
                    source: "Icons/ic_settings_applications_white_24dp.png"
                    Material.foreground: colorlt
                    Material.background: colordp
                    Material.elevation: 0
                    onClicked: {
                        load.enabled = false;
                        options.show();
                    }
                }

            }
        }
    }

    Component {
        id: log
        LogView { id: lview }
    }
}
