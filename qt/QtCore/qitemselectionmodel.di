/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtGui module of the Qt Toolkit.
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

public import QtCore.qset;
public import QtCore.qvector;
public import QtCore.qlist;
public import QtCore.qabstractitemmodel;


#ifndef QT_NO_ITEMVIEWS

extern(C++) class export QItemSelectionRange
{

public:
    /+inline+/ QItemSelectionRange() {}
    /+inline+/ QItemSelectionRange(ref const(QItemSelectionRange) other)
        : tl(other.tl), br(other.br) {}
    /+inline+/ QItemSelectionRange(ref const(QModelIndex) topLeft, ref const(QModelIndex) bottomRight);
    explicit /+inline+/ QItemSelectionRange(ref const(QModelIndex) index)
        { tl = index; br = tl; }

    /+inline+/ int top() const { return tl.row(); }
    /+inline+/ int left() const { return tl.column(); }
    /+inline+/ int bottom() const { return br.row(); }
    /+inline+/ int right() const { return br.column(); }
    /+inline+/ int width() const { return br.column() - tl.column() + 1; }
    /+inline+/ int height() const { return br.row() - tl.row() + 1; }

    /+inline+/ ref const(QPersistentModelIndex) topLeft() const { return tl; }
    /+inline+/ ref const(QPersistentModelIndex) bottomRight() const { return br; }
    /+inline+/ QModelIndex parent() const { return tl.parent(); }
    /+inline+/ const(QAbstractItemModel)* model() const { return tl.model(); }

    /+inline+/ bool contains(ref const(QModelIndex) index) const
    {
        return (parent() == index.parent()
                && tl.row() <= index.row() && tl.column() <= index.column()
                && br.row() >= index.row() && br.column() >= index.column());
    }

    /+inline+/ bool contains(int row, int column, ref const(QModelIndex) parentIndex) const
    {
        return (parent() == parentIndex
                && tl.row() <= row && tl.column() <= column
                && br.row() >= row && br.column() >= column);
    }

    bool intersects(ref const(QItemSelectionRange) other) const;
#if QT_DEPRECATED_SINCE(5, 0)
    /+inline+/ QItemSelectionRange intersect(ref const(QItemSelectionRange) other) const
        { return intersected(other); }
#endif
    QItemSelectionRange intersected(ref const(QItemSelectionRange) other) const;


    /+inline+/ bool operator==(ref const(QItemSelectionRange) other) const
        { return (tl == other.tl && br == other.br); }
    /+inline+/ bool operator!=(ref const(QItemSelectionRange) other) const
        { return !operator==(other); }
    /+inline+/ bool operator<(ref const(QItemSelectionRange) other) const
        {
            // Comparing parents will compare the models, but if two equivalent ranges
            // in two different models have invalid parents, they would appear the same
            if (other.tl.model() == tl.model()) {
                // parent has to be calculated, so we only do so once.
                const QModelIndex topLeftParent = tl.parent();
                const QModelIndex otherTopLeftParent = other.tl.parent();
                if (topLeftParent == otherTopLeftParent) {
                    if (other.tl.row() == tl.row()) {
                        if (other.tl.column() == tl.column()) {
                            if (other.br.row() == br.row()) {
                                return br.column() < other.br.column();
                            }
                            return br.row() < other.br.row();
                        }
                        return tl.column() < other.tl.column();
                    }
                    return tl.row() < other.tl.row();
                }
                return topLeftParent < otherTopLeftParent;
            }
            return tl.model() < other.tl.model();
        }

    /+inline+/ bool isValid() const
    {
        return (tl.isValid() && br.isValid() && tl.parent() == br.parent()
                && top() <= bottom() && left() <= right());
    }

    bool isEmpty() const;

    QModelIndexList indexes() const;

private:
    QPersistentModelIndex tl, br;
}
Q_DECLARE_TYPEINFO(QItemSelectionRange, Q_MOVABLE_TYPE);

/+inline+/ QItemSelectionRange::QItemSelectionRange(ref const(QModelIndex) atopLeft,
                                                ref const(QModelIndex) abottomRight)
{ tl = atopLeft; br = abottomRight; }

extern(C++) class QItemSelection;
extern(C++) class QItemSelectionModelPrivate;

extern(C++) class export QItemSelectionModel : QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;
    Q_FLAGS(SelectionFlags)

