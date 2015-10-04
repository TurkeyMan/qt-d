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

#ifndef QGRAPHICSSCENEEVENT_H
#define QGRAPHICSSCENEEVENT_H

public import qt.QtCore.qcoreevent;
public import qt.QtCore.qpoint;
public import qt.QtCore.qscopedpointer;
public import qt.QtCore.qrect;
public import qt.QtGui.qpolygon;
public import qt.QtCore.qset;
public import qt.QtCore.qhash;

QT_BEGIN_NAMESPACE


#if !defined(QT_NO_GRAPHICSVIEW)

class QMimeData;
class QPointF;
class QSizeF;
class QWidget;

class QGraphicsSceneEventPrivate;
class Q_WIDGETS_EXPORT QGraphicsSceneEvent : public QEvent
{
public:
    explicit QGraphicsSceneEvent(Type type);
    ~QGraphicsSceneEvent();

    QWidget *widget() const;
    void setWidget(QWidget *widget);

protected:
    QGraphicsSceneEvent(QGraphicsSceneEventPrivate &dd, Type type = None);
    QScopedPointer<QGraphicsSceneEventPrivate> d_ptr;
    mixin Q_DECLARE_PRIVATE;
private:
    mixin Q_DISABLE_COPY;
};

class QGraphicsSceneMouseEventPrivate;
class Q_WIDGETS_EXPORT QGraphicsSceneMouseEvent : public QGraphicsSceneEvent
{
public:
    explicit QGraphicsSceneMouseEvent(Type type = None);
    ~QGraphicsSceneMouseEvent();

    QPointF pos() const;
    void setPos(ref const(QPointF) pos);

    QPointF scenePos() const;
    void setScenePos(ref const(QPointF) pos);

    QPoint screenPos() const;
    void setScreenPos(ref const(QPoint) pos);

    QPointF buttonDownPos(Qt.MouseButton button) const;
    void setButtonDownPos(Qt.MouseButton button, ref const(QPointF) pos);

    QPointF buttonDownScenePos(Qt.MouseButton button) const;
    void setButtonDownScenePos(Qt.MouseButton button, ref const(QPointF) pos);

    QPoint buttonDownScreenPos(Qt.MouseButton button) const;
    void setButtonDownScreenPos(Qt.MouseButton button, ref const(QPoint) pos);

    QPointF lastPos() const;
    void setLastPos(ref const(QPointF) pos);

    QPointF lastScenePos() const;
    void setLastScenePos(ref const(QPointF) pos);

    QPoint lastScreenPos() const;
    void setLastScreenPos(ref const(QPoint) pos);

    Qt.MouseButtons buttons() const;
    void setButtons(Qt.MouseButtons buttons);

    Qt.MouseButton button() const;
    void setButton(Qt.MouseButton button);

    Qt.KeyboardModifiers modifiers() const;
    void setModifiers(Qt.KeyboardModifiers modifiers);

    Qt.MouseEventSource source() const;
    void setSource(Qt.MouseEventSource source);

    Qt.MouseEventFlags flags() const;
    void setFlags(Qt.MouseEventFlags);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

class QGraphicsSceneWheelEventPrivate;
class Q_WIDGETS_EXPORT QGraphicsSceneWheelEvent : public QGraphicsSceneEvent
{
public:
    explicit QGraphicsSceneWheelEvent(Type type = None);
    ~QGraphicsSceneWheelEvent();

    QPointF pos() const;
    void setPos(ref const(QPointF) pos);

    QPointF scenePos() const;
    void setScenePos(ref const(QPointF) pos);

    QPoint screenPos() const;
    void setScreenPos(ref const(QPoint) pos);

    Qt.MouseButtons buttons() const;
    void setButtons(Qt.MouseButtons buttons);

    Qt.KeyboardModifiers modifiers() const;
    void setModifiers(Qt.KeyboardModifiers modifiers);

    int delta() const;
    void setDelta(int delta);

    Qt.Orientation orientation() const;
    void setOrientation(Qt.Orientation orientation);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

class QGraphicsSceneContextMenuEventPrivate;
class Q_WIDGETS_EXPORT QGraphicsSceneContextMenuEvent : public QGraphicsSceneEvent
{
public:
    enum Reason { Mouse, Keyboard, Other };

