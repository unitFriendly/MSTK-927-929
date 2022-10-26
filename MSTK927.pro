QT += quick 3dcore 3drender 3dinput 3dextras 3dquick 3dquickextras quick3d serialport

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        classfortest.cpp \
        config.cpp \
        main.cpp \
        mainclass.cpp \
        parserjson.cpp \
        serialparser.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Picture_MSTK/Rezultaty/Close_spravku.tif \
    Picture_MSTK/Rezultaty/Kursor_vremeni.tif \
    Picture_MSTK/Rezultaty/Line_centr.tif \
    Picture_MSTK/Rezultaty/Line_spravki.tif \
    Picture_MSTK/Rezultaty/Okno_full_infy.tif \
    Picture_MSTK/Rezultaty/Okno_misheni.tif \
    Picture_MSTK/Rezultaty/Pause.tif \
    Picture_MSTK/Rezultaty/Plashka_timeline_aktiv.tif \
    Picture_MSTK/Rezultaty/Plashka_timeline_ne_aktiv.tif \
    Picture_MSTK/Rezultaty/Play.tif \
    Picture_MSTK/Rezultaty/Podcherkivanie_okno_full.tif \
    Picture_MSTK/Rezultaty/Podcherkivanie_okno_mishen.tif \
    Picture_MSTK/Rezultaty/Popadanie_aktiv.tif \
    Picture_MSTK/Rezultaty/Popadanie_ne_aktiv.tif \
    Picture_MSTK/Rezultaty/Spravka.tif \
    Picture_MSTK/Rezultaty/TimeLine_aktiv.tif \
    Picture_MSTK/Rezultaty/TimeLine_ne_aktiv.tif \
    Picture_MSTK/Rezultaty/Verh.tif \
    Picture_MSTK/Rezultaty/Vyhod.tif \
    Picture_MSTK/pictures/Close_okno_nastroek.tif \
    Picture_MSTK/pictures/Close_spravku.tif \
    Picture_MSTK/pictures/Cyber-Mandarin.tif \
    Picture_MSTK/pictures/Cyber.tif \
    Picture_MSTK/pictures/Line_spravki.tif \
    Picture_MSTK/pictures/Logo.tif \
    Picture_MSTK/pictures/Nastoriki_knopka_primenit.tif \
    Picture_MSTK/pictures/Nastroiki.tif \
    Picture_MSTK/pictures/Nastroiki_knopka_obzor.tif \
    Picture_MSTK/pictures/Nastroiki_pole_zapisi.tif \
    Picture_MSTK/pictures/Parametry.tif \
    Picture_MSTK/pictures/Poisk_misheney.tif \
    Picture_MSTK/pictures/Put_papki_save.tif \
    Picture_MSTK/pictures/Spravka.tif \
    Picture_MSTK/pictures/Trenirovka_aktiv.tif \
    Picture_MSTK/pictures/Trenirovka_ne_aktiv.tif \
    Picture_MSTK/pictures/Verh.tif \
    Picture_MSTK/pictures/Vyhod.tif \
    Picture_MSTK/pictures/Zagruzit_trenyu.tif \
    Picture_MSTK/Trenirovka/Close_spravku.tif \
    Picture_MSTK/Trenirovka/Knopka_zavershit.tif \
    Picture_MSTK/Trenirovka/Line_spravki.tif \
    Picture_MSTK/Trenirovka/Mishen_aktiv.tif \
    Picture_MSTK/Trenirovka/Mishen_ne_aktiv.tif \
    Picture_MSTK/Trenirovka/Plashka_timeline.tif \
    Picture_MSTK/Trenirovka/Popadanie_aktiv.tif \
    Picture_MSTK/Trenirovka/Popadanie_ne_aktiv.tif \
    Picture_MSTK/Trenirovka/Spravka.tif \
    Picture_MSTK/Trenirovka/TimeLine.tif \
    Picture_MSTK/Trenirovka/Verh.tif

HEADERS += \
    classfortest.h \
    config.h \
    mainclass.h \
    parserjson.h \
    serialparser.h
