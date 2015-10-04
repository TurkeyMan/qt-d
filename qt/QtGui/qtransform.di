/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtGui module of the Qt Toolkit.
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
#ifndef QTRANSFORM_H
#define QTRANSFORM_H

public import qt.QtGui.qmatrix;
public import qt.QtGui.qpainterpath;
public import qt.QtGui.qpolygon;
public import qt.QtGui.qregion;
public import qt.QtGui.qwindowdefs;
public import qt.QtCore.qline;
public import qt.QtCore.qpoint;
public import qt.QtCore.qrect;

QT_BEGIN_NAMESPACE


class QVariant;

class Q_GUI_EXPORT QTransform
{
public:
    enum TransformationType {
        TxNone      = 0x00,
        TxTranslate = 0x01,
        TxScale     = 0x02,
        TxRotate    = 0x04,
        TxShear     = 0x08,
        TxProject   = 0x10
    };

    /+inline+/ explicit QTransform(Qt.Initialization) : affine(Qt.Uninitialized) {}
    QTransform();
    QTransform(qreal h11, qreal h12, qreal h13,
               qreal h21, qreal h22, qreal h23,
               qreal h31, qreal h32, qreal h33 = 1.0);
    QTransform(qreal h11, qreal h12, qreal h21,
               qreal h22, qreal dx, qreal dy);
    explicit QTransform(ref const(QMatrix) mtx);

    bool isAffine() const;
    bool isIdentity() const;
    bool isInvertible() const;
    bool isScaling() const;
    bool isRotating() const;
    bool isTranslating() const;

    TransformationType type() const;

    /+inline+/ qreal determinant() const;
    qreal det() const;

    qreal m11() const;
    qreal m12() const;
    qreal m13() const;
    qreal m21() const;
    qreal m22() const;
    qreal m23() const;
    qreal m31() const;
    qreal m32() const;
    qreal m33() const;
    qreal dx() const;
    qreal dy() const;

    void setMatrix(qreal m11, qreal m12, qreal m13,
                   qreal m21, qreal m22, qreal m23,
                   qreal m31, qreal m32, qreal m33);

    QTransform inverted(bool *invertible = 0) const Q_REQUIRED_RESULT;
    QTransform adjoint() const Q_REQUIRED_RESULT;
    QTransform transposed() const Q_REQUIRED_RESULT;

    QTransform &translate(qreal dx, qreal dy);
    QTransform &scale(qreal sx, qreal sy);
    QTransform &shear(qreal sh, qreal sv);
    QTransform &rotate(qreal a, Qt.Axis axis = Qt.ZAxis);
    QTransform &rotateRadians(qreal a, Qt.Axis axis = Qt.ZAxis);

    static bool squareToQuad(ref const(QPolygonF) square, QTransform &result);
    static bool quadToSquare(ref const(QPolygonF) quad, QTransform &result);
    static bool quadToQuad(ref const(QPolygonF) one,
                           ref const(QPolygonF) two,
                           QTransform &result);

    bool operator==(ref const(QTransform) ) const;
    bool operator!=(ref const(QTransform) ) const;

    QTransform &operator*=(ref const(QTransform) );
    QTransform operator*(ref const(QTransform) o) const;

    QTransform &operator=(ref const(QTransform) );

    operator QVariant() const;

    void reset();
    QPoint       map(ref const(QPoint) p) const;
    QPointF      map(ref const(QPointF) p) const;
    QLine        map(ref const(QLine) l) const;
    QLineF       map(ref const(QLineF) l) const;
    QPolygonF    map(ref const(QPolygonF) a) const;
    QPolygon     map(ref const(QPolygon) a) const;
    QRegion      map(ref const(QRegion) r) const;
    QPainterPath map(ref const(QPainterPath) p) const;
    QPolygon     mapToPolygon(ref const(QRect) r) const;
    QRect mapRect(ref const(QRect) ) const;
    QRectF mapRect(ref const(QRectF) ) const;
    void map(int x, int y, int *tx, int *ty) const;
    void map(qreal x, qreal y, qreal *tx, qreal *ty) const;

