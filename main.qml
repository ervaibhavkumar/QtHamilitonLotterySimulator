import QtQuick 2.12
import QtQuick.Window 2.12
import QtQml 2.0
import QtQuick.Controls 2.0

Window {
    width: 900
    height: 780
    visible: true
    title: qsTr("Hamiliton Lottery Simulator")

    property int count: 0

    Timer {
        id: timer
        interval: 50
        running: false
        repeat: true
        onTriggered: {
            var num = Math.floor( Math.random() * 5000 )
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
        spacing: 30
        Text {
            id: heading
            text: qsTr("Hamilton Lottery Simulator")
            font.pixelSize: 40
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            width: parent.width
            text: qsTr("This Simulator assumes 10 tickets available every night with 50000 people entering lottery.")
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
        }

        Text {
            width: parent.width
            text: qsTr("You have 1 in 5000 chance of winning")
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
            text: qsTr("In order to have 99% chance of winning the lottery atleast one time, you must play the lottery ~23000 times")
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
                button: "grey"
            }

            onClicked: {
                // start
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
