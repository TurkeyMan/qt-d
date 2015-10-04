/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtLocation module of the Qt Toolkit.
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

#ifndef QGEOCODEREPLY_H
#define QGEOCODEREPLY_H

public import qt.QtCore.QObject;
public import qt.QtCore.QList;
public import qt.QtPositioning.QGeoLocation;

public import qt.QtLocation.qlocationglobal;

QT_BEGIN_NAMESPACE

class QGeoShape;
class QGeoCodeReplyPrivate;

class Q_LOCATION_EXPORT QGeoCodeReply : public QObject
{
    mixin Q_OBJECT;

public:
    enum Error {
        NoError,
        EngineNotSetError,
        CommunicationError,
        ParseError,
        UnsupportedOptionError,
        CombinationError,
        UnknownError
    };

    QGeoCodeReply(Error error, ref const(QString) errorString, QObject *parent = 0);
    /+virtual+/ ~QGeoCodeReply();

    bool isFinished() const;
    Error error() const;
    QString errorString() const;

    QGeoShape viewport() const;
    QList<QGeoLocation> locations() const;

    int limit() const;
    int offset() const;

    /+virtual+/ void abort();

Q_SIGNALS:
    void finished();
    void error(QGeoCodeReply::Error error, ref const(QString) errorString = QString());

protected:
    QGeoCodeReply(QObject *parent = 0);

    void setError(Error error, ref const(QString) errorString);
    void setFinished(bool finished);

    void setViewport(ref const(QGeoShape) viewport);
    void addLocation(ref const(QGeoLocation) location);
    void setLocations(ref const(QList<QGeoLocation>) locations);

    void setLimit(int limit);
    void setOffset(int offset);

private:
    QGeoCodeReplyPrivate *d_ptr;
    mixin Q_DISABLE_COPY;
};

QT_END_NAMESPACE

#endif
