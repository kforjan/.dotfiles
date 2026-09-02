import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    color: "#191724"

    readonly property color base:    "#191724"
    readonly property color surface: "#1f1d2e"
    readonly property color overlay: "#26233a"
    readonly property color muted:   "#6e6a86"
    readonly property color subtle:  "#908caa"
    readonly property color text:    "#e0def4"
    readonly property color love:    "#eb6f92"
    readonly property color foam:    "#9ccfd8"
    readonly property color iris:    "#c4a7e7"

    property int sessionIndex: sessionModel.lastIndex

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

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 10

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: Qt.formatDateTime(clock.now, "HH:mm")
            color: root.text
            font.pointSize: 64
            font.family: config.font
            font.weight: Font.Light
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: Qt.formatDateTime(clock.now, "dddd, d MMMM")
            color: root.subtle
            font.pointSize: 14
            font.family: config.font
            bottomPadding: 40
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: userField.text.length ? userField.text : "…"
            color: root.text
            font.pointSize: 16
            font.family: config.font
            bottomPadding: 6
        }

        TextField {
            id: userField
            Layout.preferredWidth: 340
            Layout.alignment: Qt.AlignHCenter
            text: userModel.lastUser
            color: root.text
            font.family: config.font
            font.pointSize: 12
            horizontalAlignment: TextInput.AlignHCenter
            background: Rectangle {
                radius: 10
                color: root.surface
                border.width: 1
                border.color: userField.activeFocus ? root.iris : root.overlay
            }
            onAccepted: passwordField.forceActiveFocus()
        }

        TextField {
            id: passwordField
            Layout.preferredWidth: 340
            Layout.alignment: Qt.AlignHCenter
            echoMode: TextInput.Password
            placeholderText: "Password"
            placeholderTextColor: root.muted
            color: root.text
            font.family: config.font
            font.pointSize: 12
            horizontalAlignment: TextInput.AlignHCenter
            focus: true
            background: Rectangle {
                radius: 10
                color: root.surface
                border.width: 1
                border.color: passwordField.activeFocus ? root.iris : root.overlay
            }
            onAccepted: sddm.login(userField.text, passwordField.text, root.sessionIndex)
        }

        Text {
            id: message
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 340
            horizontalAlignment: Text.AlignHCenter
            color: root.love
            font.family: config.font
            font.pointSize: 10
            text: ""
        }
    }

    RowLayout {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 24
        spacing: 16

        ComboBox {
            id: sessionBox
            model: sessionModel
            textRole: "name"
            currentIndex: root.sessionIndex
            onActivated: root.sessionIndex = currentIndex
            font.family: config.font
            font.pointSize: 10
            implicitWidth: 220
        }

        Button {
            text: "Reboot"
            enabled: sddm.canReboot
            font.family: config.font
            font.pointSize: 10
            onClicked: sddm.reboot()
        }

        Button {
            text: "Shutdown"
            enabled: sddm.canPowerOff
            font.family: config.font
            font.pointSize: 10
            onClicked: sddm.powerOff()
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
        function onLoginFailed() {
            message.text = "Login failed"
            passwordField.text = ""
            passwordField.forceActiveFocus()
        }
        function onLoginSucceeded() {
            message.text = ""
        }
    }

    Component.onCompleted: passwordField.forceActiveFocus()
}
