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

#ifndef QTREEWIDGET_H
#define QTREEWIDGET_H

public import qt.QtWidgets.qtreeview;
public import qt.QtWidgets.qtreewidgetitemiterator;
public import qt.QtCore.qvariant;
public import qt.QtCore.qvector;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_TREEWIDGET

class QTreeWidget;
class QTreeModel;
class QWidgetItemData;
class QTreeWidgetItemPrivate;

class Q_WIDGETS_EXPORT QTreeWidgetItem
{
    friend class QTreeModel;
    friend class QTreeWidget;
    friend class QTreeWidgetPrivate;
    friend class QTreeWidgetItemIterator;
    friend class QTreeWidgetItemPrivate;
public:
    enum ItemType { Type = 0, UserType = 1000 };
    explicit QTreeWidgetItem(int type = Type);
    explicit QTreeWidgetItem(ref const(QStringList) strings, int type = Type);
    explicit QTreeWidgetItem(QTreeWidget *view, int type = Type);
    QTreeWidgetItem(QTreeWidget *view, ref const(QStringList) strings, int type = Type);
    QTreeWidgetItem(QTreeWidget *view, QTreeWidgetItem *after, int type = Type);
    explicit QTreeWidgetItem(QTreeWidgetItem *parent, int type = Type);
    QTreeWidgetItem(QTreeWidgetItem *parent, ref const(QStringList) strings, int type = Type);
    QTreeWidgetItem(QTreeWidgetItem *parent, QTreeWidgetItem *after, int type = Type);
    QTreeWidgetItem(ref const(QTreeWidgetItem) other);
    /+virtual+/ ~QTreeWidgetItem();

    /+virtual+/ QTreeWidgetItem *clone() const;

    /+inline+/ QTreeWidget *treeWidget() const { return view; }

    /+inline+/ void setSelected(bool select);
    /+inline+/ bool isSelected() const;

    /+inline+/ void setHidden(bool hide);
    /+inline+/ bool isHidden() const;

    /+inline+/ void setExpanded(bool expand);
    /+inline+/ bool isExpanded() const;

    /+inline+/ void setFirstColumnSpanned(bool span);
    /+inline+/ bool isFirstColumnSpanned() const;

    /+inline+/ void setDisabled(bool disabled);
    /+inline+/ bool isDisabled() const;

    enum ChildIndicatorPolicy { ShowIndicator, DontShowIndicator, DontShowIndicatorWhenChildless };
    void setChildIndicatorPolicy(QTreeWidgetItem::ChildIndicatorPolicy policy);
    QTreeWidgetItem::ChildIndicatorPolicy childIndicatorPolicy() const;

    Qt.ItemFlags flags() const;
    void setFlags(Qt.ItemFlags flags);

    /+inline+/ QString text(int column) const
        { return data(column, Qt.DisplayRole).toString(); }
    /+inline+/ void setText(int column, ref const(QString) text);

    /+inline+/ QIcon icon(int column) const
        { return qvariant_cast<QIcon>(data(column, Qt.DecorationRole)); }
    /+inline+/ void setIcon(int column, ref const(QIcon) icon);

    /+inline+/ QString statusTip(int column) const
        { return data(column, Qt.StatusTipRole).toString(); }
    /+inline+/ void setStatusTip(int column, ref const(QString) statusTip);

#ifndef QT_NO_TOOLTIP
    /+inline+/ QString toolTip(int column) const
        { return data(column, Qt.ToolTipRole).toString(); }
    /+inline+/ void setToolTip(int column, ref const(QString) toolTip);
#endif

#ifndef QT_NO_WHATSTHIS
    /+inline+/ QString whatsThis(int column) const
        { return data(column, Qt.WhatsThisRole).toString(); }
    /+inline+/ void setWhatsThis(int column, ref const(QString) whatsThis);
#endif

    /+inline+/ QFont font(int column) const
        { return qvariant_cast<QFont>(data(column, Qt.FontRole)); }
    /+inline+/ void setFont(int column, ref const(QFont) font);

    /+inline+/ int textAlignment(int column) const
        { return data(column, Qt.TextAlignmentRole).toInt(); }
    /+inline+/ void setTextAlignment(int column, int alignment)
        { setData(column, Qt.TextAlignmentRole, alignment); }

    /+inline+/ QColor backgroundColor(int column) const
        { return qvariant_cast<QColor>(data(column, Qt.BackgroundColorRole)); }
    /+inline+/ void setBackgroundColor(int column, ref const(QColor) color)
        { setData(column, Qt.BackgroundColorRole, color); }

