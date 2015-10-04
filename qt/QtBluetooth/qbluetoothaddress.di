/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtBluetooth module of the Qt Toolkit.
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

#ifndef QBLUETOOTHADDRESS_H
#define QBLUETOOTHADDRESS_H

public import qt.QtBluetooth.qbluetoothglobal;

public import qt.QtCore.QByteArray;
public import qt.QtCore.QString;
public import qt.QtCore.QMetaType;

QT_BEGIN_NAMESPACE

class QBluetoothAddressPrivate;

class Q_BLUETOOTH_EXPORT QBluetoothAddress
{
public:
    QBluetoothAddress();
    explicit QBluetoothAddress(quint64 address);
    explicit QBluetoothAddress(ref const(QString) address);
    QBluetoothAddress(ref const(QBluetoothAddress) other);
    ~QBluetoothAddress();

    QBluetoothAddress &operator=(ref const(QBluetoothAddress) other);

    bool isNull() const;

    void clear();

    bool operator<(ref const(QBluetoothAddress) other) const;
    bool operator==(ref const(QBluetoothAddress) other) const;
    /+inline+/ bool operator!=(ref const(QBluetoothAddress) other) const
    {
        return !operator==(other);
    }

    quint64 toUInt64() const;
    QString toString() const;

private:
    mixin Q_DECLARE_PRIVATE;
    QBluetoothAddressPrivate *d_ptr;
};

#ifndef QT_NO_DEBUG_STREAM
Q_BLUETOOTH_EXPORT QDebug operator<<(QDebug, ref const(QBluetoothAddress) address);
#endif

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QBluetoothAddress)

#endif