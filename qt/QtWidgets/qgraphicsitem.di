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

#ifndef QGRAPHICSITEM_H
#define QGRAPHICSITEM_H

public import qt.QtCore.qglobal;
public import qt.QtCore.qobject;
public import qt.QtCore.qvariant;
public import qt.QtCore.qrect;
public import qt.QtCore.qscopedpointer;
public import qt.QtGui.qpainterpath;
public import qt.QtGui.qpixmap;

class tst_QGraphicsItem;

QT_BEGIN_NAMESPACE


#if !defined(QT_NO_GRAPHICSVIEW)

class QBrush;
class QCursor;
class QFocusEvent;
class QGraphicsEffect;
class QGraphicsItemGroup;
class QGraphicsObject;
class QGraphicsSceneContextMenuEvent;
class QGraphicsSceneDragDropEvent;
class QGraphicsSceneEvent;
class QGraphicsSceneHoverEvent;
class QGraphicsSceneMouseEvent;
class QGraphicsSceneWheelEvent;
class QGraphicsScene;
class QGraphicsTransform;
class QGraphicsWidget;
class QInputMethodEvent;
class QKeyEvent;
class QMatrix;
class QMenu;
class QPainter;
class QPen;
class QPointF;
class QRectF;
class QStyleOptionGraphicsItem;

class QGraphicsItemPrivate;
class Q_WIDGETS_EXPORT QGraphicsItem
{
public:
    enum GraphicsItemFlag {
        ItemIsMovable = 0x1,
        ItemIsSelectable = 0x2,
        ItemIsFocusable = 0x4,
        ItemClipsToShape = 0x8,
        ItemClipsChildrenToShape = 0x10,
        ItemIgnoresTransformations = 0x20,
        ItemIgnoresParentOpacity = 0x40,
        ItemDoesntPropagateOpacityToChildren = 0x80,
        ItemStacksBehindParent = 0x100,
        ItemUsesExtendedStyleOption = 0x200,
        ItemHasNoContents = 0x400,
        ItemSendsGeometryChanges = 0x800,
        ItemAcceptsInputMethod = 0x1000,
        ItemNegativeZStacksBehindParent = 0x2000,
        ItemIsPanel = 0x4000,
        ItemIsFocusScope = 0x8000, // internal
        ItemSendsScenePositionChanges = 0x10000,
        ItemStopsClickFocusPropagation = 0x20000,
        ItemStopsFocusHandling = 0x40000,
        ItemContainsChildrenInShape = 0x80000
        // NB! Don't forget to increase the d_ptr->flags bit field by 1 when adding a new flag.
    };
    Q_DECLARE_FLAGS(GraphicsItemFlags, GraphicsItemFlag)

    enum GraphicsItemChange {
        ItemPositionChange,
        ItemMatrixChange,
        ItemVisibleChange,
        ItemEnabledChange,
        ItemSelectedChange,
        ItemParentChange,
        ItemChildAddedChange,
        ItemChildRemovedChange,
        ItemTransformChange,
        ItemPositionHasChanged,
        ItemTransformHasChanged,
        ItemSceneChange,
        ItemVisibleHasChanged,
        ItemEnabledHasChanged,
        ItemSelectedHasChanged,
        ItemParentHasChanged,
        ItemSceneHasChanged,
        ItemCursorChange,
        ItemCursorHasChanged,
        ItemToolTipChange,
        ItemToolTipHasChanged,
        ItemFlagsChange,
        ItemFlagsHaveChanged,
        ItemZValueChange,
        ItemZValueHasChanged,
        ItemOpacityChange,
        ItemOpacityHasChanged,
        ItemScenePositionHasChanged,
        ItemRotationChange,
        ItemRotationHasChanged,
        ItemScaleChange,
        ItemScaleHasChanged,
        ItemTransformOriginPointChange,
        ItemTransformOriginPointHasChanged
    };

    enum CacheMode {
        NoCache,
        ItemCoordinateCache,
        DeviceCoordinateCache
    };

    enum PanelModality
    {
        NonModal,
        PanelModal,
        SceneModal
    };

    explicit QGraphicsItem(QGraphicsItem *parent = 0);
    /+virtual+/ ~QGraphicsItem();

    QGraphicsScene *scene() const;

    QGraphicsItem *parentItem() const;
    QGraphicsItem *topLevelItem() const;
    QGraphicsObject *parentObject() const;
    QGraphicsWidget *parentWidget() const;
    QGraphicsWidget *topLevelWidget() const;
    QGraphicsWidget *window() const;
    QGraphicsItem *panel() const;
    void setParentItem(QGraphicsItem *parent);
#if QT_DEPRECATED_SINCE(5, 0)
    QT_DEPRECATED /+inline+/ QList<QGraphicsItem *> children() const { return childItems(); }
#endif
    QList<QGraphicsItem *> childItems() const;
    bool isWidget() const;
    bool isWindow() const;
    bool isPanel() const;

    QGraphicsObject *toGraphicsObject();
    const(QGraphicsObject)* toGraphicsObject() const;

    QGraphicsItemGroup *group() const;
    void setGroup(QGraphicsItemGroup *group);

    GraphicsItemFlags flags() const;
    void setFlag(GraphicsItemFlag flag, bool enabled = true);
    void setFlags(GraphicsItemFlags flags);

    CacheMode cacheMode() const;
    void setCacheMode(CacheMode mode, ref const(QSize) cacheSize = QSize());

    PanelModality panelModality() const;
    void setPanelModality(PanelModality panelModality);
    bool isBlockedByModalPanel(QGraphicsItem **blockingPanel = 0) const;

#ifndef QT_NO_TOOLTIP
    QString toolTip() const;
    void setToolTip(ref const(QString) toolTip);
#endif

#ifndef QT_NO_CURSOR
    QCursor cursor() const;
    void setCursor(ref const(QCursor) cursor);
    bool hasCursor() const;
    void unsetCursor();
#endif

