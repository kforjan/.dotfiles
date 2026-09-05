import QtQuick 2.15

Rectangle {
    id: root
    color: "#191724"

    // Rose Pine (main)
    readonly property color base:    "#191724"
    readonly property color surface: "#1f1d2e"
    readonly property color overlay: "#26233a"
    readonly property color muted:   "#6e6a86"
    readonly property color subtle:  "#908caa"
    readonly property color text:    "#e0def4"
    readonly property color love:    "#eb6f92"
    readonly property color iris:    "#c4a7e7"

    readonly property color grad1:   "#1ba9e6"
    readonly property color grad2:   "#135eb1"
    readonly property color grad3:   "#8f2857"
    readonly property color grad4:   "#9f1f4c"

    property int sessionIndex: sessionModel.lastIndex
    property string fontName: config.font ? config.font : "Sans"

    function doLogin() {
        message.text = ""
        sddm.login(userInput.text, passwordInput.text, root.sessionIndex)
    }

    Image {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: true
    }

    Rectangle {
        anchors.fill: parent
        color: root.base
        opacity: 0.55
    }

    Column {
        anchors.centerIn: parent
        spacing: 8

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.now, "HH:mm")
            color: root.text
            font.family: root.fontName
            font.pointSize: 64
            font.weight: Font.Light
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.now, "dddd, d MMMM")
            color: root.subtle
            font.family: root.fontName
            font.pointSize: 14
        }

        Item { width: 1; height: 40 }

        // username
        Rectangle {
            width: 340; height: 46
            radius: 10
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0;  color: userInput.activeFocus ? root.grad1 : root.overlay }
                GradientStop { position: 0.35; color: userInput.activeFocus ? root.grad2 : root.overlay }
                GradientStop { position: 0.7;  color: userInput.activeFocus ? root.grad3 : root.overlay }
                GradientStop { position: 1.0;  color: userInput.activeFocus ? root.grad4 : root.overlay }
            }

            Rectangle {
                anchors.fill: parent
                anchors.margins: userInput.activeFocus ? 2 : 1
                radius: 9
                color: root.surface
            }

            TextInput {
                id: userInput
                anchors.fill: parent
                anchors.margins: 12
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
                text: userModel.lastUser
                color: root.text
                font.family: root.fontName
                font.pointSize: 12
                selectionColor: root.grad1
                selectedTextColor: root.base
                clip: true
                KeyNavigation.tab: passwordInput
                onAccepted: passwordInput.forceActiveFocus()
            }
        }

        Rectangle {
            width: 340; height: 46
            radius: 10
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0;  color: passwordInput.activeFocus ? root.grad1 : root.overlay }
                GradientStop { position: 0.35; color: passwordInput.activeFocus ? root.grad2 : root.overlay }
                GradientStop { position: 0.7;  color: passwordInput.activeFocus ? root.grad3 : root.overlay }
                GradientStop { position: 1.0;  color: passwordInput.activeFocus ? root.grad4 : root.overlay }
            }

            Rectangle {
                anchors.fill: parent
                anchors.margins: passwordInput.activeFocus ? 2 : 1
                radius: 9
                color: root.surface
            }

            TextInput {
                id: passwordInput
                anchors.fill: parent
                anchors.margins: 12
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
                echoMode: TextInput.Password
                passwordCharacter: "•"
                color: root.text
                font.family: root.fontName
                font.pointSize: 12
                clip: true
                focus: true
                onAccepted: root.doLogin()
            }

            // TextInput has no placeholderText; this stands in for it.
            Text {
                anchors.centerIn: parent
                text: "Password"
                color: root.muted
                font.family: root.fontName
                font.pointSize: 12
                visible: passwordInput.text.length === 0 && !passwordInput.activeFocus
            }
        }

        Text {
            id: message
            anchors.horizontalCenter: parent.horizontalCenter
            width: 340
            horizontalAlignment: Text.AlignHCenter
            color: root.love
            font.family: root.fontName
            font.pointSize: 10
            text: ""
        }
    }

    Row {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 24
        spacing: 22

        Text {
            text: sessionModel.count > 0
                  ? sessionModel.data(sessionModel.index(root.sessionIndex, 0), Qt.UserRole + 4)
                  : ""
            color: root.subtle
            font.family: root.fontName
            font.pointSize: 10

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.sessionIndex = (root.sessionIndex + 1) % sessionModel.count
            }
        }

        Text {
            text: "Reboot"
            color: sddm.canReboot ? root.subtle : root.muted
            font.family: root.fontName
            font.pointSize: 10
            MouseArea {
                anchors.fill: parent
                enabled: sddm.canReboot
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.reboot()
            }
        }

        Text {
            text: "Shutdown"
            color: sddm.canPowerOff ? root.subtle : root.muted
            font.family: root.fontName
            font.pointSize: 10
            MouseArea {
                anchors.fill: parent
                enabled: sddm.canPowerOff
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.powerOff()
            }
        }
    }

    QtObject {
        id: clock
        property var now: new Date()
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.now = new Date()
    }

    Connections {
        target: sddm
        onLoginFailed: {
            message.text = "Login failed"
            passwordInput.text = ""
            passwordInput.forceActiveFocus()
        }
    }

    Component.onCompleted: passwordInput.forceActiveFocus()
}
