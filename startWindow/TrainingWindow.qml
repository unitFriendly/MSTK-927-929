import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3

ApplicationWindow{
    id: viewwew

    width: 1280
    height: 800

//    width: 1920
//    height: 1080

    color: "#626262"
    title: "МСТК-927/929"

    //    visible: false

    property int widthRectRepeater: 300
    property int heightRectRepeater: 50

    //    function getTimeAndDate()
    //    {
    //        startWindowDateText.text = Qt.formatDateTime(new Date(), "dd.MM.yyyy")
    //        startWindowHourAndMinutsText.text = Qt.formatTime(new Date(), "hh:mm")
    //        //        print(Qt.formatDateTime(new Date(), "dd.MM.yyyy"))

    //    }
    function getTimeFromC()
    {
        startWindowHourAndMinutsText.text = mainClass.getTime()
    }

    function getDateFromC()
    {
        startWindowDateText.text = mainClass.getDate()
    }

    function handlerNewHit(target, zone)
    {
        widgetShootingTargetAll.handlerNewHit(target, -1)
        widgetShooting.handlerNewHit(target, zone)

    }

    function showing()
    {
        viewwewRepeater.model = mainClass.getCountTargets()
        viewwewRow.width = (widthRectRepeater + viewwewRow.spacing) * viewwewRepeater.model

        widgetShootingTargetAll.setNameWidget("Общий")
        widgetShooting.setNameWidget("Мишень 1")

        currentTargetActiv = viewwewRepeater.itemAt(0)
        currentTargetActiv.setImageActiv()

        widgetShooting.clearChild()
        widgetShootingTargetAll.clearChild()

        viewWindowTraining.clearColorModel()

        mainClass.clearSizeZone(configMSTK.getCountTarget())

//        widgetShooting.children
//        var tmpListChild = widgetShooting.children
    }

    signal signalViewwewExit

    WidgetViewWindowTraining {
        id: viewWindowTraining
        width: parent.width / 1.45
        height: parent.height / 1.45
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2 + parent.height / 20
//        anchors.fill: parent
//        anchors.rightMargin: 182
//        anchors.bottomMargin: 110
//        anchors.leftMargin: 182
//        anchors.topMargin: 195
//        color: "red"
    }

    Rectangle {
        id: startWindowTime
        width: parent.width
        height: 70
        color: "#404040"
        border.color: "#404040"
        border.width: 0
        anchors.top: parent.top
        //        Timer {
        //            id: startWindowTimer
        //            interval: 1000
        //            repeat: true
        //            running: true

        //            onTriggered: {
        //                getTimeAndDate()
        //            }
        //        }

        Rectangle {
            id: startWindowTimeHourAndMinuts
            width: 180
            height: parent.height / 2
            color: "#00000000"
            anchors.right: parent.right
            anchors.top: parent.top
            Text {
                id: startWindowHourAndMinutsText
                width: 180
                height: 35
                color: "#ffffff"

                anchors.verticalCenter: startWindowTimeHourAndMinuts.verticalCenter
                font.pixelSize: 22
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                anchors.horizontalCenter: startWindowTimeHourAndMinuts.horizontalCenter
                font.family: "Calibri"
            }
        }

        Rectangle {
            id: startWindowDate
            width: 180
            height: parent.height / 2
            color: "#00000000"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            Text {
                id: startWindowDateText
                width: 180
                height: 35
                color: "#ffffff"

                anchors.verticalCenter: startWindowDate.verticalCenter
                font.pixelSize: 22
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                anchors.horizontalCenter: startWindowDate.horizontalCenter
                font.family: "Calibri"
            }
        }

        function getDateFromC()
        {
            startWindowDateText.text = mainClass.getDate()
        }

        function getTimeFromC()
        {
            startWindowHourAndMinutsText.text = mainClass.getTime()
        }

        Component.onCompleted: {
            mainClass.onGetTime.connect(getTimeFromC)
            mainClass.onGetDate.connect(getDateFromC)
        }

//        Rectangle {
//            id: startWindowHelp
//            x: 0
//            y: 0
//            width: 86
//            height: 70
//            color: startWindowHelpMouse.containsMouse ? "#323232" : "transparent"
//            MouseArea {
//                id: startWindowHelpMouse
//                anchors.fill: parent
//                hoverEnabled: true
//            }

//            Text {
//                id: startWindowHelpText
//                color: "#ffffff"
//                text: startWindowHelpMouse.containsMouse ? "X" : "?"
//                anchors.fill: parent
//                horizontalAlignment: Text.AlignHCenter
//                verticalAlignment: Text.AlignVCenter
//                font.family: startWindowHelpMouse.containsMouse ? "Arial Unicode MS" : "Tahoma"
//                font.pointSize: startWindowHelpMouse.containsMouse ? fontSizeHover : fontSize
//                font.bold: startWindowHelpMouse.containsMouse ? false : true
//            }
//        }

//        Rectangle {
//            id: startWindowSettings
//            x: 110
//            y: 0
//            width: 86
//            height: 70
//            color: startWindowSettingsMouse.containsMouse ? "#323232" : "transparent"
//            Rectangle {
//                id: startWindowSettingsRect
//                width: startWindowSettingsMouse.containsMouse ? 55 : 50
//                height: startWindowSettingsMouse.containsMouse ? 50 : 45
//                color: "#00000000"
//                anchors.verticalCenter: parent.verticalCenter
//                Image {
//                    id: startWindowSettingsImg
//                    x: 0
//                    y: 0
//                    width: parent.width
//                    height: parent.width
//                    source: startWindowSettingsMouse.containsMouse ? "qrc:/pictures/Nastroiki.tif" : "qrc:/pictures/Big_Nastroiki.tif"
//                }
//                anchors.horizontalCenter: parent.horizontalCenter
//            }

//            MouseArea {
//                id: startWindowSettingsMouse
//                anchors.fill: parent
//                hoverEnabled: true
//            }
//        }



        Rectangle {
            id: endTraining
            height: 70
            width: 287
            y: 0
            x: 0
            color: "transparent"
//            visible: false

            Image {
//                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10

                height: 0.65 * parent.height
                width: 0.65 * parent.width

                source: "qrc:/picturesTrainingWindow/Knopka_zavershit.tif"

                MouseArea{
                    id: mouseEndTraining
                    anchors.fill: parent

                    hoverEnabled: true

                    onClicked: {

                        var pathToSaveFile = mainClass.saveTraining(configMSTK.getDefaultPathTraining())
                        resultWindow.loadDataFromFile("file:///" + pathToSaveFile)
                        infoMessage.showMessage("Тренировка сохранена")
                    }
                }

                Text {
                    id: textEndTraining
                    anchors.fill: parent
                    text: qsTr("Завершить")
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: mouseEndTraining.containsMouse ? 22 : 20
                    font.family: "Calibri"
                    font.bold: mouseEndTraining.containsMouse ? true : false
                    color: "white"
                }
            }
        }

        Rectangle {
            height: 70
            width: 408
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"

            Rectangle {
                id: cyberMandarin
                anchors.left: parent.left
                anchors.top: parent.top
                width: 70
                height: 70
                color: "#00000000"
                Image {
                    id: cyberMandarinImg
                    width: 70
                    height: 70
                    source: "qrc:/pictures/Logo3.tif"
                }
            }

            Rectangle {
                id: cyberMandarinName
                width: 338
                height: 70
                color: "#00000000"
                anchors.left: cyberMandarin.right
                anchors.top: parent.top
                Image {
                    id: image
                    x: 0
                    y: 15
                    width: 257
                    height: 40
                    source: "qrc:/pictures/Cyber.tif"
                }
            }
        }



//        Rectangle {
//            id: startWindowStick
//            x: 85
//            y: 0
//            width: 25
//            height: 70
//            color: "#00000000"
//            Rectangle {
//                x: 12
//                y: 12
//                width: 1
//                height: 50
//                color: "#ffffff"
//            }
//        }
    }

    property var currentTargetActiv



    Row {
        id: viewwewRow

        anchors.horizontalCenter: parent.horizontalCenter
        y: 159

        height: heightRectRepeater
        spacing: 30

        Repeater {
            id: viewwewRepeater
            anchors.fill: parent


            //            anchors.fill: parent
            //            model: countTargets
            Rectangle {
                id: rectReapeater
                height: parent.height
                width: widthRectRepeater
                color: "transparent"

                function setImageActiv()
                {
                    imageButton.source = "qrc:/picturesTrainingWindow/Mishen_aktiv_2.tif"
                    repeaterRectText.color = "white"
                }

                function setImageNoActiv()
                {
                    imageButton.source = "qrc:/picturesTrainingWindow/Mishen_ne_aktiv_2.tif"
                    repeaterRectText.color = "black"
                }

                Image {
                    id: imageButton
                    anchors.fill: parent
                    //          fillMode: Image.PreserveAspectCrop
                    source: "qrc:/picturesTrainingWindow/Mishen_ne_aktiv_2.tif"
                    MouseArea {
                        id: imageRepeaterMouse
                        anchors.fill: parent

                        onClicked: {
                            currentTargetActiv.setImageNoActiv()
                            currentTargetActiv = rectReapeater
                            currentTargetActiv.setImageActiv()

                            widgetShooting.currentTargetActiv = index

                            widgetShooting.onChangeTarget(index)

                            widgetShooting.setNameWidget("Мишень " + (index + 1))
                        }
                    }

                    Text {
                        id: repeaterRectText
                        anchors.fill: parent
                        text: qsTr("Мишень " + (index+1))
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        //                fontSize
                        font.pointSize: 22/*parametersTrainingMouse.containsMouse ? fontSizeHover : fontSize*/
                        font.family: "Calibri"
                        //font.bold: parametersTrainingMouse.containsMouse ? true : false
                        color: "#000000"
                    }
                }
            }
        }
    }

    WidgetShooting {
        id: widgetShooting
        x: 2
//        y: 716
        y: parent.height - 100
        anchors.horizontalCenter: parent.horizontalCenter
        currentTargetActiv: 0
//        color: "green"
    }

    WidgetShooting {
        id: widgetShootingTargetAll
        x: 0
        y: 86
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button
    {
        x: 50
        y: 125
        width: 50
        height: 50
        focus: true
        background: Rectangle {
            color: "transparent"
        }

        Keys.onPressed: {
            if (event.key === Qt.Key_Q)
            {
                console.log("Q")
                mainClass.newHit(0, 1)
                event.accepted = true;
            }

            if (event.key === Qt.Key_A)
            {
                console.log("A")
                mainClass.newHit(0, 2)
                event.accepted = true;
            }

            if (event.key === Qt.Key_Z)
            {
                console.log("Z")
                mainClass.newHit(0, 3)
                event.accepted = true;
            }

            if (event.key === Qt.Key_W)
            {
                console.log("W")
                mainClass.newHit(1, 4)
                event.accepted = true;
            }

            if (event.key === Qt.Key_S)
            {
                console.log("S")
                mainClass.newHit(1, 5)
                event.accepted = true;
            }

            if (event.key === Qt.Key_X)
            {
                console.log("X")
                mainClass.newHit(1, 6)
                event.accepted = true;
            }

            if (event.key === Qt.Key_E)
            {
                console.log("E")
                mainClass.newHit(2, 7)
                event.accepted = true;
            }

            if (event.key === Qt.Key_D)
            {
                console.log("D")
                mainClass.newHit(2, 8)
                event.accepted = true;
            }

            if (event.key === Qt.Key_C)
            {
                console.log("C")
                mainClass.newHit(2, 9)
                event.accepted = true;
            }

            if (event.key === Qt.Key_R)
            {
                console.log("R")
                mainClass.newHit(0, 10)
                event.accepted = true;
            }

            if (event.key === Qt.Key_F)
            {
                console.log("F")
                mainClass.newHit(0, 11)
                event.accepted = true;
            }

            if (event.key === Qt.Key_V)
            {
                console.log("V")
                mainClass.newHit(0, 12)
                event.accepted = true;
            }

            if (event.key === Qt.Key_T)
            {
                console.log("T")
                mainClass.newHit(0, 13)
                event.accepted = true;
            }
        }
    }

//    Slider {
//        id: slider
//        x: 50
//        y: 132
//        width: 40
//        height: 558
//        orientation: Qt.Vertical
//        value: 30
//        from: 30
//        to: 120
//        stepSize: 15

//        Keys.onPressed: {
//            if (event.key === Qt.Key_Q)
//            {
//                console.log("Q")

//                mainClass.newHit(0, 1)

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_A)
//            {
//                console.log("A")

//                //for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(0, 2)
//                }

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_Z)
//            {
//                console.log("Z")

