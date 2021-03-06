/***************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Copyright (C) 2013 BlackBerry Limited all rights reserved
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

#ifndef QLOWENERGYCHARACTERISTIC_H
#define QLOWENERGYCHARACTERISTIC_H
public import qt.QtCore.QSharedPointer;
public import qt.QtCore.QObject;
public import qt.QtBluetooth.qbluetooth;
public import qt.QtBluetooth.QBluetoothUuid;
public import qt.QtBluetooth.QLowEnergyDescriptor;

QT_BEGIN_NAMESPACE

class QBluetoothUuid;
class QLowEnergyServicePrivate;
struct QLowEnergyCharacteristicPrivate;
class Q_BLUETOOTH_EXPORT QLowEnergyCharacteristic
{
public:

    enum PropertyType {
        Unknown = 0x00,
        Broadcasting = 0x01,
        Read = 0x02,
        WriteNoResponse = 0x04,
        Write = 0x08,
        Notify = 0x10,
        Indicate = 0x20,
        WriteSigned = 0x40,
        ExtendedProperty = 0x80
    };
    Q_DECLARE_FLAGS(PropertyTypes, PropertyType)

    QLowEnergyCharacteristic();
    QLowEnergyCharacteristic(ref const(QLowEnergyCharacteristic) other);
    ~QLowEnergyCharacteristic();

    QLowEnergyCharacteristic &operator=(ref const(QLowEnergyCharacteristic) other);
    bool operator==(ref const(QLowEnergyCharacteristic) other) const;
    bool operator!=(ref const(QLowEnergyCharacteristic) other) const;

    QString name() const;

    QBluetoothUuid uuid() const;

    QByteArray value() const;

    QLowEnergyCharacteristic::PropertyTypes properties() const;
    QLowEnergyHandle handle() const;

    QLowEnergyDescriptor descriptor(ref const(QBluetoothUuid) uuid) const;
    QList<QLowEnergyDescriptor> descriptors() const;

    bool isValid() const;

protected:
    QLowEnergyHandle attributeHandle() const;

    QSharedPointer<QLowEnergyServicePrivate> d_ptr;

    friend class QLowEnergyService;
    friend class QLowEnergyControllerPrivate;
    QLowEnergyCharacteristicPrivate *data;
    QLowEnergyCharacteristic(QSharedPointer<QLowEnergyServicePrivate> p,
                             QLowEnergyHandle handle);
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QLowEnergyCharacteristic::PropertyTypes)

QT_END_NAMESPACE

#endif // QLOWENERGYCHARACTERISTIC_H
