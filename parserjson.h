#ifndef PARSERJSON_H
#define PARSERJSON_H

#include <QObject>

#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

/*
{
    "statistical_data_training": {
        "percentage_hits_zone": 69,   //Процент пораженных мишений
        "time_first_hit": {           //Время первого попадания
            "minuts": 2,
            "msecond": 125,
            "second": 2
        },
        "target_first_hit": num,      //Мишень, в которую попали первой
        "count_hit": num,             //Количество попаданий
        "zone_outmatch_hits": num,    //Зона наибольшей плотности попаданий
        "target_outmatch_hits": num,  //Самая поразительная мишень
        "target_less_hits": num       //Самая невзрачная мишень
    },

    "parameters_training": {
        "count_targets": 5,             //Количество мишеней
        "date": {                       //Дата проведения тренировки
            "day": 29,
            "month": 3,
            "year": 2022
        },
        "duration": {                   //Продолжительность тренировки
            "minuts": 2,
            "msecond": 125,
            "second": 2
        },
        "time": {                       //Время начала тренировки
            "minuts": 14,
            "msecond": 333,
            "second": 31
        },
        "height_flight_target": num,    //Высота полета мишеней
        "distance_to_targets": num,     //Дальность до мишеней от рубежа
        "count_shot": num               //Количество стрелков
    },

    "hits": [
        {
            "num_target": 1,
            "time": {
                "minuts": 1,
                "msecond": 1,
                "secomd": 1
            },
            "zone": 1
        },
        {
            "num_target": 2,
            "time": {
                "minuts": 2,
                "msecond": 2,
                "secomd": 2
            },
            "zone": 2
        },
        {
            "num_target": 3,
            "time": {
                "minuts": 3,
                "msecond": 3,
                "secomd": 3
            },
            "zone": 3
        }
    ]
}
*/

struct DataHit
{
    int numTarget;
    int zone;
    QTime time;
};

namespace ___DATE {
    inline static QString KEY_MAIN()
    {
        return "date";
    }

    inline static QString KEY_DAY()
    {
        return "day";
    }

    inline static QString KEY_MONTH()
    {
        return "month";
    }

    inline static QString KEY_YEAR()
    {
        return "year";
    }
}

namespace ___TIME {
    inline static QString KEY_MAIN()
    {
        return "time";
    }

    inline static QString KEY_HOUR()
    {
        return "hour";
    }

    inline static QString KEY_MINUTE()
    {
        return "minute";
    }

    inline static QString KEY_SECOND()
    {
        return "second";
    }

    inline static QString KEY_MSECOND()
    {
        return "msecond";
    }
}

namespace ___PARAMETERS_TRAINING {
    inline static QString KEY_MAIN()
    {
        return "parameters_training";
    }

    inline static QString KEY_COUNT_TARGETS()
    {
        return "count_targets";
    }

    inline static QString KEY_DURATION()
    {
        return "duration";
    }

    inline static QString KEY_HEIGHT_FLIGHT_TARGET()
    {
        return "height_flight_target";
    }

    inline static QString KEY_DISTANCE_TO_TARGETS()
    {
        return "distance_to_targets";
    }

    inline static QString KEY_COUNT_SHOT()
    {
        return "count_shot";
    }
}

namespace ___STATISTICAL_DATA_TRAINING {
    inline static QString KEY_MAIN()
    {
        return "statistical_data_training";
    }

    inline static QString KEY_PERCENTAGE_HITS_ZONE()
    {
        return "percentage_hits_zone";
    }

    inline static QString KEY_TIME_FIRST_HIT()
    {
        return "time_first_hit";
    }

    inline static QString KEY_TARGET_FIRST_HIT()
    {
        return "target_first_hit";
    }

    inline static QString KEY_COUNT_HIT()
    {
        return "count_hit";
    }

    inline static QString KEY_ZONE_OUTMATCH_HITS()
    {
        return "zone_outmatch_hits";
    }

    inline static QString KEY_TARGET_OUTMATCH_HITS()
    {
        return "target_outmatch_hits";
    }

    inline static QString KEY_TARGET_LESS_HITS()
    {
        return "target_less_hits";
    }
}

namespace ___HITS {
    inline static QString KEY_MAIN()
    {
        return "HITS";
    }

    inline static QString KEY_NUM_TARGET()
    {
        return "num_target";
    }

    inline static QString KEY_ZONE()
    {
        return "zone";
    }
}

class ParserJSON : public QObject
{
    Q_OBJECT

private:
    QJsonDocument jDoc;
    QJsonObject jRootObject;
    QJsonArray jHitsArray;
    QJsonObject jStatisticalDataTrainingObject;
    QJsonObject jParametersTrainingObject;

    DataHit GetHit(int index);

    void AddDataToRootObject();

    void SetPropertyInt(QJsonObject* object, QString key, int value);
    void SetPropertyTime(QJsonObject* object, QString key, QTime value);
    void SetPropertyDate(QJsonObject* object, QString key, QDate value);

public:
    explicit ParserJSON( QObject *parent = nullptr);

    bool LoadJsonFromFile(QString path);
    bool SaveJsonToFile(QString path);

    QString JsonToString();

    void SetPercentageHitsZone(int percentage);
    void SetTimeFirstHit(QTime time);
    void SetTargetFirstHit(int idTarget);
    void SetCountHit(int count);
    void SetZoneOutmatchHit(int idZone);
    void SetTargetOutmatchHit(int idTarget);
    void SetTargetLessHit(int idTarget);

    void SetCountTargets(int count);
    void SetDateTraining(QDate date);
    void SetDurationTraining(QTime duration);
    void SetTimeTraining(QTime time);
    void SetHeightFlightTarget(int height);
    void SetDistanceToTargets(int distance);
    void SetCountShot(int count);

    void AddHitToArray(int numTarget, int zone, QTime time);

    int GetPercentageHitsZone();
    QTime GetTimeFirstHit();
    int GetTargetFirstHit();
    int GetCountHit();
    int GetZoneOutmatchHit();
    int GetTargetOutmatchHit();
    int GetTargetLessHit();

    int GetCountTargets();
    QDate GetDateTraining();
    QTime GetDurationTraining();
    QTime GetTimeTraining();
    int GetHeightFlightTarget();
    int GetDistanceToTargets();
    int GetCountShot();

    QVector<DataHit>* GetHits();

signals:

};

#endif // PARSERJSON_H
