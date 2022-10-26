#include "mainclass.h"

int MainClass::getTIMER_INTERVAL()
{
    return TIMER_INTERVAL;
}

int MainClass::getDurationTrainingMSec()
{
    static QTime zeroTime = QTime(0, 0, 0, 0);

    return zeroTime.msecsTo(durationTraining);
}

int MainClass::getDurationTrainingSec()
{
    static QTime zeroTime = QTime(0, 0, 0, 0);

    return zeroTime.secsTo(durationTraining);
}

QString MainClass::getDurationTrainingStr(QString format)
{
    return durationTraining.toString(format);
}

void MainClass::dropDurationTraining()
{
    durationTraining = QTime(0, 0, 0, 0);
}

bool MainClass::getIsCalcXRow()
{
    return isCalcXRow;
}

QString MainClass::getValueFromArrayPotname(int index)
{
    return arrayPortName[index];
}

QVector<QString> MainClass::getArrayPortName()
{
//    return arrayPortName;

    QVector<QString> tmp;
    tmp.append("1");
    tmp.append("3");
    tmp.append("2");

    return tmp;
}

int MainClass::getSizeArrayPortName()
{
    arrayPortName.clear();
    arrayComPort.clear();

    arrayComPort = QSerialPortInfo::availablePorts().toVector();

    for (int i =0; i< arrayComPort.size(); i++)
    {
        arrayPortName.push_back(arrayComPort[i].portName());
    }

    return arrayPortName.size();
}

void MainClass::setCffSpeedPlay(float value)
{
    cffSpeedPlay = value;
}

//void MainClass::AppendHitsFromSave(QQuickItem parent, QString path)
//{
//    //890 stranica
//}

MainClass::MainClass(QObject *parent) : QObject(parent)
{
    this->timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(emitSignalToQml()));
    goalColorCopter = QColor(255, 0, 0, 255);
    durationTraining = QTime(0, 0, 0, 0);
    cffSpeedPlay = 1.0;

    serial = new SerialParser(this);
    connect(serial, &SerialParser::onNewHit, this, &MainClass::newHit);

    connect(this, &MainClass::onConnectSerial, serial, &SerialParser::connectSerialPort);
    connect(this, &MainClass::onDisconnectSerial, serial, &SerialParser::disconnectSerialPort);

    //сразу проинициализирую массив данных
    tableHitsTime.resize(3);

    arrayComPort = QSerialPortInfo::availablePorts().toVector();

    for (int i =0; i< arrayComPort.size(); i++)
    {
        arrayPortName.push_back(arrayComPort[i].portName());
    }

    for(int i = 0; i < tableHitsTime.size(); i++)
    {
        tableHitsTime[i].resize(13);
    }
}

void MainClass::st_loadSaveTraining(QString path)
{
    jsonParserSaveTraining.LoadJsonFromFile(path.mid(8, path.size() - 8));
}

int MainClass::st_getCountTargets()
{
    return jsonParserSaveTraining.GetCountTargets();
}

QString MainClass::st_getDateTraining()
{
    return jsonParserSaveTraining.GetDateTraining().toString(Qt::RFC2822Date);
}

QString MainClass::st_getTimeTraining()
{
    return jsonParserSaveTraining.GetTimeTraining().toString("hh:mm");
}

QString MainClass::st_getDurationTraining()
{
    return jsonParserSaveTraining.GetDurationTraining().toString("hh:mm:ss");
}

int MainClass::st_getDurationTrainingMsec()
{
    static QTime zeroTime(0, 0, 0, 0);

    return zeroTime.msecsTo(jsonParserSaveTraining.GetDurationTraining());
}

int MainClass::st_getHeightFlightTarget()
{
    return jsonParserSaveTraining.GetHeightFlightTarget();
}

int MainClass::st_getDistanceToTargets()
{
    return jsonParserSaveTraining.GetDistanceToTargets();
}

int MainClass::st_getCountHit()
{
    return jsonParserSaveTraining.GetCountHit();
}

QString MainClass::st_getTimeFirstHit()
{
    return jsonParserSaveTraining.GetTimeFirstHit().toString("mm:ss.zzz");
}

int MainClass::st_getZoneOutmatchHit()
{
    return jsonParserSaveTraining.GetZoneOutmatchHit();
}

int MainClass::st_getPercentageHitsZone()
{
    return jsonParserSaveTraining.GetPercentageHitsZone();
}

int MainClass::st_getTargetOutmatchHit()
{
    return jsonParserSaveTraining.GetTargetOutmatchHit();
}

