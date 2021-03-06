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

#ifndef QNETWORKREPLY_H
#define QNETWORKREPLY_H

public import qt.QtCore.QIODevice;
public import qt.QtCore.QString;
public import qt.QtCore.QVariant;

public import qt.QtNetwork.QNetworkRequest;
public import qt.QtNetwork.QNetworkAccessManager;

QT_BEGIN_NAMESPACE


class QUrl;
class QVariant;
class QAuthenticator;
class QSslConfiguration;
class QSslError;

class QNetworkReplyPrivate;
class Q_NETWORK_EXPORT QNetworkReply: public QIODevice
{
    mixin Q_OBJECT;
    Q_ENUMS(NetworkError)
public:
    enum NetworkError {
        NoError = 0,

        // network layer errors [relating to the destination server] (1-99):
        ConnectionRefusedError = 1,
        RemoteHostClosedError,
        HostNotFoundError,
        TimeoutError,
        OperationCanceledError,
        SslHandshakeFailedError,
        TemporaryNetworkFailureError,
        NetworkSessionFailedError,
        BackgroundRequestNotAllowedError,
        UnknownNetworkError = 99,

        // proxy errors (101-199):
        ProxyConnectionRefusedError = 101,
        ProxyConnectionClosedError,
        ProxyNotFoundError,
        ProxyTimeoutError,
        ProxyAuthenticationRequiredError,
        UnknownProxyError = 199,

        // content errors (201-299):
        ContentAccessDenied = 201,
        ContentOperationNotPermittedError,
        ContentNotFoundError,
        AuthenticationRequiredError,
        ContentReSendError,
        ContentConflictError,
        ContentGoneError,
        UnknownContentError = 299,

        // protocol errors
        ProtocolUnknownError = 301,
        ProtocolInvalidOperationError,
        ProtocolFailure = 399,

        // Server side errors (401-499)
        InternalServerError = 401,
        OperationNotImplementedError,
        ServiceUnavailableError,
        UnknownServerError = 499
    };

    ~QNetworkReply();

    // reimplemented from QIODevice
    /+virtual+/ void close();
    /+virtual+/ bool isSequential() const;

    // like QAbstractSocket:
    qint64 readBufferSize() const;
    /+virtual+/ void setReadBufferSize(qint64 size);

    QNetworkAccessManager *manager() const;
    QNetworkAccessManager::Operation operation() const;
    QNetworkRequest request() const;
    NetworkError error() const;
    bool isFinished() const;
    bool isRunning() const;
    QUrl url() const;

    // "cooked" headers
    QVariant header(QNetworkRequest::KnownHeaders header) const;

    // raw headers:
    bool hasRawHeader(ref const(QByteArray) headerName) const;
    QList<QByteArray> rawHeaderList() const;
    QByteArray rawHeader(ref const(QByteArray) headerName) const;

    typedef QPair<QByteArray, QByteArray> RawHeaderPair;
    ref const(QList<RawHeaderPair>) rawHeaderPairs() const;

    // attributes
    QVariant attribute(QNetworkRequest::Attribute code) const;

#ifndef QT_NO_SSL
    QSslConfiguration sslConfiguration() const;
    void setSslConfiguration(ref const(QSslConfiguration) configuration);
    void ignoreSslErrors(ref const(QList<QSslError>) errors);
#endif

public Q_SLOTS:
    /+virtual+/ void abort() = 0;
    /+virtual+/ void ignoreSslErrors();

Q_SIGNALS:
    void metaDataChanged();
    void finished();
    void error(QNetworkReply::NetworkError);
#ifndef QT_NO_SSL
    void encrypted();
    void sslErrors(ref const(QList<QSslError>) errors);
#endif

    void uploadProgress(qint64 bytesSent, qint64 bytesTotal);
    void downloadProgress(qint64 bytesReceived, qint64 bytesTotal);

protected:
    explicit QNetworkReply(QObject *parent = 0);
    QNetworkReply(QNetworkReplyPrivate &dd, QObject *parent);
    /+virtual+/ qint64 writeData(const(char)* data, qint64 len);

    void setOperation(QNetworkAccessManager::Operation operation);
    void setRequest(ref const(QNetworkRequest) request);
    void setError(NetworkError errorCode, ref const(QString) errorString);
    void setFinished(bool);
    void setUrl(ref const(QUrl) url);
    void setHeader(QNetworkRequest::KnownHeaders header, ref const(QVariant) value);
    void setRawHeader(ref const(QByteArray) headerName, ref const(QByteArray) value);
    void setAttribute(QNetworkRequest::Attribute code, ref const(QVariant) value);

    /+virtual+/ void sslConfigurationImplementation(QSslConfiguration &) const;
    /+virtual+/ void setSslConfigurationImplementation(ref const(QSslConfiguration) );
    /+virtual+/ void ignoreSslErrorsImplementation(ref const(QList<QSslError>) );

private:
    mixin Q_DECLARE_PRIVATE;
};

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QNetworkReply::NetworkError)

#endif
