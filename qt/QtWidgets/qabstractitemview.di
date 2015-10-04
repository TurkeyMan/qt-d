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

#ifndef QABSTRACTITEMVIEW_H
#define QABSTRACTITEMVIEW_H

public import qt.QtWidgets.qabstractscrollarea;
public import qt.QtCore.qabstractitemmodel;
public import qt.QtCore.qitemselectionmodel;
public import qt.QtWidgets.qabstractitemdelegate;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_ITEMVIEWS

class QMenu;
class QDrag;
class QEvent;
class QAbstractItemViewPrivate;

class Q_WIDGETS_EXPORT QAbstractItemView : public QAbstractScrollArea
{
    mixin Q_OBJECT;
    Q_ENUMS(SelectionMode SelectionBehavior ScrollHint ScrollMode DragDropMode)
    Q_FLAGS(EditTriggers)
    mixin Q_PROPERTY!(bool, "autoScroll", "READ", "hasAutoScroll", "WRITE", "setAutoScroll");
    mixin Q_PROPERTY!(int, "autoScrollMargin", "READ", "autoScrollMargin", "WRITE", "setAutoScrollMargin");
    mixin Q_PROPERTY!(EditTriggers, "editTriggers", "READ", "editTriggers", "WRITE", "setEditTriggers");
    mixin Q_PROPERTY!(bool, "tabKeyNavigation", "READ", "tabKeyNavigation", "WRITE", "setTabKeyNavigation");
#ifndef QT_NO_DRAGANDDROP
    mixin Q_PROPERTY!(bool, "showDropIndicator", "READ", "showDropIndicator", "WRITE", "setDropIndicatorShown");
    mixin Q_PROPERTY!(bool, "dragEnabled", "READ", "dragEnabled", "WRITE", "setDragEnabled");
    mixin Q_PROPERTY!(bool, "dragDropOverwriteMode", "READ", "dragDropOverwriteMode", "WRITE", "setDragDropOverwriteMode");
    mixin Q_PROPERTY!(DragDropMode, "dragDropMode", "READ", "dragDropMode", "WRITE", "setDragDropMode");
    mixin Q_PROPERTY!(Qt.DropAction, "defaultDropAction", "READ", "defaultDropAction", "WRITE", "setDefaultDropAction");
#endif
    mixin Q_PROPERTY!(bool, "alternatingRowColors", "READ", "alternatingRowColors", "WRITE", "setAlternatingRowColors");
    mixin Q_PROPERTY!(SelectionMode, "selectionMode", "READ", "selectionMode", "WRITE", "setSelectionMode");
    mixin Q_PROPERTY!(SelectionBehavior, "selectionBehavior", "READ", "selectionBehavior", "WRITE", "setSelectionBehavior");
    mixin Q_PROPERTY!(QSize, "iconSize", "READ", "iconSize", "WRITE", "setIconSize");
    mixin Q_PROPERTY!(Qt.TextElideMode, "textElideMode", "READ", "textElideMode", "WRITE", "setTextElideMode");
    mixin Q_PROPERTY!(ScrollMode, "verticalScrollMode", "READ", "verticalScrollMode", "WRITE", "setVerticalScrollMode");
    mixin Q_PROPERTY!(ScrollMode, "horizontalScrollMode", "READ", "horizontalScrollMode", "WRITE", "setHorizontalScrollMode");

public:
    enum SelectionMode {
        NoSelection,
        SingleSelection,
        MultiSelection,
        ExtendedSelection,
        ContiguousSelection
    };

    enum SelectionBehavior {
        SelectItems,
        SelectRows,
        SelectColumns
    };

    enum ScrollHint {
        EnsureVisible,
        PositionAtTop,
        PositionAtBottom,
        PositionAtCenter
    };

    enum EditTrigger {
        NoEditTriggers = 0,
        CurrentChanged = 1,
        DoubleClicked = 2,
        SelectedClicked = 4,
        EditKeyPressed = 8,
        AnyKeyPressed = 16,
        AllEditTriggers = 31
    };

    Q_DECLARE_FLAGS(EditTriggers, EditTrigger)

    enum ScrollMode {
        ScrollPerItem,
        ScrollPerPixel
    };

    explicit QAbstractItemView(QWidget *parent = 0);
    ~QAbstractItemView();

    /+virtual+/ void setModel(QAbstractItemModel *model);
    QAbstractItemModel *model() const;

    /+virtual+/ void setSelectionModel(QItemSelectionModel *selectionModel);
    QItemSelectionModel *selectionModel() const;

    void setItemDelegate(QAbstractItemDelegate *delegate);
    QAbstractItemDelegate *itemDelegate() const;

    void setSelectionMode(QAbstractItemView::SelectionMode mode);
    QAbstractItemView::SelectionMode selectionMode() const;

    void setSelectionBehavior(QAbstractItemView::SelectionBehavior behavior);
    QAbstractItemView::SelectionBehavior selectionBehavior() const;

    QModelIndex currentIndex() const;
    QModelIndex rootIndex() const;

