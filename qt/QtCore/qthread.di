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

public import QtCore.qobject;

public import limits;


extern(C++) class QThreadData;
extern(C++) class QThreadPrivate;
extern(C++) class QAbstractEventDispatcher;

#ifndef QT_NO_THREAD
extern(C++) class export QThread : QObject
{
    mixin Q_OBJECT;
public:
    static Qt.HANDLE currentThreadId() nothrow;
    static QThread *currentThread();
    static int idealThreadCount() nothrow;
    static void yieldCurrentThread();

    explicit QThread(QObject *parent = 0);
    ~QThread();

    enum Priority {
        IdlePriority,

        LowestPriority,
        LowPriority,
        NormalPriority,
        HighPriority,
        HighestPriority,

        TimeCriticalPriority,

        InheritPriority
    }

    void setPriority(Priority priority);
    Priority priority() const;

    bool isFinished() const;
    bool isRunning() const;

    void requestInterruption();
    bool isInterruptionRequested() const;

    void setStackSize(uint stackSize);
    uint stackSize() const;

    void exit(int retcode = 0);

    QAbstractEventDispatcher *eventDispatcher() const;
    void setEventDispatcher(QAbstractEventDispatcher *eventDispatcher);

    bool event(QEvent *event);

public Q_SLOTS:
    void start(Priority = InheritPriority);
    void terminate();
    void quit();

public:
    // default argument causes thread to block indefinetely
    bool wait(unsigned long time = ULONG_MAX);

    static void sleep(unsigned long);
    static void msleep(unsigned long);
    static void usleep(unsigned long);

Q_SIGNALS:
    void started(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );
    void finished(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );

protected:
    /+virtual+/ void run();
    int exec();

    static void setTerminationEnabled(bool enabled = true);

protected:
    QThread(QThreadPrivate &dd, QObject *parent = 0);

private:
    mixin Q_DECLARE_PRIVATE;

    friend extern(C++) class QCoreApplication;
    friend extern(C++) class QThreadData;
}

#else // QT_NO_THREAD

extern(C++) class export QThread : QObject
{
public:
    static Qt.HANDLE currentThreadId() { return Qt.HANDLE(currentThread()); }
    static QThread* currentThread();

protected:
    QThread(QThreadPrivate &dd, QObject *parent = 0);

private:
    explicit QThread(QObject *parent = 0);
    static QThread *instance;

    friend extern(C++) class QCoreApplication;
    friend extern(C++) class QThreadData;
    friend extern(C++) class QAdoptedThread;
    mixin Q_DECLARE_PRIVATE;
}

#endif // QT_NO_THREAD

#endif // QTHREAD_H
