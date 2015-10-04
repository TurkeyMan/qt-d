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

public import QtCore.qnamespace;


extern(C++) class export QPoint
{
public:
    QPoint();
    QPoint(int xpos, int ypos);

    /+inline+/ bool isNull() const;

    /+inline+/ int x() const;
    /+inline+/ int y() const;
    /+inline+/ void setX(int x);
    /+inline+/ void setY(int y);

    /+inline+/ int manhattanLength() const;

    /+inline+/ int &rx();
    /+inline+/ int &ry();

    /+inline+/ QPoint &operator+=(ref const(QPoint) p);
    /+inline+/ QPoint &operator-=(ref const(QPoint) p);

    /+inline+/ QPoint &operator*=(float factor);
    /+inline+/ QPoint &operator*=(double factor);
    /+inline+/ QPoint &operator*=(int factor);

    /+inline+/ QPoint &operator/=(qreal divisor);

    static /+inline+/ int dotProduct(ref const(QPoint) p1, ref const(QPoint) p2)
    { return p1.xp * p2.xp + p1.yp * p2.yp; }

    friend /+inline+/ bool operator==(ref const(QPoint) , ref const(QPoint) );
    friend /+inline+/ bool operator!=(ref const(QPoint) , ref const(QPoint) );
    friend /+inline+/ const QPoint operator+(ref const(QPoint) , ref const(QPoint) );
    friend /+inline+/ const QPoint operator-(ref const(QPoint) , ref const(QPoint) );
    friend /+inline+/ const QPoint operator*(ref const(QPoint) , float);
    friend /+inline+/ const QPoint operator*(float, ref const(QPoint) );
    friend /+inline+/ const QPoint operator*(ref const(QPoint) , double);
    friend /+inline+/ const QPoint operator*(double, ref const(QPoint) );
    friend /+inline+/ const QPoint operator*(ref const(QPoint) , int);
    friend /+inline+/ const QPoint operator*(int, ref const(QPoint) );
    friend /+inline+/ const QPoint operator+(ref const(QPoint) );
    friend /+inline+/ const QPoint operator-(ref const(QPoint) );
    friend /+inline+/ const QPoint operator/(ref const(QPoint) , qreal);

private:
    friend extern(C++) class QTransform;
    int xp;
    int yp;
}

Q_DECLARE_TYPEINFO(QPoint, Q_MOVABLE_TYPE);

/*****************************************************************************
  QPoint stream functions
 *****************************************************************************/
#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &, ref const(QPoint) );
export QDataStream &operator>>(QDataStream &, QPoint &);
#endif

/*****************************************************************************
  QPoint /+inline+/ functions
 *****************************************************************************/

/+inline+/ QPoint::QPoint() : xp(0), yp(0) {}

/+inline+/ QPoint::QPoint(int xpos, int ypos) : xp(xpos), yp(ypos) {}

/+inline+/ bool QPoint::isNull() const
{ return xp == 0 && yp == 0; }

/+inline+/ int QPoint::x() const
{ return xp; }

/+inline+/ int QPoint::y() const
{ return yp; }

/+inline+/ void QPoint::setX(int xpos)
{ xp = xpos; }

/+inline+/ void QPoint::setY(int ypos)
{ yp = ypos; }

/+inline+/ int QPoint::manhattanLength() const
{ return qAbs(x())+qAbs(y()); }

/+inline+/ int &QPoint::rx()
{ return xp; }

/+inline+/ int &QPoint::ry()
{ return yp; }

/+inline+/ QPoint &QPoint::operator+=(ref const(QPoint) p)
{ xp+=p.xp; yp+=p.yp; return *this; }

/+inline+/ QPoint &QPoint::operator-=(ref const(QPoint) p)
{ xp-=p.xp; yp-=p.yp; return *this; }

/+inline+/ QPoint &QPoint::operator*=(float factor)
{ xp = qRound(xp*factor); yp = qRound(yp*factor); return *this; }

/+inline+/ QPoint &QPoint::operator*=(double factor)
{ xp = qRound(xp*factor); yp = qRound(yp*factor); return *this; }

