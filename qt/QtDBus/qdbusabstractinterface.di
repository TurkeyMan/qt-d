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

#ifndef QDBUSABSTRACTINTERFACE_H
#define QDBUSABSTRACTINTERFACE_H

public import qt.QtCore.qstring;
public import qt.QtCore.qvariant;
public import qt.QtCore.qlist;
public import qt.QtCore.qobject;

public import qt.QtDBus.qdbusmessage;
public import qt.QtDBus.qdbusextratypes;
public import qt.QtDBus.qdbusconnection;

#ifndef QT_NO_DBUS

QT_BEGIN_NAMESPACE


class QDBusError;
class QDBusPendingCall;

class QDBusAbstractInterfacePrivate;

class Q_DBUS_EXPORT QDBusAbstractInterfaceBase: public QObject
{
public:
    int qt_metacall(QMetaObject::Call, int, void**);
protected:
    QDBusAbstractInterfaceBase(QDBusAbstractInterfacePrivate &dd, QObject *parent);
private:
    mixin Q_DECLARE_PRIVATE;
};

class Q_DBUS_EXPORT QDBusAbstractInterface:
#ifdef Q_QDOC
        public QObject
#else
        public QDBusAbstractInterfaceBase
#endif
{
    mixin Q_OBJECT;

public:
    /+virtual+/ ~QDBusAbstractInterface();
    bool isValid() const;

    QDBusConnection connection() const;

    QString service() const;
    QString path() const;
    QString interface() const;

    QDBusError lastError() const;

    void setTimeout(int timeout);
    int timeout() const;

    QDBusMessage call(ref const(QString) method,
                      ref const(QVariant) arg1 = QVariant(),
                      ref const(QVariant) arg2 = QVariant(),
                      ref const(QVariant) arg3 = QVariant(),
                      ref const(QVariant) arg4 = QVariant(),
                      ref const(QVariant) arg5 = QVariant(),
                      ref const(QVariant) arg6 = QVariant(),
                      ref const(QVariant) arg7 = QVariant(),
                      ref const(QVariant) arg8 = QVariant());

    QDBusMessage call(QDBus::CallMode mode,
                      ref const(QString) method,
                      ref const(QVariant) arg1 = QVariant(),
                      ref const(QVariant) arg2 = QVariant(),
                      ref const(QVariant) arg3 = QVariant(),
                      ref const(QVariant) arg4 = QVariant(),
                      ref const(QVariant) arg5 = QVariant(),
                      ref const(QVariant) arg6 = QVariant(),
                      ref const(QVariant) arg7 = QVariant(),
                      ref const(QVariant) arg8 = QVariant());

    QDBusMessage callWithArgumentList(QDBus::CallMode mode,
                                      ref const(QString) method,
                                      ref const(QList<QVariant>) args);

    bool callWithCallback(ref const(QString) method,
                          ref const(QList<QVariant>) args,
                          QObject *receiver, const(char)* member, const(char)* errorSlot);
    bool callWithCallback(ref const(QString) method,
                          ref const(QList<QVariant>) args,
                          QObject *receiver, const(char)* member);

    QDBusPendingCall asyncCall(ref const(QString) method,
                               ref const(QVariant) arg1 = QVariant(),
                               ref const(QVariant) arg2 = QVariant(),
                               ref const(QVariant) arg3 = QVariant(),
                               ref const(QVariant) arg4 = QVariant(),
                               ref const(QVariant) arg5 = QVariant(),
                               ref const(QVariant) arg6 = QVariant(),
                               ref const(QVariant) arg7 = QVariant(),
                               ref const(QVariant) arg8 = QVariant());
    QDBusPendingCall asyncCallWithArgumentList(ref const(QString) method,
                                               ref const(QList<QVariant>) args);

protected:
    QDBusAbstractInterface(ref const(QString) service, ref const(QString) path, const(char)* interface,
                           ref const(QDBusConnection) connection, QObject *parent);
    QDBusAbstractInterface(QDBusAbstractInterfacePrivate &, QObject *parent);

    void connectNotify(ref const(QMetaMethod) signal);
    void disconnectNotify(ref const(QMetaMethod) signal);
    QVariant internalPropGet(const(char)* propname) const;
    void internalPropSet(const(char)* propname, ref const(QVariant) value);
    QDBusMessage internalConstCall(QDBus::CallMode mode,
                                   ref const(QString) method,
                                   ref const(QList<QVariant>) args = QList<QVariant>()) const;

private:
    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_serviceOwnerChanged(QString,QString,QString))
};

QT_END_NAMESPACE

#endif // QT_NO_DBUS
#endif