    /+inline+/ QBrush background(int column) const
        { return qvariant_cast<QBrush>(data(column, Qt.BackgroundRole)); }
    /+inline+/ void setBackground(int column, ref const(QBrush) brush)
        { setData(column, Qt.BackgroundRole, brush); }

    /+inline+/ QColor textColor(int column) const
        { return qvariant_cast<QColor>(data(column, Qt.TextColorRole)); }
    /+inline+/ void setTextColor(int column, ref const(QColor) color)
        { setData(column, Qt.TextColorRole, color); }

    /+inline+/ QBrush foreground(int column) const
        { return qvariant_cast<QBrush>(data(column, Qt.ForegroundRole)); }
    /+inline+/ void setForeground(int column, ref const(QBrush) brush)
        { setData(column, Qt.ForegroundRole, brush); }

    /+inline+/ Qt.CheckState checkState(int column) const
        { return static_cast<Qt.CheckState>(data(column, Qt.CheckStateRole).toInt()); }
    /+inline+/ void setCheckState(int column, Qt.CheckState state)
        { setData(column, Qt.CheckStateRole, state); }

    /+inline+/ QSize sizeHint(int column) const
        { return qvariant_cast<QSize>(data(column, Qt.SizeHintRole)); }
    /+inline+/ void setSizeHint(int column, ref const(QSize) size)
        { setData(column, Qt.SizeHintRole, size); }

    /+virtual+/ QVariant data(int column, int role) const;
    /+virtual+/ void setData(int column, int role, ref const(QVariant) value);

    /+virtual+/ bool operator<(ref const(QTreeWidgetItem) other) const;

#ifndef QT_NO_DATASTREAM
    /+virtual+/ void read(QDataStream &in);
    /+virtual+/ void write(QDataStream &out) const;
#endif
    QTreeWidgetItem &operator=(ref const(QTreeWidgetItem) other);

    /+inline+/ QTreeWidgetItem *parent() const { return par; }
    /+inline+/ QTreeWidgetItem *child(int index) const {
        if (index < 0 || index >= children.size())
            return 0;
        executePendingSort();
        return children.at(index);
    }
    /+inline+/ int childCount() const { return children.count(); }
    /+inline+/ int columnCount() const { return values.count(); }
    /+inline+/ int indexOfChild(QTreeWidgetItem *child) const;

    void addChild(QTreeWidgetItem *child);
    void insertChild(int index, QTreeWidgetItem *child);
    void removeChild(QTreeWidgetItem *child);
    QTreeWidgetItem *takeChild(int index);

    void addChildren(ref const(QList<QTreeWidgetItem*>) children);
    void insertChildren(int index, ref const(QList<QTreeWidgetItem*>) children);
    QList<QTreeWidgetItem*> takeChildren();

    /+inline+/ int type() const { return rtti; }
    /+inline+/ void sortChildren(int column, Qt.SortOrder order)
        { sortChildren(column, order, false); }

protected:
    void emitDataChanged();

private:
    void sortChildren(int column, Qt.SortOrder order, bool climb);
    QVariant childrenCheckState(int column) const;
    void itemChanged();
    void executePendingSort() const;

    int rtti;
    // One item has a vector of column entries. Each column has a vector of (role, value) pairs.
    QVector< QVector<QWidgetItemData> > values;
    QTreeWidget *view;
    QTreeWidgetItemPrivate *d;
    QTreeWidgetItem *par;
    QList<QTreeWidgetItem*> children;
    Qt.ItemFlags itemFlags;
};

/+inline+/ void QTreeWidgetItem::setText(int column, ref const(QString) atext)
{ setData(column, Qt.DisplayRole, atext); }

/+inline+/ void QTreeWidgetItem::setIcon(int column, ref const(QIcon) aicon)
{ setData(column, Qt.DecorationRole, aicon); }

#ifndef QT_NO_STATUSTIP
/+inline+/ void QTreeWidgetItem::setStatusTip(int column, ref const(QString) astatusTip)
{ setData(column, Qt.StatusTipRole, astatusTip); }
#endif

#ifndef QT_NO_TOOLTIP
/+inline+/ void QTreeWidgetItem::setToolTip(int column, ref const(QString) atoolTip)
{ setData(column, Qt.ToolTipRole, atoolTip); }
#endif