    bool isVisible() const;
    bool isVisibleTo(const(QGraphicsItem)* parent) const;
    void setVisible(bool visible);
    /+inline+/ void hide() { setVisible(false); }
    /+inline+/ void show() { setVisible(true); }

    bool isEnabled() const;
    void setEnabled(bool enabled);

    bool isSelected() const;
    void setSelected(bool selected);

    bool acceptDrops() const;
    void setAcceptDrops(bool on);

    qreal opacity() const;
    qreal effectiveOpacity() const;
    void setOpacity(qreal opacity);

#ifndef QT_NO_GRAPHICSEFFECT
    // Effect
    QGraphicsEffect *graphicsEffect() const;
    void setGraphicsEffect(QGraphicsEffect *effect);
#endif //QT_NO_GRAPHICSEFFECT

    Qt.MouseButtons acceptedMouseButtons() const;
    void setAcceptedMouseButtons(Qt.MouseButtons buttons);
#if QT_DEPRECATED_SINCE(5, 0)
    QT_DEPRECATED /+inline+/ bool acceptsHoverEvents() const { return acceptHoverEvents(); }
    QT_DEPRECATED /+inline+/ void setAcceptsHoverEvents(bool enabled) { setAcceptHoverEvents(enabled); }
#endif
    bool acceptHoverEvents() const;
    void setAcceptHoverEvents(bool enabled);
    bool acceptTouchEvents() const;
    void setAcceptTouchEvents(bool enabled);

    bool filtersChildEvents() const;
    void setFiltersChildEvents(bool enabled);

    bool handlesChildEvents() const;
    void setHandlesChildEvents(bool enabled);

    bool isActive() const;
    void setActive(bool active);

    bool hasFocus() const;
    void setFocus(Qt.FocusReason focusReason = Qt.OtherFocusReason);
    void clearFocus();

    QGraphicsItem *focusProxy() const;
    void setFocusProxy(QGraphicsItem *item);

    QGraphicsItem *focusItem() const;
    QGraphicsItem *focusScopeItem() const;

    void grabMouse();
    void ungrabMouse();
    void grabKeyboard();
    void ungrabKeyboard();

    // Positioning in scene coordinates
    QPointF pos() const;
    /+inline+/ qreal x() const { return pos().x(); }
    void setX(qreal x);
    /+inline+/ qreal y() const { return pos().y(); }
    void setY(qreal y);
    QPointF scenePos() const;
    void setPos(ref const(QPointF) pos);
    /+inline+/ void setPos(qreal x, qreal y);
    /+inline+/ void moveBy(qreal dx, qreal dy) { setPos(pos().x() + dx, pos().y() + dy); }

    void ensureVisible(ref const(QRectF) rect = QRectF(), int xmargin = 50, int ymargin = 50);
    /+inline+/ void ensureVisible(qreal x, qreal y, qreal w, qreal h, int xmargin = 50, int ymargin = 50);

    // Local transformation
    QMatrix matrix() const;
    QMatrix sceneMatrix() const;
    void setMatrix(ref const(QMatrix) matrix, bool combine = false);
    void resetMatrix();
    QTransform transform() const;
    QTransform sceneTransform() const;
    QTransform deviceTransform(ref const(QTransform) viewportTransform) const;
    QTransform itemTransform(const(QGraphicsItem)* other, bool *ok = 0) const;
    void setTransform(ref const(QTransform) matrix, bool combine = false);
    void resetTransform();
#if QT_DEPRECATED_SINCE(5, 0)
    QT_DEPRECATED /+inline+/ void rotate(qreal angle) { setTransform(QTransform().rotate(angle), true); }
    QT_DEPRECATED /+inline+/ void scale(qreal sx, qreal sy) { setTransform(QTransform::fromScale(sx, sy), true); }
    QT_DEPRECATED /+inline+/ void shear(qreal sh, qreal sv) { setTransform(QTransform().shear(sh, sv), true); }
    QT_DEPRECATED /+inline+/ void translate(qreal dx, qreal dy) { setTransform(QTransform::fromTranslate(dx, dy), true); }
#endif
    void setRotation(qreal angle);
    qreal rotation() const;

    void setScale(qreal scale);
    qreal scale() const;

    QList<QGraphicsTransform *> transformations() const;
    void setTransformations(const QList<QGraphicsTransform *> &transformations);

    QPointF transformOriginPoint() const;
    void setTransformOriginPoint(ref const(QPointF) origin);
    /+inline+/ void setTransformOriginPoint(qreal ax, qreal ay)
    { setTransformOriginPoint(QPointF(ax,ay)); }

    /+virtual+/ void advance(int phase);

    // Stacking order
    qreal zValue() const;
    void setZValue(qreal z);
    void stackBefore(const(QGraphicsItem)* sibling);

    // Hit test
    /+virtual+/ QRectF boundingRect() const = 0;
    QRectF childrenBoundingRect() const;
    QRectF sceneBoundingRect() const;
    /+virtual+/ QPainterPath shape() const;
    bool isClipped() const;
    QPainterPath clipPath() const;
    /+virtual+/ bool contains(ref const(QPointF) point) const;
    /+virtual+/ bool collidesWithItem(const(QGraphicsItem)* other, Qt.ItemSelectionMode mode = Qt.IntersectsItemShape) const;
    /+virtual+/ bool collidesWithPath(ref const(QPainterPath) path, Qt.ItemSelectionMode mode = Qt.IntersectsItemShape) const;
    QList<QGraphicsItem *> collidingItems(Qt.ItemSelectionMode mode = Qt.IntersectsItemShape) const;
    bool isObscured(ref const(QRectF) rect = QRectF()) const;
    /+inline+/ bool isObscured(qreal x, qreal y, qreal w, qreal h) const;
    /+virtual+/ bool isObscuredBy(const(QGraphicsItem)* item) const;
    /+virtual+/ QPainterPath opaqueArea() const;

