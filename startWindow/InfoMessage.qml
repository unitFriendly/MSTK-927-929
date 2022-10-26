import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle{
    id: popup
    width: 300
    height: 100
    x: parent.width / 2 - popup.width / 2
    y: parent.height
    radius: 10
    color: "#626262"
    border.color: "white"
    layer.enabled: true
    layer.effect: DropShadow {
        anchors.fill: popup
        horizontalOffset: 3
        verticalOffset: 3
        radius: 15
        samples: 50
        color: "black"
        source: popup
    }

    signal endAnimationPopup

    function showMessage(message)
    {
        textMessage.text = message
        numberAnimationPopupFirst.start()
    }

    Text {
        id: textMessage
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 14
        font.family: "Calibri"
//        font.bold: mouseEndTraining.containsMouse ? true : false
        color: "white"
        wrapMode: Text.Wrap
        text: ""
//        text: qsTr("text")
    }

//    MouseArea{
//        anchors.fill: parent

//        onClicked: {
//            showMessage()
//        }
//    }


    NumberAnimation {
        id: numberAnimationPopupFirst
        target: popup
        property: "y"
        from: parent.height
        to: parent.height - popup.height
        duration: 250

        onStopped:
        {
            timer.start()
        }
    }

    Timer {
        id: timer
        interval: 2000
        repeat: false

        onTriggered:
        {
            numberAnimationPopupSecond.start()
        }
    }

    NumberAnimation {
        id: numberAnimationPopupSecond
        target: popup
        property: "y"
        from: parent.height - popup.height
        to: parent.height
        duration: 250

        onStopped: {
            endAnimationPopup()
        }
    }
}