int MainClass::st_getTargetLessHit()
{
    return jsonParserSaveTraining.GetTargetLessHit();
}

int MainClass::st_getCountShot()
{
    return jsonParserSaveTraining.GetCountShot();
}

void MainClass::st_loadAllHits()
{
    QVector<DataHit>* allHits = jsonParserSaveTraining.GetHits();

    QTime zeroTime(0, 0, 0, 0);

    for(int i = 0; i < allHits->size(); i++)
    {
        emit onNewHitCopterFromRecord((*allHits)[i].numTarget, (*allHits)[i].zone, zeroTime.msecsTo((*allHits)[i].time));
    }
}

void MainClass::connectSerialPort(QString portName)
{
    qDebug() << "void MainClass::connectSerialPort(QString portName)";
    emit onConnectSerial(portName);
}

void MainClass::disconnectSerialPort()
{
    qDebug() << "void MainClass::disconnectSerialPort()";
    emit onDisconnectSerial();
}

//void MainClass::getSaveTrainingFromPath(QString path)
//{
//    emit onNewHitCopterFromRecord(1, 1, 1);
//    emit onNewHitCopterFromRecord(2, 2, 2);
//    emit onNewHitCopterFromRecord(3, 3, 3);
//    emit onNewHitCopterFromRecord(4, 4, 4);
//}

QString MainClass::saveTraining(QString path)
{
    qDebug() << "save";

    ParserJSON jsonParser;

    jsonParser.SetCountTargets(countTargets);
    jsonParser.SetDateTraining(QDate::currentDate());
    jsonParser.SetTimeTraining(QTime::currentTime());
    jsonParser.SetDurationTraining(durationTraining);

    jsonParser.SetHeightFlightTarget(Config::_this->getHeightFlightTarget());
    jsonParser.SetDistanceToTargets(Config::_this->getDistanceFlightTarget());

    jsonParser.SetCountShot(Config::_this->getCountShot());

    QVector<int> hitsZone(13, 0);
    QVector<int> hitsTarget(tableHitsTime.size(), 0);

    int targetFirstHit = -1;

    int countHitAll = 0;
    int zoneMaxHitIndex = -1;
    int zoneMaxHitValue = INT_MIN;
    int countZoneZeroHit = 0;    

    QTime timeFirstHit = QTime::currentTime();

    for(int t = 0; t < tableHitsTime.size(); t++)
    {
        for(int z = 0; z < tableHitsTime[t].size(); z++)
        {
            hitsZone[z] += tableHitsTime[t][z].size();
            hitsTarget[t] += tableHitsTime[t][z].size();

            for(int i = 0; i < tableHitsTime[t][z].size(); i++)
            {
                jsonParser.AddHitToArray(t, z, tableHitsTime[t][z][i]);

                if(tableHitsTime[t][z][i] < timeFirstHit)
                {
                    timeFirstHit = tableHitsTime[t][z][i];
                    targetFirstHit = t;
                }
            }
        }
    }

    for(int i = 0; i < hitsZone.size(); i++)
    {
        countHitAll += hitsZone[i];

        if((zoneMaxHitValue < hitsZone[i]) && (hitsZone[i] > 0))
        {
            zoneMaxHitIndex = i;
            zoneMaxHitValue = hitsZone[i];
        }

        if(hitsZone[i] == 0)
        {
            countZoneZeroHit++;
        }
    }

    if(countHitAll == 0)
    {
        timeFirstHit = QTime(0, 0, 0, 0);
    }

    int indexTargetOutmatchHit = -1;
    int indexTargetLessHit = -1;
    int countHitsTargetOutmatchHit = INT_MIN;
    int countHitsTargetLessHit = INT_MAX;

    for(int i = 0; i < hitsTarget.size(); i++)
    {
        if(hitsTarget[i] > countHitsTargetOutmatchHit)
        {
            countHitsTargetOutmatchHit = hitsTarget[i];
            indexTargetOutmatchHit = i;
        }

        if(hitsTarget[i] < countHitsTargetLessHit)
        {
            countHitsTargetLessHit = hitsTarget[i];
            indexTargetLessHit = i;
        }
    }

    if((countHitsTargetOutmatchHit == 0) && (countHitsTargetLessHit == 0))
    {
        jsonParser.SetTargetOutmatchHit(-1);
        jsonParser.SetTargetLessHit(-1);
    }
    else
    {
        jsonParser.SetTargetOutmatchHit(indexTargetOutmatchHit);
        jsonParser.SetTargetLessHit(indexTargetLessHit);
    }

    jsonParser.SetCountHit(countHitAll);
    jsonParser.SetTimeFirstHit(timeFirstHit);
    jsonParser.SetZoneOutmatchHit(zoneMaxHitIndex);
    jsonParser.SetPercentageHitsZone(static_cast<int>(((float)(hitsZone.size() - countZoneZeroHit) / (float)(hitsZone.size())) * 100.0));

    QString pathToSaveFile = path + "/training_" + QDateTime::currentDateTime().toString("dd_MM_yyyy_hh_mm_ss") + QString(".json");

    jsonParser.SaveJsonToFile(pathToSaveFile);

    return pathToSaveFile;
}

