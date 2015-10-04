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

#ifndef QDBUSSERVICEWATCHER_H
#define QDBUSSERVICEWATCHER_H

public import qt.QtCore.qobject;
public import qt.QtDBus.qdbusmacros;

#ifndef QT_NO_DBUS

QT_BEGIN_NAMESPACE


class QDBusConnection;

class QDBusServiceWatcherPrivate;
class Q_DBUS_EXPORT QDBusServiceWatcher: public QObject
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QStringList, "watchedServices", "READ", "watchedServices", "WRITE", "setWatchedServices");
    mixin Q_PROPERTY!(WatchMode, "watchMode", "READ", "watchMode", "WRITE", "setWatchMode");
public:
    enum WatchModeFlag {
        WatchForRegistration = 0x01,
        WatchForUnregistration = 0x02,
        WatchForOwnerChange = 0x03
    };
    Q_DECLARE_FLAGS(WatchMode, WatchModeFlag)

    explicit QDBusServiceWatcher(QObject *parent = 0);
    QDBusServiceWatcher(ref const(QString) service, ref const(QDBusConnection) connection,
                        WatchMode watchMode = WatchForOwnerChange, QObject *parent = 0);
    ~QDBusServiceWatcher();

    QStringList watchedServices() const;
    void setWatchedServices(ref const(QStringList) services);
    void addWatchedService(ref const(QString) newService);
    bool removeWatchedService(ref const(QString) service);

    WatchMode watchMode() const;
    void setWatchMode(WatchMode mode);

    QDBusConnection connection() const;
    void setConnection(ref const(QDBusConnection) connection);

Q_SIGNALS:
    void serviceRegistered(ref const(QString) service);
    void serviceUnregistered(ref const(QString) service);
    void serviceOwnerChanged(ref const(QString) service, ref const(QString) oldOwner, ref const(QString) newOwner);

private:
    Q_PRIVATE_SLOT(d_func(), void _q_serviceOwnerChanged(QString,QString,QString))
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QDBusServiceWatcher::WatchMode)

QT_END_NAMESPACE

#endif // QT_NO_DBUS
#endif // QDBUSSERVICEWATCHER_H
