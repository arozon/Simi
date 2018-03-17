import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3
import "../MainComponents" as Pages
import "../Components" as Comps


Item {
    clip: true
    property int headerHeight: useSafeAreaPadding ? safeAreaSize + 90 : 90
    Component.onCompleted: {
        if (useSafeAreaPadding) {
            header.topPadding = safeAreaSize;
        }
    }

    function doneServerSettings() {
        sview.push(ssettings);
    }

    function showPeopleSettings() {
        sview.push(peopleview);
    }

    function donePeopleSettings() {
        sview.push(servsettings);
    }

    function pressedIncendie() {
        winchange(incm);
    }

    function pressedMedical() {
        winchange(medimain);
    }

    function pressedEvents() {
        winchange(events);
    }

    function pressedConfigureAccess() {
        optionsbutton.visible = false;
        sview.push(apicker);
    }

    function pressedIntervenant() {
        sview.push(ssettings);
        settings.isadmin = false;
        optionsbutton.visible = false;
    }

    function pressedAdministrateursConfirmed() {
        settings.isadmin = true;
        optionsbutton.visible = false;
        sview.push(ssettings);
    }

    function confirmSettings(selectedMember) {
        if (settings.isfirstboot) {
             settings.isfirstboot = false;
        }
        settings.user = selectedMember;
        optionsbutton.visible = true;
        sview.push(spicker);

    }

    function pressedOptions() {
        optionsbutton.visible = false;
        sview.push(ssettings);
    }

    function serverSettings() {
        sview.push(servsettings);
    }

    Pane {
        id: header
        height: headerHeight
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            rightMargin: -1
            leftMargin: -1
            topMargin: -1
        }

        Material.elevation: 4
        Material.background: colordp
        GridLayout {
            id: gridLayout
            anchors.fill: parent
            Image {
                fillMode: Image.PreserveAspectFit
                source: "../Images/ucmu_100h.png"
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumWidth: 100
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                text: "Simi"
                color: colorlt
                font.bold: true
            }

            Comps.IconButton {
                id: optionsbutton
                Layout.fillHeight: true
                Layout.maximumHeight: header.height / 2
                Layout.maximumWidth: Layout.maximumHeight
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                source: "../Icons/ic_settings_applications_white_24dp.png"
                Material.background: colordp
                Material.foreground: colorlt
                Material.elevation: 6
                visible: !settings.isfirstboot
                onClicked: {
                    visible = false;
                    sview.push(ssettings);
                }

                Behavior on visible {
                    ScriptAction {
                        script: {
                            var val;
                            switch (optionsbutton.visible) {
                            case true:
                                val = 0;
                                break;
                            case false:
                                val = 1;
                                break;
                            }
                            optionsbutton.opacity = val;
                        }
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 190
                        easing.type: Easing.InQuad;
                    }
                }
            }
        }
    }

    Connections {
        target: window
        onDoEvents: {
          switch (settings.isfirstboot) {
          case true:
              sview.push(apicker);
              break;
          case false:
              sview.push(spicker);
              break;
          }
        }
    }


    StackView {
      id: sview
      anchors {
          top: header.bottom
          left: parent.left
          bottom: parent.bottom
          right: parent.right
      }

      clip: true
      onBusyChanged: {
          if (!busy) {
              sview.currentItem.ready();
          }
      }
    }



    Component {
        id: apicker
        Pages.AccessSelector {}
    }

    Component {
        id: spicker
        Pages.CategorySelector{}
    }

    Component {
        id: ssettings
        Pages.Settings {}
    }

    Component {
        id: servsettings
        Pages.ServerSettings {}
    }

    Component {
        id: peopleview
        Pages.PeopleConfiguration {}
    }

}


