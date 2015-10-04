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

#ifndef QLISTWIDGET_H
#define QLISTWIDGET_H

public import qt.QtWidgets.qlistview;
public import qt.QtCore.qvariant;
public import qt.QtCore.qvector;
public import qt.QtCore.qitemselectionmodel;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_LISTWIDGET

class QListWidget;
class QListModel;
class QWidgetItemData;
class QListWidgetItemPrivate;

class Q_WIDGETS_EXPORT QListWidgetItem
{
    friend class QListModel;
    friend class QListWidget;
public:
    enum ItemType { Type = 0, UserType = 1000 };
    explicit QListWidgetItem(QListWidget *view = 0, int type = Type);
    explicit QListWidgetItem(ref const(QString) text, QListWidget *view = 0, int type = Type);
    explicit QListWidgetItem(ref const(QIcon) icon, ref const(QString) text,
                             QListWidget *view = 0, int type = Type);
    QListWidgetItem(ref const(QListWidgetItem) other);
    /+virtual+/ ~QListWidgetItem();

    /+virtual+/ QListWidgetItem *clone() const;

    /+inline+/ QListWidget *listWidget() const { return view; }

    /+inline+/ void setSelected(bool select);
    /+inline+/ bool isSelected() const;

    /+inline+/ void setHidden(bool hide);
    /+inline+/ bool isHidden() const;

    /+inline+/ Qt.ItemFlags flags() const { return itemFlags; }
    void setFlags(Qt.ItemFlags flags);

    /+inline+/ QString text() const
        { return data(Qt.DisplayRole).toString(); }
    /+inline+/ void setText(ref const(QString) text);

    /+inline+/ QIcon icon() const
        { return qvariant_cast<QIcon>(data(Qt.DecorationRole)); }
    /+inline+/ void setIcon(ref const(QIcon) icon);

    /+inline+/ QString statusTip() const
        { return data(Qt.StatusTipRole).toString(); }
    /+inline+/ void setStatusTip(ref const(QString) statusTip);

#ifndef QT_NO_TOOLTIP
    /+inline+/ QString toolTip() const
        { return data(Qt.ToolTipRole).toString(); }
    /+inline+/ void setToolTip(ref const(QString) toolTip);
#endif

#ifndef QT_NO_WHATSTHIS
    /+inline+/ QString whatsThis() const
        { return data(Qt.WhatsThisRole).toString(); }
    /+inline+/ void setWhatsThis(ref const(QString) whatsThis);
#endif

    /+inline+/ QFont font() const
        { return qvariant_cast<QFont>(data(Qt.FontRole)); }
    /+inline+/ void setFont(ref const(QFont) font);

    /+inline+/ int textAlignment() const
        { return data(Qt.TextAlignmentRole).toInt(); }
    /+inline+/ void setTextAlignment(int alignment)
        { setData(Qt.TextAlignmentRole, alignment); }

    /+inline+/ QColor backgroundColor() const
        { return qvariant_cast<QColor>(data(Qt.BackgroundColorRole)); }
    /+virtual+/ void setBackgroundColor(ref const(QColor) color)
        { setData(Qt.BackgroundColorRole, color); }

    /+inline+/ QBrush background() const
        { return qvariant_cast<QBrush>(data(Qt.BackgroundRole)); }
    /+inline+/ void setBackground(ref const(QBrush) brush)
        { setData(Qt.BackgroundRole, brush); }

    /+inline+/ QColor textColor() const
        { return qvariant_cast<QColor>(data(Qt.TextColorRole)); }
    /+inline+/ void setTextColor(ref const(QColor) color)
        { setData(Qt.TextColorRole, color); }

    /+inline+/ QBrush foreground() const
        { return qvariant_cast<QBrush>(data(Qt.ForegroundRole)); }
    /+inline+/ void setForeground(ref const(QBrush) brush)
        { setData(Qt.ForegroundRole, brush); }

    /+inline+/ Qt.CheckState checkState() const
        { return static_cast<Qt.CheckState>(data(Qt.CheckStateRole).toInt()); }
    /+inline+/ void setCheckState(Qt.CheckState state)
        { setData(Qt.CheckStateRole, static_cast<int>(state)); }

