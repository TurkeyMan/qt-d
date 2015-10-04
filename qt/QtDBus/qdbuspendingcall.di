/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtDBus module of the Qt Toolkit.
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

#ifndef QDBUSPENDINGCALL_H
#define QDBUSPENDINGCALL_H

public import qt.QtCore.qglobal;
public import qt.QtCore.qobject;
public import qt.QtCore.qshareddata;

public import qt.QtDBus.qdbusmacros;
public import qt.QtDBus.qdbusmessage;

#ifndef QT_NO_DBUS

QT_BEGIN_NAMESPACE


class QDBusConnection;
class QDBusError;
class QDBusPendingCallWatcher;

class QDBusPendingCallPrivate;
class Q_DBUS_EXPORT QDBusPendingCall
{
public:
    QDBusPendingCall(ref const(QDBusPendingCall) other);
    ~QDBusPendingCall();
    QDBusPendingCall &operator=(ref const(QDBusPendingCall) other);

    void swap(QDBusPendingCall &other) { qSwap(d, other.d); }

#ifndef Q_QDOC
    // pretend that they aren't here
    bool isFinished() const;
    void waitForFinished();

    bool isError() const;
    bool isValid() const;
    QDBusError error() const;
    QDBusMessage reply() const;
#endif

    static QDBusPendingCall fromError(ref const(QDBusError) error);
    static QDBusPendingCall fromCompletedCall(ref const(QDBusMessage) message);

protected:
    QExplicitlySharedDataPointer<QDBusPendingCallPrivate> d;
    friend class QDBusPendingCallPrivate;
    friend class QDBusPendingCallWatcher;
    friend class QDBusConnection;

    QDBusPendingCall(QDBusPendingCallPrivate *dd);

private:
    QDBusPendingCall();         // not defined
};

Q_DECLARE_SHARED(QDBusPendingCall)

class QDBusPendingCallWatcherPrivate;
class Q_DBUS_EXPORT QDBusPendingCallWatcher: public QObject, public QDBusPendingCall
{
    mixin Q_OBJECT;
public:
    explicit QDBusPendingCallWatcher(ref const(QDBusPendingCall) call, QObject *parent = 0);
    ~QDBusPendingCallWatcher();

#ifdef Q_QDOC
    // trick qdoc into thinking this method is here
    bool isFinished() const;
#endif
    void waitForFinished();     // non-/+virtual+/ override

Q_SIGNALS:
    void finished(QDBusPendingCallWatcher *self);

private:
    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_finished())
};

QT_END_NAMESPACE

#endif // QT_NO_DBUS
#endif