#ifndef QT_NO_WHATSTHIS
/+inline+/ void QTreeWidgetItem::setWhatsThis(int column, ref const(QString) awhatsThis)
{ setData(column, Qt.WhatsThisRole, awhatsThis); }
#endif

/+inline+/ void QTreeWidgetItem::setFont(int column, ref const(QFont) afont)
{ setData(column, Qt.FontRole, afont); }

/+inline+/ int QTreeWidgetItem::indexOfChild(QTreeWidgetItem *achild) const
{ executePendingSort(); return children.indexOf(achild); }

#ifndef QT_NO_DATASTREAM
Q_WIDGETS_EXPORT QDataStream &operator<<(QDataStream &out, ref const(QTreeWidgetItem) item);
Q_WIDGETS_EXPORT QDataStream &operator>>(QDataStream &in, QTreeWidgetItem &item);
#endif

class QTreeWidgetPrivate;

class Q_WIDGETS_EXPORT QTreeWidget : public QTreeView
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(int, "columnCount", "READ", "columnCount", "WRITE", "setColumnCount");
    mixin Q_PROPERTY!(int, "topLevelItemCount", "READ", "topLevelItemCount");

    friend class QTreeModel;
    friend class QTreeWidgetItem;
public:
    explicit QTreeWidget(QWidget *parent = 0);
    ~QTreeWidget();

    int columnCount() const;
    void setColumnCount(int columns);

    QTreeWidgetItem *invisibleRootItem() const;
    QTreeWidgetItem *topLevelItem(int index) const;
    int topLevelItemCount() const;
    void insertTopLevelItem(int index, QTreeWidgetItem *item);
    void addTopLevelItem(QTreeWidgetItem *item);
    QTreeWidgetItem *takeTopLevelItem(int index);
    int indexOfTopLevelItem(QTreeWidgetItem *item) const;

    void insertTopLevelItems(int index, ref const(QList<QTreeWidgetItem*>) items);
    void addTopLevelItems(ref const(QList<QTreeWidgetItem*>) items);

    QTreeWidgetItem *headerItem() const;
    void setHeaderItem(QTreeWidgetItem *item);
    void setHeaderLabels(ref const(QStringList) labels);
    /+inline+/ void setHeaderLabel(ref const(QString) label);

    QTreeWidgetItem *currentItem() const;
    int currentColumn() const;
    void setCurrentItem(QTreeWidgetItem *item);
    void setCurrentItem(QTreeWidgetItem *item, int column);
    void setCurrentItem(QTreeWidgetItem *item, int column, QItemSelectionModel::SelectionFlags command);

    QTreeWidgetItem *itemAt(ref const(QPoint) p) const;
    /+inline+/ QTreeWidgetItem *itemAt(int x, int y) const;
    QRect visualItemRect(const(QTreeWidgetItem)* item) const;

    int sortColumn() const;
    void sortItems(int column, Qt.SortOrder order);

    void editItem(QTreeWidgetItem *item, int column = 0);
    void openPersistentEditor(QTreeWidgetItem *item, int column = 0);
    void closePersistentEditor(QTreeWidgetItem *item, int column = 0);

    QWidget *itemWidget(QTreeWidgetItem *item, int column) const;
    void setItemWidget(QTreeWidgetItem *item, int column, QWidget *widget);
    /+inline+/ void removeItemWidget(QTreeWidgetItem *item, int column);

    bool isItemSelected(const(QTreeWidgetItem)* item) const;
    void setItemSelected(const(QTreeWidgetItem)* item, bool select);
    QList<QTreeWidgetItem*> selectedItems() const;
    QList<QTreeWidgetItem*> findItems(ref const(QString) text, Qt.MatchFlags flags,
                                      int column = 0) const;

    bool isItemHidden(const(QTreeWidgetItem)* item) const;
    void setItemHidden(const(QTreeWidgetItem)* item, bool hide);

    bool isItemExpanded(const(QTreeWidgetItem)* item) const;
    void setItemExpanded(const(QTreeWidgetItem)* item, bool expand);

    bool isFirstItemColumnSpanned(const(QTreeWidgetItem)* item) const;
    void setFirstItemColumnSpanned(const(QTreeWidgetItem)* item, bool span);

    QTreeWidgetItem *itemAbove(const(QTreeWidgetItem)* item) const;
    QTreeWidgetItem *itemBelow(const(QTreeWidgetItem)* item) const;

    void setSelectionModel(QItemSelectionModel *selectionModel);

