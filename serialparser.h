#ifndef SERIALPARSER_H
#define SERIALPARSER_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QDebug>


class SerialParser : public QObject
{
    Q_OBJECT

private:
    QSerialPort* serialPort;
    bool status;
    QByteArray buffer;

    void InitSerialParser(QString portName,
                          qint32 baudRate,
                          QSerialPort::DataBits dataBits,
                          QSerialPort::Parity parity,
                          QSerialPort::StopBits stopBits,
                          QSerialPort::FlowControl flowControl
                          );

    const int SIZE_PACKET = 6;


public:
    SerialParser(QObject *parent = nullptr);
    SerialParser(QString portName,
                 qint32 baudRate,
                 QSerialPort::DataBits dataBits,
                 QSerialPort::Parity parity,
                 QSerialPort::StopBits stopBits,
                 QSerialPort::FlowControl flowControl
                 );

    bool getStatus() const;



public slots:

    void slotReadyRead();
    void slotErrorOccurred(QSerialPort::SerialPortError error);

    void disconnectSerialPort();

//    void connectSerial();
    void emitNewHit(int target, int zone);

    void connectSerialPort(QString portName);
signals:
    void onNewHit(int target, int zone);

};

#endif // SERIALPARSER_H
