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

#ifndef QTREEVIEW_H
#define QTREEVIEW_H

public import qt.QtWidgets.qabstractitemview;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_TREEVIEW

class QTreeViewPrivate;
class QHeaderView;

class Q_WIDGETS_EXPORT QTreeView : public QAbstractItemView
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(int, "autoExpandDelay", "READ", "autoExpandDelay", "WRITE", "setAutoExpandDelay");
    mixin Q_PROPERTY!(int, "indentation", "READ", "indentation", "WRITE", "setIndentation", "RESET", "resetIndentation");
    mixin Q_PROPERTY!(bool, "rootIsDecorated", "READ", "rootIsDecorated", "WRITE", "setRootIsDecorated");
    mixin Q_PROPERTY!(bool, "uniformRowHeights", "READ", "uniformRowHeights", "WRITE", "setUniformRowHeights");
    mixin Q_PROPERTY!(bool, "itemsExpandable", "READ", "itemsExpandable", "WRITE", "setItemsExpandable");
    mixin Q_PROPERTY!(bool, "sortingEnabled", "READ", "isSortingEnabled", "WRITE", "setSortingEnabled");
    mixin Q_PROPERTY!(bool, "animated", "READ", "isAnimated", "WRITE", "setAnimated");
    mixin Q_PROPERTY!(bool, "allColumnsShowFocus", "READ", "allColumnsShowFocus", "WRITE", "setAllColumnsShowFocus");
    mixin Q_PROPERTY!(bool, "wordWrap", "READ", "wordWrap", "WRITE", "setWordWrap");
    mixin Q_PROPERTY!(bool, "headerHidden", "READ", "isHeaderHidden", "WRITE", "setHeaderHidden");
    mixin Q_PROPERTY!(bool, "expandsOnDoubleClick", "READ", "expandsOnDoubleClick", "WRITE", "setExpandsOnDoubleClick");

public:
    explicit QTreeView(QWidget *parent = 0);
    ~QTreeView();

    void setModel(QAbstractItemModel *model);
    void setRootIndex(ref const(QModelIndex) index);
    void setSelectionModel(QItemSelectionModel *selectionModel);

    QHeaderView *header() const;
    void setHeader(QHeaderView *header);

    int autoExpandDelay() const;
    void setAutoExpandDelay(int delay);

    int indentation() const;
    void setIndentation(int i);
    void resetIndentation();

    bool rootIsDecorated() const;
    void setRootIsDecorated(bool show);

    bool uniformRowHeights() const;
    void setUniformRowHeights(bool uniform);

    bool itemsExpandable() const;
    void setItemsExpandable(bool enable);

    bool expandsOnDoubleClick() const;
    void setExpandsOnDoubleClick(bool enable);

    int columnViewportPosition(int column) const;
    int columnWidth(int column) const;
    void setColumnWidth(int column, int width);
    int columnAt(int x) const;

    bool isColumnHidden(int column) const;
    void setColumnHidden(int column, bool hide);

    bool isHeaderHidden() const;
    void setHeaderHidden(bool hide);

    bool isRowHidden(int row, ref const(QModelIndex) parent) const;
    void setRowHidden(int row, ref const(QModelIndex) parent, bool hide);

    bool isFirstColumnSpanned(int row, ref const(QModelIndex) parent) const;
    void setFirstColumnSpanned(int row, ref const(QModelIndex) parent, bool span);

    bool isExpanded(ref const(QModelIndex) index) const;
    void setExpanded(ref const(QModelIndex) index, bool expand);

    void setSortingEnabled(bool enable);
    bool isSortingEnabled() const;

    void setAnimated(bool enable);
    bool isAnimated() const;

    void setAllColumnsShowFocus(bool enable);
    bool allColumnsShowFocus() const;

    void setWordWrap(bool on);
    bool wordWrap() const;

    void setTreePosition(int logicalIndex);
    int treePosition() const;

    void keyboardSearch(ref const(QString) search);

    QRect visualRect(ref const(QModelIndex) index) const;
    void scrollTo(ref const(QModelIndex) index, ScrollHint hint = EnsureVisible);
    QModelIndex indexAt(ref const(QPoint) p) const;
    QModelIndex indexAbove(ref const(QModelIndex) index) const;
    QModelIndex indexBelow(ref const(QModelIndex) index) const;

    void doItemsLayout();
    void reset();

    void sortByColumn(int column, Qt.SortOrder order);

    void dataChanged(ref const(QModelIndex) topLeft, ref const(QModelIndex) bottomRight, ref const(QVector<int>) roles = QVector<int>());
    void selectAll();

