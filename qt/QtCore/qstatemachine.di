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

public import QtCore.qstate;

public import QtCore.qcoreevent;
public import QtCore.qlist;
public import QtCore.qobject;
public import QtCore.qset;
public import QtCore.qvariant;


#ifndef QT_NO_STATEMACHINE

extern(C++) class QStateMachinePrivate;
extern(C++) class QAbstractAnimation;
extern(C++) class export QStateMachine : QState
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QString, "errorString", "READ", "errorString");
    mixin Q_PROPERTY!(QState::RestorePolicy, "globalRestorePolicy", "READ", "globalRestorePolicy", "WRITE", "setGlobalRestorePolicy");
    mixin Q_PROPERTY!(bool, "running", "READ", "isRunning", "WRITE", "setRunning", "NOTIFY", "runningChanged");
#ifndef QT_NO_ANIMATION
    mixin Q_PROPERTY!(bool, "animated", "READ", "isAnimated", "WRITE", "setAnimated");
#endif
public:
    extern(C++) class export SignalEvent : QEvent
    {
    public:
        SignalEvent(QObject *sender, int signalIndex,
                     ref const(QList<QVariant>) arguments);
        ~SignalEvent();

        /+inline+/ QObject *sender() const { return m_sender; }
        /+inline+/ int signalIndex() const { return m_signalIndex; }
        /+inline+/ QList<QVariant> arguments() const { return m_arguments; }

    private:
        QObject *m_sender;
        int m_signalIndex;
        QList<QVariant> m_arguments;

        friend extern(C++) class QSignalTransitionPrivate;
    }

    extern(C++) class export WrappedEvent : QEvent
    {
    public:
        WrappedEvent(QObject *object, QEvent *event);
        ~WrappedEvent();

        /+inline+/ QObject *object() const { return m_object; }
        /+inline+/ QEvent *event() const { return m_event; }

    private:
        QObject *m_object;
        QEvent *m_event;
    }

    enum EventPriority {
        NormalPriority,
        HighPriority
    }

    enum Error {
        NoError,
        NoInitialStateError,
        NoDefaultStateInHistoryStateError,
        NoCommonAncestorForTransitionError
    }

    explicit QStateMachine(QObject *parent = 0);
    explicit QStateMachine(QState::ChildMode childMode, QObject *parent = 0);
    ~QStateMachine();

    void addState(QAbstractState *state);
    void removeState(QAbstractState *state);

    Error error() const;
    QString errorString() const;
    void clearError();

    bool isRunning() const;

#ifndef QT_NO_ANIMATION
    bool isAnimated() const;
    void setAnimated(bool enabled);

    void addDefaultAnimation(QAbstractAnimation *animation);
    QList<QAbstractAnimation *> defaultAnimations() const;
    void removeDefaultAnimation(QAbstractAnimation *animation);
#endif // QT_NO_ANIMATION

    QState::RestorePolicy globalRestorePolicy() const;
    void setGlobalRestorePolicy(QState::RestorePolicy restorePolicy);

    void postEvent(QEvent *event, EventPriority priority = NormalPriority);
    int postDelayedEvent(QEvent *event, int delay);
    bool cancelDelayedEvent(int id);

    QSet<QAbstractState*> configuration() const;

#ifndef QT_NO_STATEMACHINE_EVENTFILTER
    bool eventFilter(QObject *watched, QEvent *event);
#endif

public Q_SLOTS:
    void start();
    void stop();
    void setRunning(bool running);

Q_SIGNALS:
    void started(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );
    void stopped(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );
    void runningChanged(bool running);


protected:
    void onEntry(QEvent *event);
    void onExit(QEvent *event);

    /+virtual+/ void beginSelectTransitions(QEvent *event);
    /+virtual+/ void endSelectTransitions(QEvent *event);

    /+virtual+/ void beginMicrostep(QEvent *event);
    /+virtual+/ void endMicrostep(QEvent *event);

    bool event(QEvent *e);

protected:
    QStateMachine(QStateMachinePrivate &dd, QObject *parent);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_start())
    Q_PRIVATE_SLOT(d_func(), void _q_process())
#ifndef QT_NO_ANIMATION
    Q_PRIVATE_SLOT(d_func(), void _q_animationFinished())
#endif
    Q_PRIVATE_SLOT(d_func(), void _q_startDelayedEventTimer(int, int))
    Q_PRIVATE_SLOT(d_func(), void _q_killDelayedEventTimer(int, int))
}

#endif //QT_NO_STATEMACHINE

#endif
