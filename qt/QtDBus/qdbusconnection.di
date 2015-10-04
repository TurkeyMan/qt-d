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

#ifndef QDBUSCONNECTION_H
#define QDBUSCONNECTION_H

public import qt.QtDBus.qdbusmacros;
public import qt.QtCore.qstring;

#ifndef QT_NO_DBUS

QT_BEGIN_NAMESPACE


namespace QDBus
{
    enum CallMode {
        NoBlock,
        Block,
        BlockWithGui,
        AutoDetect
    };
}

class QDBusAbstractInterfacePrivate;
class QDBusInterface;
class QDBusError;
class QDBusMessage;
class QDBusPendingCall;
class QDBusConnectionInterface;
class QDBusVirtualObject;
class QObject;

class QDBusConnectionPrivate;
class Q_DBUS_EXPORT QDBusConnection
{
    Q_GADGET
    Q_ENUMS(BusType UnregisterMode)
    Q_FLAGS(RegisterOptions)
public:
    enum BusType { SessionBus, SystemBus, ActivationBus };
    enum RegisterOption {
        ExportAdaptors = 0x01,

        ExportScriptableSlots = 0x10,
        ExportScriptableSignals = 0x20,
        ExportScriptableProperties = 0x40,
        ExportScriptableInvokables = 0x80,
        ExportScriptableContents = 0xf0,

        ExportNonScriptableSlots = 0x100,
        ExportNonScriptableSignals = 0x200,
        ExportNonScriptableProperties = 0x400,
        ExportNonScriptableInvokables = 0x800,
        ExportNonScriptableContents = 0xf00,

        ExportAllSlots = ExportScriptableSlots|ExportNonScriptableSlots,
        ExportAllSignals = ExportScriptableSignals|ExportNonScriptableSignals,
        ExportAllProperties = ExportScriptableProperties|ExportNonScriptableProperties,
        ExportAllInvokables = ExportScriptableInvokables|ExportNonScriptableInvokables,
        ExportAllContents = ExportScriptableContents|ExportNonScriptableContents,

#ifndef Q_QDOC
        // Qt 4.2 had a misspelling here
        ExportAllSignal = ExportAllSignals,
#endif
        ExportChildObjects = 0x1000
        // Reserved = 0xff000000
    };
    enum UnregisterMode {
        UnregisterNode,
        UnregisterTree
    };
    Q_DECLARE_FLAGS(RegisterOptions, RegisterOption)

    enum VirtualObjectRegisterOption {
        SingleNode = 0x0,
        SubPath = 0x1
        // Reserved = 0xff000000
    };
#ifndef Q_QDOC
    Q_DECLARE_FLAGS(VirtualObjectRegisterOptions, VirtualObjectRegisterOption)
#endif

    enum ConnectionCapability {
        UnixFileDescriptorPassing = 0x0001
    };
    Q_DECLARE_FLAGS(ConnectionCapabilities, ConnectionCapability)

    explicit QDBusConnection(ref const(QString) name);
    QDBusConnection(ref const(QDBusConnection) other);
    ~QDBusConnection();

    QDBusConnection &operator=(ref const(QDBusConnection) other);

    bool isConnected() const;
    QString baseService() const;
    QDBusError lastError() const;
    QString name() const;
    ConnectionCapabilities connectionCapabilities() const;

    bool send(ref const(QDBusMessage) message) const;
    bool callWithCallback(ref const(QDBusMessage) message, QObject *receiver,
                          const(char)* returnMethod, const(char)* errorMethod,
                          int timeout = -1) const;
    bool callWithCallback(ref const(QDBusMessage) message, QObject *receiver,
                          const(char)* slot, int timeout = -1) const;
    QDBusMessage call(ref const(QDBusMessage) message, QDBus::CallMode mode = QDBus::Block,
                      int timeout = -1) const;
    QDBusPendingCall asyncCall(ref const(QDBusMessage) message, int timeout = -1) const;

    bool connect(ref const(QString) service, ref const(QString) path, ref const(QString) interface,
                 ref const(QString) name, QObject *receiver, const(char)* slot);
    bool connect(ref const(QString) service, ref const(QString) path, ref const(QString) interface,
                 ref const(QString) name, ref const(QString) signature,
                 QObject *receiver, const(char)* slot);
    bool connect(ref const(QString) service, ref const(QString) path, ref const(QString) interface,
                 ref const(QString) name, ref const(QStringList) argumentMatch, ref const(QString) signature,
                 QObject *receiver, const(char)* slot);

    bool disconnect(ref const(QString) service, ref const(QString) path, ref const(QString) interface,
                    ref const(QString) name, QObject *receiver, const(char)* slot);
    bool disconnect(ref const(QString) service, ref const(QString) path, ref const(QString) interface,
                    ref const(QString) name, ref const(QString) signature,
                    QObject *receiver, const(char)* slot);
    bool disconnect(ref const(QString) service, ref const(QString) path, ref const(QString) interface,
                    ref const(QString) name, ref const(QStringList) argumentMatch, ref const(QString) signature,
                    QObject *receiver, const(char)* slot);

    bool registerObject(ref const(QString) path, QObject *object,
                        RegisterOptions options = ExportAdaptors);
    void unregisterObject(ref const(QString) path, UnregisterMode mode = UnregisterNode);
    QObject *objectRegisteredAt(ref const(QString) path) const;

    bool registerVirtualObject(ref const(QString) path, QDBusVirtualObject *object,
                          VirtualObjectRegisterOption options = SingleNode);

    bool registerService(ref const(QString) serviceName);
    bool unregisterService(ref const(QString) serviceName);

    QDBusConnectionInterface *interface() const;

    void *internalPointer() const;

    static QDBusConnection connectToBus(BusType type, ref const(QString) name);
    static QDBusConnection connectToBus(ref const(QString) address, ref const(QString) name);
    static QDBusConnection connectToPeer(ref const(QString) address, ref const(QString) name);
    static void disconnectFromBus(ref const(QString) name);
    static void disconnectFromPeer(ref const(QString) name);

    static QByteArray localMachineId();

    static QDBusConnection sessionBus();
    static QDBusConnection systemBus();

    static QDBusConnection sender();

protected:
    explicit QDBusConnection(QDBusConnectionPrivate *dd);

private:
    friend class QDBusConnectionPrivate;
    QDBusConnectionPrivate *d;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QDBusConnection::RegisterOptions)
Q_DECLARE_OPERATORS_FOR_FLAGS(QDBusConnection::VirtualObjectRegisterOptions)

QT_END_NAMESPACE

#endif // QT_NO_DBUS
#endif
