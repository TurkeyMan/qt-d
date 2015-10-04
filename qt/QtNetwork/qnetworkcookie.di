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

#ifndef QNETWORKCOOKIE_H
#define QNETWORKCOOKIE_H

public import qt.QtCore.QSharedDataPointer;
public import qt.QtCore.QList;
public import qt.QtCore.QMetaType;
public import qt.QtCore.QObject;

QT_BEGIN_NAMESPACE


class QByteArray;
class QDateTime;
class QString;
class QUrl;

class QNetworkCookiePrivate;
class Q_NETWORK_EXPORT QNetworkCookie
{
public:
    enum RawForm {
        NameAndValueOnly,
        Full
    };

    explicit QNetworkCookie(ref const(QByteArray) name = QByteArray(), ref const(QByteArray) value = QByteArray());
    QNetworkCookie(ref const(QNetworkCookie) other);
    ~QNetworkCookie();
    QNetworkCookie &operator=(ref const(QNetworkCookie) other);

    void swap(QNetworkCookie &other) { qSwap(d, other.d); }

    bool operator==(ref const(QNetworkCookie) other) const;
    /+inline+/ bool operator!=(ref const(QNetworkCookie) other) const
    { return !(*this == other); }

    bool isSecure() const;
    void setSecure(bool enable);
    bool isHttpOnly() const;
    void setHttpOnly(bool enable);

    bool isSessionCookie() const;
    QDateTime expirationDate() const;
    void setExpirationDate(ref const(QDateTime) date);

    QString domain() const;
    void setDomain(ref const(QString) domain);

    QString path() const;
    void setPath(ref const(QString) path);

    QByteArray name() const;
    void setName(ref const(QByteArray) cookieName);

    QByteArray value() const;
    void setValue(ref const(QByteArray) value);

    QByteArray toRawForm(RawForm form = Full) const;

    bool hasSameIdentifier(ref const(QNetworkCookie) other) const;
    void normalize(ref const(QUrl) url);

    static QList<QNetworkCookie> parseCookies(ref const(QByteArray) cookieString);

private:
    QSharedDataPointer<QNetworkCookiePrivate> d;
    friend class QNetworkCookiePrivate;
};

Q_DECLARE_SHARED(QNetworkCookie)

#ifndef QT_NO_DEBUG_STREAM
class QDebug;
Q_NETWORK_EXPORT QDebug operator<<(QDebug, ref const(QNetworkCookie) );
#endif

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QNetworkCookie)

#endif
