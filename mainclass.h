#ifndef MAINCLASS_H
#define MAINCLASS_H

#include <QObject>
#include <QDateTime>
#include <QDebug>
#include <QTimer>
#include <QColor>
#include <QArrayData>
#include <QQuickItem>
#include <serialparser.h>
#include <QtSerialPort/QSerialPortInfo>
#include <parserjson.h>
#include <config.h>

class MainClass : public QObject
{
    Q_OBJECT
private:
    QColor startColorCopter;
    QColor goalColorCopter;

    const int MAX_COUNT_HIT = 15;

    bool isCalcXRow = false;

    QVector<QSerialPortInfo> arrayComPort;
    QVector<QString> arrayPortName;
    QString portName;


    QVector<QVector<QVector<QTime>>> tableHitsTime;

    const int TIMER_INTERVAL = 30;

    QTime durationTraining;

    float cffSpeedPlay;

    const int MAX_COUNT_ZONE = 13;
    const int MAX_COUNT_TARGET = 3;

    ParserJSON jsonParserSaveTraining;

public:
    explicit MainClass(QObject *parent = nullptr);

    int countTargets;
    QTimer *timer;
    SerialParser *serial;

signals:

    void onTestNewHit(int zone, QColor newColor);
    void onNewHitCopterUpdateColor(int zone, QColor newColor);
    void onNewHitCopter(int target, int zone);

    void onNewHitCopterFromRecord(int target, int zone, int time);

    void onGetTime();
    void onGetDate();

    void on100ms();
    void on500ms();
    void on1000ms();
    void on5000ms();

    void onCalcXRow();

    void onConnectSerial(QString portName);
    void onDisconnectSerial();

public slots:

    void st_loadSaveTraining(QString path);
    int st_getCountTargets();
    QString st_getDateTraining();
    QString st_getTimeTraining();
    QString st_getDurationTraining();
    int st_getDurationTrainingMsec();
    int st_getHeightFlightTarget();
    int st_getDistanceToTargets();
    int st_getCountHit();
    QString st_getTimeFirstHit();
    int st_getZoneOutmatchHit();
    int st_getPercentageHitsZone();
    int st_getTargetOutmatchHit();
    int st_getTargetLessHit();
    int st_getCountShot();
    void st_loadAllHits();

    QString saveTraining(QString path);

    void connectSerialPort(QString portName);
    void disconnectSerialPort();

//    void getSaveTrainingFromPath(QString path);

    QVector<QString> getArrayPortName();

    void emitSignalToQml();

    int getCountTargets();

    void setCountTargets(int value);

    QString getDate();

    QString getTime();

    int getRandom(int min, int max);

    void startTimerGeneral();
    void stopTimerGeneral();

    void newHit(int zone, int target);

    void setStartColor(QColor color);

    QColor getNextColorForZone(int currentCountHit);

    void setIsCalcXRow(bool isCalc);
    bool getIsCalcXRow();

    int getTIMER_INTERVAL();

    int getDurationTrainingMSec();
    int getDurationTrainingSec();
    QString getDurationTrainingStr(QString format = "mm:ss");
    void dropDurationTraining();

    void setCffSpeedPlay(float value);

    //    void AppendHitsFromSave(QQuickItem parent, QString path);
    int getSizeArrayPortName();

    QString getValueFromArrayPotname(int index);

    ///обнуление закрашенных зон
    void clearSizeZone(int value);
};

#endif // MAINCLASS_H
