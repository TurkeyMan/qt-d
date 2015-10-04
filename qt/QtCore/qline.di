/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtCore module of the Qt Toolkit.
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

public import QtCore.qpoint;


/*******************************************************************************
 * extern(C++) class QLine
 *******************************************************************************/

extern(C++) class export QLine
{
public:
    /+inline+/ QLine();
    /+inline+/ QLine(ref const(QPoint) pt1, ref const(QPoint) pt2);
    /+inline+/ QLine(int x1, int y1, int x2, int y2);

    /+inline+/ bool isNull() const;

    /+inline+/ QPoint p1() const;
    /+inline+/ QPoint p2() const;

    /+inline+/ int x1() const;
    /+inline+/ int y1() const;

    /+inline+/ int x2() const;
    /+inline+/ int y2() const;

    /+inline+/ int dx() const;
    /+inline+/ int dy() const;

    /+inline+/ void translate(ref const(QPoint) p);
    /+inline+/ void translate(int dx, int dy);

    /+inline+/ QLine translated(ref const(QPoint) p) const Q_REQUIRED_RESULT;
    /+inline+/ QLine translated(int dx, int dy) const Q_REQUIRED_RESULT;

    /+inline+/ void setP1(ref const(QPoint) p1);
    /+inline+/ void setP2(ref const(QPoint) p2);
    /+inline+/ void setPoints(ref const(QPoint) p1, ref const(QPoint) p2);
    /+inline+/ void setLine(int x1, int y1, int x2, int y2);

    /+inline+/ bool operator==(ref const(QLine) d) const;
    /+inline+/ bool operator!=(ref const(QLine) d) const { return !(*this == d); }

private:
    QPoint pt1, pt2;
}
Q_DECLARE_TYPEINFO(QLine, Q_MOVABLE_TYPE);

/*******************************************************************************
 * extern(C++) class QLine /+inline+/ members
 *******************************************************************************/

/+inline+/ QLine::QLine() { }

/+inline+/ QLine::QLine(ref const(QPoint) pt1_, ref const(QPoint) pt2_) : pt1(pt1_), pt2(pt2_) { }

/+inline+/ QLine::QLine(int x1pos, int y1pos, int x2pos, int y2pos) : pt1(QPoint(x1pos, y1pos)), pt2(QPoint(x2pos, y2pos)) { }

/+inline+/ bool QLine::isNull() const
{
    return pt1 == pt2;
}

/+inline+/ int QLine::x1() const
{
    return pt1.x();
}

/+inline+/ int QLine::y1() const
{
    return pt1.y();
}

/+inline+/ int QLine::x2() const
{
    return pt2.x();
}

/+inline+/ int QLine::y2() const
{
    return pt2.y();
}

/+inline+/ QPoint QLine::p1() const
{
    return pt1;
}

/+inline+/ QPoint QLine::p2() const
{
    return pt2;
}

/+inline+/ int QLine::dx() const
{
    return pt2.x() - pt1.x();
}

/+inline+/ int QLine::dy() const
{
    return pt2.y() - pt1.y();
}

/+inline+/ void QLine::translate(ref const(QPoint) point)
{
    pt1 += point;
    pt2 += point;
}

/+inline+/ void QLine::translate(int adx, int ady)
{
    this->translate(QPoint(adx, ady));
}

/+inline+/ QLine QLine::translated(ref const(QPoint) p) const
{
    return QLine(pt1 + p, pt2 + p);
}

/+inline+/ QLine QLine::translated(int adx, int ady) const
{
    return translated(QPoint(adx, ady));
}

/+inline+/ void QLine::setP1(ref const(QPoint) aP1)
{
    pt1 = aP1;
}

/+inline+/ void QLine::setP2(ref const(QPoint) aP2)
{
    pt2 = aP2;
}

/+inline+/ void QLine::setPoints(ref const(QPoint) aP1, ref const(QPoint) aP2)
{
    pt1 = aP1;
    pt2 = aP2;
}

/+inline+/ void QLine::setLine(int aX1, int aY1, int aX2, int aY2)
{
    pt1 = QPoint(aX1, aY1);
    pt2 = QPoint(aX2, aY2);
}

/+inline+/ bool QLine::operator==(ref const(QLine) d) const
{
    return pt1 == d.pt1 && pt2 == d.pt2;
}

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug d, ref const(QLine) p);
#endif

#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &, ref const(QLine) );
export QDataStream &operator>>(QDataStream &, QLine &);
#endif

/*******************************************************************************
 * extern(C++) class QLineF
 *******************************************************************************/
