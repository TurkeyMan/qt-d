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

#ifndef QGRAPHICSSCENE_H
#define QGRAPHICSSCENE_H

public import qt.QtCore.qobject;
public import qt.QtCore.qpoint;
public import qt.QtCore.qrect;
public import qt.QtGui.qbrush;
public import qt.QtGui.qfont;
public import qt.QtGui.qtransform;
public import qt.QtGui.qmatrix;
public import qt.QtGui.qpen;

QT_BEGIN_NAMESPACE


#if !defined(QT_NO_GRAPHICSVIEW)

template<typename T> class QList;
class QFocusEvent;
class QFont;
class QFontMetrics;
class QGraphicsEllipseItem;
class QGraphicsItem;
class QGraphicsItemGroup;
class QGraphicsLineItem;
class QGraphicsPathItem;
class QGraphicsPixmapItem;
class QGraphicsPolygonItem;
class QGraphicsProxyWidget;
class QGraphicsRectItem;
class QGraphicsSceneContextMenuEvent;
class QGraphicsSceneDragDropEvent;
class QGraphicsSceneEvent;
class QGraphicsSceneHelpEvent;
class QGraphicsSceneHoverEvent;
class QGraphicsSceneMouseEvent;
class QGraphicsSceneWheelEvent;
class QGraphicsSimpleTextItem;
class QGraphicsTextItem;
class QGraphicsView;
class QGraphicsWidget;
class QGraphicsSceneIndex;
class QHelpEvent;
class QInputMethodEvent;
class QKeyEvent;
class QLineF;
class QPainterPath;
class QPixmap;
class QPointF;
class QPolygonF;
class QRectF;
class QSizeF;
class QStyle;
class QStyleOptionGraphicsItem;

class QGraphicsScenePrivate;
class Q_WIDGETS_EXPORT QGraphicsScene : public QObject
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QBrush, "backgroundBrush", "READ", "backgroundBrush", "WRITE", "setBackgroundBrush");
    mixin Q_PROPERTY!(QBrush, "foregroundBrush", "READ", "foregroundBrush", "WRITE", "setForegroundBrush");
    mixin Q_PROPERTY!(ItemIndexMethod, "itemIndexMethod", "READ", "itemIndexMethod", "WRITE", "setItemIndexMethod");
    mixin Q_PROPERTY!(QRectF, "sceneRect", "READ", "sceneRect", "WRITE", "setSceneRect");
    mixin Q_PROPERTY!(int, "bspTreeDepth", "READ", "bspTreeDepth", "WRITE", "setBspTreeDepth");
    mixin Q_PROPERTY!(QPalette, "palette", "READ", "palette", "WRITE", "setPalette");
    mixin Q_PROPERTY!(QFont, "font", "READ", "font", "WRITE", "setFont");
    mixin Q_PROPERTY!(bool, "sortCacheEnabled", "READ", "isSortCacheEnabled", "WRITE", "setSortCacheEnabled");
    mixin Q_PROPERTY!(bool, "stickyFocus", "READ", "stickyFocus", "WRITE", "setStickyFocus");
    mixin Q_PROPERTY!(qreal, "minimumRenderSize", "READ", "minimumRenderSize", "WRITE", "setMinimumRenderSize");

