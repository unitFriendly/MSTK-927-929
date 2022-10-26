#include "serialparser.h"

void SerialParser::slotReadyRead()
{
    static int indexEndSymbol = -1;
    static int indexStartSymbol = -1;

    buffer.append(serialPort->readAll());

    // начало на ! (21)
    indexEndSymbol = buffer.indexOf('!');

    if(indexEndSymbol != -1)
    {
        QByteArray tmpArray;
        tmpArray.insert(0, buffer, indexEndSymbol + 1);
        buffer.remove(0, indexEndSymbol + 1);

        // начало на i (69)
        indexStartSymbol = tmpArray.lastIndexOf('i');

        if((indexEndSymbol != -1) && (indexEndSymbol + 1 - indexStartSymbol == SIZE_PACKET))
        {
            emit onNewHit(tmpArray[indexStartSymbol + 3], tmpArray[indexStartSymbol + 4]);

            qDebug() << tmpArray[indexStartSymbol + 3] << tmpArray[indexStartSymbol + 4];
            qDebug() << "emit onNewHit";
//            emitNewHit(tmpArray[indexStartSymbol + 3], tmpArray[indexStartSymbol + 4]);
        }
    }
}

void SerialParser::slotErrorOccurred(QSerialPort::SerialPortError error)
{
    if(error == QSerialPort::NoError)
    {
        status = true;
    }
    else
    {
        qDebug() << "ERROR: Serial port error code - " << error;
        status = false;
    }
}

void SerialParser::connectSerialPort(QString portName)
{
//    disconnect(serialPort, &QSerialPort::readyRead, this, &SerialParser::slotReadyRead);
    serialPort->setPortName(portName);
    if (!serialPort->open(QIODevice::ReadOnly))
    {
        qDebug() << "ERROR: Serial port error - " << serialPort->errorString();
        status = false;
    }
//    connect(serialPort, &QSerialPort::readyRead, this, &SerialParser::slotReadyRead);
    qDebug() << "void SerialParser::connectSerialPort(QString portName)";
}

void SerialParser::disconnectSerialPort()
{
    serialPort->close();

//    disconnect(serialPort, &QSerialPort::readyRead, this, &SerialParser::slotReadyRead);
    qDebug() << "void SerialParser::disconnectSerialPort()";
}

bool SerialParser::getStatus() const
{
    return status;
}

void SerialParser::InitSerialParser(
                                    QString portName,
                                    qint32 baudRate,
                                    QSerialPort::DataBits dataBits,
                                    QSerialPort::Parity parity,
                                    QSerialPort::StopBits stopBits,
                                    QSerialPort::FlowControl flowControl)
{
    serialPort = new QSerialPort();
    serialPort->setPortName(portName);
    serialPort->setBaudRate(baudRate);
    serialPort->setDataBits(dataBits);
    serialPort->setParity(parity);
    serialPort->setStopBits(stopBits);
    serialPort->setFlowControl(flowControl);

    connect(serialPort, &QSerialPort::errorOccurred, this, &SerialParser::slotErrorOccurred);
    connect(serialPort, &QSerialPort::readyRead, this, &SerialParser::slotReadyRead);

//    if (!serialPort->open(QIODevice::ReadOnly)) {
//        qDebug() << "ERROR: Serial port error - " << serialPort->errorString();
//        status = false;
//    }

    serialPort->clear();
    buffer.clear();
    status = true;
}

void SerialParser::emitNewHit(int target, int zone)
{
    //тут эмитем новое попадание
//    disconnect(serialPort, &QSerialPort::readyRead, this, &SerialParser::slotReadyRead);
    qDebug() << target<< zone;

}

SerialParser::SerialParser(QObject *parent) : QObject(parent)
{
    InitSerialParser(
                "COM3",
                9600,
                QSerialPort::Data8,
                QSerialPort::NoParity,
                QSerialPort::OneStop,
                QSerialPort::NoFlowControl
                );
}

SerialParser::SerialParser(
                            QString portName,
                            qint32 baudRate,
                            QSerialPort::DataBits dataBits,
                            QSerialPort::Parity parity,
                            QSerialPort::StopBits stopBits,
                            QSerialPort::FlowControl flowControl
                          )
{
    InitSerialParser(
                        portName,
                        baudRate,
                        dataBits,
                        parity,
                        stopBits,
                        flowControl
                    );
}