extern(C++) class export QLineF {
public:

    enum IntersectType { NoIntersection, BoundedIntersection, UnboundedIntersection }

    /+inline+/ QLineF();
    /+inline+/ QLineF(ref const(QPointF) pt1, ref const(QPointF) pt2);
    /+inline+/ QLineF(qreal x1, qreal y1, qreal x2, qreal y2);
    /+inline+/ QLineF(ref const(QLine) line) : pt1(line.p1()), pt2(line.p2()) { }

    static QLineF fromPolar(qreal length, qreal angle) Q_REQUIRED_RESULT;

    bool isNull() const;

    /+inline+/ QPointF p1() const;
    /+inline+/ QPointF p2() const;

    /+inline+/ qreal x1() const;
    /+inline+/ qreal y1() const;

    /+inline+/ qreal x2() const;
    /+inline+/ qreal y2() const;

    /+inline+/ qreal dx() const;
    /+inline+/ qreal dy() const;

    qreal length() const;
    void setLength(qreal len);

    qreal angle() const;
    void setAngle(qreal angle);

    qreal angleTo(ref const(QLineF) l) const;

    QLineF unitVector() const Q_REQUIRED_RESULT;
    /+inline+/ QLineF normalVector() const Q_REQUIRED_RESULT;

    // ### Qt 6: rename intersects() or intersection() and rename IntersectType IntersectionType
    IntersectType intersect(ref const(QLineF) l, QPointF *intersectionPoint) const;

    qreal angle(ref const(QLineF) l) const;

    /+inline+/ QPointF pointAt(qreal t) const;
    /+inline+/ void translate(ref const(QPointF) p);
    /+inline+/ void translate(qreal dx, qreal dy);

    /+inline+/ QLineF translated(ref const(QPointF) p) const Q_REQUIRED_RESULT;
    /+inline+/ QLineF translated(qreal dx, qreal dy) const Q_REQUIRED_RESULT;

    /+inline+/ void setP1(ref const(QPointF) p1);
    /+inline+/ void setP2(ref const(QPointF) p2);
    /+inline+/ void setPoints(ref const(QPointF) p1, ref const(QPointF) p2);
    /+inline+/ void setLine(qreal x1, qreal y1, qreal x2, qreal y2);

    /+inline+/ bool operator==(ref const(QLineF) d) const;
    /+inline+/ bool operator!=(ref const(QLineF) d) const { return !(*this == d); }

    QLine toLine() const;

private:
    QPointF pt1, pt2;
}
Q_DECLARE_TYPEINFO(QLineF, Q_MOVABLE_TYPE);

/*******************************************************************************
 * extern(C++) class QLineF /+inline+/ members
 *******************************************************************************/

/+inline+/ QLineF::QLineF()
{
}

/+inline+/ QLineF::QLineF(ref const(QPointF) apt1, ref const(QPointF) apt2)
    : pt1(apt1), pt2(apt2)
{
}

/+inline+/ QLineF::QLineF(qreal x1pos, qreal y1pos, qreal x2pos, qreal y2pos)
    : pt1(x1pos, y1pos), pt2(x2pos, y2pos)
{
}

/+inline+/ qreal QLineF::x1() const
{
    return pt1.x();
}

/+inline+/ qreal QLineF::y1() const
{
    return pt1.y();
}

/+inline+/ qreal QLineF::x2() const
{
    return pt2.x();
}

/+inline+/ qreal QLineF::y2() const
{
    return pt2.y();
}

/+inline+/ bool QLineF::isNull() const
{
    return qFuzzyCompare(pt1.x(), pt2.x()) && qFuzzyCompare(pt1.y(), pt2.y());
}

/+inline+/ QPointF QLineF::p1() const
{
    return pt1;
}

/+inline+/ QPointF QLineF::p2() const
{
    return pt2;
}

/+inline+/ qreal QLineF::dx() const
{
    return pt2.x() - pt1.x();
}

/+inline+/ qreal QLineF::dy() const
{
    return pt2.y() - pt1.y();
}

/+inline+/ QLineF QLineF::normalVector() const
{
    return QLineF(p1(), p1() + QPointF(dy(), -dx()));
}

/+inline+/ void QLineF::translate(ref const(QPointF) point)
{
    pt1 += point;
    pt2 += point;
}

/+inline+/ void QLineF::translate(qreal adx, qreal ady)
{
    this->translate(QPointF(adx, ady));
}

/+inline+/ QLineF QLineF::translated(ref const(QPointF) p) const
{
    return QLineF(pt1 + p, pt2 + p);
}

/+inline+/ QLineF QLineF::translated(qreal adx, qreal ady) const
{
    return translated(QPointF(adx, ady));
}

/+inline+/ void QLineF::setLength(qreal len)
{
    if (isNull())
        return;
    QLineF v = unitVector();
    pt2 = QPointF(pt1.x() + v.dx() * len, pt1.y() + v.dy() * len);
}

/+inline+/ QPointF QLineF::pointAt(qreal t) const
{
    return QPointF(pt1.x() + (pt2.x() - pt1.x()) * t, pt1.y() + (pt2.y() - pt1.y()) * t);
}

/+inline+/ QLine QLineF::toLine() const
{
    return QLine(pt1.toPoint(), pt2.toPoint());
}


/+inline+/ void QLineF::setP1(ref const(QPointF) aP1)
{
    pt1 = aP1;
}

/+inline+/ void QLineF::setP2(ref const(QPointF) aP2)
{
    pt2 = aP2;
}

/+inline+/ void QLineF::setPoints(ref const(QPointF) aP1, ref const(QPointF) aP2)
{
    pt1 = aP1;
    pt2 = aP2;
}

/+inline+/ void QLineF::setLine(qreal aX1, qreal aY1, qreal aX2, qreal aY2)
{
    pt1 = QPointF(aX1, aY1);
    pt2 = QPointF(aX2, aY2);
}


/+inline+/ bool QLineF::operator==(ref const(QLineF) d) const
{
    return pt1 == d.pt1 && pt2 == d.pt2;
}



#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug d, ref const(QLineF) p);
#endif

#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &, ref const(QLineF) );
export QDataStream &operator>>(QDataStream &, QLineF &);
#endif

#endif // QLINE_H
