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

#ifndef QHTTPMULTIPART_H
#define QHTTPMULTIPART_H

public import qt.QtCore.QSharedDataPointer;
public import qt.QtCore.QByteArray;
public import qt.QtCore.QIODevice;
public import qt.QtNetwork.QNetworkRequest;

QT_BEGIN_NAMESPACE


class QHttpPartPrivate;
class QHttpMultiPart;

class Q_NETWORK_EXPORT QHttpPart
{
public:
    QHttpPart();
    QHttpPart(ref const(QHttpPart) other);
    ~QHttpPart();
    QHttpPart &operator=(ref const(QHttpPart) other);

    void swap(QHttpPart &other) { qSwap(d, other.d); }

    bool operator==(ref const(QHttpPart) other) const;
    /+inline+/ bool operator!=(ref const(QHttpPart) other) const
    { return !operator==(other); }

    void setHeader(QNetworkRequest::KnownHeaders header, ref const(QVariant) value);
    void setRawHeader(ref const(QByteArray) headerName, ref const(QByteArray) headerValue);

    void setBody(ref const(QByteArray) body);
    void setBodyDevice(QIODevice *device);

private:
    QSharedDataPointer<QHttpPartPrivate> d;

    friend class QHttpMultiPartIODevice;
};

Q_DECLARE_SHARED(QHttpPart)

class QHttpMultiPartPrivate;

class Q_NETWORK_EXPORT QHttpMultiPart : public QObject
{
    mixin Q_OBJECT;

public:

    enum ContentType {
        MixedType,
        RelatedType,
        FormDataType,
        AlternativeType
    };

    explicit QHttpMultiPart(QObject *parent = 0);
    explicit QHttpMultiPart(ContentType contentType, QObject *parent = 0);
    ~QHttpMultiPart();

    void append(ref const(QHttpPart) httpPart);

    void setContentType(ContentType contentType);

    QByteArray boundary() const;
    void setBoundary(ref const(QByteArray) boundary);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    friend class QNetworkAccessManager;
    friend class QNetworkAccessManagerPrivate;
};

QT_END_NAMESPACE

#endif // QHTTPMULTIPART_H