//                //for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(0, 3)
//                }

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_W)
//            {
//                console.log("W")

//                //            for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(1, 4)
//                }

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_S)
//            {
//                console.log("S")

//                //            for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(1, 5)
//                }

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_X)
//            {
//                console.log("X")

//                //            for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(1, 6)
//                }

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_E)
//            {
//                console.log("E")

//                //            for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(2, 7)
//                }

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_D)
//            {
//                console.log("D")

//                //            for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(2, 8)
//                }

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_C)
//            {
//                console.log("C")

//                //            for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(2, 9)
//                }

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_R)
//            {
//                console.log("R")

//                //            for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(0, 10)
//                }

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_F)
//            {
//                console.log("F")

//                //            for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(0, 11)
//                }

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_V)
//            {
//                console.log("V")

//                //            for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(0, 12)
//                }

//                event.accepted = true;
//            }

//            if (event.key === Qt.Key_T)
//            {
//                console.log("T")

//                //            for (var i = 0; i < mainClass.getCountTargets(); i++)
//                {
//                    mainClass.newHit(0, 13)
//                }

//                event.accepted = true;
//            }
//        }

//        onValueChanged: {

//            widgetShootingTargetAll.currentScaleTime = value
//            widgetShooting.currentScaleTime = value

//            //            console.log(value)
//            //            sizeRectangleCurrent = windowRect.width / slider.value