    /+inline+/ QSize sizeHint() const
        { return qvariant_cast<QSize>(data(Qt.SizeHintRole)); }
    /+inline+/ void setSizeHint(ref const(QSize) size)
        { setData(Qt.SizeHintRole, size); }

    /+virtual+/ QVariant data(int role) const;
    /+virtual+/ void setData(int role, ref const(QVariant) value);

    /+virtual+/ bool operator<(ref const(QListWidgetItem) other) const;

#ifndef QT_NO_DATASTREAM
    /+virtual+/ void read(QDataStream &in);
    /+virtual+/ void write(QDataStream &out) const;
#endif
    QListWidgetItem &operator=(ref const(QListWidgetItem) other);

    /+inline+/ int type() const { return rtti; }

private:
    int rtti;
    QVector<void *> dummy;
    QListWidget *view;
    QListWidgetItemPrivate *d;
    Qt.ItemFlags itemFlags;
};

/+inline+/ void QListWidgetItem::setText(ref const(QString) atext)
{ setData(Qt.DisplayRole, atext); }

/+inline+/ void QListWidgetItem::setIcon(ref const(QIcon) aicon)
{ setData(Qt.DecorationRole, aicon); }

/+inline+/ void QListWidgetItem::setStatusTip(ref const(QString) astatusTip)
{ setData(Qt.StatusTipRole, astatusTip); }

#ifndef QT_NO_TOOLTIP
/+inline+/ void QListWidgetItem::setToolTip(ref const(QString) atoolTip)
{ setData(Qt.ToolTipRole, atoolTip); }
#endif

#ifndef QT_NO_WHATSTHIS
/+inline+/ void QListWidgetItem::setWhatsThis(ref const(QString) awhatsThis)
{ setData(Qt.WhatsThisRole, awhatsThis); }
#endif

/+inline+/ void QListWidgetItem::setFont(ref const(QFont) afont)
{ setData(Qt.FontRole, afont); }

#ifndef QT_NO_DATASTREAM
Q_WIDGETS_EXPORT QDataStream &operator<<(QDataStream &out, ref const(QListWidgetItem) item);
Q_WIDGETS_EXPORT QDataStream &operator>>(QDataStream &in, QListWidgetItem &item);
#endif

class QListWidgetPrivate;

class Q_WIDGETS_EXPORT QListWidget : public QListView
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(int, "count", "READ", "count");
    mixin Q_PROPERTY!(int, "currentRow", "READ", "currentRow", "WRITE", "setCurrentRow", "NOTIFY", "currentRowChanged", "USER", "true");
    mixin Q_PROPERTY!(bool, "sortingEnabled", "READ", "isSortingEnabled", "WRITE", "setSortingEnabled");

    friend class QListWidgetItem;
    friend class QListModel;
public:
    explicit QListWidget(QWidget *parent = 0);
    ~QListWidget();

    QListWidgetItem *item(int row) const;
    int row(const(QListWidgetItem)* item) const;
    void insertItem(int row, QListWidgetItem *item);
    void insertItem(int row, ref const(QString) label);
    void insertItems(int row, ref const(QStringList) labels);
    /+inline+/ void addItem(ref const(QString) label) { insertItem(count(), label); }
    /+inline+/ void addItem(QListWidgetItem *item);
    /+inline+/ void addItems(ref const(QStringList) labels) { insertItems(count(), labels); }
    QListWidgetItem *takeItem(int row);
    int count() const;

    QListWidgetItem *currentItem() const;
    void setCurrentItem(QListWidgetItem *item);
    void setCurrentItem(QListWidgetItem *item, QItemSelectionModel::SelectionFlags command);

    int currentRow() const;
    void setCurrentRow(int row);
    void setCurrentRow(int row, QItemSelectionModel::SelectionFlags command);

    QListWidgetItem *itemAt(ref const(QPoint) p) const;
    /+inline+/ QListWidgetItem *itemAt(int x, int y) const;
    QRect visualItemRect(const(QListWidgetItem)* item) const;

    void sortItems(Qt.SortOrder order = Qt.AscendingOrder);
    void setSortingEnabled(bool enable);
    bool isSortingEnabled() const;

    void editItem(QListWidgetItem *item);
    void openPersistentEditor(QListWidgetItem *item);
    void closePersistentEditor(QListWidgetItem *item);

    QWidget *itemWidget(QListWidgetItem *item) const;
    void setItemWidget(QListWidgetItem *item, QWidget *widget);
    /+inline+/ void removeItemWidget(QListWidgetItem *item);

    bool isItemSelected(const(QListWidgetItem)* item) const;
    void setItemSelected(const(QListWidgetItem)* item, bool select);
    QList<QListWidgetItem*> selectedItems() const;
    QList<QListWidgetItem*> findItems(ref const(QString) text, Qt.MatchFlags flags) const;

    bool isItemHidden(const(QListWidgetItem)* item) const;
    void setItemHidden(const(QListWidgetItem)* item, bool hide);
    void dropEvent(QDropEvent *event);