/+inline+/ QPoint &QPoint::operator*=(int factor)
{ xp = xp*factor; yp = yp*factor; return *this; }

/+inline+/ bool operator==(ref const(QPoint) p1, ref const(QPoint) p2)
{ return p1.xp == p2.xp && p1.yp == p2.yp; }

/+inline+/ bool operator!=(ref const(QPoint) p1, ref const(QPoint) p2)
{ return p1.xp != p2.xp || p1.yp != p2.yp; }

/+inline+/ const QPoint operator+(ref const(QPoint) p1, ref const(QPoint) p2)
{ return QPoint(p1.xp+p2.xp, p1.yp+p2.yp); }

/+inline+/ const QPoint operator-(ref const(QPoint) p1, ref const(QPoint) p2)
{ return QPoint(p1.xp-p2.xp, p1.yp-p2.yp); }

/+inline+/ const QPoint operator*(ref const(QPoint) p, float factor)
{ return QPoint(qRound(p.xp*factor), qRound(p.yp*factor)); }

/+inline+/ const QPoint operator*(ref const(QPoint) p, double factor)
{ return QPoint(qRound(p.xp*factor), qRound(p.yp*factor)); }

/+inline+/ const QPoint operator*(ref const(QPoint) p, int factor)
{ return QPoint(p.xp*factor, p.yp*factor); }

/+inline+/ const QPoint operator*(float factor, ref const(QPoint) p)
{ return QPoint(qRound(p.xp*factor), qRound(p.yp*factor)); }

/+inline+/ const QPoint operator*(double factor, ref const(QPoint) p)
{ return QPoint(qRound(p.xp*factor), qRound(p.yp*factor)); }

/+inline+/ const QPoint operator*(int factor, ref const(QPoint) p)
{ return QPoint(p.xp*factor, p.yp*factor); }

/+inline+/ const QPoint operator+(ref const(QPoint) p)
{ return p; }

/+inline+/ const QPoint operator-(ref const(QPoint) p)
{ return QPoint(-p.xp, -p.yp); }

/+inline+/ QPoint &QPoint::operator/=(qreal c)
{
    xp = qRound(xp/c);
    yp = qRound(yp/c);
    return *this;
}

/+inline+/ const QPoint operator/(ref const(QPoint) p, qreal c)
{
    return QPoint(qRound(p.xp/c), qRound(p.yp/c));
}

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, ref const(QPoint) );
#endif





extern(C++) class export QPointF
{
public:
    QPointF();
    QPointF(ref const(QPoint) p);
    QPointF(qreal xpos, qreal ypos);

    /+inline+/ qreal manhattanLength() const;

    /+inline+/ bool isNull() const;

    /+inline+/ qreal x() const;
    /+inline+/ qreal y() const;
    /+inline+/ void setX(qreal x);
    /+inline+/ void setY(qreal y);

    /+inline+/ qreal &rx();
    /+inline+/ qreal &ry();

    /+inline+/ QPointF &operator+=(ref const(QPointF) p);
    /+inline+/ QPointF &operator-=(ref const(QPointF) p);
    /+inline+/ QPointF &operator*=(qreal c);
    /+inline+/ QPointF &operator/=(qreal c);

    static /+inline+/ qreal dotProduct(ref const(QPointF) p1, ref const(QPointF) p2)
    { return p1.xp * p2.xp + p1.yp * p2.yp; }

    friend /+inline+/ bool operator==(ref const(QPointF) , ref const(QPointF) );
    friend /+inline+/ bool operator!=(ref const(QPointF) , ref const(QPointF) );
    friend /+inline+/ const QPointF operator+(ref const(QPointF) , ref const(QPointF) );
    friend /+inline+/ const QPointF operator-(ref const(QPointF) , ref const(QPointF) );
    friend /+inline+/ const QPointF operator*(qreal, ref const(QPointF) );
    friend /+inline+/ const QPointF operator*(ref const(QPointF) , qreal);
    friend /+inline+/ const QPointF operator+(ref const(QPointF) );
    friend /+inline+/ const QPointF operator-(ref const(QPointF) );
    friend /+inline+/ const QPointF operator/(ref const(QPointF) , qreal);

    QPoint toPoint() const;

private:
    friend extern(C++) class QMatrix;
    friend extern(C++) class QTransform;

    qreal xp;
    qreal yp;
}

