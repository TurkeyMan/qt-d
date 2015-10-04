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


extern(C++) class export QSize
{
public:
    QSize();
    QSize(int w, int h);

    /+inline+/ bool isNull() const;
    /+inline+/ bool isEmpty() const;
    /+inline+/ bool isValid() const;

    /+inline+/ int width() const;
    /+inline+/ int height() const;
    /+inline+/ void setWidth(int w);
    /+inline+/ void setHeight(int h);
    void transpose();
    /+inline+/ QSize transposed() const;

    /+inline+/ void scale(int w, int h, Qt.AspectRatioMode mode);
    /+inline+/ void scale(ref const(QSize) s, Qt.AspectRatioMode mode);
    QSize scaled(int w, int h, Qt.AspectRatioMode mode) const;
    QSize scaled(ref const(QSize) s, Qt.AspectRatioMode mode) const;

    /+inline+/ QSize expandedTo(ref const(QSize) ) const;
    /+inline+/ QSize boundedTo(ref const(QSize) ) const;

    /+inline+/ int &rwidth();
    /+inline+/ int &rheight();

    /+inline+/ QSize &operator+=(ref const(QSize) );
    /+inline+/ QSize &operator-=(ref const(QSize) );
    /+inline+/ QSize &operator*=(qreal c);
    /+inline+/ QSize &operator/=(qreal c);

    friend /+inline+/ bool operator==(ref const(QSize) , ref const(QSize) );
    friend /+inline+/ bool operator!=(ref const(QSize) , ref const(QSize) );
    friend /+inline+/ const QSize operator+(ref const(QSize) , ref const(QSize) );
    friend /+inline+/ const QSize operator-(ref const(QSize) , ref const(QSize) );
    friend /+inline+/ const QSize operator*(ref const(QSize) , qreal);
    friend /+inline+/ const QSize operator*(qreal, ref const(QSize) );
    friend /+inline+/ const QSize operator/(ref const(QSize) , qreal);

private:
    int wd;
    int ht;
}
Q_DECLARE_TYPEINFO(QSize, Q_MOVABLE_TYPE);

/*****************************************************************************
  QSize stream functions
 *****************************************************************************/

#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &, ref const(QSize) );
export QDataStream &operator>>(QDataStream &, QSize &);
#endif


/*****************************************************************************
  QSize /+inline+/ functions
 *****************************************************************************/

/+inline+/ QSize::QSize() : wd(-1), ht(-1) {}

/+inline+/ QSize::QSize(int w, int h) : wd(w), ht(h) {}

/+inline+/ bool QSize::isNull() const
{ return wd==0 && ht==0; }

/+inline+/ bool QSize::isEmpty() const
{ return wd<1 || ht<1; }

/+inline+/ bool QSize::isValid() const
{ return wd>=0 && ht>=0; }

/+inline+/ int QSize::width() const
{ return wd; }

/+inline+/ int QSize::height() const
{ return ht; }

/+inline+/ void QSize::setWidth(int w)
{ wd = w; }

/+inline+/ void QSize::setHeight(int h)
{ ht = h; }

/+inline+/ QSize QSize::transposed() const
{ return QSize(ht, wd); }

/+inline+/ void QSize::scale(int w, int h, Qt.AspectRatioMode mode)
{ scale(QSize(w, h), mode); }

/+inline+/ void QSize::scale(ref const(QSize) s, Qt.AspectRatioMode mode)
{ *this = scaled(s, mode); }

/+inline+/ QSize QSize::scaled(int w, int h, Qt.AspectRatioMode mode) const
{ return scaled(QSize(w, h), mode); }

/+inline+/ int &QSize::rwidth()
{ return wd; }

/+inline+/ int &QSize::rheight()
{ return ht; }

/+inline+/ QSize &QSize::operator+=(ref const(QSize) s)
{ wd+=s.wd; ht+=s.ht; return *this; }

/+inline+/ QSize &QSize::operator-=(ref const(QSize) s)
{ wd-=s.wd; ht-=s.ht; return *this; }

/+inline+/ QSize &QSize::operator*=(qreal c)
{ wd = qRound(wd*c); ht = qRound(ht*c); return *this; }

/+inline+/ bool operator==(ref const(QSize) s1, ref const(QSize) s2)
{ return s1.wd == s2.wd && s1.ht == s2.ht; }

