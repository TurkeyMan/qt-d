/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtCore module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL21$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia. For licensing terms and
** conditions see http://qt.digia.com/licensing. For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file. Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights. These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** $QT_END_LICENSE$
**
****************************************************************************/

public import QtCore.qglobal;
public import QtCore.qstring;
#ifndef QT_NO_QOBJECT
public import QtCore.qobject;
public import QtCore.qcoreevent;
public import QtCore.qeventloop;
#else
public import QtCore.qscopedpointer;
#endif

#ifndef QT_NO_QOBJECT
#if defined(Q_OS_WIN) && !defined(tagMSG)
typedef struct tagMSG MSG;
#endif
#endif


extern(C++) class QCoreApplicationPrivate;
extern(C++) class QTextCodec;
extern(C++) class QTranslator;
extern(C++) class QPostEventList;
extern(C++) class QStringList;
extern(C++) class QAbstractEventDispatcher;
extern(C++) class QAbstractNativeEventFilter;

#define qApp QCoreApplication::instance()

extern(C++) class export QCoreApplication
#ifndef QT_NO_QOBJECT
    : public QObject
#endif
{
#ifndef QT_NO_QOBJECT
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QString, "applicationName", "READ", "applicationName", "WRITE", "setApplicationName", "NOTIFY", "applicationNameChanged");
    mixin Q_PROPERTY!(QString, "applicationVersion", "READ", "applicationVersion", "WRITE", "setApplicationVersion", "NOTIFY", "applicationVersionChanged");
    mixin Q_PROPERTY!(QString, "organizationName", "READ", "organizationName", "WRITE", "setOrganizationName", "NOTIFY", "organizationNameChanged");
    mixin Q_PROPERTY!(QString, "organizationDomain", "READ", "organizationDomain", "WRITE", "setOrganizationDomain", "NOTIFY", "organizationDomainChanged");
    mixin Q_PROPERTY!(bool, "quitLockEnabled", "READ", "isQuitLockEnabled", "WRITE", "setQuitLockEnabled");
#endif

    mixin Q_DECLARE_PRIVATE;
public:
    enum { ApplicationFlags = QT_VERSION
    }

    QCoreApplication(int &argc, char **argv
#ifndef Q_QDOC
                     , int = ApplicationFlags
#endif
            );

    ~QCoreApplication();

    static QStringList arguments();

    static void setAttribute(Qt.ApplicationAttribute attribute, bool on = true);
    static bool testAttribute(Qt.ApplicationAttribute attribute);

    static void setOrganizationDomain(ref const(QString) orgDomain);
    static QString organizationDomain();
    static void setOrganizationName(ref const(QString) orgName);
    static QString organizationName();
    static void setApplicationName(ref const(QString) application);
    static QString applicationName();
    static void setApplicationVersion(ref const(QString) version);
    static QString applicationVersion();

    static void setSetuidAllowed(bool allow);
    static bool isSetuidAllowed();

    static QCoreApplication *instance() { return self; }

#ifndef QT_NO_QOBJECT
    static int exec();
    static void processEvents(QEventLoop::ProcessEventsFlags flags = QEventLoop::AllEvents);
    static void processEvents(QEventLoop::ProcessEventsFlags flags, int maxtime);
    static void exit(int retcode=0);

    static bool sendEvent(QObject *receiver, QEvent *event);
    static void postEvent(QObject *receiver, QEvent *event, int priority = Qt.NormalEventPriority);
    static void sendPostedEvents(QObject *receiver = 0, int event_type = 0);
    static void removePostedEvents(QObject *receiver, int eventType = 0);
#if QT_DEPRECATED_SINCE(5, 3)
    QT_DEPRECATED static bool hasPendingEvents();
#endif
    static QAbstractEventDispatcher *eventDispatcher();
    static void setEventDispatcher(QAbstractEventDispatcher *eventDispatcher);

    /+virtual+/ bool notify(QObject *, QEvent *);

    static bool startingUp();
    static bool closingDown();
#endif

    static QString applicationDirPath();
    static QString applicationFilePath();
    static qint64 applicationPid();

#ifndef QT_NO_LIBRARY
    static void setLibraryPaths(ref const(QStringList) );
    static QStringList libraryPaths();
    static void addLibraryPath(ref const(QString) );
    static void removeLibraryPath(ref const(QString) );
#endif // QT_NO_LIBRARY

#ifndef QT_NO_TRANSLATION
    static bool installTranslator(QTranslator * messageFile);
    static bool removeTranslator(QTranslator * messageFile);
#endif

    static QString translate(const(char)*  context,
                             const(char)*  key,
                             const(char)*  disambiguation = 0,
                             int n = -1);
