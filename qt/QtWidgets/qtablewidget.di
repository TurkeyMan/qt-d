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

#ifndef QTABLEWIDGET_H
#define QTABLEWIDGET_H

public import qt.QtWidgets.qtableview;
public import qt.QtCore.qvariant;
public import qt.QtCore.qvector;
//public import qt.QtWidgets.qitemselectionmodel;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_TABLEWIDGET

class Q_WIDGETS_EXPORT QTableWidgetSelectionRange
{
public:
    QTableWidgetSelectionRange();
    QTableWidgetSelectionRange(int top, int left, int bottom, int right);
    QTableWidgetSelectionRange(ref const(QTableWidgetSelectionRange) other);
    ~QTableWidgetSelectionRange();

    /+inline+/ int topRow() const { return top; }
    /+inline+/ int bottomRow() const { return bottom; }
    /+inline+/ int leftColumn() const { return left; }
    /+inline+/ int rightColumn() const { return right; }
    /+inline+/ int rowCount() const { return bottom - top + 1; }
    /+inline+/ int columnCount() const { return right - left + 1; }

private:
    int top, left, bottom, right;
};

class QTableWidget;
class QTableModel;
class QWidgetItemData;
class QTableWidgetItemPrivate;

class Q_WIDGETS_EXPORT QTableWidgetItem
{
    friend class QTableWidget;
    friend class QTableModel;
public:
    enum ItemType { Type = 0, UserType = 1000 };
    explicit QTableWidgetItem(int type = Type);
    explicit QTableWidgetItem(ref const(QString) text, int type = Type);
    explicit QTableWidgetItem(ref const(QIcon) icon, ref const(QString) text, int type = Type);
    QTableWidgetItem(ref const(QTableWidgetItem) other);
    /+virtual+/ ~QTableWidgetItem();

    /+virtual+/ QTableWidgetItem *clone() const;

    /+inline+/ QTableWidget *tableWidget() const { return view; }

    /+inline+/ int row() const;
    /+inline+/ int column() const;

    /+inline+/ void setSelected(bool select);
    /+inline+/ bool isSelected() const;

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
    /+inline+/ void setBackgroundColor(ref const(QColor) color)
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
        { setData(Qt.CheckStateRole, state); }

    /+inline+/ QSize sizeHint() const
        { return qvariant_cast<QSize>(data(Qt.SizeHintRole)); }
    /+inline+/ void setSizeHint(ref const(QSize) size)
        { setData(Qt.SizeHintRole, size); }

    /+virtual+/ QVariant data(int role) const;
    /+virtual+/ void setData(int role, ref const(QVariant) value);

    /+virtual+/ bool operator<(ref const(QTableWidgetItem) other) const;

#ifndef QT_NO_DATASTREAM
    /+virtual+/ void read(QDataStream &in);
    /+virtual+/ void write(QDataStream &out) const;
#endif
    QTableWidgetItem &operator=(ref const(QTableWidgetItem) other);

    /+inline+/ int type() const { return rtti; }

private:
    int rtti;
    QVector<QWidgetItemData> values;
    QTableWidget *view;
    QTableWidgetItemPrivate *d;
    Qt.ItemFlags itemFlags;
};

/+inline+/ void QTableWidgetItem::setText(ref const(QString) atext)
{ setData(Qt.DisplayRole, atext); }

/+inline+/ void QTableWidgetItem::setIcon(ref const(QIcon) aicon)
{ setData(Qt.DecorationRole, aicon); }

/+inline+/ void QTableWidgetItem::setStatusTip(ref const(QString) astatusTip)
{ setData(Qt.StatusTipRole, astatusTip); }

#ifndef QT_NO_TOOLTIP
/+inline+/ void QTableWidgetItem::setToolTip(ref const(QString) atoolTip)
{ setData(Qt.ToolTipRole, atoolTip); }
#endif

#ifndef QT_NO_WHATSTHIS
/+inline+/ void QTableWidgetItem::setWhatsThis(ref const(QString) awhatsThis)
{ setData(Qt.WhatsThisRole, awhatsThis); }
#endif

/+inline+/ void QTableWidgetItem::setFont(ref const(QFont) afont)
{ setData(Qt.FontRole, afont); }

#ifndef QT_NO_DATASTREAM
Q_WIDGETS_EXPORT QDataStream &operator>>(QDataStream &in, QTableWidgetItem &item);
Q_WIDGETS_EXPORT QDataStream &operator<<(QDataStream &out, ref const(QTableWidgetItem) item);
#endif

class QTableWidgetPrivate;

class Q_WIDGETS_EXPORT QTableWidget : public QTableView
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(int, "rowCount", "READ", "rowCount", "WRITE", "setRowCount");
    mixin Q_PROPERTY!(int, "columnCount", "READ", "columnCount", "WRITE", "setColumnCount");

    friend class QTableModel;
