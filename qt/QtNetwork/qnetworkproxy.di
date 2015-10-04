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

#ifndef QNETWORKPROXY_H
#define QNETWORKPROXY_H

public import qt.QtNetwork.qhostaddress;
public import qt.QtNetwork.qnetworkrequest;
public import qt.QtCore.qshareddata;

#ifndef QT_NO_NETWORKPROXY

QT_BEGIN_NAMESPACE


class QUrl;
class QNetworkConfiguration;

class QNetworkProxyQueryPrivate;
class Q_NETWORK_EXPORT QNetworkProxyQuery
{
public:
    enum QueryType {
        TcpSocket,
        UdpSocket,
        TcpServer = 100,
        UrlRequest
    };

    QNetworkProxyQuery();
    explicit QNetworkProxyQuery(ref const(QUrl) requestUrl, QueryType queryType = UrlRequest);
    QNetworkProxyQuery(ref const(QString) hostname, int port, ref const(QString) protocolTag = QString(),
                       QueryType queryType = TcpSocket);
    explicit QNetworkProxyQuery(quint16 bindPort, ref const(QString) protocolTag = QString(),
                       QueryType queryType = TcpServer);
    QNetworkProxyQuery(ref const(QNetworkProxyQuery) other);
#ifndef QT_NO_BEARERMANAGEMENT
    QNetworkProxyQuery(ref const(QNetworkConfiguration) networkConfiguration,
                       ref const(QUrl) requestUrl, QueryType queryType = UrlRequest);
    QNetworkProxyQuery(ref const(QNetworkConfiguration) networkConfiguration,
                       ref const(QString) hostname, int port, ref const(QString) protocolTag = QString(),
                       QueryType queryType = TcpSocket);
    QNetworkProxyQuery(ref const(QNetworkConfiguration) networkConfiguration,
                       quint16 bindPort, ref const(QString) protocolTag = QString(),
                       QueryType queryType = TcpServer);
#endif
    ~QNetworkProxyQuery();
    QNetworkProxyQuery &operator=(ref const(QNetworkProxyQuery) other);

    void swap(QNetworkProxyQuery &other) { qSwap(d, other.d); }

    bool operator==(ref const(QNetworkProxyQuery) other) const;
    /+inline+/ bool operator!=(ref const(QNetworkProxyQuery) other) const
    { return !(*this == other); }

    QueryType queryType() const;
    void setQueryType(QueryType type);

    int peerPort() const;
    void setPeerPort(int port);

    QString peerHostName() const;
    void setPeerHostName(ref const(QString) hostname);

    int localPort() const;
    void setLocalPort(int port);

    QString protocolTag() const;
    void setProtocolTag(ref const(QString) protocolTag);

    QUrl url() const;
    void setUrl(ref const(QUrl) url);

#ifndef QT_NO_BEARERMANAGEMENT
    QNetworkConfiguration networkConfiguration() const;
    void setNetworkConfiguration(ref const(QNetworkConfiguration) networkConfiguration);
#endif

private:
    QSharedDataPointer<QNetworkProxyQueryPrivate> d;
};

Q_DECLARE_SHARED(QNetworkProxyQuery)

class QNetworkProxyPrivate;

class Q_NETWORK_EXPORT QNetworkProxy
{
public:
    enum ProxyType {
        DefaultProxy,
        Socks5Proxy,
        NoProxy,
        HttpProxy,
        HttpCachingProxy,
        FtpCachingProxy
    };

    enum Capability {
        TunnelingCapability = 0x0001,
        ListeningCapability = 0x0002,
        UdpTunnelingCapability = 0x0004,
        CachingCapability = 0x0008,
        HostNameLookupCapability = 0x0010
    };
    Q_DECLARE_FLAGS(Capabilities, Capability)

    QNetworkProxy();
    QNetworkProxy(ProxyType type, ref const(QString) hostName = QString(), quint16 port = 0,
                  ref const(QString) user = QString(), ref const(QString) password = QString());
    QNetworkProxy(ref const(QNetworkProxy) other);
    QNetworkProxy &operator=(ref const(QNetworkProxy) other);
    ~QNetworkProxy();

    void swap(QNetworkProxy &other) { qSwap(d, other.d); }

    bool operator==(ref const(QNetworkProxy) other) const;
    /+inline+/ bool operator!=(ref const(QNetworkProxy) other) const
    { return !(*this == other); }

    void setType(QNetworkProxy::ProxyType type);
    QNetworkProxy::ProxyType type() const;

    void setCapabilities(Capabilities capab);
    Capabilities capabilities() const;
    bool isCachingProxy() const;
    bool isTransparentProxy() const;

    void setUser(ref const(QString) userName);
    QString user() const;

    void setPassword(ref const(QString) password);
    QString password() const;

    void setHostName(ref const(QString) hostName);
    QString hostName() const;

    void setPort(quint16 port);
    quint16 port() const;

    static void setApplicationProxy(ref const(QNetworkProxy) proxy);
    static QNetworkProxy applicationProxy();

    // "cooked" headers
    QVariant header(QNetworkRequest::KnownHeaders header) const;
    void setHeader(QNetworkRequest::KnownHeaders header, ref const(QVariant) value);

    // raw headers:
    bool hasRawHeader(ref const(QByteArray) headerName) const;
    QList<QByteArray> rawHeaderList() const;
    QByteArray rawHeader(ref const(QByteArray) headerName) const;
    void setRawHeader(ref const(QByteArray) headerName, ref const(QByteArray) value);

private:
    QSharedDataPointer<QNetworkProxyPrivate> d;
};

Q_DECLARE_SHARED(QNetworkProxy)
Q_DECLARE_OPERATORS_FOR_FLAGS(QNetworkProxy::Capabilities)

class Q_NETWORK_EXPORT QNetworkProxyFactory
{
public:
    QNetworkProxyFactory();
    /+virtual+/ ~QNetworkProxyFactory();

    /+virtual+/ QList<QNetworkProxy> queryProxy(ref const(QNetworkProxyQuery) query = QNetworkProxyQuery()) = 0;

    static void setUseSystemConfiguration(bool enable);
    static void setApplicationProxyFactory(QNetworkProxyFactory *factory);
    static QList<QNetworkProxy> proxyForQuery(ref const(QNetworkProxyQuery) query);
    static QList<QNetworkProxy> systemProxyForQuery(ref const(QNetworkProxyQuery) query = QNetworkProxyQuery());
};

#ifndef QT_NO_DEBUG_STREAM
Q_NETWORK_EXPORT QDebug operator<<(QDebug debug, ref const(QNetworkProxy) proxy);
#endif

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QNetworkProxy)

#endif // QT_NO_NETWORKPROXY

#endif // QHOSTINFO_H
