/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtNetwork module of the Qt Toolkit.
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

#ifndef QHOSTADDRESS_H
#define QHOSTADDRESS_H

public import qt.QtCore.qpair;
public import qt.QtCore.qstring;
public import qt.QtCore.qscopedpointer;
public import qt.QtNetwork.qabstractsocket;

struct sockaddr;

QT_BEGIN_NAMESPACE


class QHostAddressPrivate;

class Q_NETWORK_EXPORT QIPv6Address
{
public:
    /+inline+/ quint8 &operator [](int index) { return c[index]; }
    /+inline+/ quint8 operator [](int index) const { return c[index]; }
    quint8 c[16];
};

typedef QIPv6Address Q_IPV6ADDR;

class QHostAddress;
// qHash is a friend, but we can't use default arguments for friends (§8.3.6.4)
Q_NETWORK_EXPORT uint qHash(ref const(QHostAddress) key, uint seed = 0);

class Q_NETWORK_EXPORT QHostAddress
{
public:
    enum SpecialAddress {
        Null,
        Broadcast,
        LocalHost,
        LocalHostIPv6,
        Any,
        AnyIPv6,
        AnyIPv4
    };

    QHostAddress();
    explicit QHostAddress(quint32 ip4Addr);
    explicit QHostAddress(quint8 *ip6Addr);
    explicit QHostAddress(ref const(Q_IPV6ADDR) ip6Addr);
    explicit QHostAddress(const(sockaddr)* address);
    explicit QHostAddress(ref const(QString) address);
    QHostAddress(ref const(QHostAddress) copy);
    QHostAddress(SpecialAddress address);
    ~QHostAddress();

    QHostAddress &operator=(ref const(QHostAddress) other);
    QHostAddress &operator=(ref const(QString) address);

    void setAddress(quint32 ip4Addr);
    void setAddress(quint8 *ip6Addr);
    void setAddress(ref const(Q_IPV6ADDR) ip6Addr);
    void setAddress(const(sockaddr)* address);
    bool setAddress(ref const(QString) address);

    QAbstractSocket::NetworkLayerProtocol protocol() const;
    quint32 toIPv4Address() const;
    Q_IPV6ADDR toIPv6Address() const;

    QString toString() const;

    QString scopeId() const;
    void setScopeId(ref const(QString) id);

    bool operator ==(ref const(QHostAddress) address) const;
    bool operator ==(SpecialAddress address) const;
    /+inline+/ bool operator !=(ref const(QHostAddress) address) const
    { return !operator==(address); }
    /+inline+/ bool operator !=(SpecialAddress address) const
    { return !operator==(address); }
    bool isNull() const;
    void clear();

    bool isInSubnet(ref const(QHostAddress) subnet, int netmask) const;
    bool isInSubnet(const QPair<QHostAddress, int> &subnet) const;

    bool isLoopback() const;

    static QPair<QHostAddress, int> parseSubnet(ref const(QString) subnet);

    friend Q_NETWORK_EXPORT uint qHash(ref const(QHostAddress) key, uint seed);
protected:
    QScopedPointer<QHostAddressPrivate> d;
};

/+inline+/ bool operator ==(QHostAddress::SpecialAddress address1, ref const(QHostAddress) address2)
{ return address2 == address1; }

#ifndef QT_NO_DEBUG_STREAM
Q_NETWORK_EXPORT QDebug operator<<(QDebug, ref const(QHostAddress) );
#endif

#ifndef QT_NO_DATASTREAM
Q_NETWORK_EXPORT QDataStream &operator<<(QDataStream &, ref const(QHostAddress) );
Q_NETWORK_EXPORT QDataStream &operator>>(QDataStream &, QHostAddress &);
#endif

QT_END_NAMESPACE

#endif // QHOSTADDRESS_H