    void setEditTriggers(EditTriggers triggers);
    EditTriggers editTriggers() const;

    void setVerticalScrollMode(ScrollMode mode);
    ScrollMode verticalScrollMode() const;

    void setHorizontalScrollMode(ScrollMode mode);
    ScrollMode horizontalScrollMode() const;

    void setAutoScroll(bool enable);
    bool hasAutoScroll() const;

    void setAutoScrollMargin(int margin);
    int autoScrollMargin() const;

    void setTabKeyNavigation(bool enable);
    bool tabKeyNavigation() const;

#ifndef QT_NO_DRAGANDDROP
    void setDropIndicatorShown(bool enable);
    bool showDropIndicator() const;

    void setDragEnabled(bool enable);
    bool dragEnabled() const;

    void setDragDropOverwriteMode(bool overwrite);
    bool dragDropOverwriteMode() const;

    enum DragDropMode {
        NoDragDrop,
        DragOnly,
        DropOnly,
        DragDrop,
        InternalMove
    };

    void setDragDropMode(DragDropMode behavior);
    DragDropMode dragDropMode() const;

    void setDefaultDropAction(Qt.DropAction dropAction);
    Qt.DropAction defaultDropAction() const;
#endif

    void setAlternatingRowColors(bool enable);
    bool alternatingRowColors() const;

    void setIconSize(ref const(QSize) size);
    QSize iconSize() const;

    void setTextElideMode(Qt.TextElideMode mode);
    Qt.TextElideMode textElideMode() const;

    /+virtual+/ void keyboardSearch(ref const(QString) search);

    /+virtual+/ QRect visualRect(ref const(QModelIndex) index) const = 0;
    /+virtual+/ void scrollTo(ref const(QModelIndex) index, ScrollHint hint = EnsureVisible) = 0;
    /+virtual+/ QModelIndex indexAt(ref const(QPoint) point) const = 0;

    QSize sizeHintForIndex(ref const(QModelIndex) index) const;
    /+virtual+/ int sizeHintForRow(int row) const;
    /+virtual+/ int sizeHintForColumn(int column) const;

    void openPersistentEditor(ref const(QModelIndex) index);
    void closePersistentEditor(ref const(QModelIndex) index);

    void setIndexWidget(ref const(QModelIndex) index, QWidget *widget);
    QWidget *indexWidget(ref const(QModelIndex) index) const;

    void setItemDelegateForRow(int row, QAbstractItemDelegate *delegate);
    QAbstractItemDelegate *itemDelegateForRow(int row) const;

    void setItemDelegateForColumn(int column, QAbstractItemDelegate *delegate);
    QAbstractItemDelegate *itemDelegateForColumn(int column) const;

    QAbstractItemDelegate *itemDelegate(ref const(QModelIndex) index) const;

    /+virtual+/ QVariant inputMethodQuery(Qt.InputMethodQuery query) const;

#ifdef Q_NO_USING_KEYWORD
    /+inline+/ void update() { QAbstractScrollArea::update(); }
#else
    using QAbstractScrollArea::update;
#endif

public Q_SLOTS:
    /+virtual+/ void reset();
    /+virtual+/ void setRootIndex(ref const(QModelIndex) index);
    /+virtual+/ void doItemsLayout();
    /+virtual+/ void selectAll();
    void edit(ref const(QModelIndex) index);
    void clearSelection();
    void setCurrentIndex(ref const(QModelIndex) index);
    void scrollToTop();
    void scrollToBottom();
    void update(ref const(QModelIndex) index);

protected Q_SLOTS:
    /+virtual+/ void dataChanged(ref const(QModelIndex) topLeft, ref const(QModelIndex) bottomRight, ref const(QVector<int>) roles = QVector<int>());
    /+virtual+/ void rowsInserted(ref const(QModelIndex) parent, int start, int end);
    /+virtual+/ void rowsAboutToBeRemoved(ref const(QModelIndex) parent, int start, int end);
    /+virtual+/ void selectionChanged(ref const(QItemSelection) selected, ref const(QItemSelection) deselected);
    /+virtual+/ void currentChanged(ref const(QModelIndex) current, ref const(QModelIndex) previous);
    /+virtual+/ void updateEditorData();
    /+virtual+/ void updateEditorGeometries();
    /+virtual+/ void updateGeometries();
    /+virtual+/ void verticalScrollbarAction(int action);
    /+virtual+/ void horizontalScrollbarAction(int action);
    /+virtual+/ void verticalScrollbarValueChanged(int value);
    /+virtual+/ void horizontalScrollbarValueChanged(int value);
    /+virtual+/ void closeEditor(QWidget *editor, QAbstractItemDelegate::EndEditHint hint);
    /+virtual+/ void commitData(QWidget *editor);
    /+virtual+/ void editorDestroyed(QObject *editor);

Q_SIGNALS:
    void pressed(ref const(QModelIndex) index);
    void clicked(ref const(QModelIndex) index);
    void doubleClicked(ref const(QModelIndex) index);

