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

/*****************************************************************************
  QMargins class
 *****************************************************************************/

extern(C++) class QMargins
{
public:
    QMargins();
    QMargins(int left, int top, int right, int bottom);

    bool isNull() const;

    int left() const;
    int top() const;
    int right() const;
    int bottom() const;

    void setLeft(int left);
    void setTop(int top);
    void setRight(int right);
    void setBottom(int bottom);

    QMargins &operator+=(ref const(QMargins) margins);
    QMargins &operator-=(ref const(QMargins) margins);
    QMargins &operator+=(int);
    QMargins &operator-=(int);
    QMargins &operator*=(int);
    QMargins &operator/=(int);
    QMargins &operator*=(qreal);
    QMargins &operator/=(qreal);

private:
    int m_left;
    int m_top;
    int m_right;
    int m_bottom;

    friend /+inline+/ bool operator==(ref const(QMargins) , ref const(QMargins) );
    friend /+inline+/ bool operator!=(ref const(QMargins) , ref const(QMargins) );
}

Q_DECLARE_TYPEINFO(QMargins, Q_MOVABLE_TYPE);

/*****************************************************************************
  QMargins stream functions
 *****************************************************************************/
#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &, ref const(QMargins) );
export QDataStream &operator>>(QDataStream &, QMargins &);
#endif

/*****************************************************************************
  QMargins /+inline+/ functions
 *****************************************************************************/

/+inline+/ QMargins::QMargins() : m_left(0), m_top(0), m_right(0), m_bottom(0) {}

/+inline+/ QMargins::QMargins(int aleft, int atop, int aright, int abottom)
    : m_left(aleft), m_top(atop), m_right(aright), m_bottom(abottom) {}

/+inline+/ bool QMargins::isNull() const
{ return m_left==0 && m_top==0 && m_right==0 && m_bottom==0; }

/+inline+/ int QMargins::left() const
{ return m_left; }

/+inline+/ int QMargins::top() const
{ return m_top; }

/+inline+/ int QMargins::right() const
{ return m_right; }

/+inline+/ int QMargins::bottom() const
{ return m_bottom; }


/+inline+/ void QMargins::setLeft(int aleft)
{ m_left = aleft; }

/+inline+/ void QMargins::setTop(int atop)
{ m_top = atop; }

/+inline+/ void QMargins::setRight(int aright)
{ m_right = aright; }

/+inline+/ void QMargins::setBottom(int abottom)
{ m_bottom = abottom; }

/+inline+/ bool operator==(ref const(QMargins) m1, ref const(QMargins) m2)
{
    return
            m1.m_left == m2.m_left &&
            m1.m_top == m2.m_top &&
            m1.m_right == m2.m_right &&
            m1.m_bottom == m2.m_bottom;
}

/+inline+/ bool operator!=(ref const(QMargins) m1, ref const(QMargins) m2)
{
    return
            m1.m_left != m2.m_left ||
            m1.m_top != m2.m_top ||
            m1.m_right != m2.m_right ||
            m1.m_bottom != m2.m_bottom;
}

/+inline+/ QMargins operator+(ref const(QMargins) m1, ref const(QMargins) m2)
{
    return QMargins(m1.left() + m2.left(), m1.top() + m2.top(),
                    m1.right() + m2.right(), m1.bottom() + m2.bottom());
}

/+inline+/ QMargins operator-(ref const(QMargins) m1, ref const(QMargins) m2)
{
    return QMargins(m1.left() - m2.left(), m1.top() - m2.top(),
                    m1.right() - m2.right(), m1.bottom() - m2.bottom());
}

/+inline+/ QMargins operator+(ref const(QMargins) lhs, int rhs)
{
    return QMargins(lhs.left() + rhs, lhs.top() + rhs,
                    lhs.right() + rhs, lhs.bottom() + rhs);
}

/+inline+/ QMargins operator+(int lhs, ref const(QMargins) rhs)
{
    return QMargins(rhs.left() + lhs, rhs.top() + lhs,
                    rhs.right() + lhs, rhs.bottom() + lhs);
}

/+inline+/ QMargins operator-(ref const(QMargins) lhs, int rhs)
{
    return QMargins(lhs.left() - rhs, lhs.top() - rhs,
                    lhs.right() - rhs, lhs.bottom() - rhs);
}

/+inline+/ QMargins operator*(ref const(QMargins) margins, int factor)
{
    return QMargins(margins.left() * factor, margins.top() * factor,
                    margins.right() * factor, margins.bottom() * factor);
}

/+inline+/ QMargins operator*(int factor, ref const(QMargins) margins)
{
    return QMargins(margins.left() * factor, margins.top() * factor,
                    margins.right() * factor, margins.bottom() * factor);
}

