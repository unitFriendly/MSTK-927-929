#include "parserjson.h"

QString ParserJSON::JsonToString()
{
    AddDataToRootObject();

    return jDoc.toJson(QJsonDocument::Indented);
}

void ParserJSON::SetPercentageHitsZone(int percentage)
{
    SetPropertyInt(&jStatisticalDataTrainingObject, ___STATISTICAL_DATA_TRAINING::KEY_PERCENTAGE_HITS_ZONE(), percentage);
}

void ParserJSON::SetTimeFirstHit(QTime time)
{
    SetPropertyTime(&jStatisticalDataTrainingObject, ___STATISTICAL_DATA_TRAINING::KEY_TIME_FIRST_HIT(), time);
}

void ParserJSON::SetTargetFirstHit(int idTarget)
{
    SetPropertyInt(&jStatisticalDataTrainingObject, ___STATISTICAL_DATA_TRAINING::KEY_TARGET_FIRST_HIT(), idTarget);
}

void ParserJSON::SetCountHit(int count)
{
    SetPropertyInt(&jStatisticalDataTrainingObject, ___STATISTICAL_DATA_TRAINING::KEY_COUNT_HIT(), count);
}

void ParserJSON::SetZoneOutmatchHit(int idZone)
{
    SetPropertyInt(&jStatisticalDataTrainingObject, ___STATISTICAL_DATA_TRAINING::KEY_ZONE_OUTMATCH_HITS(), idZone);
}

void ParserJSON::SetTargetOutmatchHit(int idTarget)
{
    SetPropertyInt(&jStatisticalDataTrainingObject, ___STATISTICAL_DATA_TRAINING::KEY_TARGET_OUTMATCH_HITS(), idTarget);
}

void ParserJSON::SetTargetLessHit(int idTarget)
{
    SetPropertyInt(&jStatisticalDataTrainingObject, ___STATISTICAL_DATA_TRAINING::KEY_TARGET_LESS_HITS(), idTarget);
}

void ParserJSON::SetCountTargets(int count)
{
    SetPropertyInt(&jParametersTrainingObject, ___PARAMETERS_TRAINING::KEY_COUNT_TARGETS(), count);
}

void ParserJSON::SetDateTraining(QDate date)
{
    SetPropertyDate(&jParametersTrainingObject, ___DATE::KEY_MAIN(), date);
}

void ParserJSON::SetDurationTraining(QTime duration)
{
    SetPropertyTime(&jParametersTrainingObject, ___PARAMETERS_TRAINING::KEY_DURATION(), duration);
}

void ParserJSON::SetTimeTraining(QTime time)
{
    SetPropertyTime(&jParametersTrainingObject, ___TIME::KEY_MAIN(), time);
}

void ParserJSON::SetHeightFlightTarget(int height)
{
    SetPropertyInt(&jParametersTrainingObject, ___PARAMETERS_TRAINING::KEY_HEIGHT_FLIGHT_TARGET(), height);
}

void ParserJSON::SetDistanceToTargets(int distance)
{
    SetPropertyInt(&jParametersTrainingObject, ___PARAMETERS_TRAINING::KEY_DISTANCE_TO_TARGETS(), distance);
}

void ParserJSON::SetCountShot(int count)
{
    SetPropertyInt(&jParametersTrainingObject, ___PARAMETERS_TRAINING::KEY_COUNT_SHOT(), count);
}

void ParserJSON::AddHitToArray(int numTarget, int zone, QTime time)
{
    QJsonObject tmpObject;

    SetPropertyTime(&tmpObject, ___TIME::KEY_MAIN(), time);
    SetPropertyInt(&tmpObject, ___HITS::KEY_NUM_TARGET(), numTarget);
    SetPropertyInt(&tmpObject, ___HITS::KEY_ZONE(), zone);

    jHitsArray.push_back(tmpObject);
}

int ParserJSON::GetPercentageHitsZone()
{
    return jStatisticalDataTrainingObject[___STATISTICAL_DATA_TRAINING::KEY_PERCENTAGE_HITS_ZONE()].toInt();
}

QTime ParserJSON::GetTimeFirstHit()
{
    QJsonObject tmpObject = jStatisticalDataTrainingObject[___STATISTICAL_DATA_TRAINING::KEY_TIME_FIRST_HIT()].toObject();

    return QTime
                (
                    tmpObject[___TIME::KEY_HOUR()].toInt(),
                    tmpObject[___TIME::KEY_MINUTE()].toInt(),
                    tmpObject[___TIME::KEY_SECOND()].toInt(),
                    tmpObject[___TIME::KEY_MSECOND()].toInt()
            );
}