/+inline+/ bool operator!=(ref const(QSize) s1, ref const(QSize) s2)
{ return s1.wd != s2.wd || s1.ht != s2.ht; }

/+inline+/ const QSize operator+(ref const(QSize)  s1, ref const(QSize)  s2)
{ return QSize(s1.wd+s2.wd, s1.ht+s2.ht); }

/+inline+/ const QSize operator-(ref const(QSize) s1, ref const(QSize) s2)
{ return QSize(s1.wd-s2.wd, s1.ht-s2.ht); }

/+inline+/ const QSize operator*(ref const(QSize) s, qreal c)
{ return QSize(qRound(s.wd*c), qRound(s.ht*c)); }

/+inline+/ const QSize operator*(qreal c, ref const(QSize) s)
{ return QSize(qRound(s.wd*c), qRound(s.ht*c)); }

/+inline+/ QSize &QSize::operator/=(qreal c)
{
    Q_ASSERT(!qFuzzyIsNull(c));
    wd = qRound(wd/c); ht = qRound(ht/c);
    return *this;
}

/+inline+/ const QSize operator/(ref const(QSize) s, qreal c)
{
    Q_ASSERT(!qFuzzyIsNull(c));
    return QSize(qRound(s.wd/c), qRound(s.ht/c));
}

/+inline+/ QSize QSize::expandedTo(ref const(QSize)  otherSize) const
{
    return QSize(qMax(wd,otherSize.wd), qMax(ht,otherSize.ht));
}

/+inline+/ QSize QSize::boundedTo(ref const(QSize)  otherSize) const
{
    return QSize(qMin(wd,otherSize.wd), qMin(ht,otherSize.ht));
}

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, ref const(QSize) );
#endif


extern(C++) class export QSizeF
{
public:
    QSizeF();
    QSizeF(ref const(QSize) sz);
    QSizeF(qreal w, qreal h);

    /+inline+/ bool isNull() const;
    /+inline+/ bool isEmpty() const;
    /+inline+/ bool isValid() const;

    /+inline+/ qreal width() const;
    /+inline+/ qreal height() const;
    /+inline+/ void setWidth(qreal w);
    /+inline+/ void setHeight(qreal h);
    void transpose();
    /+inline+/ QSizeF transposed() const;

    /+inline+/ void scale(qreal w, qreal h, Qt.AspectRatioMode mode);
    /+inline+/ void scale(ref const(QSizeF) s, Qt.AspectRatioMode mode);
    QSizeF scaled(qreal w, qreal h, Qt.AspectRatioMode mode) const;
    QSizeF scaled(ref const(QSizeF) s, Qt.AspectRatioMode mode) const;

    /+inline+/ QSizeF expandedTo(ref const(QSizeF) ) const;
    /+inline+/ QSizeF boundedTo(ref const(QSizeF) ) const;

    /+inline+/ qreal &rwidth();
    /+inline+/ qreal &rheight();

    /+inline+/ QSizeF &operator+=(ref const(QSizeF) );
    /+inline+/ QSizeF &operator-=(ref const(QSizeF) );
    /+inline+/ QSizeF &operator*=(qreal c);
    /+inline+/ QSizeF &operator/=(qreal c);

    friend /+inline+/ bool operator==(ref const(QSizeF) , ref const(QSizeF) );
    friend /+inline+/ bool operator!=(ref const(QSizeF) , ref const(QSizeF) );
    friend /+inline+/ const QSizeF operator+(ref const(QSizeF) , ref const(QSizeF) );
    friend /+inline+/ const QSizeF operator-(ref const(QSizeF) , ref const(QSizeF) );
    friend /+inline+/ const QSizeF operator*(ref const(QSizeF) , qreal);
    friend /+inline+/ const QSizeF operator*(qreal, ref const(QSizeF) );
    friend /+inline+/ const QSizeF operator/(ref const(QSizeF) , qreal);

    /+inline+/ QSize toSize() const;

private:
    qreal wd;
    qreal ht;
}
Q_DECLARE_TYPEINFO(QSizeF, Q_MOVABLE_TYPE);


/*****************************************************************************
  QSizeF stream functions
 *****************************************************************************/

#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &, ref const(QSizeF) );
export QDataStream &operator>>(QDataStream &, QSizeF &);
#endif


/*****************************************************************************
  QSizeF /+inline+/ functions
 *****************************************************************************/