    QRegion boundingRegion(ref const(QTransform) itemToDeviceTransform) const;
    qreal boundingRegionGranularity() const;
    void setBoundingRegionGranularity(qreal granularity);

    // Drawing
    /+virtual+/ void paint(QPainter *painter, const(QStyleOptionGraphicsItem)* option, QWidget *widget = 0) = 0;
    void update(ref const(QRectF) rect = QRectF());
    /+inline+/ void update(qreal x, qreal y, qreal width, qreal height);
    void scroll(qreal dx, qreal dy, ref const(QRectF) rect = QRectF());

    // Coordinate mapping
    QPointF mapToItem(const(QGraphicsItem)* item, ref const(QPointF) point) const;
    QPointF mapToParent(ref const(QPointF) point) const;
    QPointF mapToScene(ref const(QPointF) point) const;
    QPolygonF mapToItem(const(QGraphicsItem)* item, ref const(QRectF) rect) const;
    QPolygonF mapToParent(ref const(QRectF) rect) const;
    QPolygonF mapToScene(ref const(QRectF) rect) const;
    QRectF mapRectToItem(const(QGraphicsItem)* item, ref const(QRectF) rect) const;
    QRectF mapRectToParent(ref const(QRectF) rect) const;
    QRectF mapRectToScene(ref const(QRectF) rect) const;
    QPolygonF mapToItem(const(QGraphicsItem)* item, ref const(QPolygonF) polygon) const;
    QPolygonF mapToParent(ref const(QPolygonF) polygon) const;
    QPolygonF mapToScene(ref const(QPolygonF) polygon) const;
    QPainterPath mapToItem(const(QGraphicsItem)* item, ref const(QPainterPath) path) const;
    QPainterPath mapToParent(ref const(QPainterPath) path) const;
    QPainterPath mapToScene(ref const(QPainterPath) path) const;
    QPointF mapFromItem(const(QGraphicsItem)* item, ref const(QPointF) point) const;
    QPointF mapFromParent(ref const(QPointF) point) const;
    QPointF mapFromScene(ref const(QPointF) point) const;
    QPolygonF mapFromItem(const(QGraphicsItem)* item, ref const(QRectF) rect) const;
    QPolygonF mapFromParent(ref const(QRectF) rect) const;
    QPolygonF mapFromScene(ref const(QRectF) rect) const;
    QRectF mapRectFromItem(const(QGraphicsItem)* item, ref const(QRectF) rect) const;
    QRectF mapRectFromParent(ref const(QRectF) rect) const;
    QRectF mapRectFromScene(ref const(QRectF) rect) const;
    QPolygonF mapFromItem(const(QGraphicsItem)* item, ref const(QPolygonF) polygon) const;
    QPolygonF mapFromParent(ref const(QPolygonF) polygon) const;
    QPolygonF mapFromScene(ref const(QPolygonF) polygon) const;
    QPainterPath mapFromItem(const(QGraphicsItem)* item, ref const(QPainterPath) path) const;
    QPainterPath mapFromParent(ref const(QPainterPath) path) const;
    QPainterPath mapFromScene(ref const(QPainterPath) path) const;

    /+inline+/ QPointF mapToItem(const(QGraphicsItem)* item, qreal x, qreal y) const;
    /+inline+/ QPointF mapToParent(qreal x, qreal y) const;
    /+inline+/ QPointF mapToScene(qreal x, qreal y) const;
    /+inline+/ QPolygonF mapToItem(const(QGraphicsItem)* item, qreal x, qreal y, qreal w, qreal h) const;
    /+inline+/ QPolygonF mapToParent(qreal x, qreal y, qreal w, qreal h) const;
    /+inline+/ QPolygonF mapToScene(qreal x, qreal y, qreal w, qreal h) const;
    /+inline+/ QRectF mapRectToItem(const(QGraphicsItem)* item, qreal x, qreal y, qreal w, qreal h) const;
    /+inline+/ QRectF mapRectToParent(qreal x, qreal y, qreal w, qreal h) const;
    /+inline+/ QRectF mapRectToScene(qreal x, qreal y, qreal w, qreal h) const;
    /+inline+/ QPointF mapFromItem(const(QGraphicsItem)* item, qreal x, qreal y) const;
    /+inline+/ QPointF mapFromParent(qreal x, qreal y) const;
    /+inline+/ QPointF mapFromScene(qreal x, qreal y) const;
    /+inline+/ QPolygonF mapFromItem(const(QGraphicsItem)* item, qreal x, qreal y, qreal w, qreal h) const;
    /+inline+/ QPolygonF mapFromParent(qreal x, qreal y, qreal w, qreal h) const;
    /+inline+/ QPolygonF mapFromScene(qreal x, qreal y, qreal w, qreal h) const;
    /+inline+/ QRectF mapRectFromItem(const(QGraphicsItem)* item, qreal x, qreal y, qreal w, qreal h) const;
    /+inline+/ QRectF mapRectFromParent(qreal x, qreal y, qreal w, qreal h) const;
    /+inline+/ QRectF mapRectFromScene(qreal x, qreal y, qreal w, qreal h) const;

    bool isAncestorOf(const(QGraphicsItem)* child) const;
    QGraphicsItem *commonAncestorItem(const(QGraphicsItem)* other) const;
    bool isUnderMouse() const;

    // Custom data
    QVariant data(int key) const;
    void setData(int key, ref const(QVariant) value);

