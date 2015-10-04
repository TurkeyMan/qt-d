/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtWidgets module of the Qt Toolkit.
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

#ifndef QGRAPHICSEFFECT_H
#define QGRAPHICSEFFECT_H

public import qt.QtCore.qobject;
public import qt.QtCore.qpoint;
public import qt.QtCore.qrect;
public import qt.QtGui.qcolor;
public import qt.QtGui.qbrush;

#ifndef QT_NO_GRAPHICSEFFECT
QT_BEGIN_NAMESPACE


class QGraphicsItem;
class QStyleOption;
class QPainter;
class QPixmap;

class QGraphicsEffectSource;

class QGraphicsEffectPrivate;
class Q_WIDGETS_EXPORT QGraphicsEffect : public QObject
{
    mixin Q_OBJECT;
    Q_FLAGS(ChangeFlags)
    mixin Q_PROPERTY!(bool, "enabled", "READ", "isEnabled", "WRITE", "setEnabled", "NOTIFY", "enabledChanged");
public:
    enum ChangeFlag {
        SourceAttached = 0x1,
        SourceDetached = 0x2,
        SourceBoundingRectChanged = 0x4,
        SourceInvalidated = 0x8
    };
    Q_DECLARE_FLAGS(ChangeFlags, ChangeFlag)

    enum PixmapPadMode {
        NoPad,
        PadToTransparentBorder,
        PadToEffectiveBoundingRect
    };

    QGraphicsEffect(QObject *parent = 0);
    /+virtual+/ ~QGraphicsEffect();

    /+virtual+/ QRectF boundingRectFor(ref const(QRectF) sourceRect) const;
    QRectF boundingRect() const;

    bool isEnabled() const;

public Q_SLOTS:
    void setEnabled(bool enable);
    void update();

Q_SIGNALS:
    void enabledChanged(bool enabled);

protected:
    QGraphicsEffect(QGraphicsEffectPrivate &d, QObject *parent = 0);
    /+virtual+/ void draw(QPainter *painter) = 0;
    /+virtual+/ void sourceChanged(ChangeFlags flags);
    void updateBoundingRect();

    bool sourceIsPixmap() const;
    QRectF sourceBoundingRect(Qt.CoordinateSystem system = Qt.LogicalCoordinates) const;
    void drawSource(QPainter *painter);
    QPixmap sourcePixmap(Qt.CoordinateSystem system = Qt.LogicalCoordinates,
                         QPoint *offset = 0,
                         PixmapPadMode mode = PadToEffectiveBoundingRect) const;

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    friend class QGraphicsItem;
    friend class QGraphicsItemPrivate;
    friend class QGraphicsScenePrivate;
    friend class QWidget;
    friend class QWidgetPrivate;

public:
    QGraphicsEffectSource *source() const; // internal

};
Q_DECLARE_OPERATORS_FOR_FLAGS(QGraphicsEffect::ChangeFlags)

class QGraphicsColorizeEffectPrivate;
class Q_WIDGETS_EXPORT QGraphicsColorizeEffect: public QGraphicsEffect
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QColor, "color", "READ", "color", "WRITE", "setColor", "NOTIFY", "colorChanged");
    mixin Q_PROPERTY!(qreal, "strength", "READ", "strength", "WRITE", "setStrength", "NOTIFY", "strengthChanged");
public:
    QGraphicsColorizeEffect(QObject *parent = 0);
    ~QGraphicsColorizeEffect();

    QColor color() const;
    qreal strength() const;

public Q_SLOTS:
    void setColor(ref const(QColor) c);
    void setStrength(qreal strength);

Q_SIGNALS:
    void colorChanged(ref const(QColor) color);
    void strengthChanged(qreal strength);

protected:
    void draw(QPainter *painter);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

class QGraphicsBlurEffectPrivate;
class Q_WIDGETS_EXPORT QGraphicsBlurEffect: public QGraphicsEffect
{
    mixin Q_OBJECT;
    Q_FLAGS(BlurHint BlurHints)
    mixin Q_PROPERTY!(qreal, "blurRadius", "READ", "blurRadius", "WRITE", "setBlurRadius", "NOTIFY", "blurRadiusChanged");
    mixin Q_PROPERTY!(BlurHints, "blurHints", "READ", "blurHints", "WRITE", "setBlurHints", "NOTIFY", "blurHintsChanged");
public:
    enum BlurHint {
        PerformanceHint = 0x00,
        QualityHint = 0x01,
        AnimationHint = 0x02
    };
    Q_DECLARE_FLAGS(BlurHints, BlurHint)

