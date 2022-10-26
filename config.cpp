#include "config.h"

Config* Config::_this = nullptr;

const QString Config::PATH_CONFIG = QString("conf.json");

const QString Config::___keyDefaultPathTraining = QString("key_default_path");
const QString Config::___keyCountShot = QString("key_count_shot");
const QString Config::___keyCountTarget = QString("key_count_target");
const QString Config::___keyHeightFlightTarget = QString("key_height_flight_target");
const QString Config::___keyDistanceFlightTarget = QString("key_distance_flight_target");

Config::Config(QObject *parent) : QObject(parent)
{
    QFile file(PATH_CONFIG);

    if(!file.open(QFile::ReadOnly))
    {
        defaultPathTraining = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation).at(0);
        countShot = 1;
        heightFlightTarget = 10;
        distanceFlightTarget = 50;
        countTarget = 1;

        saveConfigToFile();

        return;
    }


    QJsonDocument jDoc = QJsonDocument::fromJson(file.readAll());

    file.close();

    QJsonObject rootObject = jDoc.object();

    countShot = rootObject[___keyCountShot].toString().toInt();
    countTarget = rootObject[___keyCountTarget].toString().toInt();
    distanceFlightTarget = rootObject[___keyDistanceFlightTarget].toString().toInt();
    heightFlightTarget = rootObject[___keyHeightFlightTarget].toString().toInt();
    defaultPathTraining = rootObject[___keyDefaultPathTraining].toString();
}

void Config::saveConfigToFile()
{
    QJsonDocument jDoc;
    QJsonObject rootObject;

    rootObject.insert(___keyCountShot, QJsonValue(QString::number(countShot)));
    rootObject.insert(___keyCountTarget, QJsonValue(QString::number(countTarget)));
    rootObject.insert(___keyHeightFlightTarget, QJsonValue(QString::number(heightFlightTarget)));
    rootObject.insert(___keyDistanceFlightTarget, QJsonValue(QString::number(distanceFlightTarget)));
    rootObject.insert(___keyDefaultPathTraining, QJsonValue(defaultPathTraining));

    jDoc.setObject(rootObject);

    QFile file(PATH_CONFIG);
    file.open(QFile::WriteOnly);
    file.write(jDoc.toJson(QJsonDocument::Indented));
    file.close();
}

void Config::setDefaultPathTraining(QString path)
{
    defaultPathTraining = path.mid(8, path.length() - 8);
    saveConfigToFile();
}

QString Config::getDefaultPathTraining()
{
    return defaultPathTraining;
}

void Config::setCountShot(int count)
{
    countShot = count;
    saveConfigToFile();
}

int Config::getCountShot()
{
    return countShot;
}

void Config::setCountTarget(int count)
{
    countTarget = count;
    saveConfigToFile();
}

int Config::getCountTarget()
{
    return countTarget;
}

void Config::setHeightFlightTarget(int count)
{
    heightFlightTarget = count;
    saveConfigToFile();
}

int Config::getHeightFlightTarget()
{
    return heightFlightTarget;
}

void Config::setDistanceFlightTarget(int count)
{
    distanceFlightTarget = count;
    saveConfigToFile();
}

int Config::getDistanceFlightTarget()
{
    return distanceFlightTarget;
}