/+inline+/ QSizeF::QSizeF() : wd(-1.), ht(-1.) {}

/+inline+/ QSizeF::QSizeF(ref const(QSize) sz) : wd(sz.width()), ht(sz.height()) {}

/+inline+/ QSizeF::QSizeF(qreal w, qreal h) : wd(w), ht(h) {}

/+inline+/ bool QSizeF::isNull() const
{ return qIsNull(wd) && qIsNull(ht); }

/+inline+/ bool QSizeF::isEmpty() const
{ return wd <= 0. || ht <= 0.; }

/+inline+/ bool QSizeF::isValid() const
{ return wd >= 0. && ht >= 0.; }

/+inline+/ qreal QSizeF::width() const
{ return wd; }

/+inline+/ qreal QSizeF::height() const
{ return ht; }

/+inline+/ void QSizeF::setWidth(qreal w)
{ wd = w; }

/+inline+/ void QSizeF::setHeight(qreal h)
{ ht = h; }

/+inline+/ QSizeF QSizeF::transposed() const
{ return QSizeF(ht, wd); }

/+inline+/ void QSizeF::scale(qreal w, qreal h, Qt.AspectRatioMode mode)
{ scale(QSizeF(w, h), mode); }

/+inline+/ void QSizeF::scale(ref const(QSizeF) s, Qt.AspectRatioMode mode)
{ *this = scaled(s, mode); }

/+inline+/ QSizeF QSizeF::scaled(qreal w, qreal h, Qt.AspectRatioMode mode) const
{ return scaled(QSizeF(w, h), mode); }

/+inline+/ qreal &QSizeF::rwidth()
{ return wd; }

/+inline+/ qreal &QSizeF::rheight()
{ return ht; }

/+inline+/ QSizeF &QSizeF::operator+=(ref const(QSizeF) s)
{ wd += s.wd; ht += s.ht; return *this; }

/+inline+/ QSizeF &QSizeF::operator-=(ref const(QSizeF) s)
{ wd -= s.wd; ht -= s.ht; return *this; }

/+inline+/ QSizeF &QSizeF::operator*=(qreal c)
{ wd *= c; ht *= c; return *this; }

/+inline+/ bool operator==(ref const(QSizeF) s1, ref const(QSizeF) s2)
{ return qFuzzyCompare(s1.wd, s2.wd) && qFuzzyCompare(s1.ht, s2.ht); }

/+inline+/ bool operator!=(ref const(QSizeF) s1, ref const(QSizeF) s2)
{ return !qFuzzyCompare(s1.wd, s2.wd) || !qFuzzyCompare(s1.ht, s2.ht); }

/+inline+/ const QSizeF operator+(ref const(QSizeF)  s1, ref const(QSizeF)  s2)
{ return QSizeF(s1.wd+s2.wd, s1.ht+s2.ht); }

/+inline+/ const QSizeF operator-(ref const(QSizeF) s1, ref const(QSizeF) s2)
{ return QSizeF(s1.wd-s2.wd, s1.ht-s2.ht); }

/+inline+/ const QSizeF operator*(ref const(QSizeF) s, qreal c)
{ return QSizeF(s.wd*c, s.ht*c); }

/+inline+/ const QSizeF operator*(qreal c, ref const(QSizeF) s)
{ return QSizeF(s.wd*c, s.ht*c); }

/+inline+/ QSizeF &QSizeF::operator/=(qreal c)
{
    Q_ASSERT(!qFuzzyIsNull(c));
    wd = wd/c; ht = ht/c;
    return *this;
}

/+inline+/ const QSizeF operator/(ref const(QSizeF) s, qreal c)
{
    Q_ASSERT(!qFuzzyIsNull(c));
    return QSizeF(s.wd/c, s.ht/c);
}

/+inline+/ QSizeF QSizeF::expandedTo(ref const(QSizeF)  otherSize) const
{
    return QSizeF(qMax(wd,otherSize.wd), qMax(ht,otherSize.ht));
}

/+inline+/ QSizeF QSizeF::boundedTo(ref const(QSizeF)  otherSize) const
{
    return QSizeF(qMin(wd,otherSize.wd), qMin(ht,otherSize.ht));
}

/+inline+/ QSize QSizeF::toSize() const
{
    return QSize(qRound(wd), qRound(ht));
}

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, ref const(QSizeF) );
#endif

#endif // QSIZE_H
