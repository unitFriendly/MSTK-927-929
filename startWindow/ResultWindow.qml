import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

import "../"

ApplicationWindow {
    id: resultWindow
    width: 1280
    height: 800
    //    visible: true
    title: "МСТК-927/929"
    color: "#626262"

    //    flags: Qt.FramelessWindowHint

    signal signalExitResultWindow

    property int scaleTimeText: 30
    property var speedTimeText: 1.0

    property var imageRecord: "qrc:/Rezultaty/Play.tif"

    property bool flagPlayPause: true

    property int fontSize: 20

    property int paddingInfoText: 40

    function getDateFromC()
    {
        resultWindowDateText.text = mainClass.getDate()
    }

    function getTimeFromC()
    {
        resultWindowHourAndMinutsText.text = mainClass.getTime()
    }

    Component.onCompleted: {
        mainClass.onGetTime.connect(getTimeFromC)
        mainClass.onGetDate.connect(getDateFromC)
    }

    function decryptionZone(zone)
    {
        switch (zone)
        {
        case 0:
            return "-"

        case 1:
            return "Ц"

        case 2:
            return "Ф"

        case 3:
            return "ФЛ"

        case 4:
            return "ФП"

        case 5:
            return "ЛБ"

        case 6:
            return "ПБ"

        case 7:
            return "СЛФ"

        case 8:
            return "СЛТ"

        case 9:
            return "СПФ"

        case 10:
            return "СПТ"

        case 11:
            return "Т"

        case 12:
            return "ТЛ"

        case 13:
            return "ТП"      
        }
    }

    function calcDurationTrainingfromRecord()
    {
        textTimeRecordTraining.text = mainClass.getDurationTrainingStr()

        if(mainClass.st_getDurationTrainingMsec() < mainClass.getDurationTrainingMSec())
        {
            imgRecord.source = flagPlayPause ? "qrc:/Rezultaty/Pause.tif" : "qrc:/Rezultaty/Play.tif"
            mainClass.setIsCalcXRow(flagPlayPause)
            flagPlayPause = !flagPlayPause
        }
    }

    function loadDataFromFile(path)
    {
        imgRecord.source = "qrc:/Rezultaty/Play.tif"
        mainClass.setIsCalcXRow(false)
        flagPlayPause = true
        mainClass.dropDurationTraining()

        mainClass.st_loadSaveTraining(path);

        repWidgetShooting.model = mainClass.st_getCountTargets() + 1

        for(var i = 0; i < mainClass.st_getCountTargets() + 1; i++)
        {
            repWidgetShooting.itemAt(i).xRow = 0.0;
            repWidgetShooting.itemAt(i).clearChild()
        }

        mainClass.onCalcXRow.connect(calcDurationTrainingfromRecord)

        mainClass.onNewHitCopterFromRecord.connect(handlerNewHitFromRecoed)
        mainClass.st_loadAllHits()
        mainClass.onNewHitCopterFromRecord.disconnect(handlerNewHitFromRecoed)

        textDateTimeTraining.text = "Тренировка: " + mainClass.st_getDateTraining() + " - " + mainClass.st_getTimeTraining() + ""
        textPercentageHitsZone.text = mainClass.st_getPercentageHitsZone() + "%"
        textTimeFirstHit.text = mainClass.st_getTimeFirstHit()
        textCountHit.text = mainClass.st_getCountHit()
        textZoneOutmatchHit.text = decryptionZone(mainClass.st_getZoneOutmatchHit() + 1)

        if(mainClass.st_getTargetOutmatchHit() == -1)
        {
            textTargetOutmatchHit.text = "-"
        }
        else
        {
            textTargetOutmatchHit.text = mainClass.st_getTargetOutmatchHit() + 1
        }

        if(mainClass.st_getTargetLessHit() == -1)
        {
            textTargetLessHit.text = "-"
        }
        else
        {
            textTargetLessHit.text = mainClass.st_getTargetLessHit() + 1
        }

        textCountTargets.text = mainClass.st_getCountTargets()
        textHeightFlightTarget.text = mainClass.st_getHeightFlightTarget() + " м"
        textDistanceToTargets.text = mainClass.st_getDistanceToTargets() + " м"
        textCountShot.text = mainClass.st_getCountShot()
        textDurationTraining.text = "Длительность: " + mainClass.st_getDurationTraining()
//        console.log("~~~~~~~~~~~work~~~~~~~~~~~")
    }

    function handlerNewHitFromRecoed(target, zone, time)
    {
        repWidgetShooting.itemAt(0).handlerNewHitFromRecord(target, -1, time);
        repWidgetShooting.itemAt(target + 1).handlerNewHitFromRecord(-1, zone, time);
//        repWidgetShooting.itemAt(target + 1).handlerNewHitFromRecord(target, zone, time);
//        repWidgetShooting.children[target].handlerNewHitFromRecord(target, zone, time);
//        repWidgetShooting.children[target].handlerNewHitFromRecord(target, -1, time);
    }

//    Component.onCompleted: {
//        console.log("resultWindow")
//    }

    GridLayout{
        id: grid
        anchors.fill: parent
        //        anchors.verticalCenter: parent.verticalCenter
        //        anchors.horizontalCenter: parent.horizontalCenter
        // columnSpacing: 15
        columns: 16
        rows: 22

        component GridRectangle : Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: Layout.columnSpan
            Layout.preferredHeight: Layout.rowSpan
            color: "#626262"
            border.color: Qt.darker(color)
            border.width: 0
            //Layout.margins: 20
        }

        //toolbar(доделать)
        GridRectangle {
            id: toolBarResult
            Layout.column: 1
            Layout.row: 0
            Layout.columnSpan: 15
            Layout.rowSpan: 2

            color: "#404040"
//            color: "red"
            anchors.right: parent.right
            anchors.top: parent.top

            //toolBar стартового окна
            Rectangle {
                id: startWindowTime
                anchors.top: parent.top
                x: 0
                y: 0
                width: parent.width
                height: 70
                color: "#404040"
                border.color: "#404040"
                border.width: 0

                Rectangle
                {
                    id: resultWindowTimeHourAndMinuts
                    anchors.right: parent.right
                    anchors.top: parent.top
                    width: 180
                    height: parent.height / 2
                    color: "transparent"
                    Text {
                        id: resultWindowHourAndMinutsText
                        anchors.horizontalCenter: resultWindowTimeHourAndMinuts.horizontalCenter
                        anchors.verticalCenter: resultWindowTimeHourAndMinuts.verticalCenter
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

                Rectangle{
                    id: resultWindowDate
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    width: 180
                    height: parent.height / 2
                    color: "transparent"

                    Text {
                        id: resultWindowDateText
                        anchors.verticalCenter: resultWindowDate.verticalCenter
                        anchors.horizontalCenter: resultWindowDate.horizontalCenter
                        width: 180
                        height: 35
                        font.pixelSize: 22
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignTop
                        font.family: "Calibri"
                        color: "#ffffff"
                        text: ""
                    }
                }

                //кнопка пасхалка
                Rectangle {
                    id: cyberMandarin
                    x: 413
                    y: 0
                    width: 70
                    height: 70
                    color: "transparent"

                    Image {
                        id: cyberMandarinImg
                        width: 70
                        height: 70
                        source: "qrc:/pictures/Logo3.tif"
                    }
                }

                Rectangle {
                    id: cyberMandarinName
                    x: 500
                    y: 0
                    width: 338
                    height: 70
                    color: "transparent"

                    Image {
                        id: image
                        x: 0
                        y: 15
                        width: 257
                        height: 40
                        source: "qrc:/pictures/Cyber.tif"
                    }
                }

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
                                resultWindow.hide()
                                mainClass.onCalcXRow.disconnect(calcDurationTrainingfromRecord)
                                startWindow.show()
                            }
                        }

                        Text {
                            id: textEndTraining
                            anchors.fill: parent
                            text: qsTr("Выход")
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: mouseEndTraining.containsMouse ? 22 : 20
                            font.family: "Calibri"
                            font.bold: mouseEndTraining.containsMouse ? true : false
                            color: "white"
                        }
                    }
                }
            }
        }

        //button exit
        GridRectangle {
            id: buttonExit
            Layout.column: 1
            Layout.row: 2
            Layout.columnSpan: 2
            Layout.rowSpan: 2
            //            Layout.padding: 1
            Layout.leftMargin: 20
            color: "transparent"

//            MouseArea{
//                id: startWindowExitMouse
//                anchors.fill: parent

//                hoverEnabled: true

//                onClicked: {
//                    resultWindow.hide()
//                    startWindow.show()

////                    mainClass.onNewHitCopterFromRecord.connect(handlerNewHitFromRecoed)
////                    mainClass.getSaveTrainingFromPath("");
////                    mainClass.onNewHitCopterFromRecord.disconnect(handlerNewHitFromRecoed)
//                }
//            }

//            Image {
//                id: startWindowExitImg
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter
//                width: parent.width - 50
//                height: parent.height - 15
//                source: "qrc:/pictures/Vyhod.tif"
//                //            fillMode: Image.PreserveAspectFit

//            }
//            Text {
//                id: startWindowExitText
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter
//                text: "Выйти"
//                horizontalAlignment: Text.AlignHCenter
//                verticalAlignment: Text.AlignVCenter
//                font.pixelSize: 20/*startWindowExitMouse.containsMouse ? fontSizeHover : fontSize*/
//                color: "#ffffff"
//            }
        }

        //label date and time training
        GridRectangle{
            id: labelDateTimeTraining
            Layout.column: 7
            Layout.row: 2
            Layout.columnSpan: 5
            Layout.rowSpan: 2
            z: -1

            Text {
                id: textDateTimeTraining
                text: "Тренировка " + mainClass.st_getDateTraining() + " (" + mainClass.st_getTimeTraining() + ")"
                wrapMode: Text.WrapAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#ffffff"
                font.pixelSize: 20
            }
        }

        // duration Training
        GridRectangle{
            id: durationTraining
            Layout.column: 13
            Layout.row: 2
            Layout.columnSpan: 3
            Layout.rowSpan: 2
            Layout.rightMargin: 20
            z: -1

            Text {
                id: textDurationTraining
                text: "Длительность: "
                wrapMode: Text.WrapAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#ffffff"
                font.pixelSize: 20
            }
        }

        //обобщенные результаты тренировки
        GridRectangle{
            id: generalInfoResult
            Layout.column: 1
            Layout.row: 4
            Layout.columnSpan: 15
            Layout.rowSpan: 9
            Layout.rightMargin: 20
            Layout.leftMargin: 20

            Image {
                anchors.fill: parent
                source: "qrc:/Rezultaty/WindowFullInfo.tif"
            }

            GridLayout{
                id: gridGeneralInfo
                anchors.fill: parent
                columns: 8
                rows: 7

                component GridLabel: Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: Layout.columnSpan
                    Layout.preferredHeight: Layout.rowSpan
                    color: "#00000000"
                    border.width: 0
                    border.color: "white"
                    //Layout.margins: 20
                }


                //1
                GridLabel{
                    Layout.column: 0
                    Layout.row: 0
                    Layout.columnSpan: 4
                    Layout.rowSpan: 1

                    Text {
                        anchors.centerIn: parent
                        text: "ОБОБЩЕННАЯ ИНФОРМАЦИЯ"
                        font.pixelSize: fontSize
                        font.underline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 0
                    Layout.row: 1
                    Layout.columnSpan: 3
                    Layout.rowSpan: 1

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: resultWindow.paddingInfoText
                        text: "Процент поражения мишеней"
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 0
                    Layout.row: 2
                    Layout.columnSpan: 3
                    Layout.rowSpan: 1

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: resultWindow.paddingInfoText
                        text: "Время первого попадания"
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 0
                    Layout.row: 3
                    Layout.columnSpan: 3
                    Layout.rowSpan: 1

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: resultWindow.paddingInfoText
                        text: "Количество попаданий"
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 0
                    Layout.row: 4
                    Layout.columnSpan: 3
                    Layout.rowSpan: 1

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: resultWindow.paddingInfoText
                        text: "Зона наибольшей плотности попаданий"
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 0
                    Layout.row: 5
                    Layout.columnSpan: 3
                    Layout.rowSpan: 1

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: resultWindow.paddingInfoText
                        text: "Самая поразительная мишень"
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 0
                    Layout.row: 6
                    Layout.columnSpan: 3
                    Layout.rowSpan: 1

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: resultWindow.paddingInfoText
                        text: "Самая невзрачная мишень"
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }

                //2
                GridLabel{
                    Layout.column: 3
                    Layout.row: 1
                    Layout.columnSpan: 1
                    Layout.rowSpan: 1

                    Text {
                        id: textPercentageHitsZone
                        anchors.left: parent.left
                        text: ""
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 3
                    Layout.row: 2
                    Layout.columnSpan: 1
                    Layout.rowSpan: 1

                    Text {
                        id: textTimeFirstHit
                        anchors.left: parent.left
                        text: ""
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 3
                    Layout.row: 3
                    Layout.columnSpan: 1
                    Layout.rowSpan: 1

                    Text {
                        id: textCountHit
                        anchors.left: parent.left
                        text: ""
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 3
                    Layout.row: 4
                    Layout.columnSpan: 1
                    Layout.rowSpan: 1

                    Text {
                        id: textZoneOutmatchHit
                        anchors.left: parent.left
                        text: "ФП"
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 3
                    Layout.row: 5
                    Layout.columnSpan: 1
                    Layout.rowSpan: 1

                    Text {
                        id: textTargetOutmatchHit
                        anchors.left: parent.left
                        text: ""
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 3
                    Layout.row: 6
                    Layout.columnSpan: 1
                    Layout.rowSpan: 1

                    Text {
                        id: textTargetLessHit
                        anchors.left: parent.left
                        text: ""
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }

                //3
                GridLabel{
                    Layout.column: 4
                    Layout.row: 0
                    Layout.columnSpan: 4
                    Layout.rowSpan: 1

                    Text {
                        anchors.centerIn: parent
                        text: "ПАРАМЕТРЫ ТРЕНИРОВКИ"
                        font.pixelSize: fontSize
                        font.underline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                //                GridLabel{
                //                    Layout.column: 4
                //                    Layout.row: 1
                //                    Layout.columnSpan: 3
                //                    Layout.rowSpan: 1

                //                    Text {
                //                        anchors.centerIn: parent
                //                        text: "Самая невзрачная мишень"
                //                        font.pixelSize: fontSize
                //                        //                        font.overline: true
                //                        verticalAlignment: Text.AlignVCenter
                //                        horizontalAlignment: Text.AlignHCenter
                //                        color: "white"
                //                    }
                //                }
                GridLabel{
                    Layout.column: 4
                    Layout.row: 2
                    Layout.columnSpan: 3
                    Layout.rowSpan: 1

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: resultWindow.paddingInfoText
                        text: "Количество мишеней"
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 4
                    Layout.row: 3
                    Layout.columnSpan: 3
                    Layout.rowSpan: 1

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: resultWindow.paddingInfoText
                        text: "Высота полета мишеней"
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 4
                    Layout.row: 4
                    Layout.columnSpan: 3
                    Layout.rowSpan: 1

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: resultWindow.paddingInfoText
                        text: "Дальность до мишеней от рубежа"
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 4
                    Layout.row: 5
                    Layout.columnSpan: 3
                    Layout.rowSpan: 1

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: resultWindow.paddingInfoText
                        text: "Количество стрелков"
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                //                GridLabel{
                //                    Layout.column: 4
                //                    Layout.row: 6
                //                    Layout.columnSpan: 3
                //                    Layout.rowSpan: 1

                //                    Text {
                //                        anchors.centerIn: parent
                //                        text: "Самая невзрачная мишень"
                //                        font.pixelSize: fontSize
                //                        //                        font.overline: true
                //                        verticalAlignment: Text.AlignVCenter
                //                        horizontalAlignment: Text.AlignHCenter
                //                        color: "white"
                //                    }
                //                }


                //4~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                //                GridLabel{
                //                    Layout.column: 7
                //                    Layout.row: 1
                //                    Layout.columnSpan: 1
                //                    Layout.rowSpan: 1

                //                    Text {
                //                        anchors.centerIn: parent
                //                        text: "Самая невзрачная мишень"
                //                        font.pixelSize: fontSize
                //                        //                        font.overline: true
                //                        verticalAlignment: Text.AlignVCenter
                //                        horizontalAlignment: Text.AlignHCenter
                //                        color: "white"
                //                    }
                //                }
                GridLabel{
                    Layout.column: 7
                    Layout.row: 2
                    Layout.columnSpan: 1
                    Layout.rowSpan: 1

                    Text {
                        id: textCountTargets
                        anchors.left: parent.left
                        text: ""
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 7
                    Layout.row: 3
                    Layout.columnSpan: 1
                    Layout.rowSpan: 1

                    Text {
                        id: textHeightFlightTarget
                        anchors.left: parent.left
                        text: ""
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 7
                    Layout.row: 4
                    Layout.columnSpan: 1
                    Layout.rowSpan: 1

                    Text {
                        id: textDistanceToTargets
                        anchors.left: parent.left
                        text: ""
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                GridLabel{
                    Layout.column: 7
                    Layout.row: 5
                    Layout.columnSpan: 1
                    Layout.rowSpan: 1

                    Text {
                        id: textCountShot
                        anchors.left: parent.left
                        text: ""
                        font.pixelSize: fontSize
                        //                        font.overline: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }
                //                GridLabel{
                //                    Layout.column: 7
                //                    Layout.row: 6
                //                    Layout.columnSpan: 1
                //                    Layout.rowSpan: 1

                //                    Text {
                //                        anchors.centerIn: parent
                //                        text: "Самая невзрачная мишень"
                //                        font.pixelSize: fontSize
                //                        //                        font.overline: true
                //                        verticalAlignment: Text.AlignVCenter
                //                        horizontalAlignment: Text.AlignHCenter
                //                        color: "white"
                //                    }
                //                }
            }
        }

        //изменение масштаба и скорости воспроизведения
        GridRectangle{
            id: scaleAndSpeed
            Layout.column: 1
            Layout.row: 13
            Layout.columnSpan: 15
            Layout.rowSpan: 2
            Layout.rightMargin: 20
            Layout.leftMargin: 20

            GridLayout{
                id: gridScaleAndSpeed

                anchors.fill: parent
                columns: 6
                rows: 4

                component GridScale: Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: Layout.columnSpan
                    Layout.preferredHeight: Layout.rowSpan
                    color: "#626262"
                    border.color: Qt.darker(color)
                    border.width: 0
                    //Layout.margins: 20
                }


                GridScale {
                    id: scaleLabel
                    Layout.column: 0
                    Layout.row: 0
                    Layout.columnSpan: 1
                    Layout.rowSpan: 2

                    Text {
                        text: "Масштаб времени"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: fontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }

                GridScale {
                    id: scaleSlider
                    Layout.column: 0
                    Layout.row: 2
                    Layout.columnSpan: 1
                    Layout.rowSpan: 2

                    Slider{
                        id: slider
                        anchors.fill: parent
                        orientation: Qt.Horizontal
                        value: 30
                        from: 30
                        to: 120
                        stepSize: 15
                        //                        scale: 0.8

                        handle: Rectangle {
                            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                            y: slider.topPadding + slider.availableHeight / 2 - height / 2
                            implicitWidth: 16
                            implicitHeight: 16
                            radius: 8
                            color: slider.pressed ? "#f0f0f0" : "#f6f6f6"
                            border.color: "#bdbebf"
                        }

                        onValueChanged: {                            
                            for(var i = 0; i < repWidgetShooting.count; i++)
                            {
                                repWidgetShooting.itemAt(i).currentScaleTime = value
                            }
                            scaleTimeText = value
                        }
                    }
                }

                GridScale {
                    id: scaleTimeSlider
                    Layout.column: 1
                    Layout.row: 2
                    Layout.columnSpan: 1
                    Layout.rowSpan: 2

                    Text {
                        id: textScaleTimeSlider
                        anchors.verticalCenter: parent.verticalCenter
                        text: scaleTimeText + " c"
                        font.pixelSize: fontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }

                GridScale {
                    id: timeRecordTraining
                    Layout.column: 2
                    Layout.row: 1
                    Layout.columnSpan: 2
                    Layout.rowSpan: 2

                    Text {
                        id: textTimeRecordTraining
                        anchors.centerIn: parent
                        text: "00:00"
                        font.pixelSize: fontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                    }
                }

                GridScale {
                    id: speedSliderText
                    Layout.column: 4
                    Layout.row: 0
                    Layout.columnSpan: 2
                    Layout.rowSpan: 2

                    Text {

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        text: speedTimeText
                        font.pixelSize: fontSize
                        color: "white"
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        width: 30
                        clip: true
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        text: "Скорость воспроизведения: "
                        font.pixelSize: fontSize
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        color: "white"
                        width: 315
                        clip: true

                    }

                }
                GridScale {
                    id: speedSlider
                    Layout.column: 5
                    Layout.row: 2
                    Layout.columnSpan: 1
                    Layout.rowSpan: 2

                    Slider{
                        id: controlsSpeedSlider
                        anchors.fill: parent
                        orientation: Qt.Horizontal
                        value: 1
                        from: 0.5
                        to: 4
                        stepSize: 0.5
                        //                        scale: 0.8

                        handle: Rectangle {
                            x: controlsSpeedSlider.leftPadding + controlsSpeedSlider.visualPosition * (controlsSpeedSlider.availableWidth - width)
                            y: controlsSpeedSlider.topPadding + controlsSpeedSlider.availableHeight / 2 - height / 2
                            implicitWidth: 16
                            implicitHeight: 16
                            radius: 8
                            color: controlsSpeedSlider.pressed ? "#f0f0f0" : "#f6f6f6"
                            border.color: "#bdbebf"
                        }

                        onValueChanged: {
                            speedTimeText = value
                            mainClass.setCffSpeedPlay(value)
                            //                            widgetShootingTargetAll.currentScaleTime = value
                            //                            widgetShooting.currentScaleTime = value
                        }
                    }
                }

                GridScale {
                    id: buttonStartRecord
                    Layout.column: 4
                    Layout.row: 2
                    Layout.columnSpan: 1
                    Layout.rowSpan: 2

                    Image {
                        id: imgRecord
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        source: "qrc:/Rezultaty/Play.tif"
                        MouseArea{
                            anchors.fill: parent

                            onClicked: {
                                imgRecord.source = flagPlayPause ? "qrc:/Rezultaty/Pause.tif" : "qrc:/Rezultaty/Play.tif"
                                mainClass.setIsCalcXRow(flagPlayPause)
                                flagPlayPause = !flagPlayPause


//                                if(mainClass.getIsCalcXRow())
//                                {
//                                    mainClass.setIsCalcXRow(false)
//                                }
//                                else
//                                {
//                                    mainClass.setIsCalcXRow(true)
//                                }

                                //                                print(flagPlayPause)
                            }
                        }
                    }
                }
            }
        }

//        property type name: value
        function nameTargets(index)
        {

        }

        //Список мишеней с общим timeLine
        GridRectangle{
            id: targetsAndGeneralTimeLine
            Layout.column: 1
            Layout.row: 15
            Layout.columnSpan: 15
            Layout.rowSpan: 6
            Layout.rightMargin: 20
            Layout.leftMargin: 20
            Layout.bottomMargin: 5

            ScrollView{
                id: scrollTargets
                anchors.fill: parent
                height: parent.height
                width: parent.width
                contentWidth: parent.width
                contentHeight: 8 * (10 + widgetShooting.height)
                clip: true

                Column{
//                    anchors.verticalCenter: parent.verticalCenter
                    anchors.fill: parent
//                    anchors.left: parent.left
                    spacing: 10
                    Repeater{
                        id: repWidgetShooting
                        anchors.fill: parent
                        model: 4/*mainClass.getCountTargets()*/

                        WidgetShooting{
                            id: widgetShooting
//                            width: parent.width
                            anchors.horizontalCenter: parent.horizontalCenter


                            Component.onCompleted: {
                                if(index == 0)
                                {
                                    widgetShooting.setNameWidget("Общий");
                                    widgetShooting.currentTargetActiv = -1
                                }
                                else
                                {
                                    widgetShooting.setNameWidget("Мишень " + index);
                                    widgetShooting.currentTargetActiv = index
                                }



                                console.log("widgetShooting.setNameWidget(Мишень " + "index);");
                            }
                        }
                    }
                }           
            }
        }
    }
}