public Q_SLOTS:
    void scrollToItem(const(QTreeWidgetItem)* item,
                      QAbstractItemView::ScrollHint hint = EnsureVisible);
    void expandItem(const(QTreeWidgetItem)* item);
    void collapseItem(const(QTreeWidgetItem)* item);
    void clear();

Q_SIGNALS:
    void itemPressed(QTreeWidgetItem *item, int column);
    void itemClicked(QTreeWidgetItem *item, int column);
    void itemDoubleClicked(QTreeWidgetItem *item, int column);
    void itemActivated(QTreeWidgetItem *item, int column);
    void itemEntered(QTreeWidgetItem *item, int column);
    void itemChanged(QTreeWidgetItem *item, int column);
    void itemExpanded(QTreeWidgetItem *item);
    void itemCollapsed(QTreeWidgetItem *item);
    void currentItemChanged(QTreeWidgetItem *current, QTreeWidgetItem *previous);
    void itemSelectionChanged();

protected:
    bool event(QEvent *e);
    /+virtual+/ QStringList mimeTypes() const;
    /+virtual+/ QMimeData *mimeData(const QList<QTreeWidgetItem*> items) const;
    /+virtual+/ bool dropMimeData(QTreeWidgetItem *parent, int index,
                              const(QMimeData)* data, Qt.DropAction action);
    /+virtual+/ Qt.DropActions supportedDropActions() const;
    QList<QTreeWidgetItem*> items(const(QMimeData)* data) const;

    QModelIndex indexFromItem(QTreeWidgetItem *item, int column = 0) const;
    QTreeWidgetItem *itemFromIndex(ref const(QModelIndex) index) const;
    void dropEvent(QDropEvent *event);

private:
    void setModel(QAbstractItemModel *model);

    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    Q_PRIVATE_SLOT(d_func(), void _q_emitItemPressed(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemClicked(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemDoubleClicked(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemActivated(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemEntered(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemChanged(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemExpanded(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemCollapsed(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitCurrentItemChanged(ref const(QModelIndex) previous, ref const(QModelIndex) current))
    Q_PRIVATE_SLOT(d_func(), void _q_sort())
    Q_PRIVATE_SLOT(d_func(), void _q_dataChanged(ref const(QModelIndex) topLeft, ref const(QModelIndex) bottomRight))
    Q_PRIVATE_SLOT(d_func(), void _q_selectionChanged(ref const(QItemSelection) selected, ref const(QItemSelection) deselected))
};

/+inline+/ void QTreeWidget::removeItemWidget(QTreeWidgetItem *item, int column)
{ setItemWidget(item, column, 0); }

/+inline+/ QTreeWidgetItem *QTreeWidget::itemAt(int ax, int ay) const
{ return itemAt(QPoint(ax, ay)); }

/+inline+/ void QTreeWidget::setHeaderLabel(ref const(QString) alabel)
{ setHeaderLabels(QStringList(alabel)); }

/+inline+/ void QTreeWidgetItem::setSelected(bool aselect)
{ if (view) view->setItemSelected(this, aselect); }

/+inline+/ bool QTreeWidgetItem::isSelected() const
{ return (view ? view->isItemSelected(this) : false); }

/+inline+/ void QTreeWidgetItem::setHidden(bool ahide)
{ if (view) view->setItemHidden(this, ahide); }

/+inline+/ bool QTreeWidgetItem::isHidden() const
{ return (view ? view->isItemHidden(this) : false); }

/+inline+/ void QTreeWidgetItem::setExpanded(bool aexpand)
{ if (view) view->setItemExpanded(this, aexpand); }

/+inline+/ bool QTreeWidgetItem::isExpanded() const
{ return (view ? view->isItemExpanded(this) : false); }

/+inline+/ void QTreeWidgetItem::setFirstColumnSpanned(bool aspan)
{ if (view) view->setFirstItemColumnSpanned(this, aspan); }

/+inline+/ bool QTreeWidgetItem::isFirstColumnSpanned() const
{ return (view ? view->isFirstItemColumnSpanned(this) : false); }

/+inline+/ void QTreeWidgetItem::setDisabled(bool disabled)
{ setFlags(disabled ? (flags() & ~Qt.ItemIsEnabled) : flags() | Qt.ItemIsEnabled); }

/+inline+/ bool QTreeWidgetItem::isDisabled() const
{ return !(flags() & Qt.ItemIsEnabled); }

#endif // QT_NO_TREEWIDGET

QT_END_NAMESPACE

#endif // QTREEWIDGET_H