/+inline+/ QMargins operator*(ref const(QMargins) margins, qreal factor)
{
    return QMargins(qRound(margins.left() * factor), qRound(margins.top() * factor),
                    qRound(margins.right() * factor), qRound(margins.bottom() * factor));
}

/+inline+/ QMargins operator*(qreal factor, ref const(QMargins) margins)
{
    return QMargins(qRound(margins.left() * factor), qRound(margins.top() * factor),
                    qRound(margins.right() * factor), qRound(margins.bottom() * factor));
}

/+inline+/ QMargins operator/(ref const(QMargins) margins, int divisor)
{
    return QMargins(margins.left() / divisor, margins.top() / divisor,
                    margins.right() / divisor, margins.bottom() / divisor);
}

/+inline+/ QMargins operator/(ref const(QMargins) margins, qreal divisor)
{
    return QMargins(qRound(margins.left() / divisor), qRound(margins.top() / divisor),
                    qRound(margins.right() / divisor), qRound(margins.bottom() / divisor));
}

/+inline+/ QMargins &QMargins::operator+=(ref const(QMargins) margins)
{
    return *this = *this + margins;
}

/+inline+/ QMargins &QMargins::operator-=(ref const(QMargins) margins)
{
    return *this = *this - margins;
}

/+inline+/ QMargins &QMargins::operator+=(int margin)
{
    m_left += margin;
    m_top += margin;
    m_right += margin;
    m_bottom += margin;
    return *this;
}

/+inline+/ QMargins &QMargins::operator-=(int margin)
{
    m_left -= margin;
    m_top -= margin;
    m_right -= margin;
    m_bottom -= margin;
    return *this;
}

/+inline+/ QMargins &QMargins::operator*=(int factor)
{
    return *this = *this * factor;
}

/+inline+/ QMargins &QMargins::operator/=(int divisor)
{
    return *this = *this / divisor;
}

/+inline+/ QMargins &QMargins::operator*=(qreal factor)
{
    return *this = *this * factor;
}

/+inline+/ QMargins &QMargins::operator/=(qreal divisor)
{
    return *this = *this / divisor;
}

/+inline+/ QMargins operator+(ref const(QMargins) margins)
{
    return margins;
}

/+inline+/ QMargins operator-(ref const(QMargins) margins)
{
    return QMargins(-margins.left(), -margins.top(), -margins.right(), -margins.bottom());
}

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, ref const(QMargins) );
#endif

/*****************************************************************************
  QMarginsF class
 *****************************************************************************/

extern(C++) class QMarginsF
{
public:
    QMarginsF();
    QMarginsF(qreal left, qreal top, qreal right, qreal bottom);
    QMarginsF(ref const(QMargins) margins);

    bool isNull() const;

    qreal left() const;
    qreal top() const;
    qreal right() const;
    qreal bottom() const;

    void setLeft(qreal left);
    void setTop(qreal top);
    void setRight(qreal right);
    void setBottom(qreal bottom);

    QMarginsF &operator+=(ref const(QMarginsF) margins);
    QMarginsF &operator-=(ref const(QMarginsF) margins);
    QMarginsF &operator+=(qreal addend);
    QMarginsF &operator-=(qreal subtrahend);
    QMarginsF &operator*=(qreal factor);
    QMarginsF &operator/=(qreal divisor);

    /+inline+/ QMargins toMargins() const;

private:
    qreal m_left;
    qreal m_top;
    qreal m_right;
    qreal m_bottom;
}

Q_DECLARE_TYPEINFO(QMarginsF, Q_MOVABLE_TYPE);

/*****************************************************************************
  QMarginsF stream functions
 *****************************************************************************/

#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &, ref const(QMarginsF) );
export QDataStream &operator>>(QDataStream &, QMarginsF &);
#endif

/*****************************************************************************
  QMarginsF /+inline+/ functions
 *****************************************************************************/

/+inline+/ QMarginsF::QMarginsF() : m_left(0), m_top(0), m_right(0), m_bottom(0) {}

/+inline+/ QMarginsF::QMarginsF(qreal aleft, qreal atop, qreal aright, qreal abottom)
    : m_left(aleft), m_top(atop), m_right(aright), m_bottom(abottom) {}

/+inline+/ QMarginsF::QMarginsF(ref const(QMargins) margins)
    : m_left(margins.left()), m_top(margins.top()), m_right(margins.right()), m_bottom(margins.bottom()) {}

/+inline+/ bool QMarginsF::isNull() const
{ return qFuzzyIsNull(m_left) && qFuzzyIsNull(m_top) && qFuzzyIsNull(m_right) && qFuzzyIsNull(m_bottom); }

/+inline+/ qreal QMarginsF::left() const
{ return m_left; }

/+inline+/ qreal QMarginsF::top() const
{ return m_top; }

/+inline+/ qreal QMarginsF::right() const
{ return m_right; }