    Qt.InputMethodHints inputMethodHints() const;
    void setInputMethodHints(Qt.InputMethodHints hints);

    enum {
        Type = 1,
        UserType = 65536
    };
    /+virtual+/ int type() const;

    void installSceneEventFilter(QGraphicsItem *filterItem);
    void removeSceneEventFilter(QGraphicsItem *filterItem);

protected:
    void updateMicroFocus();
    /+virtual+/ bool sceneEventFilter(QGraphicsItem *watched, QEvent *event);
    /+virtual+/ bool sceneEvent(QEvent *event);
    /+virtual+/ void contextMenuEvent(QGraphicsSceneContextMenuEvent *event);
    /+virtual+/ void dragEnterEvent(QGraphicsSceneDragDropEvent *event);
    /+virtual+/ void dragLeaveEvent(QGraphicsSceneDragDropEvent *event);
    /+virtual+/ void dragMoveEvent(QGraphicsSceneDragDropEvent *event);
    /+virtual+/ void dropEvent(QGraphicsSceneDragDropEvent *event);
    /+virtual+/ void focusInEvent(QFocusEvent *event);
    /+virtual+/ void focusOutEvent(QFocusEvent *event);
    /+virtual+/ void hoverEnterEvent(QGraphicsSceneHoverEvent *event);
    /+virtual+/ void hoverMoveEvent(QGraphicsSceneHoverEvent *event);
    /+virtual+/ void hoverLeaveEvent(QGraphicsSceneHoverEvent *event);
    /+virtual+/ void keyPressEvent(QKeyEvent *event);
    /+virtual+/ void keyReleaseEvent(QKeyEvent *event);
    /+virtual+/ void mousePressEvent(QGraphicsSceneMouseEvent *event);
    /+virtual+/ void mouseMoveEvent(QGraphicsSceneMouseEvent *event);
    /+virtual+/ void mouseReleaseEvent(QGraphicsSceneMouseEvent *event);
    /+virtual+/ void mouseDoubleClickEvent(QGraphicsSceneMouseEvent *event);
    /+virtual+/ void wheelEvent(QGraphicsSceneWheelEvent *event);
    /+virtual+/ void inputMethodEvent(QInputMethodEvent *event);
    /+virtual+/ QVariant inputMethodQuery(Qt.InputMethodQuery query) const;

    /+virtual+/ QVariant itemChange(GraphicsItemChange change, ref const(QVariant) value);

    enum Extension {
        UserExtension = 0x80000000
    };
    /+virtual+/ bool supportsExtension(Extension extension) const;
    /+virtual+/ void setExtension(Extension extension, ref const(QVariant) variant);
    /+virtual+/ QVariant extension(ref const(QVariant) variant) const;

protected:
    QGraphicsItem(QGraphicsItemPrivate &dd, QGraphicsItem *parent);
    QScopedPointer<QGraphicsItemPrivate> d_ptr;

    void addToIndex();
    void removeFromIndex();
    void prepareGeometryChange();

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    friend class QGraphicsItemGroup;
    friend class QGraphicsScene;
    friend class QGraphicsScenePrivate;
    friend class QGraphicsSceneFindItemBspTreeVisitor;
    friend class QGraphicsSceneBspTree;
    friend class QGraphicsView;
    friend class QGraphicsViewPrivate;
    friend class QGraphicsObject;
    friend class QGraphicsWidget;
    friend class QGraphicsWidgetPrivate;
    friend class QGraphicsProxyWidgetPrivate;
    friend class QGraphicsSceneIndex;
    friend class QGraphicsSceneIndexPrivate;
    friend class QGraphicsSceneBspTreeIndex;
    friend class QGraphicsSceneBspTreeIndexPrivate;
    friend class QGraphicsItemEffectSourcePrivate;
    friend class QGraphicsTransformPrivate;
#ifndef QT_NO_GESTURES
    friend class QGestureManager;
#endif
    friend class ::tst_QGraphicsItem;
    friend bool qt_closestLeaf(const(QGraphicsItem)* , const(QGraphicsItem)* );
    friend bool qt_closestItemFirst(const(QGraphicsItem)* , const(QGraphicsItem)* );
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QGraphicsItem::GraphicsItemFlags)
Q_DECLARE_INTERFACE(QGraphicsItem, "org.qt-project.Qt.QGraphicsItem")

