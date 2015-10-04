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


#ifndef QT_NO_ANIMATION

extern(C++) class QAnimationGroup;
extern(C++) class QSequentialAnimationGroup;
extern(C++) class QAnimationDriver;

extern(C++) class QAbstractAnimationPrivate;
extern(C++) class export QAbstractAnimation : QObject
{
    mixin Q_OBJECT;
    Q_ENUMS(State)
    Q_ENUMS(Direction)
    mixin Q_PROPERTY!(State, "state", "READ", "state", "NOTIFY", "stateChanged");
    mixin Q_PROPERTY!(int, "loopCount", "READ", "loopCount", "WRITE", "setLoopCount");
    mixin Q_PROPERTY!(int, "currentTime", "READ", "currentTime", "WRITE", "setCurrentTime");
    mixin Q_PROPERTY!(int, "currentLoop", "READ", "currentLoop", "NOTIFY", "currentLoopChanged");
    mixin Q_PROPERTY!(Direction, "direction", "READ", "direction", "WRITE", "setDirection", "NOTIFY", "directionChanged");
    mixin Q_PROPERTY!(int, "duration", "READ", "duration");

public:
    enum Direction {
        Forward,
        Backward
    }

    enum State {
        Stopped,
        Paused,
        Running
    }

    enum DeletionPolicy {
        KeepWhenStopped = 0,
        DeleteWhenStopped
    }

    QAbstractAnimation(QObject *parent = 0);
    /+virtual+/ ~QAbstractAnimation();

    State state() const;

    QAnimationGroup *group() const;

    Direction direction() const;
    void setDirection(Direction direction);

    int currentTime() const;
    int currentLoopTime() const;

    int loopCount() const;
    void setLoopCount(int loopCount);
    int currentLoop() const;

    /+virtual+/ int duration() const = 0;
    int totalDuration() const;

Q_SIGNALS:
    void finished();
    void stateChanged(QAbstractAnimation::State newState, QAbstractAnimation::State oldState);
    void currentLoopChanged(int currentLoop);
    void directionChanged(QAbstractAnimation::Direction);

public Q_SLOTS:
    void start(QAbstractAnimation::DeletionPolicy policy = KeepWhenStopped);
    void pause();
    void resume();
    void setPaused(bool);
    void stop();
    void setCurrentTime(int msecs);

protected:
    QAbstractAnimation(QAbstractAnimationPrivate &dd, QObject *parent = 0);
    bool event(QEvent *event);

    /+virtual+/ void updateCurrentTime(int currentTime) = 0;
    /+virtual+/ void updateState(QAbstractAnimation::State newState, QAbstractAnimation::State oldState);
    /+virtual+/ void updateDirection(QAbstractAnimation::Direction direction);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
}

extern(C++) class QAnimationDriverPrivate;
extern(C++) class export QAnimationDriver : QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

public:
    QAnimationDriver(QObject *parent = 0);
    ~QAnimationDriver();

    /+virtual+/ void advance();

    void install();
    void uninstall();

    bool isRunning() const;

    /+virtual+/ qint64 elapsed() const;

    // ### Qt6: Remove these two functions
    void setStartTime(qint64 startTime);
    qint64 startTime() const;

Q_SIGNALS:
    void started();
    void stopped();

protected:
    // ### Qt6: Remove timestep argument
    void advanceAnimation(qint64 timeStep = -1);
    /+virtual+/ void start();
    /+virtual+/ void stop();

    QAnimationDriver(QAnimationDriverPrivate &dd, QObject *parent = 0);

private:
    friend extern(C++) class QUnifiedTimer;

}




#endif //QT_NO_ANIMATION

