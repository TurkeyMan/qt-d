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

#ifndef QNETWORKACCESSMANAGER_H
#define QNETWORKACCESSMANAGER_H

public import qt.QtCore.QObject;
#ifndef QT_NO_SSL
public import qt.QtNetwork.QSslConfiguration;
#endif

QT_BEGIN_NAMESPACE


class QIODevice;
class QAbstractNetworkCache;
class QAuthenticator;
class QByteArray;
template<typename T> class QList;
class QNetworkCookie;
class QNetworkCookieJar;
class QNetworkRequest;
class QNetworkReply;
class QNetworkProxy;
class QNetworkProxyFactory;
class QSslError;
#ifndef QT_NO_BEARERMANAGEMENT
class QNetworkConfiguration;
#endif
class QHttpMultiPart;

class QNetworkReplyImplPrivate;
class QNetworkAccessManagerPrivate;
class Q_NETWORK_EXPORT QNetworkAccessManager: public QObject
{
    mixin Q_OBJECT;

#ifndef QT_NO_BEARERMANAGEMENT
    mixin Q_PROPERTY!(NetworkAccessibility, "networkAccessible", "READ", "networkAccessible", "WRITE", "setNetworkAccessible", "NOTIFY", "networkAccessibleChanged");
#endif

public:
    enum Operation {
        HeadOperation = 1,
        GetOperation,
        PutOperation,
        PostOperation,
        DeleteOperation,
        CustomOperation,

        UnknownOperation = 0
    };

#ifndef QT_NO_BEARERMANAGEMENT
    enum NetworkAccessibility {
        UnknownAccessibility = -1,
        NotAccessible = 0,
        Accessible = 1
    };
#endif

    explicit QNetworkAccessManager(QObject *parent = 0);
    ~QNetworkAccessManager();

    // ### Qt 6: turn into virtual
    QStringList supportedSchemes() const;

    void clearAccessCache();

#ifndef QT_NO_NETWORKPROXY
    QNetworkProxy proxy() const;
    void setProxy(ref const(QNetworkProxy) proxy);
    QNetworkProxyFactory *proxyFactory() const;
    void setProxyFactory(QNetworkProxyFactory *factory);
#endif

    QAbstractNetworkCache *cache() const;
    void setCache(QAbstractNetworkCache *cache);

    QNetworkCookieJar *cookieJar() const;
    void setCookieJar(QNetworkCookieJar *cookieJar);

    QNetworkReply *head(ref const(QNetworkRequest) request);
    QNetworkReply *get(ref const(QNetworkRequest) request);
    QNetworkReply *post(ref const(QNetworkRequest) request, QIODevice *data);
    QNetworkReply *post(ref const(QNetworkRequest) request, ref const(QByteArray) data);
    QNetworkReply *post(ref const(QNetworkRequest) request, QHttpMultiPart *multiPart);
    QNetworkReply *put(ref const(QNetworkRequest) request, QIODevice *data);
    QNetworkReply *put(ref const(QNetworkRequest) request, ref const(QByteArray) data);
    QNetworkReply *put(ref const(QNetworkRequest) request, QHttpMultiPart *multiPart);
    QNetworkReply *deleteResource(ref const(QNetworkRequest) request);
    QNetworkReply *sendCustomRequest(ref const(QNetworkRequest) request, ref const(QByteArray) verb, QIODevice *data = 0);

#ifndef QT_NO_BEARERMANAGEMENT
    void setConfiguration(ref const(QNetworkConfiguration) config);
    QNetworkConfiguration configuration() const;
    QNetworkConfiguration activeConfiguration() const;

    void setNetworkAccessible(NetworkAccessibility accessible);
    NetworkAccessibility networkAccessible() const;
#endif

#ifndef QT_NO_SSL
    void connectToHostEncrypted(ref const(QString) hostName, quint16 port = 443,
                                ref const(QSslConfiguration) sslConfiguration = QSslConfiguration::defaultConfiguration());
#endif
    void connectToHost(ref const(QString) hostName, quint16 port = 80);

Q_SIGNALS:
#ifndef QT_NO_NETWORKPROXY
    void proxyAuthenticationRequired(ref const(QNetworkProxy) proxy, QAuthenticator *authenticator);
#endif
    void authenticationRequired(QNetworkReply *reply, QAuthenticator *authenticator);
    void finished(QNetworkReply *reply);
#ifndef QT_NO_SSL
    void encrypted(QNetworkReply *reply);
    void sslErrors(QNetworkReply *reply, ref const(QList<QSslError>) errors);
#endif

#ifndef QT_NO_BEARERMANAGEMENT
    void networkSessionConnected();

    void networkAccessibleChanged(QNetworkAccessManager::NetworkAccessibility accessible);
#endif

protected:
    /+virtual+/ QNetworkReply *createRequest(Operation op, ref const(QNetworkRequest) request,
                                         QIODevice *outgoingData = 0);

protected Q_SLOTS:
    QStringList supportedSchemesImplementation() const;

private:
    friend class QNetworkReplyImplPrivate;
    friend class QNetworkReplyHttpImpl;
    friend class QNetworkReplyHttpImplPrivate;

    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_replyFinished())
    Q_PRIVATE_SLOT(d_func(), void _q_replyEncrypted())
    Q_PRIVATE_SLOT(d_func(), void _q_replySslErrors(QList<QSslError>))
#ifndef QT_NO_BEARERMANAGEMENT
    Q_PRIVATE_SLOT(d_func(), void _q_networkSessionClosed())
    Q_PRIVATE_SLOT(d_func(), void _q_networkSessionStateChanged(QNetworkSession::State))
    Q_PRIVATE_SLOT(d_func(), void _q_onlineStateChanged(bool))
#endif
};

QT_END_NAMESPACE

#endif
