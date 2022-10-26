import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3
import Qt.labs.platform 1.1

ApplicationWindow{
    id: settingsWindow
    width: 640
    height: 480
    color: "#7f7f7f"
    title: "МСТК-927/929"
//    flags: Qt.ToolTip
    flags: Qt.FramelessWindowHint
    //    visible: false

    signal signalSettingsExit

    function connectButton()
    {
        if (comboBoxComPort.displayText != "")
        {
            mainClass.connectSerialPort(comboBoxComPort.displayText);
            buttonConnectSettings.enabled = false;
            buttonConnectSettings.opacity = 0.5;
            buttonDisconnectSettings.enabled = true;
            buttonDisconnectSettings.opacity = 1;
        }
        else
        {
            buttonConnectSettings.opacity = 0.5;
            buttonDisconnectSettings.opacity = 0.5;
        }
    }

    function disconnectButton()
    {
        if (comboBoxComPort.displayText != "")
        {
            mainClass.disconnectSerialPort();
            buttonConnectSettings.enabled = true;
            buttonConnectSettings.opacity = 1;
            buttonDisconnectSettings.enabled = false;
            buttonDisconnectSettings.opacity = 0.5;
        }
        else
        {
            buttonConnectSettings.opacity = 0.5;
            buttonDisconnectSettings.opacity = 0.5;
        }
    }

    function updateButton()
    {
        listComPort = []
        for (var i = 0; i < mainClass.getSizeArrayPortName(); i++)
        {
            listComPort.push(mainClass.getValueFromArrayPotname(i));
            //                    console.log(listComPort[i])
        }
        buttonConnectSettings.opacity = 1;
        buttonDisconnectSettings.opacity = 1;
        comboBoxComPort.model = listComPort
    }

    TextField {
        id: settingsWindowTextField
        x: 39
        y: 84
        width: 423
        height: 40

        anchors.verticalCenter: buttomFileSaveAs.verticalCenter
        anchors.right: buttomFileSaveAs.left
        anchors.top: buttomFileSaveAs.top
        anchors.bottom: buttomFileSaveAs.bottom
        font.pointSize: 14
        layer.enabled: false
        anchors.rightMargin: 6
//        placeholderText: qsTr("C:\\Users\\5 rota\\Desktop\\train")
        placeholderText: configMSTK.getDefaultPathTraining()
        color: "#ffffff"
        background: Rectangle{

            border.color: "white"

            color: "#595959"
        }
    }

    //кнопка "Сохранить как" или "Обзор"
    Rectangle {
        id: buttomFileSaveAs
        x: 468
        y: 84
        width: 123
        height: 40
        color: "transparent"

        Image {
            id: buttomFileSaveAsImg
            x: 0
            y: 0
            width: 123
            height: 40
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "qrc:/pictures/Nastoriki_knopka_primenit.tif"
            anchors.horizontalCenter: parent.horizontalCenter
            //                fillMode: Image.PreserveAspectFit
        }

        Text {
            id: buttomFileSaveAsText
            x: 0
            y: 0
            width: 123
            height: 40
            color: "#ffffff"
            text: "Обзор..."
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }

        MouseArea{
            id: buttomFileSaveAsMouse
            anchors.fill: parent

            hoverEnabled: true

            onClicked: {
                //                settingsWindow.close()
                //                startWindow.show()
                folderDialog.open()
            }
        }
    }

    Rectangle {
        id: settingsWindowLabelFileRect
        x: 0
        y: 0
        width: 278
        height: 33
        color: "transparent"
        anchors.left: settingsWindowTextField.left
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.topMargin: 50

        Text {
            id: settingsWindowLabelFile
            anchors.fill: parent
            width: 278
            height: 33
            text: qsTr("Путь сохранения тренировок")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pointSize: 16
            font.family: "Calibri"
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#ffffff"
        }
    }

//    Rectangle {
//        id: buttomApplyFilepath
//        x: 39
//        y: 130
//        width: 149
//        height: 40
//        color: "#00000000"
//        Image {
//            id: buttomApplyFilepathImg
//            x: 0
//            y: 0
//            width: 123
//            height: 40
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            source: "qrc:/pictures/Nastoriki_knopka_primenit.tif"
//            anchors.horizontalCenter: parent.horizontalCenter
//        }

//        Text {
//            id: buttomApplyFilepathText
//            x: 0
//            y: 0
//            width: 123
//            height: 40
//            color: "#ffffff"
//            text: "Применить"
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            horizontalAlignment: Text.AlignHCenter
//            verticalAlignment: Text.AlignVCenter
//            anchors.horizontalCenter: parent.horizontalCenter
//            font.pointSize: 16
//        }

//        MouseArea {
//            id: buttomApplyFilepathMouse
//            anchors.fill: parent
//            hoverEnabled: true
//        }
//    }

    Rectangle {
        id: settingsWindowTextLabel
        x: 39
        y: 237
        width: 513
        height: 64
        color: "#00000000"

        Rectangle {
            id: settingsWindowLabelTargetRect
            x: 0
            y: -39
            width: 278
            height: 33
            color: "#00000000"
            anchors.left: settingsWindowTextField.left
            anchors.top: parent.top
            Text {
                id: settingsWindowLabelTarget
                width: 278
                height: 33
                color: "#ffffff"
                text: qsTr("Настройки мишени:")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Calibri"
                font.pointSize: 16
            }
            anchors.leftMargin: 8
            anchors.topMargin: 0
        }

        Rectangle {
            id: settingsWindowLabelTargetReference
            x: 0
            y: -40
            width: 513
            height: 33
            color: "#00000000"
            anchors.top: parent.top
            Text {
                id: settingsWindowLabelReferenceText
                width: 278
                height: 33
                color: "#ffffff"
                text: qsTr("Отключите все мишени, кроме той, которую собираетесь настраивать!")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.fill: parent
                verticalAlignment: Text.AlignTop
                anchors.rightMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Calibri"
                font.pointSize: 10
            }
            anchors.topMargin: 31
            anchors.leftMargin: -406
        }
    }

    Row {
        id: settingsWindowRowCurrentAddress
        x: 39
        y: 307
        width: 552
        height: 33
        layoutDirection: Qt.LeftToRight
        spacing: 5

        Rectangle {
            id: settingsWindowRowCurrentAddressRect
            x: 0
            y: -39
            width: 140
            height: 33
            color: "#00000000"
            anchors.left: settingsWindowTextField.left
            anchors.top: parent.top
            Text {
                id: settingsWindowRowCurrentAddressText
                width: 278
                height: 33
                color: "#ffffff"
                text: qsTr("Текущий адрес:")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Calibri"
                font.pointSize: 16
            }
            anchors.topMargin: 0
            anchors.leftMargin: 8
        }

        Rectangle{
            width: 70
            height: 33
            color: "#00000000" // прозрачный

            TextField {
                id: textField
                x: 0
                y: 0
                width: 70
                height: 33
                font.pointSize: 14
                layer.enabled: false
                anchors.rightMargin: 6
                placeholderText: qsTr("11")
                color: "#ffffff"
                background: Rectangle{

                    border.color: "white"
                    color: "#595959"
                }
            }
        }

        Rectangle {
            id: buttomRequestTarget
            width: 149
            height: 33
            color: "#00000000"
            Image {
                id: buttomRequestTargetImg
                x: 0
                y: 0
                width: 123
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                source: "qrc:/pictures/Nastoriki_knopka_primenit.tif"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: buttomRequestTargetText
                x: 0
                y: 0
                width: 123
                height: 40
                color: "#ffffff"
                text: "Запросить"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 16
            }

            MouseArea {
                id: buttomRequestTargetMouse
                anchors.fill: parent
                hoverEnabled: true
            }
        }
    }

    Row {
        id: settingsWindowRowCurrentAddress1
        x: 39
        y: 354
        width: 552
        height: 33
        layoutDirection: Qt.LeftToRight
        Rectangle {
            id: settingsWindowRowCurrentAddressRect1
            x: 0
            y: -39
            width: 140
            height: 33
            color: "#00000000"
            anchors.left: settingsWindowTextField.left
            anchors.top: parent.top
            Text {
                id: settingsWindowRowCurrentAddressText1
                width: 278
                height: 33
                color: "#ffffff"
                text: qsTr("Замена адреса:")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Calibri"
                anchors.rightMargin: 0
                font.pointSize: 16
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
            }
            anchors.leftMargin: 8
            anchors.topMargin: 0
        }

        Rectangle {
            width: 70
            height: 33
            color: "#00000000"
            TextField {
                id: textField1
                x: 0
                y: 0
                width: 70
                height: 33
                color: "#ffffff"
                placeholderText: qsTr("11")
                anchors.rightMargin: 6
                font.pointSize: 14
                background: Rectangle {
                    color: "#595959"
                    border.color: "#ffffff"
                }
                layer.enabled: false
            }
        }

        Rectangle {
            id: buttomChangeTargetAddress
            width: 149
            height: 33
            color: "#00000000"
            Image {
                id: buttomChangeTargetAddressImg
                x: 0
                y: 0
                width: 123
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                source: "qrc:/pictures/Nastoriki_knopka_primenit.tif"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: buttomChangeTargetAddressText
                x: 0
                y: 0
                width: 123
                height: 40
                color: "#ffffff"
                text: "Заменить"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 16
            }

            MouseArea {
                id: buttomChangeTargetAddressMouse
                anchors.fill: parent
                hoverEnabled: true
            }
        }
        spacing: 5
    }

    Rectangle {
        id: settingsWindowLabelTargetReference1
        x: 39
        y: -40
        width: 552
        height: 33
        color: "#00000000"
        anchors.top: parent.top
        Text {
            id: settingsWindowLabelReferenceText1
            width: 278
            height: 33
            color: "#ffffff"
            text: qsTr("У мишеней должны быть индивидуальные неповторяющиеся адреса для корректной работы
")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.fill: parent
            verticalAlignment: Text.AlignTop
            anchors.rightMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Calibri"
            font.pointSize: 10
        }
        anchors.leftMargin: -406
        anchors.topMargin: 402
    }

    Rectangle {
        id: settingsWindowNameAppRect
        x: 509
        y: 441
        width: 117
        height: 30
        color: "#00000000"

        Text {
            id: settingsWindowNameAppText
            x: 0
            y: 0
            width: 62
            height: 30
            color: "#92da18"
            text: qsTr("Guarden")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: settingsWindowVersionText
            x: 61
            y: 0
            width: 56
            height: 30
            color: "#ffffff"
            text: qsTr("v0.02")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: parent.width
        height: 23
        color: "#404040"

        Rectangle {
            id: rectangle1
            x: 263
            y: 0
            width: 115
            height: 23
            color: "#00000000"

            Text {
                id: text1
                width: 115
                height: 23
                color: "#ffffff"
                text: qsTr("Настройки")
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Rectangle {
            id: rectangle2
            x: 610
            y: 0
            width: 23
            height: 23
            color: "#00000000"

            Image {
                id: image
                width: 23
                height: 23
                source: "qrc:/pictures/Close_okno_nastroek.tif"
                fillMode: Image.PreserveAspectFit
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    settingsWindow.hide()
                    startWindow.show()
                }
            }
        }
    }

    FolderDialog {
        id: folderDialog
        title: "Путь сохранения тренировок:"
//        folder: shortcuts.home
//        folder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0]
        folder: configMSTK.getDefaultPathTraining()
        visible: false
        onAccepted: {
            console.log("You chose: " + folderDialog.folder)
            configMSTK.setDefaultPathTraining(folderDialog.folder)
            settingsWindowTextField.placeholderText = configMSTK.getDefaultPathTraining()
            //            Qt.quit()
        }
        onRejected: {
            console.log("Canceled")
            //            Qt.quit()
        }   //        Component.onCompleted: visible = true
    }

    property var listComPort: []

    ComboBox {
        id: comboBoxComPort
        x: 39
        y: 204
        width: 140
        height: 33
    }

    Rectangle {
        id: buttonConnectSettings
        x: 354
        y: 204
        width: 132
        height: 33
        color: "#00000000"
        opacity: 0.5
        Image {
            id: buttonConnectSettingsImg1
            x: 0
            y: 0
            width: 123
            height: 40
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "qrc:/pictures/Nastoriki_knopka_primenit.tif"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: buttonConnectSettingsText1
            x: 0
            y: 0
            width: 123
            height: 40
            color: "#ffffff"
            text: "Connect"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }

        MouseArea {
            id: buttonConnectSettingsMouse1
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                settingsWindow.connectButton();
            }
        }
    }

    Rectangle {
        id: buttonDisconnectSettings
        x: 509
        y: 204
        width: 117
        height: 33
        color: "#00000000"

        opacity: 0.5
        Image {
            id: buttonDisconnectSettingsImg2
            x: 0
            y: 0
            width: 123
            height: 40
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "qrc:/pictures/Nastoriki_knopka_primenit.tif"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: buttonDisconnectSettingsText2
            x: 0
            y: 0
            width: 123
            height: 40
            color: "#ffffff"
            text: "Disconnect"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }

        MouseArea {
            id: buttonDisconnectSettingsMouse2
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                settingsWindow.disconnectButton();

            }
        }
    }

    Rectangle {
        id: buttonUpdateSettings
        x: 205
        y: 204
        width: 123
        height: 33
        color: "#00000000"
        Image {
            id: buttonUpdateSettingsImg2
            x: 0
            y: 0
            width: 123
            height: 40
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "qrc:/pictures/Nastoriki_knopka_primenit.tif"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: buttonUpdateSettingsText2
            x: 0
            y: 0
            width: 123
            height: 40
            color: "#ffffff"
            text: "Update"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }

        MouseArea {
            id: buttonUpdateSettingsMouse2
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                settingsWindow.updateButton();
            }
        }
    }

    Label {
        id: label
        x: 39
        y: 176
        width: 140
        height: 22
        color: "#ffffff"
        text: qsTr("Настройкa COM-port")
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 10
    }
}



