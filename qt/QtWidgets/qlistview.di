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

#ifndef QLISTVIEW_H
#define QLISTVIEW_H

public import qt.QtWidgets.qabstractitemview;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_LISTVIEW

class QListViewPrivate;

class Q_WIDGETS_EXPORT QListView : public QAbstractItemView
{
    mixin Q_OBJECT;
    Q_ENUMS(Movement Flow ResizeMode LayoutMode ViewMode)
    mixin Q_PROPERTY!(Movement, "movement", "READ", "movement", "WRITE", "setMovement");
    mixin Q_PROPERTY!(Flow, "flow", "READ", "flow", "WRITE", "setFlow");
    mixin Q_PROPERTY!(bool, "isWrapping", "READ", "isWrapping", "WRITE", "setWrapping");
    mixin Q_PROPERTY!(ResizeMode, "resizeMode", "READ", "resizeMode", "WRITE", "setResizeMode");
    mixin Q_PROPERTY!(LayoutMode, "layoutMode", "READ", "layoutMode", "WRITE", "setLayoutMode");
    mixin Q_PROPERTY!(int, "spacing", "READ", "spacing", "WRITE", "setSpacing");
    mixin Q_PROPERTY!(QSize, "gridSize", "READ", "gridSize", "WRITE", "setGridSize");
    mixin Q_PROPERTY!(ViewMode, "viewMode", "READ", "viewMode", "WRITE", "setViewMode");
    mixin Q_PROPERTY!(int, "modelColumn", "READ", "modelColumn", "WRITE", "setModelColumn");
    mixin Q_PROPERTY!(bool, "uniformItemSizes", "READ", "uniformItemSizes", "WRITE", "setUniformItemSizes");
    mixin Q_PROPERTY!(int, "batchSize", "READ", "batchSize", "WRITE", "setBatchSize");
    mixin Q_PROPERTY!(bool, "wordWrap", "READ", "wordWrap", "WRITE", "setWordWrap");
    mixin Q_PROPERTY!(bool, "selectionRectVisible", "READ", "isSelectionRectVisible", "WRITE", "setSelectionRectVisible");

public:
    enum Movement { Static, Free, Snap };
    enum Flow { LeftToRight, TopToBottom };
    enum ResizeMode { Fixed, Adjust };
    enum LayoutMode { SinglePass, Batched };
    enum ViewMode { ListMode, IconMode };

    explicit QListView(QWidget *parent = 0);
    ~QListView();

    void setMovement(Movement movement);
    Movement movement() const;

    void setFlow(Flow flow);
    Flow flow() const;

    void setWrapping(bool enable);
    bool isWrapping() const;

    void setResizeMode(ResizeMode mode);
    ResizeMode resizeMode() const;

    void setLayoutMode(LayoutMode mode);
    LayoutMode layoutMode() const;

    void setSpacing(int space);
    int spacing() const;

    void setBatchSize(int batchSize);
    int batchSize() const;

    void setGridSize(ref const(QSize) size);
    QSize gridSize() const;

    void setViewMode(ViewMode mode);
    ViewMode viewMode() const;

    void clearPropertyFlags();

    bool isRowHidden(int row) const;
    void setRowHidden(int row, bool hide);

    void setModelColumn(int column);
    int modelColumn() const;

    void setUniformItemSizes(bool enable);
    bool uniformItemSizes() const;

    void setWordWrap(bool on);
    bool wordWrap() const;

    void setSelectionRectVisible(bool show);
    bool isSelectionRectVisible() const;

    QRect visualRect(ref const(QModelIndex) index) const;
    void scrollTo(ref const(QModelIndex) index, ScrollHint hint = EnsureVisible);
    QModelIndex indexAt(ref const(QPoint) p) const;

    void doItemsLayout();
    void reset();
    void setRootIndex(ref const(QModelIndex) index);

Q_SIGNALS:
    void indexesMoved(ref const(QModelIndexList) indexes);

protected:
    QListView(QListViewPrivate &, QWidget *parent = 0);

    bool event(QEvent *e);

    void scrollContentsBy(int dx, int dy);

    void resizeContents(int width, int height);
    QSize contentsSize() const;

    void dataChanged(ref const(QModelIndex) topLeft, ref const(QModelIndex) bottomRight, ref const(QVector<int>) roles = QVector<int>());
    void rowsInserted(ref const(QModelIndex) parent, int start, int end);
    void rowsAboutToBeRemoved(ref const(QModelIndex) parent, int start, int end);

    void mouseMoveEvent(QMouseEvent *e);
    void mouseReleaseEvent(QMouseEvent *e);

    void timerEvent(QTimerEvent *e);
    void resizeEvent(QResizeEvent *e);
#ifndef QT_NO_DRAGANDDROP
    void dragMoveEvent(QDragMoveEvent *e);
    void dragLeaveEvent(QDragLeaveEvent *e);
    void dropEvent(QDropEvent *e);
    void startDrag(Qt.DropActions supportedActions);
#endif // QT_NO_DRAGANDDROP

    QStyleOptionViewItem viewOptions() const;
    void paintEvent(QPaintEvent *e);

    int horizontalOffset() const;
    int verticalOffset() const;
    QModelIndex moveCursor(CursorAction cursorAction, Qt.KeyboardModifiers modifiers);
    QRect rectForIndex(ref const(QModelIndex) index) const;
    void setPositionForIndex(ref const(QPoint) position, ref const(QModelIndex) index);

    void setSelection(ref const(QRect) rect, QItemSelectionModel::SelectionFlags command);
    QRegion visualRegionForSelection(ref const(QItemSelection) selection) const;
    QModelIndexList selectedIndexes() const;

    void updateGeometries();

    bool isIndexHidden(ref const(QModelIndex) index) const;

    void selectionChanged(ref const(QItemSelection) selected, ref const(QItemSelection) deselected);
    void currentChanged(ref const(QModelIndex) current, ref const(QModelIndex) previous);

    QSize viewportSizeHint() const Q_DECL_OVERRIDE;

private:
    int visualIndex(ref const(QModelIndex) index) const;

    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

#endif // QT_NO_LISTVIEW

QT_END_NAMESPACE

#endif // QLISTVIEW_H
