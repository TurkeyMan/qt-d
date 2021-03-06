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

public import QtCore.qglobal;
public import QtCore.qobjectdefs;
public import QtCore.qvector;
#if QT_DEPRECATED_SINCE(5, 0)
public import qt.QtCore.qlist;
public import qt.QtCore.qpoint;
#endif


extern(C++) class QEasingCurvePrivate;
extern(C++) class QPointF;
extern(C++) class export QEasingCurve
{
    Q_GADGET
    Q_ENUMS(Type)
public:
    enum Type {
        Linear,
        InQuad, OutQuad, InOutQuad, OutInQuad,
        InCubic, OutCubic, InOutCubic, OutInCubic,
        InQuart, OutQuart, InOutQuart, OutInQuart,
        InQuint, OutQuint, InOutQuint, OutInQuint,
        InSine, OutSine, InOutSine, OutInSine,
        InExpo, OutExpo, InOutExpo, OutInExpo,
        InCirc, OutCirc, InOutCirc, OutInCirc,
        InElastic, OutElastic, InOutElastic, OutInElastic,
        InBack, OutBack, InOutBack, OutInBack,
        InBounce, OutBounce, InOutBounce, OutInBounce,
        InCurve, OutCurve, SineCurve, CosineCurve,
        BezierSpline, TCBSpline, Custom, NCurveTypes
    }

    QEasingCurve(Type type = Linear);
    QEasingCurve(ref const(QEasingCurve) other);
    ~QEasingCurve();

    QEasingCurve &operator=(ref const(QEasingCurve) other)
    { if ( this != &other ) { QEasingCurve copy(other); swap(copy); } return *this; }
#ifdef Q_COMPILER_RVALUE_REFS
    QEasingCurve(QEasingCurve &&other) : d_ptr(other.d_ptr) { other.d_ptr = 0; }
    QEasingCurve &operator=(QEasingCurve &&other)
    { qSwap(d_ptr, other.d_ptr); return *this; }
#endif

    /+inline+/ void swap(QEasingCurve &other) { qSwap(d_ptr, other.d_ptr); }

    bool operator==(ref const(QEasingCurve) other) const;
    /+inline+/ bool operator!=(ref const(QEasingCurve) other) const
    { return !(this->operator==(other)); }

    qreal amplitude() const;
    void setAmplitude(qreal amplitude);

    qreal period() const;
    void setPeriod(qreal period);

    qreal overshoot() const;
    void setOvershoot(qreal overshoot);

    void addCubicBezierSegment(ref const(QPointF)  c1, ref const(QPointF)  c2, ref const(QPointF)  endPoint);
    void addTCBSegment(ref const(QPointF) nextPoint, qreal t, qreal c, qreal b);
    QVector<QPointF> toCubicSpline() const;
#if QT_DEPRECATED_SINCE(5, 0)
    QT_DEPRECATED QList<QPointF> cubicBezierSpline() const { return toCubicSpline().toList(); }
#endif

    Type type() const;
    void setType(Type type);
    typedef qreal (*EasingFunction)(qreal progress);
    void setCustomType(EasingFunction func);
    EasingFunction customType() const;

    qreal valueForProgress(qreal progress) const;
private:
    QEasingCurvePrivate *d_ptr;
#ifndef QT_NO_DEBUG_STREAM
    friend export QDebug operator<<(QDebug debug, ref const(QEasingCurve) item);
#endif
#ifndef QT_NO_DATASTREAM
    friend export QDataStream &operator<<(QDataStream &, ref const(QEasingCurve));
    friend export QDataStream &operator>>(QDataStream &, QEasingCurve &);
#endif
}
Q_DECLARE_TYPEINFO(QEasingCurve, Q_MOVABLE_TYPE);

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug debug, ref const(QEasingCurve) item);
#endif

#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &, ref const(QEasingCurve));
export QDataStream &operator>>(QDataStream &, QEasingCurve &);
#endif

#endif