Q_SIGNALS:
    void expanded(ref const(QModelIndex) index);
    void collapsed(ref const(QModelIndex) index);

public Q_SLOTS:
    void hideColumn(int column);
    void showColumn(int column);
    void expand(ref const(QModelIndex) index);
    void collapse(ref const(QModelIndex) index);
    void resizeColumnToContents(int column);
    void sortByColumn(int column);
    void expandAll();
    void collapseAll();
    void expandToDepth(int depth);

protected Q_SLOTS:
    void columnResized(int column, int oldSize, int newSize);
    void columnCountChanged(int oldCount, int newCount);
    void columnMoved();
    void reexpand();
    void rowsRemoved(ref const(QModelIndex) parent, int first, int last);

protected:
    QTreeView(QTreeViewPrivate &dd, QWidget *parent = 0);
    void scrollContentsBy(int dx, int dy);
    void rowsInserted(ref const(QModelIndex) parent, int start, int end);
    void rowsAboutToBeRemoved(ref const(QModelIndex) parent, int start, int end);

    QModelIndex moveCursor(CursorAction cursorAction, Qt.KeyboardModifiers modifiers);
    int horizontalOffset() const;
    int verticalOffset() const;

    void setSelection(ref const(QRect) rect, QItemSelectionModel::SelectionFlags command);
    QRegion visualRegionForSelection(ref const(QItemSelection) selection) const;
    QModelIndexList selectedIndexes() const;

    void timerEvent(QTimerEvent *event);
    void paintEvent(QPaintEvent *event);

    void drawTree(QPainter *painter, ref const(QRegion) region) const;
    /+virtual+/ void drawRow(QPainter *painter,
                         ref const(QStyleOptionViewItem) options,
                         ref const(QModelIndex) index) const;
    /+virtual+/ void drawBranches(QPainter *painter,
                              ref const(QRect) rect,
                              ref const(QModelIndex) index) const;

    void mousePressEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
    void mouseDoubleClickEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);
    void keyPressEvent(QKeyEvent *event);
#ifndef QT_NO_DRAGANDDROP
    void dragMoveEvent(QDragMoveEvent *event);
#endif
    bool viewportEvent(QEvent *event);

    void updateGeometries();

    QSize viewportSizeHint() const Q_DECL_OVERRIDE;

    int sizeHintForColumn(int column) const;
    int indexRowSizeHint(ref const(QModelIndex) index) const;
    int rowHeight(ref const(QModelIndex) index) const;

    void horizontalScrollbarAction(int action);

    bool isIndexHidden(ref const(QModelIndex) index) const;
    void selectionChanged(ref const(QItemSelection) selected,
                          ref const(QItemSelection) deselected);
    void currentChanged(ref const(QModelIndex) current, ref const(QModelIndex) previous);

private:
    friend class QAccessibleTable;
    friend class QAccessibleTree;
    friend class QAccessibleTableCell;
    int visualIndex(ref const(QModelIndex) index) const;

    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
#ifndef QT_NO_ANIMATION
    Q_PRIVATE_SLOT(d_func(), void _q_endAnimatedOperation())
#endif //QT_NO_ANIMATION
    Q_PRIVATE_SLOT(d_func(), void _q_modelAboutToBeReset())
    Q_PRIVATE_SLOT(d_func(), void _q_sortIndicatorChanged(int column, Qt.SortOrder order))
};

#endif // QT_NO_TREEVIEW

QT_END_NAMESPACE

#endif // QTREEVIEW_H