    QGraphicsBlurEffect(QObject *parent = 0);
    ~QGraphicsBlurEffect();

    QRectF boundingRectFor(ref const(QRectF) rect) const;
    qreal blurRadius() const;
    BlurHints blurHints() const;

public Q_SLOTS:
    void setBlurRadius(qreal blurRadius);
    void setBlurHints(BlurHints hints);

Q_SIGNALS:
    void blurRadiusChanged(qreal blurRadius);
    void blurHintsChanged(BlurHints hints);

protected:
    void draw(QPainter *painter);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QGraphicsBlurEffect::BlurHints)

class QGraphicsDropShadowEffectPrivate;
class Q_WIDGETS_EXPORT QGraphicsDropShadowEffect: public QGraphicsEffect
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QPointF, "offset", "READ", "offset", "WRITE", "setOffset", "NOTIFY", "offsetChanged");
    mixin Q_PROPERTY!(qreal, "xOffset", "READ", "xOffset", "WRITE", "setXOffset", "NOTIFY", "offsetChanged");
    mixin Q_PROPERTY!(qreal, "yOffset", "READ", "yOffset", "WRITE", "setYOffset", "NOTIFY", "offsetChanged");
    mixin Q_PROPERTY!(qreal, "blurRadius", "READ", "blurRadius", "WRITE", "setBlurRadius", "NOTIFY", "blurRadiusChanged");
    mixin Q_PROPERTY!(QColor, "color", "READ", "color", "WRITE", "setColor", "NOTIFY", "colorChanged");
public:
    QGraphicsDropShadowEffect(QObject *parent = 0);
    ~QGraphicsDropShadowEffect();

    QRectF boundingRectFor(ref const(QRectF) rect) const;
    QPointF offset() const;

    /+inline+/ qreal xOffset() const
    { return offset().x(); }

    /+inline+/ qreal yOffset() const
    { return offset().y(); }

    qreal blurRadius() const;
    QColor color() const;

public Q_SLOTS:
    void setOffset(ref const(QPointF) ofs);

    /+inline+/ void setOffset(qreal dx, qreal dy)
    { setOffset(QPointF(dx, dy)); }

    /+inline+/ void setOffset(qreal d)
    { setOffset(QPointF(d, d)); }

    /+inline+/ void setXOffset(qreal dx)
    { setOffset(QPointF(dx, yOffset())); }

    /+inline+/ void setYOffset(qreal dy)
    { setOffset(QPointF(xOffset(), dy)); }

    void setBlurRadius(qreal blurRadius);
    void setColor(ref const(QColor) color);

Q_SIGNALS:
    void offsetChanged(ref const(QPointF) offset);
    void blurRadiusChanged(qreal blurRadius);
    void colorChanged(ref const(QColor) color);

protected:
    void draw(QPainter *painter);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

class QGraphicsOpacityEffectPrivate;
class Q_WIDGETS_EXPORT QGraphicsOpacityEffect: public QGraphicsEffect
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(qreal, "opacity", "READ", "opacity", "WRITE", "setOpacity", "NOTIFY", "opacityChanged");
    mixin Q_PROPERTY!(QBrush, "opacityMask", "READ", "opacityMask", "WRITE", "setOpacityMask", "NOTIFY", "opacityMaskChanged");
public:
    QGraphicsOpacityEffect(QObject *parent = 0);
    ~QGraphicsOpacityEffect();

    qreal opacity() const;
    QBrush opacityMask() const;

public Q_SLOTS:
    void setOpacity(qreal opacity);
    void setOpacityMask(ref const(QBrush) mask);

Q_SIGNALS:
    void opacityChanged(qreal opacity);
    void opacityMaskChanged(ref const(QBrush) mask);

protected:
    void draw(QPainter *painter);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

QT_END_NAMESPACE

#endif //QT_NO_GRAPHICSEFFECT

#endif // QGRAPHICSEFFECT_H