//            //            window.changedWidthSignal(sizeRectangleCurrent, timerRect.xRow)

//            //scroll.contentWidth = timerRect.count * sizeRectangleCurrent
//        }
//    }

//    Slider {
//        id: slider1
//        x: 103
//        y: 132
//        width: 40
//        height: 558
//        value: 1
//        stepSize: 0.5
//        orientation: Qt.Vertical
//        to: 4
//        from: 0.5

//        Label {
//            id: label
//            x: 37
//            y: 8
//            width: 48
//            height: 28
//            text: qsTr("Label")
//            horizontalAlignment: Text.AlignHCenter
//            font.pointSize: 12

//            Component.onCompleted: {
//                label.text = slider1.value
//            }
//        }

//        onValueChanged: {
//            label.text = slider1.value
//            mainClass.setCffSpeedPlay(slider1.value)
//        }
//    }

//    Button {
//        id: button
//        x: 1130
//        y: 243
//        text: qsTr("Button")

//        onClicked: {

////            mainClass.setStartColor(Qt.rgba(0.4,0.4,0.4,1));
////            mainClass.clearSizeZone();
////            viewWindowTraining.clearColorModel();

////            if(mainClass.getIsCalcXRow())
////            {
////                mainClass.setIsCalcXRow(false)
////            }
////            else
////            {
////                mainClass.setIsCalcXRow(true)
////            }


//        }
//    }

    Component.onCompleted: {
        mainClass.onGetDate.connect(getDateFromC)
        mainClass.onGetTime.connect(getTimeFromC)
        mainClass.onNewHitCopter.connect(handlerNewHit)
    }

    InfoMessage{
        id: infoMessage

        onEndAnimationPopup:
        {
            resultWindow.show()
            viewwew.hide()
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}D{i:29}
}
##^##*/
