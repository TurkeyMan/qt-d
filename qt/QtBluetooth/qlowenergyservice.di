/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Copyright (C) 2013 Javier S. Pedro <maemo@javispedro.com>
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
#ifndef QLOWENERGYSERVICE_H
#define QLOWENERGYSERVICE_H

public import qt.QtBluetooth.QBluetoothAddress;
public import qt.QtBluetooth.QBluetoothUuid;
public import qt.QtBluetooth.QLowEnergyCharacteristic;

QT_BEGIN_NAMESPACE

class QLowEnergyServicePrivate;
class QLowEnergyControllerPrivate;
class Q_BLUETOOTH_EXPORT QLowEnergyService : public QObject
{
    mixin Q_OBJECT;
public:
    enum ServiceType {
        PrimaryService = 0x0001,
        IncludedService = 0x0002
    };
    Q_DECLARE_FLAGS(ServiceTypes, ServiceType)

    enum ServiceError {
        NoError = 0,
        OperationError,
        CharacteristicWriteError,
        DescriptorWriteError
    };

    enum ServiceState {
        InvalidService = 0,
        DiscoveryRequired,  // we know start/end handle but nothing more
        //TODO Rename DiscoveringServices -> DiscoveringDetails or DiscoveringService
        DiscoveringServices,// discoverDetails() called and running
        ServiceDiscovered,  // all details have been synchronized
    };

    enum WriteMode {
        WriteWithResponse = 0,
        WriteWithoutResponse
    };

    ~QLowEnergyService();

    QList<QBluetoothUuid> includedServices() const;

    QLowEnergyService::ServiceTypes type() const;
    QLowEnergyService::ServiceState state() const;

    QLowEnergyCharacteristic characteristic(ref const(QBluetoothUuid) uuid) const;
    QList<QLowEnergyCharacteristic> characteristics() const;
    QBluetoothUuid serviceUuid() const;
    QString serviceName() const;

    void discoverDetails();

    ServiceError error() const;

    bool contains(ref const(QLowEnergyCharacteristic) characteristic) const;
    void writeCharacteristic(ref const(QLowEnergyCharacteristic) characteristic,
                             ref const(QByteArray) newValue,
                             WriteMode mode = WriteWithResponse);

    bool contains(ref const(QLowEnergyDescriptor) descriptor) const;
    void writeDescriptor(ref const(QLowEnergyDescriptor) descriptor,
                         ref const(QByteArray) newValue);

Q_SIGNALS:
    void stateChanged(QLowEnergyService::ServiceState newState);
    void characteristicChanged(ref const(QLowEnergyCharacteristic) info,
                               ref const(QByteArray) value);
    void characteristicWritten(ref const(QLowEnergyCharacteristic) info,
                               ref const(QByteArray) value);
    void descriptorWritten(ref const(QLowEnergyDescriptor) info,
                           ref const(QByteArray) value);
    void error(QLowEnergyService::ServiceError error);

private:
    mixin Q_DECLARE_PRIVATE;
    QSharedPointer<QLowEnergyServicePrivate> d_ptr;

    // QLowEnergyController is the factory for this class
    friend class QLowEnergyController;
    QLowEnergyService(QSharedPointer<QLowEnergyServicePrivate> p,
                      QObject *parent = 0);
};

QT_END_NAMESPACE

#endif // QLOWENERGYSERVICE_H
