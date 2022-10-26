import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3

Rectangle {
    id: window
    width: 1180
    height: heightCustom
    border.width: 1
    border.color: "white"

    color: "transparent"

    Component.onCompleted: {
        mainClass.onCalcXRow.connect(calcXRow)
//        mainClass.setIsCalcXRow(true)

        rectGreenCreator = Qt.createComponent("RectGreen.qml")
    }

    property real currentScaleTime: 30

    signal onChangeTarget(var target)

    signal onChangeScaleTime(var target)

    property var currentTargetActiv: -1

    property var rectGreenCreator

    property int heightCustom: 40

    onCurrentScaleTimeChanged: {
        onChangeScaleTime(currentScaleTime)
        calcXRow()
    }

    function clearChild()
    {
        for (var i = 1; i < row.children.length; i++)
        {
            row.children[i].destroy()
        }
    }

    function createNewRectGreenOnTime(target, textInRect, posX, time)
    {
//        console.log("x = ", time)

        var Rect = rectGreenCreator.createObject(row,
                                        {
                                            x: posX,
                                            textInRect: textInRect,
                                            currentScaleTime: currentScaleTime,
                                            dfltHeight: heightCustom,
                                            attribute: target,
                                            timeCreated: time,
                                            widthParent: scroll.width,
                                            visible: ((target == currentTargetActiv) || (target == -1)) ? true : false
                                        });

        onChangeScaleTime.connect(Rect.changeScaleTime)
        onChangeTarget.connect(Rect.changeActivTarget)
    }

    function createNewRectGreen(target, textInRect)
    {
        createNewRectGreenOnTime(target, textInRect, window.xRow, mainClass.getDurationTrainingMSec());
    }

    function loadAllHits()
    {
//        testTTTT = mainClass.psdc

//        console.log(testTTTT[0][0].second());

//        var arr = mainClass.getSaveTrainingFromPath("");

//        for(var i = 0; i < arr.length; i++)
//        {
//            console.log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + i);
//            console.log(arr[i].toString());
//            console.log("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + i);
//        }
    }

    function decryptionZone(zone)
    {
        switch (zone)
        {

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

    function handlerNewHitFromRecord(target, zone, time)
    {
        if(zone == -1)
        {
            //рисуем новый квадрат
            //текст внутри квадрата это номер таргета
            //не указывать принадлежность квадрата к мишени

            createNewRectGreenOnTime(-1, target + 1, calcXRowFromTime(time), time)
        }
        else
        {
            //рисуем новый квадрат
            //текст внутри зона попадания
            //указывать принадлежность квадрата к мишени

            createNewRectGreenOnTime(target, decryptionZone(zone + 1), calcXRowFromTime(time), time)
        }
    }

    function handlerNewHit(target, zone)
    {
        if(zone == -1)
        {
            //рисуем новый квадрат
            //текст внутри квадрата это номер таргета
            //не указывать принадлежность квадрата к мишени

            createNewRectGreen(-1, target + 1)
        }
        else
        {
            //рисуем новый квадрат
            //текст внутри зона попадания
            //указывать принадлежность квадрата к мишени

            createNewRectGreen(target, decryptionZone(zone))
        }
    }

    function setNameWidget(name)
    {
        nameWidget.text = name
    }

    function getNameWidget(name)
    {
        return nameWidget.text
    }

    // смещение по скролл вию
    function calcXRow()
    {
        window.xRow  = ((scroll.width / currentScaleTime) / (1000 / mainClass.getTIMER_INTERVAL())) * (mainClass.getDurationTrainingMSec() / mainClass.getTIMER_INTERVAL())
    }

    function calcXRowFromTime(time)
    {
        return ((scroll.width / currentScaleTime) / (1000 / mainClass.getTIMER_INTERVAL())) * (time / mainClass.getTIMER_INTERVAL())
    }

    property real xRow: 0.0

    Row {
        id: rowWidget
        anchors.fill: parent
        spacing: 3

        Rectangle {
            width: 150
            height: heightCustom
            color: "#92da18"

            Text {
                id: nameWidget
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 22
                font.family: "Calibri"
                color: "#000000"
            }
        }

        Rectangle {
            id: windowRect
            x: 150
            height: heightCustom
            width: 1027
            color: "transparent"

            ScrollView {
                id: scroll
                anchors.fill: parent
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                height: heightCustom
                wheelEnabled: false
                hoverEnabled: true
                width: parent.width
                contentWidth: window.xRow
                contentHeight: row.height
                ScrollBar.horizontal.position: window.xRow
                clip: true

                Flickable {
                    interactive: false
                }

                Row{
                    id: row

                    Rectangle {
                        color: "white"
                        x: window.xRow
                        height: heightCustom
                        width: 1
                        radius: 1
//                        visible: false

//                        onXChanged: {
//                            if (x >= scroll.width - 5)
//                            {
//                                visible = false
//                            }
//                            else
//                            {
//                                visible = true
//                            }
//                        }
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}
}
##^##*/