    explicit QGraphicsSceneContextMenuEvent(Type type = None);
    ~QGraphicsSceneContextMenuEvent();

    QPointF pos() const;
    void setPos(ref const(QPointF) pos);

    QPointF scenePos() const;
    void setScenePos(ref const(QPointF) pos);

    QPoint screenPos() const;
    void setScreenPos(ref const(QPoint) pos);

    Qt.KeyboardModifiers modifiers() const;
    void setModifiers(Qt.KeyboardModifiers modifiers);

    Reason reason() const;
    void setReason(Reason reason);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

class QGraphicsSceneHoverEventPrivate;
class Q_WIDGETS_EXPORT QGraphicsSceneHoverEvent : public QGraphicsSceneEvent
{
public:
    explicit QGraphicsSceneHoverEvent(Type type = None);
    ~QGraphicsSceneHoverEvent();

    QPointF pos() const;
    void setPos(ref const(QPointF) pos);

    QPointF scenePos() const;
    void setScenePos(ref const(QPointF) pos);

    QPoint screenPos() const;
    void setScreenPos(ref const(QPoint) pos);

    QPointF lastPos() const;
    void setLastPos(ref const(QPointF) pos);

    QPointF lastScenePos() const;
    void setLastScenePos(ref const(QPointF) pos);

    QPoint lastScreenPos() const;
    void setLastScreenPos(ref const(QPoint) pos);

    Qt.KeyboardModifiers modifiers() const;
    void setModifiers(Qt.KeyboardModifiers modifiers);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

class QGraphicsSceneHelpEventPrivate;
class Q_WIDGETS_EXPORT QGraphicsSceneHelpEvent : public QGraphicsSceneEvent
{
public:
    explicit QGraphicsSceneHelpEvent(Type type = None);
    ~QGraphicsSceneHelpEvent();

    QPointF scenePos() const;
    void setScenePos(ref const(QPointF) pos);

    QPoint screenPos() const;
    void setScreenPos(ref const(QPoint) pos);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

class QGraphicsSceneDragDropEventPrivate;
class Q_WIDGETS_EXPORT QGraphicsSceneDragDropEvent : public QGraphicsSceneEvent
{
public:
    explicit QGraphicsSceneDragDropEvent(Type type = None);
    ~QGraphicsSceneDragDropEvent();

    QPointF pos() const;
    void setPos(ref const(QPointF) pos);

    QPointF scenePos() const;
    void setScenePos(ref const(QPointF) pos);

    QPoint screenPos() const;
    void setScreenPos(ref const(QPoint) pos);

    Qt.MouseButtons buttons() const;
    void setButtons(Qt.MouseButtons buttons);

    Qt.KeyboardModifiers modifiers() const;
    void setModifiers(Qt.KeyboardModifiers modifiers);

    Qt.DropActions possibleActions() const;
    void setPossibleActions(Qt.DropActions actions);

    Qt.DropAction proposedAction() const;
    void setProposedAction(Qt.DropAction action);
    void acceptProposedAction();

    Qt.DropAction dropAction() const;
    void setDropAction(Qt.DropAction action);

    QWidget *source() const;
    void setSource(QWidget *source);

    const(QMimeData)* mimeData() const;
    void setMimeData(const(QMimeData)* data);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

class QGraphicsSceneResizeEventPrivate;
class Q_WIDGETS_EXPORT QGraphicsSceneResizeEvent : public QGraphicsSceneEvent
{
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
public:
    QGraphicsSceneResizeEvent();
    ~QGraphicsSceneResizeEvent();

    QSizeF oldSize() const;
    void setOldSize(ref const(QSizeF) size);

    QSizeF newSize() const;
    void setNewSize(ref const(QSizeF) size);
};

class QGraphicsSceneMoveEventPrivate;
class Q_WIDGETS_EXPORT QGraphicsSceneMoveEvent : public QGraphicsSceneEvent
{
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
public:
    QGraphicsSceneMoveEvent();
    ~QGraphicsSceneMoveEvent();

    QPointF oldPos() const;
    void setOldPos(ref const(QPointF) pos);

    QPointF newPos() const;
    void setNewPos(ref const(QPointF) pos);
};

#endif // QT_NO_GRAPHICSVIEW

QT_END_NAMESPACE

#endif
