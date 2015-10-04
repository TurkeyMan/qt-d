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

#ifndef QNETWORKDISKCACHE_H
#define QNETWORKDISKCACHE_H

public import qt.QtNetwork.qabstractnetworkcache;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_NETWORKDISKCACHE

class QNetworkDiskCachePrivate;
class Q_NETWORK_EXPORT QNetworkDiskCache : public QAbstractNetworkCache
{
    mixin Q_OBJECT;

public:
    explicit QNetworkDiskCache(QObject *parent = 0);
    ~QNetworkDiskCache();

    QString cacheDirectory() const;
    void setCacheDirectory(ref const(QString) cacheDir);

    qint64 maximumCacheSize() const;
    void setMaximumCacheSize(qint64 size);

    qint64 cacheSize() const;
    QNetworkCacheMetaData metaData(ref const(QUrl) url);
    void updateMetaData(ref const(QNetworkCacheMetaData) metaData);
    QIODevice *data(ref const(QUrl) url);
    bool remove(ref const(QUrl) url);
    QIODevice *prepare(ref const(QNetworkCacheMetaData) metaData);
    void insert(QIODevice *device);

    QNetworkCacheMetaData fileMetaData(ref const(QString) fileName) const;

public Q_SLOTS:
    void clear();

protected:
    /+virtual+/ qint64 expire();

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

#endif // QT_NO_NETWORKDISKCACHE

QT_END_NAMESPACE

#endif // QNETWORKDISKCACHE_H
