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

#ifndef QGEORECTANGLE_H
#define QGEORECTANGLE_H

public import qt.QtPositioning.QGeoShape;

QT_BEGIN_NAMESPACE

class QGeoCoordinate;
class QGeoRectanglePrivate;

class Q_POSITIONING_EXPORT QGeoRectangle : public QGeoShape
{
public:
    QGeoRectangle();
    QGeoRectangle(ref const(QGeoCoordinate) center, double degreesWidth, double degreesHeight);
    QGeoRectangle(ref const(QGeoCoordinate) topLeft, ref const(QGeoCoordinate) bottomRight);
    QGeoRectangle(ref const(QList<QGeoCoordinate>) coordinates);
    QGeoRectangle(ref const(QGeoRectangle) other);
    QGeoRectangle(ref const(QGeoShape) other);

    ~QGeoRectangle();

    QGeoRectangle &operator=(ref const(QGeoRectangle) other);

    using QGeoShape::operator==;
    bool operator==(ref const(QGeoRectangle) other) const;

    using QGeoShape::operator!=;
    bool operator!=(ref const(QGeoRectangle) other) const;

    void setTopLeft(ref const(QGeoCoordinate) topLeft);
    QGeoCoordinate topLeft() const;

    void setTopRight(ref const(QGeoCoordinate) topRight);
    QGeoCoordinate topRight() const;

    void setBottomLeft(ref const(QGeoCoordinate) bottomLeft);
    QGeoCoordinate bottomLeft() const;

    void setBottomRight(ref const(QGeoCoordinate) bottomRight);
    QGeoCoordinate bottomRight() const;

    void setCenter(ref const(QGeoCoordinate) center);
    QGeoCoordinate center() const;

    void setWidth(double degreesWidth);
    double width() const;

    void setHeight(double degreesHeight);
    double height() const;

    using QGeoShape::contains;
    bool contains(ref const(QGeoRectangle) rectangle) const;
    bool intersects(ref const(QGeoRectangle) rectangle) const;

    void translate(double degreesLatitude, double degreesLongitude);
    QGeoRectangle translated(double degreesLatitude, double degreesLongitude) const;

    QGeoRectangle united(ref const(QGeoRectangle) rectangle) const;
    QGeoRectangle operator|(ref const(QGeoRectangle) rectangle) const;
    QGeoRectangle &operator|=(ref const(QGeoRectangle) rectangle);

private:
    /+inline+/ QGeoRectanglePrivate *d_func();
    /+inline+/ const(QGeoRectanglePrivate)* d_func() const;
};

Q_DECLARE_TYPEINFO(QGeoRectangle, Q_MOVABLE_TYPE);

/+inline+/ QGeoRectangle QGeoRectangle::operator|(ref const(QGeoRectangle) rectangle) const
{
    return united(rectangle);
}

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QGeoRectangle)

#endif

