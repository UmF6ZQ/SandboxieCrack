QT = core gui
QT += gui-private
unix {
    QT += gui-private
}
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = UGlobalHotkey
TEMPLATE = lib
CONFIG += c++11

# Switch ABI to export (vs import, which is default)
DEFINES += UGLOBALHOTKEY_LIBRARY

INCLUDEPATH += $$PWD
DEPENDPATH += $$PWD

OBJECTS_DIR = release
MOC_DIR = release

HEADERS += $$PWD/ukeysequence.h $$PWD/uglobalhotkeys.h $$PWD/uexception.h $$PWD/hotkeymap.h $$PWD/uglobal.h
SOURCES += $$PWD/ukeysequence.cpp $$PWD/uglobalhotkeys.cpp $$PWD/uexception.cpp

message("PWD: $$PWD")
message("SOURCES: $$SOURCES")

# Linking options for different platforms
linux: LIBS += -lxcb -lxcb-keysyms
mac: LIBS += -framework Carbon

windows {
    *-g++* {
        LIBS += -luser32
    }
    *-msvc* {
        LIBS += user32.lib
    }
}

CONFIG(release, debug|release):{
QMAKE_CXXFLAGS_RELEASE = $$QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO
QMAKE_LFLAGS_RELEASE = $$QMAKE_LFLAGS_RELEASE_WITH_DEBUGINFO
}

QMAKE_CXXFLAGS_RELEASE -= -O2

MY_ARCH=$$(build_arch)
equals(MY_ARCH, ARM64) {
#  message("Building ARM64")
  CONFIG(debug, debug|release):DESTDIR = ../Bin/ARM64/Debug
  CONFIG(release, debug|release):DESTDIR = ../Bin/ARM64/Release
} else:equals(MY_ARCH, x64) {
#  message("Building x64")
  CONFIG(debug, debug|release):DESTDIR = ../Bin/x64/Debug
  CONFIG(release, debug|release):DESTDIR = ../Bin/x64/Release
} else {
#  message("Building x86")
  CONFIG(debug, debug|release):DESTDIR = ../Bin/Win32/Debug
  CONFIG(release, debug|release):DESTDIR = ../Bin/Win32/Release
}
