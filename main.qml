import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

import QtQuick.Layouts 1.15

import "./startWindow"



Window {
    id: window
    width: 1280
    height: 720
    visible: true
    title: "МСТК-927/929"
    //    flags: Qt.FramelessWindowHint

    color: "#626262"
    property var textTime: ""

    property int fontSize: 32
    property int fontSizeHover: 36


    //    Rectangle {
    //        Text {
    //            id: name
    //            text: textTime
    //        }

    //        //        Transition




    //    }

    //    function log(number_1) {
    //        console.log(number_1)
    //    }

    signal changedWidthSignal(var newWidth, var newXPosition)

    //    Component.onCompleted: {
    //        changedWidthSignal.connect(window.log)
    //    }

    //    Timer {
    //        id: timerRect
    //        property int count: -1
    //        property int xRow: 0
    //        interval: 500
    //        running: true
    //        repeat: true

    //        onTriggered: {
    //            var rectCreator = Qt.createComponent("RectGreen.qml")

    //            timerRect.count = timerRect.count + 1

    //            timerRect.xRow = (sizeRectangleCurrent * timerRect.count);

    //            var Rect = rectCreator.createObject(row,
    //                                                {
    //                                                    x: timerRect.xRow,
    //                                                    countText: timerRect.count,
    //                                                    colorChange: Qt.rgba(0.0, 1.0, 0.0 , 0.5),
    //                                                    dfltWidth: sizeRectangleCurrent
    //                                                });

    //            changedWidthSignal.connect(Rect.setWidthRectGreen)
    ////            print(timerRect.count)
    //        }
    //    }
    //    }

//    Button {
//        x: 500
//        y: 500
////        visible: false

//        onClicked:
//        {
//            popup.open()
//        }
//    }







    StartWindow{
        id: startWindow

        onSignalExit: {
            startWindow.close()
            window.show()
        }
    }


    Rectangle{
        id: parametersTraining
        y: 282
        width: 480
        height: 156
        anchors.left: parent.left
        anchors.leftMargin: 400
        color: "transparent"

        MouseArea{
            id: parametersTrainingMouse
            anchors.fill: parent

            hoverEnabled: true

            onClicked: {
                startWindow.show()
                window.hide()
                mainClass.startTimerGeneral()
            }
        }

        Image {

            height: parent.height
            width: parent.width
            //          fillMode: Image.PreserveAspectCrop
            source: "qrc:/pictures/Nastroiki_knopka_obzor.tif"
        }

        Text {
            id: parameterstrainingText
            x: 28
            y: 8
            width: 423
            height: 140
            text: qsTr("Старт")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            //                fontSize
            font.pointSize: parametersTrainingMouse.containsMouse ? fontSizeHover : fontSize
            font.family: "Calibri"
            font.bold: parametersTrainingMouse.containsMouse ? true : false
            color: "white"
        }
    }



//    property var listArray: []

//    ComboBox{
//        id: comboBox
//        visible: false
//    }

//    Button {
//        id: buttonConnect
//        x: 253
//        y: 76
//        text: qsTr("Connect")
//        visible: false
//        onClicked: {
//            mainClass.connectSerialPort(comboBox.displayText);
//        }
//    }

//    Button {
//        id: buttonDisconnect
//        x: 459
//        y: 76
//        text: qsTr("Disconnect")
//        visible: false

//        onClicked: {

//            mainClass.disconnectSerialPort();

//        }
//    }


//    Component.onCompleted: {
//        print("Component.onCompleted")
//        mainClass.getDate()
//        mainClass.getTime()

////        listArray = mainClass.getArrayPortName()

////        for (var i = 0; i < mainClass.getSizeArrayPortName(); i++)
////        {
////            listArray.push(mainClass.getValueFromArrayPotname(i));
////            console.log(listArray[i])
////        }

////        comboBox.model = listArray
//    }

//    Rectangle{
//        x: 552
//        y: 310
//        width: 100
//        height: 100
//        color: "red"
//        anchors.verticalCenter: parent.verticalCenter
//        anchors.verticalCenterOffset: -220
//        anchors.horizontalCenterOffset: -386
//        anchors.horizontalCenter: parent.horizontalCenter
//        MouseArea{
//            id: area
//            anchors.fill: parent

//            onClicked: {
//                //                timerRect.running = !timerRect.running

//                startWindow.show()
//                window.hide()
//                mainClass.startTimerGeneral()

//                //                var placeMent

//                //                var rectCreator = Qt.createComponent("RectGreen.qml")
//                //                var Rect = rectCreator.createObject(parent, {x: mouseX, y: mouseY});
//            }
//        }
//    }

    //    Grid {
    //        x: 171
    //        y: 183
    //        layoutDirection: Qt.LeftToRight
    //        flow: Grid.TopToBottom
    //        rows: 0
    //        verticalItemAlignment: Grid.AlignVCenter
    //        horizontalItemAlignment: Grid.AlignHCenter
    //        columns: 3
    //        spacing: 2
    //        Rectangle { color: "red"; width: 50; height: 50 }
    //        Rectangle { color: "green"; width: 20; height: 50 }
    //        Rectangle { color: "blue"; width: 50; height: 20 }
    //        Rectangle { color: "cyan"; width: 50; height: 50 }
    //        Rectangle { color: "magenta"; width: 10; height: 10 }
    //    }


    //    Grid {
    //        id: grid
    //        x: 50
    //        y: 352
    //        width: 111
    //        height: 61
    //        transformOrigin: Item.Center
    //        spacing: 2
    //        horizontalItemAlignment: Grid.AlignHCenter
    //        rows: 1
    //        columns: 2

    //        Rectangle {
    //            id: rectangle
    //            width: 20
    //            height: 20
    //            color: "#ffffff"
    //        }

    //        Rectangle {
    //            id: rectangle1
    //            width: 20
    //            height: 20
    //            color: "#ffffff"
    //        }

    //        Rectangle {
    //            id: rectangle2
    //            width: 20
    //            height: 20
    //            color: "#ffffff"
    //        }
    //    }

    //    MouseArea {
    //        anchors.fill: parent
    //        acceptedButtons: Qt.LeftButton | Qt.RightButton
    //        onClicked: {

    //                    if (mouse.button == Qt.RightButton)
    //                    {
    //                        cff += 10
    //                        scroll.contentWidth = timerRect.count * cff
    //                        console.log(scroll.contentWidth)
    ////                        event.accepted = true
    //                    }


    //                    if (mouse.button == Qt.LeftButton)
    //                    {
    //                        cff -= 10
    //                        scroll.contentWidth = timerRect.count * cff
    //                        console.log(scroll.contentWidth)
    ////                        event.accepted = true
    //                    }
    //        }
    //    }


}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