void MainClass::emitSignalToQml()
{
    static int counter = 0;

    if (isCalcXRow)
    {
        durationTraining = durationTraining.addMSecs(static_cast<int>(((float)(TIMER_INTERVAL) * cffSpeedPlay)));
        emit onCalcXRow();
    }

    counter += TIMER_INTERVAL;

    if(counter % 100 == 0)
    {
        emit on100ms();
    }

    if(counter % 500 == 0)
    {
        emit on500ms();
    }

    if(counter % 1000 == 0)
    {
        emit on1000ms();
    }

    if(counter % 5000 == 0)
    {
        emit on5000ms();

        counter = 0;
    }

    emit onGetDate();
    emit onGetTime();
}

QColor MainClass::getNextColorForZone(int currentCountHit)
{
    qDebug() << "getNextColorForZone  =" << currentCountHit;
    if(currentCountHit > MAX_COUNT_HIT)
    {
        currentCountHit = MAX_COUNT_HIT;
    }

    return QColor(
                startColorCopter.red() + (((goalColorCopter.red() - startColorCopter.red()) / (float)MAX_COUNT_HIT) * (float)currentCountHit),
                startColorCopter.green() + (((goalColorCopter.green() - startColorCopter.green()) / (float)MAX_COUNT_HIT) * (float)currentCountHit),
                startColorCopter.blue() + (((goalColorCopter.blue() - startColorCopter.blue()) / (float)MAX_COUNT_HIT) * (float)currentCountHit),
                255
                );
}

void MainClass::setIsCalcXRow(bool isCalc)
{
    this->isCalcXRow = isCalc;
}

int MainClass::getCountTargets()
{
    return this->countTargets;
}

void MainClass::setCountTargets(int value)
{
    this->countTargets = value;
    tableHitsTime.resize(value);

    for(int i = 0; i < value; i++)
    {
        tableHitsTime[i].resize(13);
    }
}

QString MainClass::getDate()
{
    QDate date = QDate::currentDate();
    //    qDebug() << date.toString("dd.MM.yyyy");
    return date.toString("dd.MM.yyyy");
}

QString MainClass::getTime()
{
    QTime time = QTime::currentTime();
    //    qDebug() << time.toString("mm:ss");

    return time.toString("hh:mm");;
}

int MainClass::getRandom(int min, int max)
{
    qsrand(QDateTime::currentMSecsSinceEpoch());
    //    qDebug() << (qrand() % ((max + 1) - min) + min);
    return (qrand() % ((max + 1) - min) + min);
}

void MainClass::startTimerGeneral()
{
    //    durationTraining = QTime(0, 0, 0, 0);
    timer->start(TIMER_INTERVAL);
}

void MainClass::stopTimerGeneral()
{
    timer->stop();
}

void MainClass::clearSizeZone(int value)
{
    tableHitsTime.clear();

    this->setCountTargets(value);
}

void MainClass::newHit(int target, int zone)
{
    qDebug() << "onNewHit";
    zone--;
    if((target < MAX_COUNT_TARGET) && (zone < MAX_COUNT_ZONE))
    {
        qDebug() << "target" << target << "zone" << zone;
        qDebug() << "zone" << zone << "target" << target;
        ((tableHitsTime[target])[zone]).append(durationTraining);


        emit onNewHitCopterUpdateColor(zone+1, getNextColorForZone(((tableHitsTime[target])[zone]).size()));
        emit onNewHitCopter(target, zone+1);
    }
    else
    {
        qDebug() << "ERROR: Выход за переделы\ntarget_max = " << MAX_COUNT_TARGET << "current value target = " << target << "\nzone max = " << MAX_COUNT_ZONE << "current value zone = " << zone;
    }

}

void MainClass::setStartColor(QColor color)
{
    startColorCopter = color;
}