Q_DECLARE_TYPEINFO(QPointF, Q_MOVABLE_TYPE);

/*****************************************************************************
  QPointF stream functions
 *****************************************************************************/
#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &, ref const(QPointF) );
export QDataStream &operator>>(QDataStream &, QPointF &);
#endif

/*****************************************************************************
  QPointF /+inline+/ functions
 *****************************************************************************/

/+inline+/ QPointF::QPointF() : xp(0), yp(0) { }

/+inline+/ QPointF::QPointF(qreal xpos, qreal ypos) : xp(xpos), yp(ypos) { }

/+inline+/ QPointF::QPointF(ref const(QPoint) p) : xp(p.x()), yp(p.y()) { }

/+inline+/ qreal QPointF::manhattanLength() const
{
    return qAbs(x())+qAbs(y());
}

/+inline+/ bool QPointF::isNull() const
{
    return qIsNull(xp) && qIsNull(yp);
}

/+inline+/ qreal QPointF::x() const
{
    return xp;
}

/+inline+/ qreal QPointF::y() const
{
    return yp;
}

/+inline+/ void QPointF::setX(qreal xpos)
{
    xp = xpos;
}

/+inline+/ void QPointF::setY(qreal ypos)
{
    yp = ypos;
}

/+inline+/ qreal &QPointF::rx()
{
    return xp;
}

/+inline+/ qreal &QPointF::ry()
{
    return yp;
}

/+inline+/ QPointF &QPointF::operator+=(ref const(QPointF) p)
{
    xp+=p.xp;
    yp+=p.yp;
    return *this;
}

/+inline+/ QPointF &QPointF::operator-=(ref const(QPointF) p)
{
    xp-=p.xp; yp-=p.yp; return *this;
}

/+inline+/ QPointF &QPointF::operator*=(qreal c)
{
    xp*=c; yp*=c; return *this;
}

/+inline+/ bool operator==(ref const(QPointF) p1, ref const(QPointF) p2)
{
    return qFuzzyIsNull(p1.xp - p2.xp) && qFuzzyIsNull(p1.yp - p2.yp);
}

/+inline+/ bool operator!=(ref const(QPointF) p1, ref const(QPointF) p2)
{
    return !qFuzzyIsNull(p1.xp - p2.xp) || !qFuzzyIsNull(p1.yp - p2.yp);
}

/+inline+/ const QPointF operator+(ref const(QPointF) p1, ref const(QPointF) p2)
{
    return QPointF(p1.xp+p2.xp, p1.yp+p2.yp);
}

/+inline+/ const QPointF operator-(ref const(QPointF) p1, ref const(QPointF) p2)
{
    return QPointF(p1.xp-p2.xp, p1.yp-p2.yp);
}

/+inline+/ const QPointF operator*(ref const(QPointF) p, qreal c)
{
    return QPointF(p.xp*c, p.yp*c);
}

/+inline+/ const QPointF operator*(qreal c, ref const(QPointF) p)
{
    return QPointF(p.xp*c, p.yp*c);
}

/+inline+/ const QPointF operator+(ref const(QPointF) p)
{
    return p;
}

/+inline+/ const QPointF operator-(ref const(QPointF) p)
{
    return QPointF(-p.xp, -p.yp);
}

/+inline+/ QPointF &QPointF::operator/=(qreal divisor)
{
    xp/=divisor;
    yp/=divisor;
    return *this;
}

/+inline+/ const QPointF operator/(ref const(QPointF) p, qreal divisor)
{
    return QPointF(p.xp/divisor, p.yp/divisor);
}

/+inline+/ QPoint QPointF::toPoint() const
{
    return QPoint(qRound(xp), qRound(yp));
}

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug d, ref const(QPointF) p);
#endif

#endif // QPOINT_H