public:
    enum ItemIndexMethod {
        BspTreeIndex,
        NoIndex = -1
    };

    enum SceneLayer {
        ItemLayer = 0x1,
        BackgroundLayer = 0x2,
        ForegroundLayer = 0x4,
        AllLayers = 0xffff
    };
    Q_DECLARE_FLAGS(SceneLayers, SceneLayer)

    QGraphicsScene(QObject *parent = 0);
    QGraphicsScene(ref const(QRectF) sceneRect, QObject *parent = 0);
    QGraphicsScene(qreal x, qreal y, qreal width, qreal height, QObject *parent = 0);
    /+virtual+/ ~QGraphicsScene();

    QRectF sceneRect() const;
    /+inline+/ qreal width() const { return sceneRect().width(); }
    /+inline+/ qreal height() const { return sceneRect().height(); }
    void setSceneRect(ref const(QRectF) rect);
    /+inline+/ void setSceneRect(qreal x, qreal y, qreal w, qreal h)
    { setSceneRect(QRectF(x, y, w, h)); }

    void render(QPainter *painter,
                ref const(QRectF) target = QRectF(), ref const(QRectF) source = QRectF(),
                Qt.AspectRatioMode aspectRatioMode = Qt.KeepAspectRatio);

    ItemIndexMethod itemIndexMethod() const;
    void setItemIndexMethod(ItemIndexMethod method);

    bool isSortCacheEnabled() const;
    void setSortCacheEnabled(bool enabled);

    int bspTreeDepth() const;
    void setBspTreeDepth(int depth);

    QRectF itemsBoundingRect() const;

    QList<QGraphicsItem *> items(Qt.SortOrder order = Qt.DescendingOrder) const;

    QList<QGraphicsItem *> items(ref const(QPointF) pos, Qt.ItemSelectionMode mode = Qt.IntersectsItemShape, Qt.SortOrder order = Qt.DescendingOrder, ref const(QTransform) deviceTransform = QTransform()) const;
    QList<QGraphicsItem *> items(ref const(QRectF) rect, Qt.ItemSelectionMode mode = Qt.IntersectsItemShape, Qt.SortOrder order = Qt.DescendingOrder, ref const(QTransform) deviceTransform = QTransform()) const;
    QList<QGraphicsItem *> items(ref const(QPolygonF) polygon, Qt.ItemSelectionMode mode = Qt.IntersectsItemShape, Qt.SortOrder order = Qt.DescendingOrder, ref const(QTransform) deviceTransform = QTransform()) const;
    QList<QGraphicsItem *> items(ref const(QPainterPath) path, Qt.ItemSelectionMode mode = Qt.IntersectsItemShape, Qt.SortOrder order = Qt.DescendingOrder, ref const(QTransform) deviceTransform = QTransform()) const;

    QList<QGraphicsItem *> collidingItems(const(QGraphicsItem)* item, Qt.ItemSelectionMode mode = Qt.IntersectsItemShape) const;
#if QT_DEPRECATED_SINCE(5, 0)
    QT_DEPRECATED /+inline+/ QGraphicsItem *itemAt(ref const(QPointF) position) const {
        QList<QGraphicsItem *> itemsAtPoint = items(position);
        return itemsAtPoint.isEmpty() ? 0 : itemsAtPoint.first();
    }
#endif
    QGraphicsItem *itemAt(ref const(QPointF) pos, ref const(QTransform) deviceTransform) const;
#if QT_DEPRECATED_SINCE(5, 0)
    QT_DEPRECATED /+inline+/ QList<QGraphicsItem *> items(qreal x, qreal y, qreal w, qreal h, Qt.ItemSelectionMode mode = Qt.IntersectsItemShape) const
    { return items(QRectF(x, y, w, h), mode); }
#endif
    /+inline+/ QList<QGraphicsItem *> items(qreal x, qreal y, qreal w, qreal h, Qt.ItemSelectionMode mode, Qt.SortOrder order,
                                        ref const(QTransform) deviceTransform = QTransform()) const
    { return items(QRectF(x, y, w, h), mode, order, deviceTransform); }
#if QT_DEPRECATED_SINCE(5, 0)
    QT_DEPRECATED /+inline+/ QGraphicsItem *itemAt(qreal x, qreal y) const {
        QList<QGraphicsItem *> itemsAtPoint = items(QPointF(x, y));
        return itemsAtPoint.isEmpty() ? 0 : itemsAtPoint.first();
    }