    ref const(QMatrix) toAffine() const;

    QTransform &operator*=(qreal div);
    QTransform &operator/=(qreal div);
    QTransform &operator+=(qreal div);
    QTransform &operator-=(qreal div);

    static QTransform fromTranslate(qreal dx, qreal dy);
    static QTransform fromScale(qreal dx, qreal dy);

private:
    /+inline+/ QTransform(qreal h11, qreal h12, qreal h13,
                      qreal h21, qreal h22, qreal h23,
                      qreal h31, qreal h32, qreal h33, bool)
        : affine(h11, h12, h21, h22, h31, h32, true)
        , m_13(h13), m_23(h23), m_33(h33)
        , m_type(TxNone)
        , m_dirty(TxProject)
        , d(Q_NULLPTR)
    {
    }
    /+inline+/ QTransform(bool)
        : affine(true)
        , m_13(0), m_23(0), m_33(1)
        , m_type(TxNone)
        , m_dirty(TxNone)
        , d(Q_NULLPTR)
    {
    }
    /+inline+/ TransformationType inline_type() const;
    QMatrix affine;
    qreal   m_13;
    qreal   m_23;
    qreal   m_33;

    mutable uint m_type : 5;
    mutable uint m_dirty : 5;

    class Private;
    Private *d;
};
Q_DECLARE_TYPEINFO(QTransform, Q_MOVABLE_TYPE);

/******* inlines *****/
/+inline+/ QTransform::TransformationType QTransform::inline_type() const
{
    if (m_dirty == TxNone)
        return static_cast<TransformationType>(m_type);
    return type();
}

/+inline+/ bool QTransform::isAffine() const
{
    return inline_type() < TxProject;
}
/+inline+/ bool QTransform::isIdentity() const
{
    return inline_type() == TxNone;
}

/+inline+/ bool QTransform::isInvertible() const
{
    return !qFuzzyIsNull(determinant());
}

/+inline+/ bool QTransform::isScaling() const
{
    return type() >= TxScale;
}
/+inline+/ bool QTransform::isRotating() const
{
    return inline_type() >= TxRotate;
}

/+inline+/ bool QTransform::isTranslating() const
{
    return inline_type() >= TxTranslate;
}

/+inline+/ qreal QTransform::determinant() const
{
    return affine._m11*(m_33*affine._m22-affine._dy*m_23) -
        affine._m21*(m_33*affine._m12-affine._dy*m_13)+affine._dx*(m_23*affine._m12-affine._m22*m_13);
}
/+inline+/ qreal QTransform::det() const
{
    return determinant();
}
/+inline+/ qreal QTransform::m11() const
{
    return affine._m11;
}
/+inline+/ qreal QTransform::m12() const
{
    return affine._m12;
}
/+inline+/ qreal QTransform::m13() const
{
    return m_13;
}
/+inline+/ qreal QTransform::m21() const
{
    return affine._m21;
}
/+inline+/ qreal QTransform::m22() const
{
    return affine._m22;
}
/+inline+/ qreal QTransform::m23() const
{
    return m_23;
}
/+inline+/ qreal QTransform::m31() const
{
    return affine._dx;
}
/+inline+/ qreal QTransform::m32() const
{
    return affine._dy;
}
/+inline+/ qreal QTransform::m33() const
{
    return m_33;
}
/+inline+/ qreal QTransform::dx() const
{
    return affine._dx;
}
/+inline+/ qreal QTransform::dy() const
{
    return affine._dy;
}

