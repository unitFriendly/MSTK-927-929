import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12
import Qt.labs.platform 1.1


import "../"

ApplicationWindow{
    id: startWindow
    width: 1280
    height: 800
    //    visible: true
    title: "МСТК-927/929"
    color: "#626262"
//    flags: Qt.FramelessWindowHint
    Settings{
        id: settingsWindow

        onSignalSettingsExit: {
//            startWindow.hide()
            settingsWindow.show()
        }
    }

    ResultWindow {
        id: resultWindow

        onSignalExitResultWindow: {
            loadDataFromFile(fileDialog.file)



            resultWindow.show()
            startWindow.hide()
        }
    }

    TrainingParameters{
        id: trainingParameters

        onSignalTrainingParametersExit: {
            trainingParameters.show()
//            startWindow.hide()
        }

        onTrainingParametrApply: {
            infoMessage.showMessage("Параметры тренировки сохранены")
        }
    }

    TrainingWindow {
        id: trainingWindow

        onSignalViewwewExit: {
            showing()
            trainingWindow.show()
            startWindow.hide()
        }
    }


    signal signalExit

    property int fontSize: 32
    property int fontSizeHover: 36

    property var date

    function slotTimer1Sec() {
        startWindowDateText.text = mainClass.getDate()
    }

    function getDateFromC()
    {
        startWindowDateText.text = mainClass.getDate()
    }

    function getTimeFromC()
    {
        startWindowHourAndMinutsText.text = mainClass.getTime()
//        print(mainClass.getTime())
    }

    Component.onCompleted: {
//        TimerGeneral.timerGeneral_1SecSignal.connect(slotTimer1Sec)

        mainClass.onGetTime.connect(getTimeFromC)
        mainClass.onGetDate.connect(getDateFromC)
//        mainClass.onNewHitCopter.connect(addHitEntityCopter)

    }


//    property var locale: Qt.locale()

    //функция для получения текущей даты и времени.
//    function getTimeAndDate()
//    {
//        startWindowDateText.text = Qt.formatDateTime(new Date(), "dd.MM.yyyy")
//        startWindowHourAndMinutsText.text = Qt.formatTime(new Date(), "hh:mm")
////        print(Qt.formatDateTime(new Date(), "dd.MM.yyyy"))
//    }

    //функция заглушка для рандома количества целей.
//    function getRandom(min, max)
//    {
//        min = Math.ceil(min)
//        max = Math.floor(max)
//        var a = Math.floor(Math.random() * (max - min + 1)) + min
//        return a;
//    }

    //функция для поиска целей (мишеней) и обработка нажатия на кнопку поиска целей.
    function foundTargets()
    {
        mainClass.setCountTargets(configMSTK.getCountTarget())
        countTargetsText.text = configMSTK.getCountTarget()
        foundingTargetsText.text = "Найдено\nмишеней"
        beginingTrainingImg.source = "qrc:/pictures/Trenirovka_aktiv.tif"
        beginingTrainingText.color = "black"
        beginingTraining.enabled = true
    }




    FileDialog {
        id: fileDialog
        title: "Выберите тренировку:"
        folder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
        fileMode: FileDialog.OpenFile
        nameFilters: ["*.json"]
        visible: false
        onAccepted: {
            console.log("You chose: " + fileDialog.file)
            resultWindow.signalExitResultWindow()
            console.log("resultWindow.signalExitResultWindow()")
            //            Qt.quit()
        }
        onRejected: {
            console.log("Canceled")
            //            Qt.quit()
        }   //        Component.onCompleted: visible = true
    }








    Rectangle {
        width: 1280
        height: 800
        color: "transparent"
//        opacity: 0.5

        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2

        //кнопка выхода из приложения
        Rectangle {
            id: startWindowExit
            x: 1035
            y: 711
            width: 216
            height: 60
            color: "transparent"

            MouseArea{
                id: startWindowExitMouse
                anchors.fill: parent

                hoverEnabled: true

                onClicked: {
                    Qt.quit()
                }
            }

            Image {
                id: startWindowExitImg
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width
                height: parent.height
                source: "qrc:/pictures/Vyhod.tif"
    //            fillMode: Image.PreserveAspectFit

            }
            Text {
                id: startWindowExitText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 216
                height: 60
                text: "Выход"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: startWindowExitMouse.containsMouse ? fontSizeHover : fontSize
    //            font.bold: startWindowExitMouse.containsMouse ? true : false
                color: "#ffffff"
            }
        }

        //кнопка параметров тренировки
        Rectangle{
            id: parametersTraining
            y: 311
            width: 480
            height: 156
            anchors.left: parent.left
            anchors.leftMargin: 153
            color: "transparent"

            MouseArea{
                id: parametersTrainingMouse
                anchors.fill: parent

                hoverEnabled: true

                onClicked: {
                    trainingParameters.signalTrainingParametersExit()
                }
            }

            Image {

                height: parent.height
                width: parent.width
                //          fillMode: Image.PreserveAspectCrop
                source: "qrc:/pictures/Parametry.tif"
            }

            Text {
                id: parameterstrainingText
                x: 28
                y: 8
                width: 319
                height: 140
                text: qsTr("Параметры\nтренировки")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                //                fontSize
                font.pointSize: parametersTrainingMouse.containsMouse ? fontSizeHover : fontSize
                font.family: "Calibri"
                font.bold: parametersTrainingMouse.containsMouse ? true : false
                color: "white"
            }
        }

        //кнопка загрузки записи тренировки
        Rectangle {
            id: downloadTraining
            x: 176
            y: 469
            width: 480
            height: 156
            color: "transparent"

            MouseArea{
                id: downloadTrainingMouse
                anchors.fill: parent

                hoverEnabled: true

                onClicked: {
                    fileDialog.open();
                }
            }

            Image {
                height: parent.height
                width: parent.width
                //          fillMode: Image.PreserveAspectCrop
                source: "qrc:/pictures/Zagruzit_trenyu.tif"


            }

            Text {
                x: 18
                y: 6
                width: 304
                height: 131
                text: qsTr("Загрузить\nтренировку")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: downloadTrainingMouse.containsMouse ? fontSizeHover : fontSize
                font.bold: downloadTrainingMouse.containsMouse ? true : false
                font.family: "Calibri"
                color: "white"
            }
        }

        //кнопка начала тренировки
        Rectangle {
            id: beginingTraining
            x: 610
            y: 180
            width: 480
            height: 156
            enabled: false
            color: "transparent"

            MouseArea{
                id: beginingTrainingMouse
                anchors.fill: parent

                hoverEnabled: true

                onClicked: {
    //                trainingWindow.xR
                    trainingWindow.signalViewwewExit()
                    mainClass.dropDurationTraining()
                    mainClass.setIsCalcXRow(true)

    //                startWindow.signalExit()
                }
            }

            Image {
                id: beginingTrainingImg
                x: 2
                y: -1
                height: parent.height
                width: parent.width
                //          fillMode: Image.PreserveAspectCrop
                source: "qrc:/pictures/Trenirovka_ne_aktiv.tif"
            }

            Text {
                id: beginingTrainingText
                x: 21
                y: 12
                width: 320
                height: 126
                text: qsTr("Начать\nтренировку")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: beginingTrainingMouse.containsMouse ? fontSizeHover : fontSize
                font.bold: beginingTrainingMouse.containsMouse ? true : false
                font.family: "Calibri"
                color: "#7f7f7f"
            }
        }

        //кнопка поиска мишеней
        Rectangle  {
            id: foundingTargets
            x: 662
            y: 443
            width: 480
            height: 156
            anchors.left: downloadTraining.right
            anchors.top: beginingTraining.bottom
            anchors.topMargin: 2
            anchors.leftMargin: -19
            color: "transparent"

            MouseArea{
                id: foundingTargetsMouse
                anchors.fill: parent

                hoverEnabled: true

                onClicked: {
                    foundTargets()
                }
            }

            //        enabled: false

            //        display: AbstractButton.TextBesideIcon

            Image {
                x: -1
                y: 0
                height: parent.height
                width: parent.width
                //          fillMode: Image.PreserveAspectCrop
                source: "qrc:/pictures/Poisk_misheney.tif"
            }

            Text {
                id: foundingTargetsText
                x: 138
                y: 16
                width: 205
                height: 125
                text: "Поиск\nмишеней"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: foundingTargetsMouse.containsMouse ? fontSizeHover : fontSize
                font.bold: foundingTargetsMouse.containsMouse ? true : false
                font.family: "Calibri"
                color: "white"
            }

            Text {
                id: countTargetsText
                x: 38
                y: 47
                width: 47
                height: 61
                text: "н/д"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: fontSize
                font.family: "Calibri"
                color: "white"
            }
        }
    }

    //toolBar стартового окна
    Rectangle {
        id: startWindowTime
        anchors.top: parent.top
        //        x: 0
        //        y: 0
        width: parent.width
        height: 70
        color: "#404040"
        border.color: "#404040"
        border.width: 0

        Rectangle
        {
            id: startWindowTimeHourAndMinuts
            anchors.right: parent.right
            anchors.top: parent.top
            width: 180//parent.width
            height: parent.height / 2
            color: "transparent"
            Text {
                id: startWindowHourAndMinutsText
                anchors.horizontalCenter: startWindowTimeHourAndMinuts.horizontalCenter
                anchors.verticalCenter: startWindowTimeHourAndMinuts.verticalCenter
                width: 180
                height: 35
                text: ""
                font.pixelSize: 22
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                font.family: "Calibri"
                color: "#ffffff"
            }
        }

        property var textTimeq: mainClass.getTime()

        Rectangle{
            id: startWindowDate
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width: 180//parent.width
            height: parent.height / 2
            color: "transparent"

            Text {
                id: startWindowDateText
                anchors.verticalCenter: startWindowDate.verticalCenter
                anchors.horizontalCenter: startWindowDate.horizontalCenter
                width: 180
                height: 35
//                text: startWindowTime.textTimeq
                font.pixelSize: 22
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignTop
                font.family: "Calibri"
                color: "#ffffff"
            }
        }

//        Rectangle {
//            id: startWindowHelp
//            x: 0
//            y: 0
//            width: 86
//            height: 70
//            color: startWindowHelpMouse.containsMouse ? "#323232" : "transparent"

//            MouseArea{
//                id: startWindowHelpMouse
//                anchors.fill: parent

//                hoverEnabled: true

//                onClicked: {

//                }
//            }

//            Text{
//                id: startWindowHelpText
//                color: "#ffffff"
//                anchors.fill: parent
//                horizontalAlignment: Text.AlignHCenter
//                verticalAlignment: Text.AlignVCenter
//                font.bold: startWindowHelpMouse.containsMouse ? false : true
//                font.pointSize: startWindowHelpMouse.containsMouse ? fontSizeHover : fontSize
//                font.family: startWindowHelpMouse.containsMouse ? "Arial Unicode MS" : "Tahoma"
//                text: startWindowHelpMouse.containsMouse ? "X" : "?"
//            }
//        }

        Rectangle {
            id: startWindowSettings
//            x: 110
//            y: 0
//            width: 86
//            height: 70
            x: 0
            y: 0
            width: 86
            height: 70
            color: startWindowSettingsMouse.containsMouse ? "#323232" : "transparent"

            Rectangle {
                id: startWindowSettingsRect
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: startWindowSettingsMouse.containsMouse ? 55 : 50
                height: startWindowSettingsMouse.containsMouse ? 50 : 45
                color: "transparent"

                Image {
                    id: startWindowSettingsImg
                    x: 0
                    y: 0
                    width: parent.width
                    height: parent.width
                    source: startWindowSettingsMouse.containsMouse ? "qrc:/pictures/Nastroiki.tif" : "qrc:/pictures/Big_Nastroiki.tif"
                    //                    fillMode: Image.PreserveAspectFit
                }
            }

            MouseArea{
                id: startWindowSettingsMouse
                anchors.fill: parent

                hoverEnabled: true

                onClicked: {
                    settingsWindow.signalSettingsExit()
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

        Rectangle {
            id: startWindowStick
            x: 85
            y: 0
            width: 25
            height: 70
            color: "transparent"

            Rectangle {
                x: 12
                y: 12
                width: 1
                height: 50
                color: "#ffffff"
            }
        }


    }




    InfoMessage{
        id: infoMessage
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