/+inline+/ void QGraphicsItem::setPos(qreal ax, qreal ay)
{ setPos(QPointF(ax, ay)); }
/+inline+/ void QGraphicsItem::ensureVisible(qreal ax, qreal ay, qreal w, qreal h, int xmargin, int ymargin)
{ ensureVisible(QRectF(ax, ay, w, h), xmargin, ymargin); }
/+inline+/ void QGraphicsItem::update(qreal ax, qreal ay, qreal width, qreal height)
{ update(QRectF(ax, ay, width, height)); }
/+inline+/ bool QGraphicsItem::isObscured(qreal ax, qreal ay, qreal w, qreal h) const
{ return isObscured(QRectF(ax, ay, w, h)); }
/+inline+/ QPointF QGraphicsItem::mapToItem(const(QGraphicsItem)* item, qreal ax, qreal ay) const
{ return mapToItem(item, QPointF(ax, ay)); }
/+inline+/ QPointF QGraphicsItem::mapToParent(qreal ax, qreal ay) const
{ return mapToParent(QPointF(ax, ay)); }
/+inline+/ QPointF QGraphicsItem::mapToScene(qreal ax, qreal ay) const
{ return mapToScene(QPointF(ax, ay));  }
/+inline+/ QPointF QGraphicsItem::mapFromItem(const(QGraphicsItem)* item, qreal ax, qreal ay) const
{ return mapFromItem(item, QPointF(ax, ay)); }
/+inline+/ QPointF QGraphicsItem::mapFromParent(qreal ax, qreal ay) const
{ return mapFromParent(QPointF(ax, ay));  }
/+inline+/ QPointF QGraphicsItem::mapFromScene(qreal ax, qreal ay) const
{ return mapFromScene(QPointF(ax, ay));  }
/+inline+/ QPolygonF QGraphicsItem::mapToItem(const(QGraphicsItem)* item, qreal ax, qreal ay, qreal w, qreal h) const
{ return mapToItem(item, QRectF(ax, ay, w, h)); }
/+inline+/ QPolygonF QGraphicsItem::mapToParent(qreal ax, qreal ay, qreal w, qreal h) const
{ return mapToParent(QRectF(ax, ay, w, h)); }
/+inline+/ QPolygonF QGraphicsItem::mapToScene(qreal ax, qreal ay, qreal w, qreal h) const
{ return mapToScene(QRectF(ax, ay, w, h)); }
/+inline+/ QRectF QGraphicsItem::mapRectToItem(const(QGraphicsItem)* item, qreal ax, qreal ay, qreal w, qreal h) const
{ return mapRectToItem(item, QRectF(ax, ay, w, h)); }
/+inline+/ QRectF QGraphicsItem::mapRectToParent(qreal ax, qreal ay, qreal w, qreal h) const
{ return mapRectToParent(QRectF(ax, ay, w, h)); }
/+inline+/ QRectF QGraphicsItem::mapRectToScene(qreal ax, qreal ay, qreal w, qreal h) const
{ return mapRectToScene(QRectF(ax, ay, w, h)); }
/+inline+/ QPolygonF QGraphicsItem::mapFromItem(const(QGraphicsItem)* item, qreal ax, qreal ay, qreal w, qreal h) const
{ return mapFromItem(item, QRectF(ax, ay, w, h)); }
/+inline+/ QPolygonF QGraphicsItem::mapFromParent(qreal ax, qreal ay, qreal w, qreal h) const
{ return mapFromParent(QRectF(ax, ay, w, h)); }
/+inline+/ QPolygonF QGraphicsItem::mapFromScene(qreal ax, qreal ay, qreal w, qreal h) const
{ return mapFromScene(QRectF(ax, ay, w, h)); }
/+inline+/ QRectF QGraphicsItem::mapRectFromItem(const(QGraphicsItem)* item, qreal ax, qreal ay, qreal w, qreal h) const
{ return mapRectFromItem(item, QRectF(ax, ay, w, h)); }
/+inline+/ QRectF QGraphicsItem::mapRectFromParent(qreal ax, qreal ay, qreal w, qreal h) const
{ return mapRectFromParent(QRectF(ax, ay, w, h)); }
/+inline+/ QRectF QGraphicsItem::mapRectFromScene(qreal ax, qreal ay, qreal w, qreal h) const
{ return mapRectFromScene(QRectF(ax, ay, w, h)); }


class Q_WIDGETS_EXPORT QGraphicsObject : public QObject, public QGraphicsItem
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QGraphicsObject, "*", "parent", "READ", "parentObject", "WRITE", "setParentItem", "NOTIFY", "parentChanged", "DESIGNABLE", "false");
    mixin Q_PROPERTY!(qreal, "opacity", "READ", "opacity", "WRITE", "setOpacity", "NOTIFY", "opacityChanged", "FINAL");
    mixin Q_PROPERTY!(bool, "enabled", "READ", "isEnabled", "WRITE", "setEnabled", "NOTIFY", "enabledChanged");
    mixin Q_PROPERTY!(bool, "visible", "READ", "isVisible", "WRITE", "setVisible", "NOTIFY", "visibleChanged", "FINAL");
    Q_PROPERTY(QPointF pos READ pos WRITE setPos FINAL)
    mixin Q_PROPERTY!(qreal, "x", "READ", "x", "WRITE", "setX", "NOTIFY", "xChanged", "FINAL");
    mixin Q_PROPERTY!(qreal, "y", "READ", "y", "WRITE", "setY", "NOTIFY", "yChanged", "FINAL");
    mixin Q_PROPERTY!(qreal, "z", "READ", "zValue", "WRITE", "setZValue", "NOTIFY", "zChanged", "FINAL");
    mixin Q_PROPERTY!(qreal, "rotation", "READ", "rotation", "WRITE", "setRotation", "NOTIFY", "rotationChanged");
    mixin Q_PROPERTY!(qreal, "scale", "READ", "scale", "WRITE", "setScale", "NOTIFY", "scaleChanged");
    mixin Q_PROPERTY!(QPointF, "transformOriginPoint", "READ", "transformOriginPoint", "WRITE", "setTransformOriginPoint");
#ifndef QT_NO_GRAPHICSEFFECT
    mixin Q_PROPERTY!(QGraphicsEffect, "*effect", "READ", "graphicsEffect", "WRITE", "setGraphicsEffect");
#endif
    Q_PRIVATE_PROPERTY(QGraphicsItem::d_func(), QDeclarativeListProperty<QGraphicsObject> children READ childrenList DESIGNABLE false NOTIFY childrenChanged)
    Q_PRIVATE_PROPERTY(QGraphicsItem::d_func(), qreal width READ width WRITE setWidth NOTIFY widthChanged RESET resetWidth FINAL)
    Q_PRIVATE_PROPERTY(QGraphicsItem::d_func(), qreal height READ height WRITE setHeight NOTIFY heightChanged RESET resetHeight FINAL)
    Q_CLASSINFO("DefaultProperty", "children")
    Q_INTERFACES(QGraphicsItem)
public:
    explicit QGraphicsObject(QGraphicsItem *parent = 0);
    ~QGraphicsObject();

#ifdef Q_NO_USING_KEYWORD
    ref const(QObjectList) children() const { return QObject::children(); }