public Q_SLOTS:
    void scrollToItem(const(QListWidgetItem)* item, QAbstractItemView::ScrollHint hint = EnsureVisible);
    void clear();

Q_SIGNALS:
    void itemPressed(QListWidgetItem *item);
    void itemClicked(QListWidgetItem *item);
    void itemDoubleClicked(QListWidgetItem *item);
    void itemActivated(QListWidgetItem *item);
    void itemEntered(QListWidgetItem *item);
    void itemChanged(QListWidgetItem *item);

    void currentItemChanged(QListWidgetItem *current, QListWidgetItem *previous);
    void currentTextChanged(ref const(QString) currentText);
    void currentRowChanged(int currentRow);

    void itemSelectionChanged();

protected:
    bool event(QEvent *e);
    /+virtual+/ QStringList mimeTypes() const;
    /+virtual+/ QMimeData *mimeData(const QList<QListWidgetItem*> items) const;
#ifndef QT_NO_DRAGANDDROP
    /+virtual+/ bool dropMimeData(int index, const(QMimeData)* data, Qt.DropAction action);
    /+virtual+/ Qt.DropActions supportedDropActions() const;
#endif
    QList<QListWidgetItem*> items(const(QMimeData)* data) const;

    QModelIndex indexFromItem(QListWidgetItem *item) const;
    QListWidgetItem *itemFromIndex(ref const(QModelIndex) index) const;

private:
    void setModel(QAbstractItemModel *model);
    Qt.SortOrder sortOrder() const;

    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    Q_PRIVATE_SLOT(d_func(), void _q_emitItemPressed(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemClicked(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemDoubleClicked(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemActivated(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemEntered(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitItemChanged(ref const(QModelIndex) index))
    Q_PRIVATE_SLOT(d_func(), void _q_emitCurrentItemChanged(ref const(QModelIndex) previous, ref const(QModelIndex) current))
    Q_PRIVATE_SLOT(d_func(), void _q_sort())
    Q_PRIVATE_SLOT(d_func(), void _q_dataChanged(ref const(QModelIndex) topLeft, ref const(QModelIndex) bottomRight))
};

/+inline+/ void QListWidget::removeItemWidget(QListWidgetItem *aItem)
{ setItemWidget(aItem, 0); }

/+inline+/ void QListWidget::addItem(QListWidgetItem *aitem)
{ insertItem(count(), aitem); }

/+inline+/ QListWidgetItem *QListWidget::itemAt(int ax, int ay) const
{ return itemAt(QPoint(ax, ay)); }

/+inline+/ void QListWidgetItem::setSelected(bool aselect)
{ if (view) view->setItemSelected(this, aselect); }

/+inline+/ bool QListWidgetItem::isSelected() const
{ return (view ? view->isItemSelected(this) : false); }

/+inline+/ void QListWidgetItem::setHidden(bool ahide)
{ if (view) view->setItemHidden(this, ahide); }

/+inline+/ bool QListWidgetItem::isHidden() const
{ return (view ? view->isItemHidden(this) : false); }

#endif // QT_NO_LISTWIDGET

QT_END_NAMESPACE

#endif // QLISTWIDGET_H