int ParserJSON::GetTargetFirstHit()
{
    return jStatisticalDataTrainingObject[___STATISTICAL_DATA_TRAINING::KEY_TARGET_FIRST_HIT()].toInt();
}

int ParserJSON::GetCountHit()
{
    return jStatisticalDataTrainingObject[___STATISTICAL_DATA_TRAINING::KEY_COUNT_HIT()].toInt();
}

int ParserJSON::GetZoneOutmatchHit()
{
    return jStatisticalDataTrainingObject[___STATISTICAL_DATA_TRAINING::KEY_ZONE_OUTMATCH_HITS()].toInt();
}

int ParserJSON::GetTargetOutmatchHit()
{
    return jStatisticalDataTrainingObject[___STATISTICAL_DATA_TRAINING::KEY_TARGET_OUTMATCH_HITS()].toInt();
}

int ParserJSON::GetTargetLessHit()
{
    return jStatisticalDataTrainingObject[___STATISTICAL_DATA_TRAINING::KEY_TARGET_LESS_HITS()].toInt();
}

int ParserJSON::GetCountTargets()
{
    return jParametersTrainingObject[___PARAMETERS_TRAINING::KEY_COUNT_TARGETS()].toInt();
}

QDate ParserJSON::GetDateTraining()
{
    QJsonObject tmpObject = jParametersTrainingObject[___DATE::KEY_MAIN()].toObject();

    return QDate
                (
                    tmpObject[___DATE::KEY_YEAR()].toInt(),
                    tmpObject[___DATE::KEY_MONTH()].toInt(),
                    tmpObject[___DATE::KEY_DAY()].toInt()
            );
}

QTime ParserJSON::GetDurationTraining()
{
    QJsonObject tmpObject = jParametersTrainingObject[___PARAMETERS_TRAINING::KEY_DURATION()].toObject();

    return QTime
                (
                    tmpObject[___TIME::KEY_HOUR()].toInt(),
                    tmpObject[___TIME::KEY_MINUTE()].toInt(),
                    tmpObject[___TIME::KEY_SECOND()].toInt(),
                    tmpObject[___TIME::KEY_MSECOND()].toInt()
            );
}

QTime ParserJSON::GetTimeTraining()
{
    QJsonObject tmpObject = jParametersTrainingObject[___TIME::KEY_MAIN()].toObject();

    return QTime
                (
                    tmpObject[___TIME::KEY_HOUR()].toInt(),
                    tmpObject[___TIME::KEY_MINUTE()].toInt(),
                    tmpObject[___TIME::KEY_SECOND()].toInt(),
                    tmpObject[___TIME::KEY_MSECOND()].toInt()
            );
}

int ParserJSON::GetHeightFlightTarget()
{
    return jParametersTrainingObject[___PARAMETERS_TRAINING::KEY_HEIGHT_FLIGHT_TARGET()].toInt();
}

int ParserJSON::GetDistanceToTargets()
{
    return jParametersTrainingObject[___PARAMETERS_TRAINING::KEY_DISTANCE_TO_TARGETS()].toInt();
}

int ParserJSON::GetCountShot()
{
    return jParametersTrainingObject[___PARAMETERS_TRAINING::KEY_COUNT_SHOT()].toInt();
}

QVector<DataHit>* ParserJSON::GetHits()
{
    QVector<DataHit>* result = new QVector<DataHit>();

    for(int i = 0; i < jHitsArray.count(); i++)
    {
        result->push_back(GetHit(i));
    }

    return result;
}

DataHit ParserJSON::GetHit(int index)
{    
    QJsonObject tmpObject = jHitsArray[index].toObject();

    QJsonObject tmpObjectTime = tmpObject[___TIME::KEY_MAIN()].toObject();

    return DataHit
                    {
                        tmpObject[___HITS::KEY_NUM_TARGET()].toInt(),
                        tmpObject[___HITS::KEY_ZONE()].toInt(),
                        QTime
                             (
                                tmpObjectTime[___TIME::KEY_HOUR()].toInt(),
                                tmpObjectTime[___TIME::KEY_MINUTE()].toInt(),
                                tmpObjectTime[___TIME::KEY_SECOND()].toInt(),
                                tmpObjectTime[___TIME::KEY_MSECOND()].toInt()
                             )
                    };
}

