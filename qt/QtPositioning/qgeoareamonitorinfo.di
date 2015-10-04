/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtPositioning module of the Qt Toolkit.
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

#ifndef QGEOAREAMONITORINFO_H
#define QGEOAREAMONITORINFO_H

public import qt.QtPositioning.QGeoCoordinate;
public import qt.QtPositioning.QGeoShape;
public import qt.QtCore.QSharedDataPointer;
public import qt.QtCore.QVariantMap;

QT_BEGIN_NAMESPACE

class QDataStream;
class QGeoAreaMonitorInfo;

#ifndef QT_NO_DATASTREAM
Q_POSITIONING_EXPORT QDataStream &operator<<(QDataStream &, ref const(QGeoAreaMonitorInfo) );
Q_POSITIONING_EXPORT QDataStream &operator>>(QDataStream &, QGeoAreaMonitorInfo &);
#endif

class QGeoAreaMonitorInfoPrivate;
class Q_POSITIONING_EXPORT QGeoAreaMonitorInfo
{
public:
    explicit QGeoAreaMonitorInfo(ref const(QString) name = QString());
    QGeoAreaMonitorInfo(ref const(QGeoAreaMonitorInfo) other);
    ~QGeoAreaMonitorInfo();

    QGeoAreaMonitorInfo &operator=(ref const(QGeoAreaMonitorInfo) other);

    bool operator==(ref const(QGeoAreaMonitorInfo) other) const;
    bool operator!=(ref const(QGeoAreaMonitorInfo) other) const;

    QString name() const;
    void setName(ref const(QString) name);

    QString identifier() const;
    bool isValid() const;

    QGeoShape area() const;
    void setArea(ref const(QGeoShape) newShape);

    QDateTime expiration() const;
    void setExpiration(ref const(QDateTime) expiry);

    bool isPersistent() const;
    void setPersistent(bool isPersistent);

    QVariantMap notificationParameters() const;
    void setNotificationParameters(ref const(QVariantMap) parameters);
private:
    QSharedDataPointer<QGeoAreaMonitorInfoPrivate> d;

#ifndef QT_NO_DATASTREAM
    friend Q_POSITIONING_EXPORT QDataStream &operator<<(QDataStream &, ref const(QGeoAreaMonitorInfo) );
    friend Q_POSITIONING_EXPORT QDataStream &operator>>(QDataStream &, QGeoAreaMonitorInfo &);
#endif
};

#ifndef QT_NO_DEBUG_STREAM
Q_POSITIONING_EXPORT QDebug operator<<(QDebug, ref const(QGeoAreaMonitorInfo) );
#endif

QT_END_NAMESPACE

#endif // QGEOAREAMONITORINFO_H
