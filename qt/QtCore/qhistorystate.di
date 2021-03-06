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

public import QtCore.qabstractstate;


#ifndef QT_NO_STATEMACHINE

extern(C++) class QHistoryStatePrivate;
extern(C++) class export QHistoryState : QAbstractState
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QAbstractState*, "defaultState", "READ", "defaultState", "WRITE", "setDefaultState", "NOTIFY", "defaultStateChanged");
    mixin Q_PROPERTY!(HistoryType, "historyType", "READ", "historyType", "WRITE", "setHistoryType", "NOTIFY", "historyTypeChanged");
    Q_ENUMS(HistoryType)
public:
    enum HistoryType {
        ShallowHistory,
        DeepHistory
    }

    QHistoryState(QState *parent = 0);
    QHistoryState(HistoryType type, QState *parent = 0);
    ~QHistoryState();

    QAbstractState *defaultState() const;
    void setDefaultState(QAbstractState *state);

    HistoryType historyType() const;
    void setHistoryType(HistoryType type);

Q_SIGNALS:
    void defaultStateChanged(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );
    void historyTypeChanged(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );

protected:
    void onEntry(QEvent *event);
    void onExit(QEvent *event);

    bool event(QEvent *e);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
}

#endif //QT_NO_STATEMACHINE

#endif