#if QT_DEPRECATED_SINCE(5, 0)
    enum Encoding { UnicodeUTF8, Latin1, DefaultCodec = UnicodeUTF8, CodecForTr = UnicodeUTF8 }
    QT_DEPRECATED static /+inline+/ QString translate(const(char)*  context, const(char)*  key,
                             const(char)*  disambiguation, Encoding, int n = -1)
        { return translate(context, key, disambiguation, n); }
#endif

#ifndef QT_NO_QOBJECT
    static void flush();

    void installNativeEventFilter(QAbstractNativeEventFilter *filterObj);
    void removeNativeEventFilter(QAbstractNativeEventFilter *filterObj);

    static bool isQuitLockEnabled();
    static void setQuitLockEnabled(bool enabled);

public Q_SLOTS:
    static void quit();

Q_SIGNALS:
    void aboutToQuit(
#if !defined(Q_QDOC)
    QPrivateSignal
#endif
    );

    void organizationNameChanged();
    void organizationDomainChanged();
    void applicationNameChanged();
    void applicationVersionChanged();

protected:
    bool event(QEvent *);

    /+virtual+/ bool compressEvent(QEvent *, QObject *receiver, QPostEventList *);
#endif // QT_NO_QOBJECT

protected:
    QCoreApplication(QCoreApplicationPrivate &p);

#ifdef QT_NO_QOBJECT
    QScopedPointer<QCoreApplicationPrivate> d_ptr;
#endif

private:
#ifndef QT_NO_QOBJECT
    static bool sendSpontaneousEvent(QObject *receiver, QEvent *event);
    bool notifyInternal(QObject *receiver, QEvent *event);
#endif

    void init();

    static QCoreApplication *self;

    mixin Q_DISABLE_COPY;

    friend extern(C++) class QApplication;
    friend extern(C++) class QApplicationPrivate;
    friend extern(C++) class QGuiApplication;
    friend extern(C++) class QGuiApplicationPrivate;
    friend extern(C++) class QWidget;
    friend extern(C++) class QWidgetWindow;
    friend extern(C++) class QWidgetPrivate;
#ifndef QT_NO_QOBJECT
    friend extern(C++) class QEventDispatcherUNIXPrivate;
    friend extern(C++) class QCocoaEventDispatcherPrivate;
    friend bool qt_sendSpontaneousEvent(QObject*, QEvent*);
#endif
    friend export QString qAppName();
    friend extern(C++) class QClassFactory;
}

#ifndef QT_NO_QOBJECT
/+inline+/ bool QCoreApplication::sendEvent(QObject *receiver, QEvent *event)
{  if (event) event->spont = false; return self ? self->notifyInternal(receiver, event) : false; }

/+inline+/ bool QCoreApplication::sendSpontaneousEvent(QObject *receiver, QEvent *event)
{ if (event) event->spont = true; return self ? self->notifyInternal(receiver, event) : false; }
#endif

#ifdef QT_NO_DEPRECATED
#  define QT_DECLARE_DEPRECATED_TR_FUNCTIONS(context)
#else
#  define QT_DECLARE_DEPRECATED_TR_FUNCTIONS(context) \
    QT_DEPRECATED static /+inline+/ QString trUtf8(const(char)* sourceText, const(char)* disambiguation = 0, int n = -1) \
        { return QCoreApplication::translate(#context, sourceText, disambiguation, n); }
#endif

#define Q_DECLARE_TR_FUNCTIONS(context) \
public: \
    static /+inline+/ QString tr(const(char)* sourceText, const(char)* disambiguation = 0, int n = -1) \
        { return QCoreApplication::translate(#context, sourceText, disambiguation, n); } \
    QT_DECLARE_DEPRECATED_TR_FUNCTIONS(context) \
private:

typedef void (*QtStartUpFunction)();
typedef void (*QtCleanUpFunction)();

export void qAddPreRoutine(QtStartUpFunction);
export void qAddPostRoutine(QtCleanUpFunction);
export void qRemovePostRoutine(QtCleanUpFunction);
export QString qAppName();                // get application name

#define Q_COREAPP_STARTUP_FUNCTION(AFUNC) \
    static void AFUNC ## _ctor_function() {  \
        qAddPreRoutine(AFUNC);        \
    }                                 \
    Q_CONSTRUCTOR_FUNCTION(AFUNC ## _ctor_function)

#ifndef QT_NO_QOBJECT
#if defined(Q_OS_WIN) && !defined(QT_NO_DEBUG_STREAM)
export QString decodeMSG(ref const(MSG) );
export QDebug operator<<(QDebug, ref const(MSG) );
#endif
#endif

#endif // QCOREAPPLICATION_H