public:
    explicit QTableWidget(QWidget *parent = 0);
    QTableWidget(int rows, int columns, QWidget *parent = 0);
    ~QTableWidget();

    void setRowCount(int rows);
    int rowCount() const;

    void setColumnCount(int columns);
    int columnCount() const;

    int row(const(QTableWidgetItem)* item) const;
    int column(const(QTableWidgetItem)* item) const;

    QTableWidgetItem *item(int row, int column) const;
    void setItem(int row, int column, QTableWidgetItem *item);
    QTableWidgetItem *takeItem(int row, int column);

    QTableWidgetItem *verticalHeaderItem(int row) const;
    void setVerticalHeaderItem(int row, QTableWidgetItem *item);
    QTableWidgetItem *takeVerticalHeaderItem(int row);

    QTableWidgetItem *horizontalHeaderItem(int column) const;
    void setHorizontalHeaderItem(int column, QTableWidgetItem *item);
    QTableWidgetItem *takeHorizontalHeaderItem(int column);
    void setVerticalHeaderLabels(ref const(QStringList) labels);
    void setHorizontalHeaderLabels(ref const(QStringList) labels);

    int currentRow() const;
    int currentColumn() const;
    QTableWidgetItem *currentItem() const;
    void setCurrentItem(QTableWidgetItem *item);
    void setCurrentItem(QTableWidgetItem *item, QItemSelectionModel::SelectionFlags command);
    void setCurrentCell(int row, int column);
    void setCurrentCell(int row, int column, QItemSelectionModel::SelectionFlags command);

    void sortItems(int column, Qt.SortOrder order = Qt.AscendingOrder);
    void setSortingEnabled(bool enable);
    bool isSortingEnabled() const;

    void editItem(QTableWidgetItem *item);
    void openPersistentEditor(QTableWidgetItem *item);
    void closePersistentEditor(QTableWidgetItem *item);

    QWidget *cellWidget(int row, int column) const;
    void setCellWidget(int row, int column, QWidget *widget);
    /+inline+/ void removeCellWidget(int row, int column);

    bool isItemSelected(const(QTableWidgetItem)* item) const;
    void setItemSelected(const(QTableWidgetItem)* item, bool select);
    void setRangeSelected(ref const(QTableWidgetSelectionRange) range, bool select);

    QList<QTableWidgetSelectionRange> selectedRanges() const;
    QList<QTableWidgetItem*> selectedItems() const;
    QList<QTableWidgetItem*> findItems(ref const(QString) text, Qt.MatchFlags flags) const;

    int visualRow(int logicalRow) const;
    int visualColumn(int logicalColumn) const;

    QTableWidgetItem *itemAt(ref const(QPoint) p) const;
    /+inline+/ QTableWidgetItem *itemAt(int x, int y) const;
    QRect visualItemRect(const(QTableWidgetItem)* item) const;

    const(QTableWidgetItem)* itemPrototype() const;
    void setItemPrototype(const(QTableWidgetItem)* item);

public Q_SLOTS:
    void scrollToItem(const(QTableWidgetItem)* item, QAbstractItemView::ScrollHint hint = EnsureVisible);
    void insertRow(int row);
    void insertColumn(int column);
    void removeRow(int row);
    void removeColumn(int column);
    void clear();
    void clearContents();

Q_SIGNALS:
    void itemPressed(QTableWidgetItem *item);
    void itemClicked(QTableWidgetItem *item);
    void itemDoubleClicked(QTableWidgetItem *item);

    void itemActivated(QTableWidgetItem *item);
    void itemEntered(QTableWidgetItem *item);
    void itemChanged(QTableWidgetItem *item);

    void currentItemChanged(QTableWidgetItem *current, QTableWidgetItem *previous);
    void itemSelectionChanged();

    void cellPressed(int row, int column);
    void cellClicked(int row, int column);
    void cellDoubleClicked(int row, int column);

    void cellActivated(int row, int column);
    void cellEntered(int row, int column);
    void cellChanged(int row, int column);

    void currentCellChanged(int currentRow, int currentColumn, int previousRow, int previousColumn);

protected:
    bool event(QEvent *e);
    /+virtual+/ QStringList mimeTypes() const;
    /+virtual+/ QMimeData *mimeData(const QList<QTableWidgetItem*> items) const;
    /+virtual+/ bool dropMimeData(int row, int column, const(QMimeData)* data, Qt.DropAction action);
    /+virtual+/ Qt.DropActions supportedDropActions() const;
    QList<QTableWidgetItem*> items(const(QMimeData)* data) const;

    QModelIndex indexFromItem(QTableWidgetItem *item) const;
    QTableWidgetItem *itemFromIndex(ref const(QModelIndex) index) const;
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
    Q_PRIVATE_SLOT(d_func(), void _q_emitCurrentItemChanged(ref const(QModelIndex) previous, ref const(QModelIndex) current))
    Q_PRIVATE_SLOT(d_func(), void _q_sort())
    Q_PRIVATE_SLOT(d_func(), void _q_dataChanged(ref const(QModelIndex) topLeft, ref const(QModelIndex) bottomRight))
};

/+inline+/ void QTableWidget::removeCellWidget(int arow, int acolumn)
{ setCellWidget(arow, acolumn, 0); }

/+inline+/ QTableWidgetItem *QTableWidget::itemAt(int ax, int ay) const
{ return itemAt(QPoint(ax, ay)); }

/+inline+/ int QTableWidgetItem::row() const
{ return (view ? view->row(this) : -1); }

/+inline+/ int QTableWidgetItem::column() const
{ return (view ? view->column(this) : -1); }

/+inline+/ void QTableWidgetItem::setSelected(bool aselect)
{ if (view) view->setItemSelected(this, aselect); }

/+inline+/ bool QTableWidgetItem::isSelected() const
{ return (view ? view->isItemSelected(this) : false); }

#endif // QT_NO_TABLEWIDGET

QT_END_NAMESPACE

#endif // QTABLEWIDGET_H