/+inline+/ QTransform &QTransform::operator*=(qreal num)
{
    if (num == 1.)
        return *this;
    affine._m11 *= num;
    affine._m12 *= num;
    m_13        *= num;
    affine._m21 *= num;
    affine._m22 *= num;
    m_23        *= num;
    affine._dx  *= num;
    affine._dy  *= num;
    m_33        *= num;
    if (m_dirty < TxScale)
        m_dirty = TxScale;
    return *this;
}
/+inline+/ QTransform &QTransform::operator/=(qreal div)
{
    if (div == 0)
        return *this;
    div = 1/div;
    return operator*=(div);
}
/+inline+/ QTransform &QTransform::operator+=(qreal num)
{
    if (num == 0)
        return *this;
    affine._m11 += num;
    affine._m12 += num;
    m_13        += num;
    affine._m21 += num;
    affine._m22 += num;
    m_23        += num;
    affine._dx  += num;
    affine._dy  += num;
    m_33        += num;
    m_dirty     = TxProject;
    return *this;
}
/+inline+/ QTransform &QTransform::operator-=(qreal num)
{
    if (num == 0)
        return *this;
    affine._m11 -= num;
    affine._m12 -= num;
    m_13        -= num;
    affine._m21 -= num;
    affine._m22 -= num;
    m_23        -= num;
    affine._dx  -= num;
    affine._dy  -= num;
    m_33        -= num;
    m_dirty     = TxProject;
    return *this;
}

/+inline+/ bool qFuzzyCompare(ref const(QTransform) t1, ref const(QTransform) t2)
{
    return qFuzzyCompare(t1.m11(), t2.m11())
        && qFuzzyCompare(t1.m12(), t2.m12())
        && qFuzzyCompare(t1.m13(), t2.m13())
        && qFuzzyCompare(t1.m21(), t2.m21())
        && qFuzzyCompare(t1.m22(), t2.m22())
        && qFuzzyCompare(t1.m23(), t2.m23())
        && qFuzzyCompare(t1.m31(), t2.m31())
        && qFuzzyCompare(t1.m32(), t2.m32())
        && qFuzzyCompare(t1.m33(), t2.m33());
}


/****** stream functions *******************/
#ifndef QT_NO_DATASTREAM
Q_GUI_EXPORT QDataStream &operator<<(QDataStream &, ref const(QTransform) );
Q_GUI_EXPORT QDataStream &operator>>(QDataStream &, QTransform &);
#endif

#ifndef QT_NO_DEBUG_STREAM
Q_GUI_EXPORT QDebug operator<<(QDebug, ref const(QTransform) );
#endif
/****** end stream functions *******************/

// mathematical semantics
/+inline+/ QPoint operator*(ref const(QPoint) p, ref const(QTransform) m)
{ return m.map(p); }
/+inline+/ QPointF operator*(ref const(QPointF) p, ref const(QTransform) m)
{ return m.map(p); }
/+inline+/ QLineF operator*(ref const(QLineF) l, ref const(QTransform) m)
{ return m.map(l); }
/+inline+/ QLine operator*(ref const(QLine) l, ref const(QTransform) m)
{ return m.map(l); }
/+inline+/ QPolygon operator *(ref const(QPolygon) a, ref const(QTransform) m)
{ return m.map(a); }
/+inline+/ QPolygonF operator *(ref const(QPolygonF) a, ref const(QTransform) m)
{ return m.map(a); }
/+inline+/ QRegion operator *(ref const(QRegion) r, ref const(QTransform) m)
{ return m.map(r); }
/+inline+/ QPainterPath operator *(ref const(QPainterPath) p, ref const(QTransform) m)
{ return m.map(p); }

/+inline+/ QTransform operator *(ref const(QTransform) a, qreal n)
{ QTransform t(a); t *= n; return t; }
/+inline+/ QTransform operator /(ref const(QTransform) a, qreal n)
{ QTransform t(a); t /= n; return t; }
/+inline+/ QTransform operator +(ref const(QTransform) a, qreal n)
{ QTransform t(a); t += n; return t; }
/+inline+/ QTransform operator -(ref const(QTransform) a, qreal n)
{ QTransform t(a); t -= n; return t; }

QT_END_NAMESPACE

#endif // QTRANSFORM_H
