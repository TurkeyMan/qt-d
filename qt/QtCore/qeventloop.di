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


extern(C++) class QEventLoopPrivate;

extern(C++) class export QEventLoop : QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

public:
    explicit QEventLoop(QObject *parent = 0);
    ~QEventLoop();

    enum ProcessEventsFlag {
        AllEvents = 0x00,
        ExcludeUserInputEvents = 0x01,
        ExcludeSocketNotifiers = 0x02,
        WaitForMoreEvents = 0x04,
        X11ExcludeTimers = 0x08,
        EventLoopExec = 0x20,
        DialogExec = 0x40
    }
    Q_DECLARE_FLAGS(ProcessEventsFlags, ProcessEventsFlag)

    bool processEvents(ProcessEventsFlags flags = AllEvents);
    void processEvents(ProcessEventsFlags flags, int maximumTime);

    int exec(ProcessEventsFlags flags = AllEvents);
    void exit(int returnCode = 0);
    bool isRunning() const;

    void wakeUp();

    bool event(QEvent *event);

public Q_SLOTS:
    void quit();
}

Q_DECLARE_OPERATORS_FOR_FLAGS(QEventLoop::ProcessEventsFlags)


extern(C++) class QEventLoopLockerPrivate;

extern(C++) class export QEventLoopLocker
{
public:
    QEventLoopLocker();
    explicit QEventLoopLocker(QEventLoop *loop);
    explicit QEventLoopLocker(QThread *thread);
    ~QEventLoopLocker();

private:
    mixin Q_DISABLE_COPY;
    QEventLoopLockerPrivate *d_ptr;
}

#endif // QEVENTLOOP_H
