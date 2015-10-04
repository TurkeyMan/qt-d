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

public import QtCore.qeasingcurve;
public import QtCore.qobject;


extern(C++) class QTimeLinePrivate;
extern(C++) class export QTimeLine : QObject
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(int, "duration", "READ", "duration", "WRITE", "setDuration");
    mixin Q_PROPERTY!(int, "updateInterval", "READ", "updateInterval", "WRITE", "setUpdateInterval");
    mixin Q_PROPERTY!(int, "currentTime", "READ", "currentTime", "WRITE", "setCurrentTime");
    mixin Q_PROPERTY!(Direction, "direction", "READ", "direction", "WRITE", "setDirection");
    mixin Q_PROPERTY!(int, "loopCount", "READ", "loopCount", "WRITE", "setLoopCount");
    mixin Q_PROPERTY!(CurveShape, "curveShape", "READ", "curveShape", "WRITE", "setCurveShape");
    mixin Q_PROPERTY!(QEasingCurve, "easingCurve", "READ", "easingCurve", "WRITE", "setEasingCurve");
public:
    enum State {
        NotRunning,
        Paused,
        Running
    }
    enum Direction {
        Forward,
        Backward
    }
    enum CurveShape {
        EaseInCurve,
        EaseOutCurve,
        EaseInOutCurve,
        LinearCurve,
        SineCurve,
        CosineCurve
    }

    explicit QTimeLine(int duration = 1000, QObject *parent = 0);
    /+virtual+/ ~QTimeLine();

    State state() const;

    int loopCount() const;
    void setLoopCount(int count);

    Direction direction() const;
    void setDirection(Direction direction);

    int duration() const;
    void setDuration(int duration);

    int startFrame() const;
    void setStartFrame(int frame);
    int endFrame() const;
    void setEndFrame(int frame);
    void setFrameRange(int startFrame, int endFrame);

    int updateInterval() const;
    void setUpdateInterval(int interval);

    CurveShape curveShape() const;
    void setCurveShape(CurveShape shape);

    QEasingCurve easingCurve() const;
    void setEasingCurve(ref const(QEasingCurve) curve);

    int currentTime() const;
    int currentFrame() const;
    qreal currentValue() const;

    int frameForTime(int msec) const;
    /+virtual+/ qreal valueForTime(int msec) const;

public Q_SLOTS:
    void start();
    void resume();
    void stop();
    void setPaused(bool paused);
    void setCurrentTime(int msec);
    void toggleDirection();

Q_SIGNALS:
    void valueChanged(qreal x
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );
    void frameChanged(int
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );
    void stateChanged(QTimeLine::State newState
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );
    void finished(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );

protected:
    void timerEvent(QTimerEvent *event);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
}

#endif

