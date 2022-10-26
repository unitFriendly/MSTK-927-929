#ifndef CONFIG_H
#define CONFIG_H

#include <QObject>
#include <QFile>
#include <QStandardPaths>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>

class Config : public QObject
{
    Q_OBJECT
public:
    explicit Config(QObject *parent = nullptr);
    static Config* _this;

private:
    QString defaultPathTraining;
    int countShot;
    int heightFlightTarget;
    int distanceFlightTarget;
    int countTarget;

    const static QString PATH_CONFIG;

    const static QString ___keyDefaultPathTraining;
    const static QString ___keyCountShot;
    const static QString ___keyCountTarget;
    const static QString ___keyHeightFlightTarget;
    const static QString ___keyDistanceFlightTarget;

    void saveConfigToFile();

public slots:

    void setDefaultPathTraining(QString path);
    QString getDefaultPathTraining();

    void setCountShot(int count);
    int getCountShot();

    void setCountTarget(int count);
    int getCountTarget();

    void setHeightFlightTarget(int count);
    int getHeightFlightTarget();

    void setDistanceFlightTarget(int count);
    int getDistanceFlightTarget();

signals:

};

#endif // CONFIG_H