#else
    using QObject::children;
#endif

#ifndef QT_NO_GESTURES
    void grabGesture(Qt.GestureType type, Qt.GestureFlags flags = Qt.GestureFlags());
    void ungrabGesture(Qt.GestureType type);
#endif

protected Q_SLOTS:
    void updateMicroFocus();

Q_SIGNALS:
    void parentChanged();
    void opacityChanged();
    void visibleChanged();
    void enabledChanged();
    void xChanged();
    void yChanged();
    void zChanged();
    void rotationChanged();
    void scaleChanged();
    void childrenChanged();
    void widthChanged();
    void heightChanged();

protected:
    QGraphicsObject(QGraphicsItemPrivate &dd, QGraphicsItem *parent);

    bool event(QEvent *ev);

private:
    friend class QGraphicsItem;
    friend class QGraphicsItemPrivate;
};


class QAbstractGraphicsShapeItemPrivate;
class Q_WIDGETS_EXPORT QAbstractGraphicsShapeItem : public QGraphicsItem
{
public:
    explicit QAbstractGraphicsShapeItem(QGraphicsItem *parent = 0);
    ~QAbstractGraphicsShapeItem();

    QPen pen() const;
    void setPen(ref const(QPen) pen);

    QBrush brush() const;
    void setBrush(ref const(QBrush) brush);

    bool isObscuredBy(const(QGraphicsItem)* item) const;
    QPainterPath opaqueArea() const;

protected:
    QAbstractGraphicsShapeItem(QAbstractGraphicsShapeItemPrivate &dd,
                               QGraphicsItem *parent);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

class QGraphicsPathItemPrivate;
class Q_WIDGETS_EXPORT QGraphicsPathItem : public QAbstractGraphicsShapeItem
{
public:
    explicit QGraphicsPathItem(QGraphicsItem *parent = 0);
    explicit QGraphicsPathItem(ref const(QPainterPath) path, QGraphicsItem *parent = 0);
    ~QGraphicsPathItem();

    QPainterPath path() const;
    void setPath(ref const(QPainterPath) path);

    QRectF boundingRect() const;
    QPainterPath shape() const;
    bool contains(ref const(QPointF) point) const;

    void paint(QPainter *painter, const(QStyleOptionGraphicsItem)* option, QWidget *widget = 0);

    bool isObscuredBy(const(QGraphicsItem)* item) const;
    QPainterPath opaqueArea() const;

    enum { Type = 2 };
    int type() const;

protected:
    bool supportsExtension(Extension extension) const;
    void setExtension(Extension extension, ref const(QVariant) variant);
    QVariant extension(ref const(QVariant) variant) const;

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

class QGraphicsRectItemPrivate;
class Q_WIDGETS_EXPORT QGraphicsRectItem : public QAbstractGraphicsShapeItem
{
public:
    explicit QGraphicsRectItem(QGraphicsItem *parent = 0);
    explicit QGraphicsRectItem(ref const(QRectF) rect, QGraphicsItem *parent = 0);
    explicit QGraphicsRectItem(qreal x, qreal y, qreal w, qreal h, QGraphicsItem *parent = 0);
    ~QGraphicsRectItem();

    QRectF rect() const;
    void setRect(ref const(QRectF) rect);
    /+inline+/ void setRect(qreal x, qreal y, qreal w, qreal h);

    QRectF boundingRect() const;
    QPainterPath shape() const;
    bool contains(ref const(QPointF) point) const;

    void paint(QPainter *painter, const(QStyleOptionGraphicsItem)* option, QWidget *widget = 0);

    bool isObscuredBy(const(QGraphicsItem)* item) const;
    QPainterPath opaqueArea() const;

    enum { Type = 3 };
    int type() const;

protected:
    bool supportsExtension(Extension extension) const;
    void setExtension(Extension extension, ref const(QVariant) variant);
    QVariant extension(ref const(QVariant) variant) const;

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

/+inline+/ void QGraphicsRectItem::setRect(qreal ax, qreal ay, qreal w, qreal h)
{ setRect(QRectF(ax, ay, w, h)); }

class QGraphicsEllipseItemPrivate;
class Q_WIDGETS_EXPORT QGraphicsEllipseItem : public QAbstractGraphicsShapeItem
{
public:
    explicit QGraphicsEllipseItem(QGraphicsItem *parent = 0);
    explicit QGraphicsEllipseItem(ref const(QRectF) rect, QGraphicsItem *parent = 0);
    explicit QGraphicsEllipseItem(qreal x, qreal y, qreal w, qreal h, QGraphicsItem *parent = 0);
    ~QGraphicsEllipseItem();

    QRectF rect() const;
    void setRect(ref const(QRectF) rect);
    /+inline+/ void setRect(qreal x, qreal y, qreal w, qreal h);

    int startAngle() const;
    void setStartAngle(int angle);

    int spanAngle() const;
    void setSpanAngle(int angle);

    QRectF boundingRect() const;
    QPainterPath shape() const;
    bool contains(ref const(QPointF) point) const;

    void paint(QPainter *painter, const(QStyleOptionGraphicsItem)* option, QWidget *widget = 0);

    bool isObscuredBy(const(QGraphicsItem)* item) const;
    QPainterPath opaqueArea() const;

    enum { Type = 4 };
    int type() const;

protected:
    bool supportsExtension(Extension extension) const;
    void setExtension(Extension extension, ref const(QVariant) variant);
    QVariant extension(ref const(QVariant) variant) const;

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

/+inline+/ void QGraphicsEllipseItem::setRect(qreal ax, qreal ay, qreal w, qreal h)
{ setRect(QRectF(ax, ay, w, h)); }

class QGraphicsPolygonItemPrivate;
class Q_WIDGETS_EXPORT QGraphicsPolygonItem : public QAbstractGraphicsShapeItem
{
public:
    explicit QGraphicsPolygonItem(QGraphicsItem *parent = 0);
    explicit QGraphicsPolygonItem(ref const(QPolygonF) polygon,
                                  QGraphicsItem *parent = 0);
    ~QGraphicsPolygonItem();