void ParserJSON::AddDataToRootObject()
{
    if (jRootObject.find(___HITS::KEY_MAIN())->isUndefined())
    {
        jRootObject.insert(___HITS::KEY_MAIN(), QJsonValue(jHitsArray));
    }
    else
    {
        jRootObject[___HITS::KEY_MAIN()] = QJsonValue(jHitsArray);
    }

    if (jRootObject.find(___PARAMETERS_TRAINING::KEY_MAIN())->isUndefined())
    {
        jRootObject.insert(___PARAMETERS_TRAINING::KEY_MAIN(), QJsonValue(jParametersTrainingObject));
    }
    else
    {
        jRootObject[___PARAMETERS_TRAINING::KEY_MAIN()] = QJsonValue(jParametersTrainingObject);
    }

    if (jRootObject.find(___STATISTICAL_DATA_TRAINING::KEY_MAIN())->isUndefined())
    {
        jRootObject.insert(___STATISTICAL_DATA_TRAINING::KEY_MAIN(), QJsonValue(jStatisticalDataTrainingObject));
    }
    else
    {
        jRootObject[___STATISTICAL_DATA_TRAINING::KEY_MAIN()] = QJsonValue(jStatisticalDataTrainingObject);
    }

    jDoc.setObject(jRootObject);
}

void ParserJSON::SetPropertyInt(QJsonObject *object, QString key, int value)
{
    if (object->find(key)->isUndefined())
    {
        object->insert(key, QJsonValue(value));
    }
    else
    {
        (*object)[key] = QJsonValue(value);
    }
}

void ParserJSON::SetPropertyTime(QJsonObject *object, QString key, QTime value)
{
    QJsonObject tmpObject = QJsonObject({
                                          {___TIME::KEY_HOUR(), QJsonValue(value.hour())},
                                          {___TIME::KEY_MINUTE(), QJsonValue(value.minute())},
                                          {___TIME::KEY_SECOND(), QJsonValue(value.second())},
                                          {___TIME::KEY_MSECOND(), QJsonValue(value.msec())}
                                      });

    if (object->find(key)->isUndefined())
    {
        object->insert(key, QJsonValue(tmpObject));
    }
    else
    {
        (*object)[key] = QJsonValue(tmpObject);
    }
}

void ParserJSON::SetPropertyDate(QJsonObject *object, QString key, QDate value)
{
    QJsonObject tmpObject = QJsonObject({
                                          {___DATE::KEY_DAY(), QJsonValue(value.day())},
                                          {___DATE::KEY_MONTH(), QJsonValue(value.month())},
                                          {___DATE::KEY_YEAR(), QJsonValue(value.year())}
                                      });

    if (object->find(key)->isUndefined())
    {
        object->insert(key, QJsonValue(tmpObject));
    }
    else
    {
        (*object)[key] = QJsonValue(tmpObject);
    }
}

ParserJSON::ParserJSON(QObject *parent) : QObject(parent)
{
    jDoc = QJsonDocument();
    jRootObject = QJsonObject();
    jHitsArray = QJsonArray();
    jParametersTrainingObject = QJsonObject();
    jStatisticalDataTrainingObject = QJsonObject();
}

bool ParserJSON::LoadJsonFromFile(QString path)
{
    QFile file(path);

    if(!file.open(QFile::ReadOnly))
    {
        qDebug() << "ERROR: File not found: " << path << "\n";
        return false;
    }

    jDoc = QJsonDocument::fromJson(file.readAll());

    if (jDoc.isEmpty())
    {
        qDebug() << "ERROR: jDoc.isEmpty() == true \n";
//        return false;
    }

    jRootObject = jDoc.object();

    if (jRootObject.isEmpty())
    {
        qDebug() << "ERROR: jRootObject.isEmpty() == true \n";
//        return false;
    }

    jHitsArray = jRootObject[___HITS::KEY_MAIN()].toArray();

    if (jHitsArray.isEmpty())
    {
        qDebug() << "ERROR: jHitsArray.isEmpty() == true \n";
//        return false;
    }

    jParametersTrainingObject = jRootObject[___PARAMETERS_TRAINING::KEY_MAIN()].toObject();

    if (jParametersTrainingObject.isEmpty())
    {
        qDebug() << "ERROR: jParametersTrainingObject.isEmpty() == true \n";
//        return false;
    }

    jStatisticalDataTrainingObject = jRootObject[___STATISTICAL_DATA_TRAINING::KEY_MAIN()].toObject();

    if (jStatisticalDataTrainingObject.isEmpty())
    {
        qDebug() << "ERROR: jStatisticalDataTrainingObject.isEmpty() == true \n";
//        return false;
    }

    file.close();

    return true;
}

bool ParserJSON::SaveJsonToFile(QString path)
{
    QFile file(path);

    if(!file.open(QFile::WriteOnly))
    {
        qDebug() << "ERROR: File not open for write: " << path << "\n";
        return false;
    }

    AddDataToRootObject();

    file.write(jDoc.toJson(QJsonDocument::Indented));
    file.close();

    return true;
}

