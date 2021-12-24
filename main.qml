import QtQuick 2.12
import QtQuick.Window 2.12
import QtQml 2.0
import QtQuick.Controls 2.0

Window {
    width: 900
    height: 780
    visible: true
    title: qsTr("Hamilton Lottery Simulator")

    readonly property int tickets: 10
    property int count: 0
    property int people: 20000
    property int prob: people / tickets
    property real notWinning: ( prob - 1 ) / prob // example 4999 / 5000
    property int atLeastOneTimeWin: Math.floor( Math.log(0.01) / Math.log( notWinning ) )

    Timer {
        id: timer
        interval: 50
        running: false
        repeat: true
        onTriggered: {
            var num = Math.floor( Math.random() * people )
            // when 16 is the selected, then you won
            if ( num == 16 ) {
                state.text = "You Won!!"
                stop()
            } else {
                state.text = "Try again"
            }
            count += 1
        }
    }

    Column {
        anchors.fill: parent
        spacing: 25
        Text {
            id: heading
            text: qsTr("Hamilton Lottery Simulator")
            font.pixelSize: 40
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Slider {
            from: 50
            to: 100000
            value: people
            stepSize: 100
            anchors.horizontalCenter: parent.horizontalCenter
            onValueChanged: {
                toolTip.visible = true
                people = value
            }
            ToolTip {
                id: toolTip
                text: "People: " + people
            }
        }

        Text {
            width: parent.width
            text: qsTr("This Simulator assumes " + tickets + " tickets available every night with " + people + " people entering lottery.")
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
        }

        Text {
            width: parent.width
            text: qsTr("You have 1 in " + prob + " chance of winning")
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
        }

        // prob of not winning one time = 4999 / 5000
        // prob of not winning 2 times =  ( 4999 / 5000 ) * ( 4999 / 5000 )
        // prob of not winning N times =  ( 4999 / 5000 ) ^ N = 1 - prob of winning at least one time
        Text {
            width: parent.width
            text: qsTr("In order to have 99% chance of winning the lottery atleast one time, you must play the lottery ~" + atLeastOneTimeWin + " times")
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
        }

        Button {
            id: start
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Start entering the lottery"

            palette {
                button: "#CCC"
            }

            onClicked: {
                count = 0
                timer.start()
            }
        }

        Text {
            id: counter
            text: "You have played " + count + " times"
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: state
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
