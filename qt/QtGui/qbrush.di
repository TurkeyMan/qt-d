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

#ifndef QBRUSH_H
#define QBRUSH_H

public import qt.QtCore.qpair;
public import qt.QtCore.qpoint;
public import qt.QtCore.qvector;
public import qt.QtCore.qscopedpointer;
public import qt.QtGui.qcolor;
public import qt.QtGui.qmatrix;
public import qt.QtGui.qtransform;
public import qt.QtGui.qimage;
public import qt.QtGui.qpixmap;

QT_BEGIN_NAMESPACE


struct QBrushData;
class QPixmap;
class QGradient;
class QVariant;
struct QBrushDataPointerDeleter;

class Q_GUI_EXPORT QBrush
{
public:
    QBrush();
    QBrush(Qt.BrushStyle bs);
    QBrush(ref const(QColor) color, Qt.BrushStyle bs=Qt.SolidPattern);
    QBrush(Qt.GlobalColor color, Qt.BrushStyle bs=Qt.SolidPattern);

    QBrush(ref const(QColor) color, ref const(QPixmap) pixmap);
    QBrush(Qt.GlobalColor color, ref const(QPixmap) pixmap);
    QBrush(ref const(QPixmap) pixmap);
    QBrush(ref const(QImage) image);

    QBrush(ref const(QBrush) brush);

    QBrush(ref const(QGradient) gradient);

    ~QBrush();
    QBrush &operator=(ref const(QBrush) brush);
#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QBrush &operator=(QBrush &&other)
    { qSwap(d, other.d); return *this; }
#endif
    /+inline+/ void swap(QBrush &other) { qSwap(d, other.d); }

    operator QVariant() const;

    /+inline+/ Qt.BrushStyle style() const;
    void setStyle(Qt.BrushStyle);

    /+inline+/ ref const(QMatrix) matrix() const;
    void setMatrix(ref const(QMatrix) mat);

    /+inline+/ QTransform transform() const;
    void setTransform(ref const(QTransform) );

    QPixmap texture() const;
    void setTexture(ref const(QPixmap) pixmap);

    QImage textureImage() const;
    void setTextureImage(ref const(QImage) image);

    /+inline+/ ref const(QColor) color() const;
    void setColor(ref const(QColor) color);
    /+inline+/ void setColor(Qt.GlobalColor color);

    const(QGradient)* gradient() const;

    bool isOpaque() const;

    bool operator==(ref const(QBrush) b) const;
    /+inline+/ bool operator!=(ref const(QBrush) b) const { return !(operator==(b)); }

private:
    friend class QRasterPaintEngine;
    friend class QRasterPaintEnginePrivate;
    friend struct QSpanData;
    friend class QPainter;
    friend bool Q_GUI_EXPORT qHasPixmapTexture(ref const(QBrush) brush);
    void detach(Qt.BrushStyle newStyle);
    void init(ref const(QColor) color, Qt.BrushStyle bs);
    QScopedPointer<QBrushData, QBrushDataPointerDeleter> d;
    void cleanUp(QBrushData *x);

public:
    /+inline+/ bool isDetached() const;
    typedef QScopedPointer<QBrushData, QBrushDataPointerDeleter> DataPtr;
    /+inline+/ DataPtr &data_ptr() { return d; }
};

/+inline+/ void QBrush::setColor(Qt.GlobalColor acolor)
{ setColor(QColor(acolor)); }

Q_DECLARE_SHARED(QBrush)

/*****************************************************************************
  QBrush stream functions
 *****************************************************************************/

#ifndef QT_NO_DATASTREAM
Q_GUI_EXPORT QDataStream &operator<<(QDataStream &, ref const(QBrush) );
Q_GUI_EXPORT QDataStream &operator>>(QDataStream &, QBrush &);
#endif

#ifndef QT_NO_DEBUG_STREAM
Q_GUI_EXPORT QDebug operator<<(QDebug, ref const(QBrush) );
#endif

struct QBrushData
{
    QAtomicInt ref;
    Qt.BrushStyle style;
    QColor color;
    QTransform transform;
};

/+inline+/ Qt.BrushStyle QBrush::style() const { return d->style; }
/+inline+/ ref const(QColor) QBrush::color() const { return d->color; }
/+inline+/ ref const(QMatrix) QBrush::matrix() const { return d->transform.toAffine(); }
/+inline+/ QTransform QBrush::transform() const { return d->transform; }
/+inline+/ bool QBrush::isDetached() const { return d->ref.load() == 1; }


/*******************************************************************************
 * QGradients
 */
