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

#ifndef QDBUSERROR_H
#define QDBUSERROR_H

public import qt.QtDBus.qdbusmacros;
public import qt.QtCore.qstring;

#ifndef QT_NO_DBUS

struct DBusError;

QT_BEGIN_NAMESPACE


class QDBusMessage;

class Q_DBUS_EXPORT QDBusError
{
public:
    enum ErrorType {
        NoError = 0,
        Other = 1,
        Failed,
        NoMemory,
        ServiceUnknown,
        NoReply,
        BadAddress,
        NotSupported,
        LimitsExceeded,
        AccessDenied,
        NoServer,
        Timeout,
        NoNetwork,
        AddressInUse,
        Disconnected,
        InvalidArgs,
        UnknownMethod,
        TimedOut,
        InvalidSignature,
        UnknownInterface,
        UnknownObject,
        UnknownProperty,
        PropertyReadOnly,
        InternalError,
        InvalidService,
        InvalidObjectPath,
        InvalidInterface,
        InvalidMember,

#ifndef Q_QDOC
        // don't use this one!
        LastErrorType = InvalidMember
#endif
    };

    QDBusError();
#ifndef QT_BOOTSTRAPPED
    explicit QDBusError(const(DBusError)* error);
    /*implicit*/ QDBusError(ref const(QDBusMessage) msg);
#endif
    QDBusError(ErrorType error, ref const(QString) message);
    QDBusError(ref const(QDBusError) other);
    QDBusError &operator=(ref const(QDBusError) other);
#ifndef QT_BOOTSTRAPPED
    QDBusError &operator=(ref const(QDBusMessage) msg);
#endif

    ErrorType type() const;
    QString name() const;
    QString message() const;
    bool isValid() const;

    static QString errorString(ErrorType error);

private:
    ErrorType code;
    QString msg;
    QString nm;
    void *unused;
};

#ifndef QT_NO_DEBUG_STREAM
Q_DBUS_EXPORT QDebug operator<<(QDebug, ref const(QDBusError) );
#endif

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QDBusError)

#endif // QT_NO_DBUS
#endif