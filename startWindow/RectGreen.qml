import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Item {
    id: rectGreen

    property var textInRect

    property var dfltWidth: 40
    property var dfltHeight: 40
    property var dfltScaleTime: 30
    property var dfltFontPixelSize: 20
    property var widthParent: -1

    property var attribute: -1

    property var timeCreated: -1

    property var currentScaleTime: -1

    Rectangle{

        id: test
        width: (dfltScaleTime / currentScaleTime) * dfltWidth
        height: dfltHeight
        color: "#7f92da18"

        Text {
            id:text
            text: textInRect
            color: "black"
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: "Calibri"
            font.pixelSize: (dfltScaleTime / currentScaleTime) * dfltFontPixelSize
        }

//        MouseArea{
//            id: mouse
//            anchors.fill: parent

//            onClicked: {
//                test.color = test.color == "#008000" ? "red" : "#008000"
//                print(test.color)
//            }
//        }
    }

    function changeActivTarget(newActivTaret)
    {
        rectGreen.visible = newActivTaret != attribute ? false : true
    }

    function changeScaleTime(newScaleTime)
    {
        test.width = (dfltScaleTime / newScaleTime) * dfltWidth
        text.font.pixelSize = (dfltScaleTime / newScaleTime) * dfltFontPixelSize
        rectGreen.x = (widthParent / newScaleTime) * (timeCreated / 1000)
    }
}