/+inline+/ qreal QMarginsF::bottom() const
{ return m_bottom; }


/+inline+/ void QMarginsF::setLeft(qreal aleft)
{ m_left = aleft; }

/+inline+/ void QMarginsF::setTop(qreal atop)
{ m_top = atop; }

/+inline+/ void QMarginsF::setRight(qreal aright)
{ m_right = aright; }

/+inline+/ void QMarginsF::setBottom(qreal abottom)
{ m_bottom = abottom; }

/+inline+/ bool operator==(ref const(QMarginsF) lhs, ref const(QMarginsF) rhs)
{
    return qFuzzyCompare(lhs.left(), rhs.left())
           && qFuzzyCompare(lhs.top(), rhs.top())
           && qFuzzyCompare(lhs.right(), rhs.right())
           && qFuzzyCompare(lhs.bottom(), rhs.bottom());
}

/+inline+/ bool operator!=(ref const(QMarginsF) lhs, ref const(QMarginsF) rhs)
{
    return !operator==(lhs, rhs);
}

/+inline+/ QMarginsF operator+(ref const(QMarginsF) lhs, ref const(QMarginsF) rhs)
{
    return QMarginsF(lhs.left() + rhs.left(), lhs.top() + rhs.top(),
                     lhs.right() + rhs.right(), lhs.bottom() + rhs.bottom());
}

/+inline+/ QMarginsF operator-(ref const(QMarginsF) lhs, ref const(QMarginsF) rhs)
{
    return QMarginsF(lhs.left() - rhs.left(), lhs.top() - rhs.top(),
                     lhs.right() - rhs.right(), lhs.bottom() - rhs.bottom());
}

/+inline+/ QMarginsF operator+(ref const(QMarginsF) lhs, qreal rhs)
{
    return QMarginsF(lhs.left() + rhs, lhs.top() + rhs,
                     lhs.right() + rhs, lhs.bottom() + rhs);
}

/+inline+/ QMarginsF operator+(qreal lhs, ref const(QMarginsF) rhs)
{
    return QMarginsF(rhs.left() + lhs, rhs.top() + lhs,
                     rhs.right() + lhs, rhs.bottom() + lhs);
}

/+inline+/ QMarginsF operator-(ref const(QMarginsF) lhs, qreal rhs)
{
    return QMarginsF(lhs.left() - rhs, lhs.top() - rhs,
                     lhs.right() - rhs, lhs.bottom() - rhs);
}

/+inline+/ QMarginsF operator*(ref const(QMarginsF) lhs, qreal rhs)
{
    return QMarginsF(lhs.left() * rhs, lhs.top() * rhs,
                     lhs.right() * rhs, lhs.bottom() * rhs);
}

/+inline+/ QMarginsF operator*(qreal lhs, ref const(QMarginsF) rhs)
{
    return QMarginsF(rhs.left() * lhs, rhs.top() * lhs,
                     rhs.right() * lhs, rhs.bottom() * lhs);
}

/+inline+/ QMarginsF operator/(ref const(QMarginsF) lhs, qreal divisor)
{
    return QMarginsF(lhs.left() / divisor, lhs.top() / divisor,
                     lhs.right() / divisor, lhs.bottom() / divisor);
}

/+inline+/ QMarginsF &QMarginsF::operator+=(ref const(QMarginsF) margins)
{
    return *this = *this + margins;
}

/+inline+/ QMarginsF &QMarginsF::operator-=(ref const(QMarginsF) margins)
{
    return *this = *this - margins;
}

/+inline+/ QMarginsF &QMarginsF::operator+=(qreal addend)
{
    m_left += addend;
    m_top += addend;
    m_right += addend;
    m_bottom += addend;
    return *this;
}

/+inline+/ QMarginsF &QMarginsF::operator-=(qreal subtrahend)
{
    m_left -= subtrahend;
    m_top -= subtrahend;
    m_right -= subtrahend;
    m_bottom -= subtrahend;
    return *this;
}

/+inline+/ QMarginsF &QMarginsF::operator*=(qreal factor)
{
    return *this = *this * factor;
}

/+inline+/ QMarginsF &QMarginsF::operator/=(qreal divisor)
{
    return *this = *this / divisor;
}

/+inline+/ QMarginsF operator+(ref const(QMarginsF) margins)
{
    return margins;
}

/+inline+/ QMarginsF operator-(ref const(QMarginsF) margins)
{
    return QMarginsF(-margins.left(), -margins.top(), -margins.right(), -margins.bottom());
}

/+inline+/ QMargins QMarginsF::toMargins() const
{
    return QMargins(qRound(m_left), qRound(m_top), qRound(m_right), qRound(m_bottom));
}

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, ref const(QMarginsF) );
#endif

#endif // QMARGINS_H