    void activated(ref const(QModelIndex) index);
    void entered(ref const(QModelIndex) index);
    void viewportEntered();

protected:
    QAbstractItemView(QAbstractItemViewPrivate &, QWidget *parent = 0);

    void setHorizontalStepsPerItem(int steps);
    int horizontalStepsPerItem() const;
    void setVerticalStepsPerItem(int steps);
    int verticalStepsPerItem() const;

    enum CursorAction { MoveUp, MoveDown, MoveLeft, MoveRight,
                        MoveHome, MoveEnd, MovePageUp, MovePageDown,
                        MoveNext, MovePrevious };
    /+virtual+/ QModelIndex moveCursor(CursorAction cursorAction,
                                   Qt.KeyboardModifiers modifiers) = 0;

    /+virtual+/ int horizontalOffset() const = 0;
    /+virtual+/ int verticalOffset() const = 0;

    /+virtual+/ bool isIndexHidden(ref const(QModelIndex) index) const = 0;

    /+virtual+/ void setSelection(ref const(QRect) rect, QItemSelectionModel::SelectionFlags command) = 0;
    /+virtual+/ QRegion visualRegionForSelection(ref const(QItemSelection) selection) const = 0;
    /+virtual+/ QModelIndexList selectedIndexes() const;

    /+virtual+/ bool edit(ref const(QModelIndex) index, EditTrigger trigger, QEvent *event);

    /+virtual+/ QItemSelectionModel::SelectionFlags selectionCommand(ref const(QModelIndex) index,
                                                                 const(QEvent)* event = 0) const;

#ifndef QT_NO_DRAGANDDROP
    /+virtual+/ void startDrag(Qt.DropActions supportedActions);
#endif

    /+virtual+/ QStyleOptionViewItem viewOptions() const;

    enum State {
        NoState,
        DraggingState,
        DragSelectingState,
        EditingState,
        ExpandingState,
        CollapsingState,
        AnimatingState
    };

    State state() const;
    void setState(State state);

    void scheduleDelayedItemsLayout();
    void executeDelayedItemsLayout();

    void setDirtyRegion(ref const(QRegion) region);
    void scrollDirtyRegion(int dx, int dy);
    QPoint dirtyRegionOffset() const;

    void startAutoScroll();
    void stopAutoScroll();
    void doAutoScroll();

    bool focusNextPrevChild(bool next);
    bool event(QEvent *event);
    bool viewportEvent(QEvent *event);
    void mousePressEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
    void mouseDoubleClickEvent(QMouseEvent *event);
#ifndef QT_NO_DRAGANDDROP
    void dragEnterEvent(QDragEnterEvent *event);
    void dragMoveEvent(QDragMoveEvent *event);
    void dragLeaveEvent(QDragLeaveEvent *event);
    void dropEvent(QDropEvent *event);
#endif
    void focusInEvent(QFocusEvent *event);
    void focusOutEvent(QFocusEvent *event);
    void keyPressEvent(QKeyEvent *event);
    void resizeEvent(QResizeEvent *event);
    void timerEvent(QTimerEvent *event);
    void inputMethodEvent(QInputMethodEvent *event);

#ifndef QT_NO_DRAGANDDROP
    enum DropIndicatorPosition { OnItem, AboveItem, BelowItem, OnViewport };
    DropIndicatorPosition dropIndicatorPosition() const;
#endif

    QSize viewportSizeHint() const Q_DECL_OVERRIDE;

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_columnsAboutToBeRemoved(ref const(QModelIndex), int, int))
    Q_PRIVATE_SLOT(d_func(), void _q_columnsRemoved(ref const(QModelIndex), int, int))
    Q_PRIVATE_SLOT(d_func(), void _q_columnsInserted(ref const(QModelIndex), int, int))
    Q_PRIVATE_SLOT(d_func(), void _q_rowsInserted(ref const(QModelIndex), int, int))
    Q_PRIVATE_SLOT(d_func(), void _q_rowsRemoved(ref const(QModelIndex), int, int))
    Q_PRIVATE_SLOT(d_func(), void _q_columnsMoved(ref const(QModelIndex), int, int, ref const(QModelIndex), int))
    Q_PRIVATE_SLOT(d_func(), void _q_rowsMoved(ref const(QModelIndex), int, int, ref const(QModelIndex), int))
    Q_PRIVATE_SLOT(d_func(), void _q_modelDestroyed())
    Q_PRIVATE_SLOT(d_func(), void _q_layoutChanged())
    Q_PRIVATE_SLOT(d_func(), void _q_headerDataChanged())
#ifndef QT_NO_GESTURES
    Q_PRIVATE_SLOT(d_func(), void _q_scrollerStateChanged())
#endif

    friend class QTreeViewPrivate; // needed to compile with MSVC
    friend class QListModeViewBase;
    friend class QListViewPrivate;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QAbstractItemView::EditTriggers)

#endif // QT_NO_ITEMVIEWS

QT_END_NAMESPACE

#endif // QABSTRACTITEMVIEW_H