    QPolygonF polygon() const;
    void setPolygon(ref const(QPolygonF) polygon);

    Qt.FillRule fillRule() const;
    void setFillRule(Qt.FillRule rule);

    QRectF boundingRect() const;
    QPainterPath shape() const;
    bool contains(ref const(QPointF) point) const;

    void paint(QPainter *painter, const(QStyleOptionGraphicsItem)* option, QWidget *widget = 0);

    bool isObscuredBy(const(QGraphicsItem)* item) const;
    QPainterPath opaqueArea() const;

    enum { Type = 5 };
    int type() const;

protected:
    bool supportsExtension(Extension extension) const;
    void setExtension(Extension extension, ref const(QVariant) variant);
    QVariant extension(ref const(QVariant) variant) const;

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

class QGraphicsLineItemPrivate;
class Q_WIDGETS_EXPORT QGraphicsLineItem : public QGraphicsItem
{
public:
    explicit QGraphicsLineItem(QGraphicsItem *parent = 0);
    explicit QGraphicsLineItem(ref const(QLineF) line, QGraphicsItem *parent = 0);
    explicit QGraphicsLineItem(qreal x1, qreal y1, qreal x2, qreal y2, QGraphicsItem *parent = 0);
    ~QGraphicsLineItem();

    QPen pen() const;
    void setPen(ref const(QPen) pen);

    QLineF line() const;
    void setLine(ref const(QLineF) line);
    /+inline+/ void setLine(qreal x1, qreal y1, qreal x2, qreal y2)
    { setLine(QLineF(x1, y1, x2, y2)); }

    QRectF boundingRect() const;
    QPainterPath shape() const;
    bool contains(ref const(QPointF) point) const;

    void paint(QPainter *painter, const(QStyleOptionGraphicsItem)* option, QWidget *widget = 0);

    bool isObscuredBy(const(QGraphicsItem)* item) const;
    QPainterPath opaqueArea() const;

    enum { Type = 6 };
    int type() const;

protected:
    bool supportsExtension(Extension extension) const;
    void setExtension(Extension extension, ref const(QVariant) variant);
    QVariant extension(ref const(QVariant) variant) const;

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

class QGraphicsPixmapItemPrivate;
class Q_WIDGETS_EXPORT QGraphicsPixmapItem : public QGraphicsItem
{
public:
    enum ShapeMode {
        MaskShape,
        BoundingRectShape,
        HeuristicMaskShape
    };

    explicit QGraphicsPixmapItem(QGraphicsItem *parent = 0);
    explicit QGraphicsPixmapItem(ref const(QPixmap) pixmap, QGraphicsItem *parent = 0);
    ~QGraphicsPixmapItem();

    QPixmap pixmap() const;
    void setPixmap(ref const(QPixmap) pixmap);

    Qt.TransformationMode transformationMode() const;
    void setTransformationMode(Qt.TransformationMode mode);

    QPointF offset() const;
    void setOffset(ref const(QPointF) offset);
    /+inline+/ void setOffset(qreal x, qreal y);

    QRectF boundingRect() const;
    QPainterPath shape() const;
    bool contains(ref const(QPointF) point) const;

    void paint(QPainter *painter, const(QStyleOptionGraphicsItem)* option, QWidget *widget);

    bool isObscuredBy(const(QGraphicsItem)* item) const;
    QPainterPath opaqueArea() const;

    enum { Type = 7 };
    int type() const;

    ShapeMode shapeMode() const;
    void setShapeMode(ShapeMode mode);

protected:
    bool supportsExtension(Extension extension) const;
    void setExtension(Extension extension, ref const(QVariant) variant);
    QVariant extension(ref const(QVariant) variant) const;

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

/+inline+/ void QGraphicsPixmapItem::setOffset(qreal ax, qreal ay)
{ setOffset(QPointF(ax, ay)); }

class QGraphicsTextItemPrivate;
class QTextDocument;
class QTextCursor;
class Q_WIDGETS_EXPORT QGraphicsTextItem : public QGraphicsObject
{
    mixin Q_OBJECT;
    QDOC_PROPERTY(bool openExternalLinks READ openExternalLinks WRITE setOpenExternalLinks)
    QDOC_PROPERTY(QTextCursor textCursor READ textCursor WRITE setTextCursor)

public:
    explicit QGraphicsTextItem(QGraphicsItem *parent = 0);
    explicit QGraphicsTextItem(ref const(QString) text, QGraphicsItem *parent = 0);
    ~QGraphicsTextItem();

    QString toHtml() const;
    void setHtml(ref const(QString) html);

    QString toPlainText() const;
    void setPlainText(ref const(QString) text);

    QFont font() const;
    void setFont(ref const(QFont) font);

    void setDefaultTextColor(ref const(QColor) c);
    QColor defaultTextColor() const;

    QRectF boundingRect() const;
    QPainterPath shape() const;
    bool contains(ref const(QPointF) point) const;

    void paint(QPainter *painter, const(QStyleOptionGraphicsItem)* option, QWidget *widget);

    bool isObscuredBy(const(QGraphicsItem)* item) const;
    QPainterPath opaqueArea() const;

    enum { Type = 8 };
    int type() const;

    void setTextWidth(qreal width);
    qreal textWidth() const;

    void adjustSize();

    void setDocument(QTextDocument *document);
    QTextDocument *document() const;

    void setTextInteractionFlags(Qt.TextInteractionFlags flags);
    Qt.TextInteractionFlags textInteractionFlags() const;

