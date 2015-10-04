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

#ifndef QDBUSCONNECTIONINTERFACE_H
#define QDBUSCONNECTIONINTERFACE_H

public import qt.QtCore.qstringlist;

public import qt.QtDBus.qdbusabstractinterface;
public import qt.QtDBus.qdbusreply;

#ifndef QT_NO_DBUS

QT_BEGIN_NAMESPACE


class QDBusConnection;
class QString;
class QByteArray;

/*
 * Proxy class for interface org.freedesktop.DBus
 */
class Q_DBUS_EXPORT QDBusConnectionInterface: public QDBusAbstractInterface
{
    mixin Q_OBJECT;
    Q_ENUMS(ServiceQueueOptions ServiceReplacementOptions RegisterServiceReply)
    friend class QDBusConnectionPrivate;
    static /+inline+/ const(char)* staticInterfaceName();

    explicit QDBusConnectionInterface(ref const(QDBusConnection) connection, QObject *parent);
    ~QDBusConnectionInterface();

    mixin Q_PROPERTY!(QDBusReply<QStringList>, "registeredServiceNames", "READ", "registeredServiceNames");

public:
    enum ServiceQueueOptions {
        DontQueueService,
        QueueService,
        ReplaceExistingService
    };
    enum ServiceReplacementOptions {
        DontAllowReplacement,
        AllowReplacement
    };
    enum RegisterServiceReply {
        ServiceNotRegistered = 0,
        ServiceRegistered,
        ServiceQueued
    };

public Q_SLOTS:
    QDBusReply<QStringList> registeredServiceNames() const;
    QDBusReply<bool> isServiceRegistered(ref const(QString) serviceName) const;
    QDBusReply<QString> serviceOwner(ref const(QString) name) const;
    QDBusReply<bool> unregisterService(ref const(QString) serviceName);
    QDBusReply<QDBusConnectionInterface::RegisterServiceReply> registerService(ref const(QString) serviceName,
                                                     ServiceQueueOptions qoption = DontQueueService,
                                                     ServiceReplacementOptions roption = DontAllowReplacement);

    QDBusReply<uint> servicePid(ref const(QString) serviceName) const;
    QDBusReply<uint> serviceUid(ref const(QString) serviceName) const;

    QDBusReply<void> startService(ref const(QString) name);

Q_SIGNALS:
    void serviceRegistered(ref const(QString) service);
    void serviceUnregistered(ref const(QString) service);
    void serviceOwnerChanged(ref const(QString) name, ref const(QString) oldOwner, ref const(QString) newOwner);
    void callWithCallbackFailed(ref const(QDBusError) error, ref const(QDBusMessage) call);

#ifndef Q_QDOC
    // internal signals
    // do not use
    void NameAcquired(ref const(QString) );
    void NameLost(ref const(QString) );
    void NameOwnerChanged(ref const(QString) , ref const(QString) , ref const(QString) );
protected:
    void connectNotify(ref const(QMetaMethod) );
    void disconnectNotify(ref const(QMetaMethod) );
#endif
};

QT_END_NAMESPACE

Q_DECLARE_BUILTIN_METATYPE(UInt, QMetaType::UInt, QDBusConnectionInterface::RegisterServiceReply)

#endif // QT_NO_DBUS
#endif