public:

    enum SelectionFlag {
        NoUpdate       = 0x0000,
        Clear          = 0x0001,
        Select         = 0x0002,
        Deselect       = 0x0004,
        Toggle         = 0x0008,
        Current        = 0x0010,
        Rows           = 0x0020,
        Columns        = 0x0040,
        SelectCurrent  = Select | Current,
        ToggleCurrent  = Toggle | Current,
        ClearAndSelect = Clear | Select
    }

    Q_DECLARE_FLAGS(SelectionFlags, SelectionFlag)

    explicit QItemSelectionModel(QAbstractItemModel *model);
    explicit QItemSelectionModel(QAbstractItemModel *model, QObject *parent);
    /+virtual+/ ~QItemSelectionModel();

    QModelIndex currentIndex() const;

    bool isSelected(ref const(QModelIndex) index) const;
    bool isRowSelected(int row, ref const(QModelIndex) parent) const;
    bool isColumnSelected(int column, ref const(QModelIndex) parent) const;

    bool rowIntersectsSelection(int row, ref const(QModelIndex) parent) const;
    bool columnIntersectsSelection(int column, ref const(QModelIndex) parent) const;

    bool hasSelection() const;

    QModelIndexList selectedIndexes() const;
    QModelIndexList selectedRows(int column = 0) const;
    QModelIndexList selectedColumns(int row = 0) const;
    const QItemSelection selection() const;

    const(QAbstractItemModel)* model() const;

public Q_SLOTS:
    /+virtual+/ void setCurrentIndex(ref const(QModelIndex) index, QItemSelectionModel::SelectionFlags command);
    /+virtual+/ void select(ref const(QModelIndex) index, QItemSelectionModel::SelectionFlags command);
    /+virtual+/ void select(ref const(QItemSelection) selection, QItemSelectionModel::SelectionFlags command);
    /+virtual+/ void clear();
    /+virtual+/ void reset();

    void clearSelection();
    /+virtual+/ void clearCurrentIndex();

Q_SIGNALS:
    void selectionChanged(ref const(QItemSelection) selected, ref const(QItemSelection) deselected);
    void currentChanged(ref const(QModelIndex) current, ref const(QModelIndex) previous);
    void currentRowChanged(ref const(QModelIndex) current, ref const(QModelIndex) previous);
    void currentColumnChanged(ref const(QModelIndex) current, ref const(QModelIndex) previous);

protected:
    QItemSelectionModel(QItemSelectionModelPrivate &dd, QAbstractItemModel *model);
    void emitSelectionChanged(ref const(QItemSelection) newSelection, ref const(QItemSelection) oldSelection);

private:
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_columnsAboutToBeRemoved(ref const(QModelIndex), int, int))
    Q_PRIVATE_SLOT(d_func(), void _q_rowsAboutToBeRemoved(ref const(QModelIndex), int, int))
    Q_PRIVATE_SLOT(d_func(), void _q_columnsAboutToBeInserted(ref const(QModelIndex), int, int))
    Q_PRIVATE_SLOT(d_func(), void _q_rowsAboutToBeInserted(ref const(QModelIndex), int, int))
    Q_PRIVATE_SLOT(d_func(), void _q_layoutAboutToBeChanged(ref const(QList<QPersistentModelIndex>) parents = QList<QPersistentModelIndex>(), QAbstractItemModel::LayoutChangeHint hint = QAbstractItemModel::NoHint))
    Q_PRIVATE_SLOT(d_func(), void _q_layoutChanged(ref const(QList<QPersistentModelIndex>) parents = QList<QPersistentModelIndex>(), QAbstractItemModel::LayoutChangeHint hint = QAbstractItemModel::NoHint))
}

Q_DECLARE_OPERATORS_FOR_FLAGS(QItemSelectionModel::SelectionFlags)

// dummy implentation of qHash() necessary for instantiating QList<QItemSelectionRange>::toSet() with MSVC
/+inline+/ uint qHash(ref const(QItemSelectionRange) ) { return 0; }

extern(C++) class export QItemSelection : QList<QItemSelectionRange>
{
public:
    QItemSelection() {}
    QItemSelection(ref const(QModelIndex) topLeft, ref const(QModelIndex) bottomRight);
    void select(ref const(QModelIndex) topLeft, ref const(QModelIndex) bottomRight);
    bool contains(ref const(QModelIndex) index) const;
    QModelIndexList indexes() const;
    void merge(ref const(QItemSelection) other, QItemSelectionModel::SelectionFlags command);
    static void split(ref const(QItemSelectionRange) range,
                      ref const(QItemSelectionRange) other,
                      QItemSelection *result);
}

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, ref const(QItemSelectionRange) );
#endif

#endif // QT_NO_ITEMVIEWS

#endif // QITEMSELECTIONMODEL_H
