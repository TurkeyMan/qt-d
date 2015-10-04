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

#ifndef QNETWORKREQUEST_H
#define QNETWORKREQUEST_H

public import qt.QtCore.QSharedDataPointer;
public import qt.QtCore.QString;
public import qt.QtCore.QUrl;
public import qt.QtCore.QVariant;

QT_BEGIN_NAMESPACE


class QSslConfiguration;

class QNetworkRequestPrivate;
class Q_NETWORK_EXPORT QNetworkRequest
{
public:
    enum KnownHeaders {
        ContentTypeHeader,
        ContentLengthHeader,
        LocationHeader,
        LastModifiedHeader,
        CookieHeader,
        SetCookieHeader,
        ContentDispositionHeader,  // added for QMultipartMessage
        UserAgentHeader,
        ServerHeader
    };
    enum Attribute {
        HttpStatusCodeAttribute,
        HttpReasonPhraseAttribute,
        RedirectionTargetAttribute,
        ConnectionEncryptedAttribute,
        CacheLoadControlAttribute,
        CacheSaveControlAttribute,
        SourceIsFromCacheAttribute,
        DoNotBufferUploadDataAttribute,
        HttpPipeliningAllowedAttribute,
        HttpPipeliningWasUsedAttribute,
        CustomVerbAttribute,
        CookieLoadControlAttribute,
        AuthenticationReuseAttribute,
        CookieSaveControlAttribute,
        MaximumDownloadBufferSizeAttribute, // internal
        DownloadBufferAttribute, // internal
        SynchronousRequestAttribute, // internal
        BackgroundRequestAttribute,
        SpdyAllowedAttribute,
        SpdyWasUsedAttribute,

        User = 1000,
        UserMax = 32767
    };
    enum CacheLoadControl {
        AlwaysNetwork,
        PreferNetwork,
        PreferCache,
        AlwaysCache
    };
    enum LoadControl {
        Automatic = 0,
        Manual
    };

    enum Priority {
        HighPriority = 1,
        NormalPriority = 3,
        LowPriority = 5
    };

    explicit QNetworkRequest(ref const(QUrl) url = QUrl());
    QNetworkRequest(ref const(QNetworkRequest) other);
    ~QNetworkRequest();
    QNetworkRequest &operator=(ref const(QNetworkRequest) other);

    /+inline+/ void swap(QNetworkRequest &other) { qSwap(d, other.d); }

    bool operator==(ref const(QNetworkRequest) other) const;
    /+inline+/ bool operator!=(ref const(QNetworkRequest) other) const
    { return !operator==(other); }

    QUrl url() const;
    void setUrl(ref const(QUrl) url);

    // "cooked" headers
    QVariant header(KnownHeaders header) const;
    void setHeader(KnownHeaders header, ref const(QVariant) value);

    // raw headers:
    bool hasRawHeader(ref const(QByteArray) headerName) const;
    QList<QByteArray> rawHeaderList() const;
    QByteArray rawHeader(ref const(QByteArray) headerName) const;
    void setRawHeader(ref const(QByteArray) headerName, ref const(QByteArray) value);

    // attributes
    QVariant attribute(Attribute code, ref const(QVariant) defaultValue = QVariant()) const;
    void setAttribute(Attribute code, ref const(QVariant) value);

#ifndef QT_NO_SSL
    QSslConfiguration sslConfiguration() const;
    void setSslConfiguration(ref const(QSslConfiguration) configuration);
#endif

    void setOriginatingObject(QObject *object);
    QObject *originatingObject() const;

    Priority priority() const;
    void setPriority(Priority priority);

private:
    QSharedDataPointer<QNetworkRequestPrivate> d;
    friend class QNetworkRequestPrivate;
};

Q_DECLARE_SHARED(QNetworkRequest)

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QNetworkRequest)

#endif