class QGradientPrivate;

typedef QPair<qreal, QColor> QGradientStop;
typedef QVector<QGradientStop> QGradientStops;

class Q_GUI_EXPORT QGradient
{
    Q_GADGET
    Q_ENUMS(Type Spread CoordinateMode)
public:
    enum Type {
        LinearGradient,
        RadialGradient,
        ConicalGradient,
        NoGradient
    };

    enum Spread {
        PadSpread,
        ReflectSpread,
        RepeatSpread
    };

    enum CoordinateMode {
        LogicalMode,
        StretchToDeviceMode,
        ObjectBoundingMode
    };

    enum InterpolationMode {
        ColorInterpolation,
        ComponentInterpolation
    };

    QGradient();

    Type type() const { return m_type; }

    /+inline+/ void setSpread(Spread spread);
    Spread spread() const { return m_spread; }

    void setColorAt(qreal pos, ref const(QColor) color);

    void setStops(ref const(QGradientStops) stops);
    QGradientStops stops() const;

    CoordinateMode coordinateMode() const;
    void setCoordinateMode(CoordinateMode mode);

    InterpolationMode interpolationMode() const;
    void setInterpolationMode(InterpolationMode mode);

    bool operator==(ref const(QGradient) gradient) const;
    /+inline+/ bool operator!=(ref const(QGradient) other) const
    { return !operator==(other); }

private:
    friend class QLinearGradient;
    friend class QRadialGradient;
    friend class QConicalGradient;
    friend class QBrush;

    Type m_type;
    Spread m_spread;
    QGradientStops m_stops;
    union {
        struct {
            qreal x1, y1, x2, y2;
        } linear;
        struct {
            qreal cx, cy, fx, fy, cradius;
        } radial;
        struct {
            qreal cx, cy, angle;
        } conical;
    } m_data;
    void *dummy;
};

/+inline+/ void QGradient::setSpread(Spread aspread)
{ m_spread = aspread; }

class Q_GUI_EXPORT QLinearGradient : public QGradient
{
public:
    QLinearGradient();
    QLinearGradient(ref const(QPointF) start, ref const(QPointF) finalStop);
    QLinearGradient(qreal xStart, qreal yStart, qreal xFinalStop, qreal yFinalStop);

    QPointF start() const;
    void setStart(ref const(QPointF) start);
    /+inline+/ void setStart(qreal x, qreal y) { setStart(QPointF(x, y)); }

    QPointF finalStop() const;
    void setFinalStop(ref const(QPointF) stop);
    /+inline+/ void setFinalStop(qreal x, qreal y) { setFinalStop(QPointF(x, y)); }
};


class Q_GUI_EXPORT QRadialGradient : public QGradient
{
public:
    QRadialGradient();
    QRadialGradient(ref const(QPointF) center, qreal radius, ref const(QPointF) focalPoint);
    QRadialGradient(qreal cx, qreal cy, qreal radius, qreal fx, qreal fy);

    QRadialGradient(ref const(QPointF) center, qreal radius);
    QRadialGradient(qreal cx, qreal cy, qreal radius);

    QRadialGradient(ref const(QPointF) center, qreal centerRadius, ref const(QPointF) focalPoint, qreal focalRadius);
    QRadialGradient(qreal cx, qreal cy, qreal centerRadius, qreal fx, qreal fy, qreal focalRadius);

    QPointF center() const;
    void setCenter(ref const(QPointF) center);
    /+inline+/ void setCenter(qreal x, qreal y) { setCenter(QPointF(x, y)); }

    QPointF focalPoint() const;
    void setFocalPoint(ref const(QPointF) focalPoint);
    /+inline+/ void setFocalPoint(qreal x, qreal y) { setFocalPoint(QPointF(x, y)); }

    qreal radius() const;
    void setRadius(qreal radius);

    qreal centerRadius() const;
    void setCenterRadius(qreal radius);

    qreal focalRadius() const;
    void setFocalRadius(qreal radius);
};


class Q_GUI_EXPORT QConicalGradient : public QGradient
{
public:
    QConicalGradient();
    QConicalGradient(ref const(QPointF) center, qreal startAngle);
    QConicalGradient(qreal cx, qreal cy, qreal startAngle);

    QPointF center() const;
    void setCenter(ref const(QPointF) center);
    /+inline+/ void setCenter(qreal x, qreal y) { setCenter(QPointF(x, y)); }

    qreal angle() const;
    void setAngle(qreal angle);
};

QT_END_NAMESPACE

#endif // QBRUSH_H
