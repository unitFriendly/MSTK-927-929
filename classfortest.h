#ifndef CLASSFORTEST_H
#define CLASSFORTEST_H

#include <QObject>
#include <iostream>

class ClassForTest : public QObject
{
    Q_OBJECT
public:
    explicit ClassForTest(QObject *parent = nullptr);

public slots:

    void _100ms()
    {
        std::cout << 100 << std::endl;
    }

    void _500ms()
    {
        std::cout << 500 << std::endl;
    }

    void _1000ms()
    {
        std::cout << 1000 << std::endl;
    }

    void _5000ms()
    {
        std::cout << 5000 << std::endl;
    }
};

#endif // CLASSFORTEST_H
