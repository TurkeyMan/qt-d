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

public import QtCore.qlist;


#ifndef QT_NO_STATEMACHINE

extern(C++) class QEvent;
extern(C++) class QAbstractState;
extern(C++) class QState;
extern(C++) class QStateMachine;

#ifndef QT_NO_ANIMATION
extern(C++) class QAbstractAnimation;
#endif

extern(C++) class QAbstractTransitionPrivate;
extern(C++) class export QAbstractTransition : QObject
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QState*, "sourceState", "READ", "sourceState");
    mixin Q_PROPERTY!(QAbstractState*, "targetState", "READ", "targetState", "WRITE", "setTargetState", "NOTIFY", "targetStateChanged");
    mixin Q_PROPERTY!(QList<QAbstractState*>, "targetStates", "READ", "targetStates", "WRITE", "setTargetStates", "NOTIFY", "targetStatesChanged");
public:
    QAbstractTransition(QState *sourceState = 0);
    /+virtual+/ ~QAbstractTransition();

    QState *sourceState() const;
    QAbstractState *targetState() const;
    void setTargetState(QAbstractState* target);
    QList<QAbstractState*> targetStates() const;
    void setTargetStates(ref const(QList<QAbstractState*>) targets);

    QStateMachine *machine() const;

#ifndef QT_NO_ANIMATION
    void addAnimation(QAbstractAnimation *animation);
    void removeAnimation(QAbstractAnimation *animation);
    QList<QAbstractAnimation*> animations() const;
#endif

Q_SIGNALS:
    void triggered(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );
    void targetStateChanged(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );
    void targetStatesChanged(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );

protected:
    /+virtual+/ bool eventTest(QEvent *event) = 0;

    /+virtual+/ void onTransition(QEvent *event) = 0;

    bool event(QEvent *e);

protected:
    QAbstractTransition(QAbstractTransitionPrivate &dd, QState *parent);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
}

#endif //QT_NO_STATEMACHINE

#endif
