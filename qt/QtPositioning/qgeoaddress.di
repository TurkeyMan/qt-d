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

#ifndef QGEOADDRESS_H
#define QGEOADDRESS_H

public import qt.QtCore.QMetaType;
public import qt.QtCore.QSharedDataPointer;
public import qt.QtPositioning.qpositioningglobal;

QT_BEGIN_NAMESPACE

class QString;
class QGeoAddressPrivate;
class Q_POSITIONING_EXPORT QGeoAddress
{
public:
    QGeoAddress();
    QGeoAddress(ref const(QGeoAddress) other);
    ~QGeoAddress();

    QGeoAddress &operator=(ref const(QGeoAddress) other);
    bool operator==(ref const(QGeoAddress) other) const;
    bool operator!=(ref const(QGeoAddress) other) const {
        return !(other == *this);
    }

    QString text() const;
    void setText(ref const(QString) text);

    QString country() const;
    void setCountry(ref const(QString) country);

    QString countryCode() const;
    void setCountryCode(ref const(QString) countryCode);

    QString state() const;
    void setState(ref const(QString) state);

    QString county() const;
    void setCounty(ref const(QString) county);

    QString city() const;
    void setCity(ref const(QString) city);

    QString district() const;
    void setDistrict(ref const(QString) district);

    QString postalCode() const;
    void setPostalCode(ref const(QString) postalCode);

    QString street() const;
    void setStreet(ref const(QString) street);

    bool isEmpty() const;
    void clear();

    bool isTextGenerated() const;

private:
    QSharedDataPointer<QGeoAddressPrivate> d;
};

Q_DECLARE_TYPEINFO(QGeoAddress, Q_MOVABLE_TYPE);

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QGeoAddress)

#endif