#endif
    /+inline+/ QGraphicsItem *itemAt(qreal x, qreal y, ref const(QTransform) deviceTransform) const
    { return itemAt(QPointF(x, y), deviceTransform); }

    QList<QGraphicsItem *> selectedItems() const;
    QPainterPath selectionArea() const;
    void setSelectionArea(ref const(QPainterPath) path, ref const(QTransform) deviceTransform);
    void setSelectionArea(ref const(QPainterPath) path, Qt.ItemSelectionMode mode = Qt.IntersectsItemShape, ref const(QTransform) deviceTransform = QTransform());

    QGraphicsItemGroup *createItemGroup(const QList<QGraphicsItem *> &items);
    void destroyItemGroup(QGraphicsItemGroup *group);

    void addItem(QGraphicsItem *item);
    QGraphicsEllipseItem *addEllipse(ref const(QRectF) rect, ref const(QPen) pen = QPen(), ref const(QBrush) brush = QBrush());
    QGraphicsLineItem *addLine(ref const(QLineF) line, ref const(QPen) pen = QPen());
    QGraphicsPathItem *addPath(ref const(QPainterPath) path, ref const(QPen) pen = QPen(), ref const(QBrush) brush = QBrush());
    QGraphicsPixmapItem *addPixmap(ref const(QPixmap) pixmap);
    QGraphicsPolygonItem *addPolygon(ref const(QPolygonF) polygon, ref const(QPen) pen = QPen(), ref const(QBrush) brush = QBrush());
    QGraphicsRectItem *addRect(ref const(QRectF) rect, ref const(QPen) pen = QPen(), ref const(QBrush) brush = QBrush());
    QGraphicsTextItem *addText(ref const(QString) text, ref const(QFont) font = QFont());
    QGraphicsSimpleTextItem *addSimpleText(ref const(QString) text, ref const(QFont) font = QFont());
    QGraphicsProxyWidget *addWidget(QWidget *widget, Qt.WindowFlags wFlags = 0);
    /+inline+/ QGraphicsEllipseItem *addEllipse(qreal x, qreal y, qreal w, qreal h, ref const(QPen) pen = QPen(), ref const(QBrush) brush = QBrush())
    { return addEllipse(QRectF(x, y, w, h), pen, brush); }
    /+inline+/ QGraphicsLineItem *addLine(qreal x1, qreal y1, qreal x2, qreal y2, ref const(QPen) pen = QPen())
    { return addLine(QLineF(x1, y1, x2, y2), pen); }
    /+inline+/ QGraphicsRectItem *addRect(qreal x, qreal y, qreal w, qreal h, ref const(QPen) pen = QPen(), ref const(QBrush) brush = QBrush())
    { return addRect(QRectF(x, y, w, h), pen, brush); }
    void removeItem(QGraphicsItem *item);

    QGraphicsItem *focusItem() const;
    void setFocusItem(QGraphicsItem *item, Qt.FocusReason focusReason = Qt.OtherFocusReason);
    bool hasFocus() const;
    void setFocus(Qt.FocusReason focusReason = Qt.OtherFocusReason);
    void clearFocus();

    void setStickyFocus(bool enabled);
    bool stickyFocus() const;

    QGraphicsItem *mouseGrabberItem() const;

    QBrush backgroundBrush() const;
    void setBackgroundBrush(ref const(QBrush) brush);

    QBrush foregroundBrush() const;
    void setForegroundBrush(ref const(QBrush) brush);

    /+virtual+/ QVariant inputMethodQuery(Qt.InputMethodQuery query) const;

    QList <QGraphicsView *> views() const;

    /+inline+/ void update(qreal x, qreal y, qreal w, qreal h)
    { update(QRectF(x, y, w, h)); }
    /+inline+/ void invalidate(qreal x, qreal y, qreal w, qreal h, SceneLayers layers = AllLayers)
    { invalidate(QRectF(x, y, w, h), layers); }

    QStyle *style() const;
    void setStyle(QStyle *style);

    QFont font() const;
    void setFont(ref const(QFont) font);

    QPalette palette() const;
    void setPalette(ref const(QPalette) palette);

    bool isActive() const;
    QGraphicsItem *activePanel() const;
    void setActivePanel(QGraphicsItem *item);
    QGraphicsWidget *activeWindow() const;
    void setActiveWindow(QGraphicsWidget *widget);

    bool sendEvent(QGraphicsItem *item, QEvent *event);

    qreal minimumRenderSize() const;
    void setMinimumRenderSize(qreal minSize);

