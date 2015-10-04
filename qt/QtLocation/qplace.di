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

#ifndef QPLACE_H
#define QPLACE_H

public import qt.QtCore.QSharedDataPointer;
public import qt.QtPositioning.QGeoAddress;
public import qt.QtPositioning.QGeoRectangle;
public import qt.QtPositioning.QGeoCoordinate;
public import qt.QtPositioning.QGeoLocation;
public import qt.QtLocation.QPlaceCategory;
public import qt.QtLocation.QPlaceContent;
public import qt.QtLocation.QPlaceRatings;
public import qt.QtLocation.QPlaceReview;
public import qt.QtLocation.QPlaceAttribute;
public import qt.QtLocation.QPlaceContactDetail;

QT_BEGIN_NAMESPACE

class QString;
class QPlaceIcon;
class QPlacePrivate;

class Q_LOCATION_EXPORT QPlace
{
public:
    QPlace();
    QPlace(ref const(QPlace) other);
    ~QPlace();

    QPlace &operator=(ref const(QPlace) other);

    bool operator==(ref const(QPlace) other) const;
    bool operator!=(ref const(QPlace) other) const;

    QList<QPlaceCategory> categories() const;
    void setCategory(ref const(QPlaceCategory) category);
    void setCategories(ref const(QList<QPlaceCategory>) categories);
    QGeoLocation location() const;
    void setLocation(ref const(QGeoLocation) location);
    QPlaceRatings ratings() const;
    void setRatings(ref const(QPlaceRatings) ratings);
    QPlaceSupplier supplier() const;
    void setSupplier(ref const(QPlaceSupplier) supplier);

    QString attribution() const;
    void setAttribution(ref const(QString) attribution);

    QPlaceIcon icon() const;
    void setIcon(ref const(QPlaceIcon) icon);

    QPlaceContent::Collection content(QPlaceContent::Type type) const;
    void setContent(QPlaceContent::Type type, ref const(QPlaceContent::Collection) content);
    void insertContent(QPlaceContent::Type type, ref const(QPlaceContent::Collection) content);

    int totalContentCount(QPlaceContent::Type type) const;
    void setTotalContentCount(QPlaceContent::Type type, int total);

    QString name() const;
    void setName(ref const(QString) name);
    QString placeId() const;
    void setPlaceId(ref const(QString) identifier);

    QString primaryPhone() const;
    QString primaryFax() const;
    QString primaryEmail() const;
    QUrl primaryWebsite() const;

    bool detailsFetched() const;
    void setDetailsFetched(bool fetched);

    QStringList extendedAttributeTypes() const;
    QPlaceAttribute extendedAttribute(ref const(QString) attributeType) const;
    void setExtendedAttribute(ref const(QString) attributeType, ref const(QPlaceAttribute) attribute);
    void removeExtendedAttribute(ref const(QString) attributeType);

    QStringList contactTypes() const;
    QList<QPlaceContactDetail> contactDetails(ref const(QString) contactType) const;
    void setContactDetails(ref const(QString) contactType, QList<QPlaceContactDetail> details);
    void appendContactDetail(ref const(QString) contactType, ref const(QPlaceContactDetail) detail);
    void removeContactDetails(ref const(QString) contactType);

    QLocation::Visibility visibility() const;
    void setVisibility(QLocation::Visibility visibility);

    bool isEmpty() const;

private:
    QSharedDataPointer<QPlacePrivate> d_ptr;

    /+inline+/ QPlacePrivate *d_func();
    /+inline+/ const(QPlacePrivate)* d_func() const;
};

Q_DECLARE_TYPEINFO(QPlace, Q_MOVABLE_TYPE);

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QPlace)

#endif