    void setTabChangesFocus(bool b);
    bool tabChangesFocus() const;

    void setOpenExternalLinks(bool open);
    bool openExternalLinks() const;

    void setTextCursor(ref const(QTextCursor) cursor);
    QTextCursor textCursor() const;

Q_SIGNALS:
    void linkActivated(ref const(QString) );
    void linkHovered(ref const(QString) );

protected:
    bool sceneEvent(QEvent *event);
    void mousePressEvent(QGraphicsSceneMouseEvent *event);
    void mouseMoveEvent(QGraphicsSceneMouseEvent *event);
    void mouseReleaseEvent(QGraphicsSceneMouseEvent *event);
    void mouseDoubleClickEvent(QGraphicsSceneMouseEvent *event);
    void contextMenuEvent(QGraphicsSceneContextMenuEvent *event);
    void keyPressEvent(QKeyEvent *event);
    void keyReleaseEvent(QKeyEvent *event);
    void focusInEvent(QFocusEvent *event);
    void focusOutEvent(QFocusEvent *event);
    void dragEnterEvent(QGraphicsSceneDragDropEvent *event);
    void dragLeaveEvent(QGraphicsSceneDragDropEvent *event);
    void dragMoveEvent(QGraphicsSceneDragDropEvent *event);
    void dropEvent(QGraphicsSceneDragDropEvent *event);
    void inputMethodEvent(QInputMethodEvent *event);
    void hoverEnterEvent(QGraphicsSceneHoverEvent *event);
    void hoverMoveEvent(QGraphicsSceneHoverEvent *event);
    void hoverLeaveEvent(QGraphicsSceneHoverEvent *event);

    QVariant inputMethodQuery(Qt.InputMethodQuery query) const;

    bool supportsExtension(Extension extension) const;
    void setExtension(Extension extension, ref const(QVariant) variant);
    QVariant extension(ref const(QVariant) variant) const;

private:
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(dd, void _q_updateBoundingRect(ref const(QSizeF) ))
    Q_PRIVATE_SLOT(dd, void _q_update(QRectF))
    Q_PRIVATE_SLOT(dd, void _q_ensureVisible(QRectF))
    QGraphicsTextItemPrivate *dd;
    friend class QGraphicsTextItemPrivate;
};

class QGraphicsSimpleTextItemPrivate;
class Q_WIDGETS_EXPORT QGraphicsSimpleTextItem : public QAbstractGraphicsShapeItem
{
public:
    explicit QGraphicsSimpleTextItem(QGraphicsItem *parent = 0);
    explicit QGraphicsSimpleTextItem(ref const(QString) text, QGraphicsItem *parent = 0);
    ~QGraphicsSimpleTextItem();

    void setText(ref const(QString) text);
    QString text() const;

    void setFont(ref const(QFont) font);
    QFont font() const;

    QRectF boundingRect() const;
    QPainterPath shape() const;
    bool contains(ref const(QPointF) point) const;

    void paint(QPainter *painter, const(QStyleOptionGraphicsItem)* option, QWidget *widget);

    bool isObscuredBy(const(QGraphicsItem)* item) const;
    QPainterPath opaqueArea() const;

    enum { Type = 9 };
    int type() const;

protected:
    bool supportsExtension(Extension extension) const;
    void setExtension(Extension extension, ref const(QVariant) variant);
    QVariant extension(ref const(QVariant) variant) const;

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

class QGraphicsItemGroupPrivate;
class Q_WIDGETS_EXPORT QGraphicsItemGroup : public QGraphicsItem
{
public:
    explicit QGraphicsItemGroup(QGraphicsItem *parent = 0);
    ~QGraphicsItemGroup();

    void addToGroup(QGraphicsItem *item);
    void removeFromGroup(QGraphicsItem *item);

    QRectF boundingRect() const;
    void paint(QPainter *painter, const(QStyleOptionGraphicsItem)* option, QWidget *widget = 0);

    bool isObscuredBy(const(QGraphicsItem)* item) const;
    QPainterPath opaqueArea() const;

    enum { Type = 10 };
    int type() const;

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

template <class T> /+inline+/ T qgraphicsitem_cast(QGraphicsItem *item)
{
    typedef typename QtPrivate::remove_cv<typename QtPrivate::remove_pointer<T>::type>::type Item;
    return int(Item::Type) == int(QGraphicsItem::Type)
        || (item && int(Item::Type) == item->type()) ? static_cast<T>(item) : 0;
}

template <class T> /+inline+/ T qgraphicsitem_cast(const(QGraphicsItem)* item)
{
    typedef typename QtPrivate::remove_cv<typename QtPrivate::remove_pointer<T>::type>::type Item;
    return int(Item::Type) == int(QGraphicsItem::Type)
        || (item && int(Item::Type) == item->type()) ? static_cast<T>(item) : 0;
}

#ifndef QT_NO_DEBUG_STREAM
Q_WIDGETS_EXPORT QDebug operator<<(QDebug debug, QGraphicsItem *item);
Q_WIDGETS_EXPORT QDebug operator<<(QDebug debug, QGraphicsObject *item);
Q_WIDGETS_EXPORT QDebug operator<<(QDebug debug, QGraphicsItem::GraphicsItemChange change);
Q_WIDGETS_EXPORT QDebug operator<<(QDebug debug, QGraphicsItem::GraphicsItemFlag flag);
Q_WIDGETS_EXPORT QDebug operator<<(QDebug debug, QGraphicsItem::GraphicsItemFlags flags);
#endif

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QGraphicsItem *)

QT_BEGIN_NAMESPACE

#endif // QT_NO_GRAPHICSVIEW

QT_END_NAMESPACE

#endif // QGRAPHICSITEM_H