public Q_SLOTS:
    void update(ref const(QRectF) rect = QRectF());
    void invalidate(ref const(QRectF) rect = QRectF(), SceneLayers layers = AllLayers);
    void advance();
    void clearSelection();
    void clear();

protected:
    bool event(QEvent *event);
    bool eventFilter(QObject *watched, QEvent *event);
    /+virtual+/ void contextMenuEvent(QGraphicsSceneContextMenuEvent *event);
    /+virtual+/ void dragEnterEvent(QGraphicsSceneDragDropEvent *event);
    /+virtual+/ void dragMoveEvent(QGraphicsSceneDragDropEvent *event);
    /+virtual+/ void dragLeaveEvent(QGraphicsSceneDragDropEvent *event);
    /+virtual+/ void dropEvent(QGraphicsSceneDragDropEvent *event);
    /+virtual+/ void focusInEvent(QFocusEvent *event);
    /+virtual+/ void focusOutEvent(QFocusEvent *event);
    /+virtual+/ void helpEvent(QGraphicsSceneHelpEvent *event);
    /+virtual+/ void keyPressEvent(QKeyEvent *event);
    /+virtual+/ void keyReleaseEvent(QKeyEvent *event);
    /+virtual+/ void mousePressEvent(QGraphicsSceneMouseEvent *event);
    /+virtual+/ void mouseMoveEvent(QGraphicsSceneMouseEvent *event);
    /+virtual+/ void mouseReleaseEvent(QGraphicsSceneMouseEvent *event);
    /+virtual+/ void mouseDoubleClickEvent(QGraphicsSceneMouseEvent *event);
    /+virtual+/ void wheelEvent(QGraphicsSceneWheelEvent *event);
    /+virtual+/ void inputMethodEvent(QInputMethodEvent *event);

    /+virtual+/ void drawBackground(QPainter *painter, ref const(QRectF) rect);
    /+virtual+/ void drawForeground(QPainter *painter, ref const(QRectF) rect);
    /+virtual+/ void drawItems(QPainter *painter, int numItems,
                           QGraphicsItem *items[],
                           const QStyleOptionGraphicsItem options[],
                           QWidget *widget = 0);

protected Q_SLOTS:
    bool focusNextPrevChild(bool next);

Q_SIGNALS:
    void changed(ref const(QList<QRectF>) region);
    void sceneRectChanged(ref const(QRectF) rect);
    void selectionChanged();
    void focusItemChanged(QGraphicsItem *newFocus, QGraphicsItem *oldFocus, Qt.FocusReason reason);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_emitUpdated())
    Q_PRIVATE_SLOT(d_func(), void _q_polishItems())
    Q_PRIVATE_SLOT(d_func(), void _q_processDirtyItems())
    Q_PRIVATE_SLOT(d_func(), void _q_updateScenePosDescendants())
    friend class QGraphicsItem;
    friend class QGraphicsItemPrivate;
    friend class QGraphicsObject;
    friend class QGraphicsView;
    friend class QGraphicsViewPrivate;
    friend class QGraphicsWidget;
    friend class QGraphicsWidgetPrivate;
    friend class QGraphicsEffect;
    friend class QGraphicsSceneIndex;
    friend class QGraphicsSceneIndexPrivate;
    friend class QGraphicsSceneBspTreeIndex;
    friend class QGraphicsSceneBspTreeIndexPrivate;
    friend class QGraphicsItemEffectSourcePrivate;
#ifndef QT_NO_GESTURES
    friend class QGesture;
#endif
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QGraphicsScene::SceneLayers)

#endif // QT_NO_GRAPHICSVIEW

QT_END_NAMESPACE

#endif
