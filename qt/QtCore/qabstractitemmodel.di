/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtCore module of the Qt Toolkit.
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

public import QtCore.qvariant;
public import QtCore.qobject;
public import QtCore.qhash;
public import QtCore.qvector;


extern(C++) class QAbstractItemModel;
extern(C++) class QPersistentModelIndex;

extern(C++) class export QModelIndex
{
    friend extern(C++) class QAbstractItemModel;
public:
    /+inline+/ QModelIndex() : r(-1), c(-1), i(0), m(0) {}
    // compiler-generated copy/move ctors/assignment operators are fine!
    /+inline+/ int row() const { return r; }
    /+inline+/ int column() const { return c; }
    /+inline+/ quintptr internalId() const { return i; }
    /+inline+/ void *internalPointer() const { return reinterpret_cast<void*>(i); }
    /+inline+/ QModelIndex parent() const;
    /+inline+/ QModelIndex sibling(int row, int column) const;
    /+inline+/ QModelIndex child(int row, int column) const;
    /+inline+/ QVariant data(int role = Qt.DisplayRole) const;
    /+inline+/ Qt.ItemFlags flags() const;
    /+inline+/ const(QAbstractItemModel)* model() const { return m; }
    /+inline+/ bool isValid() const { return (r >= 0) && (c >= 0) && (m != 0); }
    /+inline+/ bool operator==(ref const(QModelIndex) other) const
        { return (other.r == r) && (other.i == i) && (other.c == c) && (other.m == m); }
    /+inline+/ bool operator!=(ref const(QModelIndex) other) const
        { return !(*this == other); }
    /+inline+/ bool operator<(ref const(QModelIndex) other) const
        {
            return  r <  other.r
                || (r == other.r && (c <  other.c
                                 || (c == other.c && (i <  other.i
                                                  || (i == other.i && m < other.m )))));
        }
private:
    /+inline+/ QModelIndex(int arow, int acolumn, void *ptr, const(QAbstractItemModel)* amodel)
        : r(arow), c(acolumn), i(reinterpret_cast<quintptr>(ptr)), m(amodel) {}
    /+inline+/ QModelIndex(int arow, int acolumn, quintptr id, const(QAbstractItemModel)* amodel)
        : r(arow), c(acolumn), i(id), m(amodel) {}
    int r, c;
    quintptr i;
    const(QAbstractItemModel)* m;
}
Q_DECLARE_TYPEINFO(QModelIndex, Q_MOVABLE_TYPE);

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, ref const(QModelIndex) );
#endif

extern(C++) class QPersistentModelIndexData;

// qHash is a friend, but we can't use default arguments for friends (§8.3.6.4)
uint qHash(ref const(QPersistentModelIndex) index, uint seed = 0);

extern(C++) class export QPersistentModelIndex
{
public:
    QPersistentModelIndex();
    QPersistentModelIndex(ref const(QModelIndex) index);
    QPersistentModelIndex(ref const(QPersistentModelIndex) other);
    ~QPersistentModelIndex();
    bool operator<(ref const(QPersistentModelIndex) other) const;
    bool operator==(ref const(QPersistentModelIndex) other) const;
    /+inline+/ bool operator!=(ref const(QPersistentModelIndex) other) const
    { return !operator==(other); }
    QPersistentModelIndex &operator=(ref const(QPersistentModelIndex) other);
#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QPersistentModelIndex(QPersistentModelIndex &&other) : d(other.d) { other.d = 0; }
    /+inline+/ QPersistentModelIndex &operator=(QPersistentModelIndex &&other)
    { qSwap(d, other.d); return *this; }
#endif
    /+inline+/ void swap(QPersistentModelIndex &other) { qSwap(d, other.d); }
    bool operator==(ref const(QModelIndex) other) const;
    bool operator!=(ref const(QModelIndex) other) const;
    QPersistentModelIndex &operator=(ref const(QModelIndex) other);
    operator ref const(QModelIndex)() const;
    int row() const;
    int column() const;
    void *internalPointer() const;
    quintptr internalId() const;
    QModelIndex parent() const;
    QModelIndex sibling(int row, int column) const;
    QModelIndex child(int row, int column) const;
    QVariant data(int role = Qt.DisplayRole) const;
    Qt.ItemFlags flags() const;
    const(QAbstractItemModel)* model() const;
    bool isValid() const;
private:
    QPersistentModelIndexData *d;
    friend uint qHash(ref const(QPersistentModelIndex) , uint seed);
#ifndef QT_NO_DEBUG_STREAM
    friend export QDebug operator<<(QDebug, ref const(QPersistentModelIndex) );
#endif
}
Q_DECLARE_SHARED(QPersistentModelIndex)

/+inline+/ uint qHash(ref const(QPersistentModelIndex) index, uint seed)
{ return qHash(index.d, seed); }


#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug, ref const(QPersistentModelIndex) );
#endif

template<typename T> extern(C++) class QList;
typedef QList<QModelIndex> QModelIndexList;

extern(C++) class QMimeData;
extern(C++) class QAbstractItemModelPrivate;
template <class Key, extern(C++) class T> extern(C++) class QMap;


extern(C++) class export QAbstractItemModel : QObject
{
    mixin Q_OBJECT;
    Q_ENUMS(LayoutChangeHint)

    friend extern(C++) class QPersistentModelIndexData;
    friend extern(C++) class QAbstractItemViewPrivate;
    friend extern(C++) class QIdentityProxyModel;
public:

    explicit QAbstractItemModel(QObject *parent = 0);
    /+virtual+/ ~QAbstractItemModel();

    bool hasIndex(int row, int column, ref const(QModelIndex) parent = QModelIndex()) const;
    /+virtual+/ QModelIndex index(int row, int column,
                              ref const(QModelIndex) parent = QModelIndex()) const = 0;
    /+virtual+/ QModelIndex parent(ref const(QModelIndex) child) const = 0;

    /+virtual+/ QModelIndex sibling(int row, int column, ref const(QModelIndex) idx) const;
    /+virtual+/ int rowCount(ref const(QModelIndex) parent = QModelIndex()) const = 0;
    /+virtual+/ int columnCount(ref const(QModelIndex) parent = QModelIndex()) const = 0;
    /+virtual+/ bool hasChildren(ref const(QModelIndex) parent = QModelIndex()) const;

    /+virtual+/ QVariant data(ref const(QModelIndex) index, int role = Qt.DisplayRole) const = 0;
    /+virtual+/ bool setData(ref const(QModelIndex) index, ref const(QVariant) value, int role = Qt.EditRole);

    /+virtual+/ QVariant headerData(int section, Qt.Orientation orientation,
                                int role = Qt.DisplayRole) const;
    /+virtual+/ bool setHeaderData(int section, Qt.Orientation orientation, ref const(QVariant) value,
                               int role = Qt.EditRole);

    /+virtual+/ QMap<int, QVariant> itemData(ref const(QModelIndex) index) const;
    /+virtual+/ bool setItemData(ref const(QModelIndex) index, const QMap<int, QVariant> &roles);

    /+virtual+/ QStringList mimeTypes() const;
    /+virtual+/ QMimeData *mimeData(ref const(QModelIndexList) indexes) const;
    /+virtual+/ bool canDropMimeData(const(QMimeData)* data, Qt.DropAction action,
                                 int row, int column, ref const(QModelIndex) parent) const;
    /+virtual+/ bool dropMimeData(const(QMimeData)* data, Qt.DropAction action,
                              int row, int column, ref const(QModelIndex) parent);
    /+virtual+/ Qt.DropActions supportedDropActions() const;

    /+virtual+/ Qt.DropActions supportedDragActions() const;
#if QT_DEPRECATED_SINCE(5, 0)
    QT_DEPRECATED void setSupportedDragActions(Qt.DropActions actions)
    { doSetSupportedDragActions(actions); }
#endif

    /+virtual+/ bool insertRows(int row, int count, ref const(QModelIndex) parent = QModelIndex());
    /+virtual+/ bool insertColumns(int column, int count, ref const(QModelIndex) parent = QModelIndex());
    /+virtual+/ bool removeRows(int row, int count, ref const(QModelIndex) parent = QModelIndex());
    /+virtual+/ bool removeColumns(int column, int count, ref const(QModelIndex) parent = QModelIndex());
    /+virtual+/ bool moveRows(ref const(QModelIndex) sourceParent, int sourceRow, int count,
                          ref const(QModelIndex) destinationParent, int destinationChild);
    /+virtual+/ bool moveColumns(ref const(QModelIndex) sourceParent, int sourceColumn, int count,
                             ref const(QModelIndex) destinationParent, int destinationChild);

    /+inline+/ bool insertRow(int row, ref const(QModelIndex) parent = QModelIndex());
    /+inline+/ bool insertColumn(int column, ref const(QModelIndex) parent = QModelIndex());
    /+inline+/ bool removeRow(int row, ref const(QModelIndex) parent = QModelIndex());
    /+inline+/ bool removeColumn(int column, ref const(QModelIndex) parent = QModelIndex());
    /+inline+/ bool moveRow(ref const(QModelIndex) sourceParent, int sourceRow,
                        ref const(QModelIndex) destinationParent, int destinationChild);
    /+inline+/ bool moveColumn(ref const(QModelIndex) sourceParent, int sourceColumn,
                           ref const(QModelIndex) destinationParent, int destinationChild);

    /+virtual+/ void fetchMore(ref const(QModelIndex) parent);
    /+virtual+/ bool canFetchMore(ref const(QModelIndex) parent) const;
    /+virtual+/ Qt.ItemFlags flags(ref const(QModelIndex) index) const;
    /+virtual+/ void sort(int column, Qt.SortOrder order = Qt.AscendingOrder);
    /+virtual+/ QModelIndex buddy(ref const(QModelIndex) index) const;
    /+virtual+/ QModelIndexList match(ref const(QModelIndex) start, int role,
                                  ref const(QVariant) value, int hits = 1,
                                  Qt.MatchFlags flags =
                                  Qt.MatchFlags(Qt.MatchStartsWith|Qt.MatchWrap)) const;
    /+virtual+/ QSize span(ref const(QModelIndex) index) const;

    /+virtual+/ QHash<int,QByteArray> roleNames() const;

#ifdef Q_NO_USING_KEYWORD
    /+inline+/ QObject *parent() const { return QObject::parent(); }
#else
    using QObject::parent;
#endif

    enum LayoutChangeHint
    {
        NoLayoutChangeHint,
        VerticalSortHint,
        HorizontalSortHint
    }

Q_SIGNALS:
    void dataChanged(ref const(QModelIndex) topLeft, ref const(QModelIndex) bottomRight, ref const(QVector<int>) roles = QVector<int>());
    void headerDataChanged(Qt.Orientation orientation, int first, int last);
    void layoutChanged(ref const(QList<QPersistentModelIndex>) parents = QList<QPersistentModelIndex>(), QAbstractItemModel::LayoutChangeHint hint = QAbstractItemModel::NoLayoutChangeHint);
    void layoutAboutToBeChanged(ref const(QList<QPersistentModelIndex>) parents = QList<QPersistentModelIndex>(), QAbstractItemModel::LayoutChangeHint hint = QAbstractItemModel::NoLayoutChangeHint);

    void rowsAboutToBeInserted(ref const(QModelIndex) parent, int first, int last
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );
    void rowsInserted(ref const(QModelIndex) parent, int first, int last
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );

    void rowsAboutToBeRemoved(ref const(QModelIndex) parent, int first, int last
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );
    void rowsRemoved(ref const(QModelIndex) parent, int first, int last
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );

    void columnsAboutToBeInserted(ref const(QModelIndex) parent, int first, int last
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );
    void columnsInserted(ref const(QModelIndex) parent, int first, int last
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );

    void columnsAboutToBeRemoved(ref const(QModelIndex) parent, int first, int last
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );
    void columnsRemoved(ref const(QModelIndex) parent, int first, int last
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );

    void modelAboutToBeReset(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );
    void modelReset(
#if !defined(Q_QDOC)
      QPrivateSignal
#endif
    );

    void rowsAboutToBeMoved( ref const(QModelIndex) sourceParent, int sourceStart, int sourceEnd, ref const(QModelIndex) destinationParent, int destinationRow
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );
    void rowsMoved( ref const(QModelIndex) parent, int start, int end, ref const(QModelIndex) destination, int row
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );

    void columnsAboutToBeMoved( ref const(QModelIndex) sourceParent, int sourceStart, int sourceEnd, ref const(QModelIndex) destinationParent, int destinationColumn
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );
    void columnsMoved( ref const(QModelIndex) parent, int start, int end, ref const(QModelIndex) destination, int column
#if !defined(Q_QDOC)
      , QPrivateSignal
#endif
    );

public Q_SLOTS:
    /+virtual+/ bool submit();
    /+virtual+/ void revert();

protected Q_SLOTS:
    // Qt 6: Make virtual
    void resetInternalData();

protected:
    QAbstractItemModel(QAbstractItemModelPrivate &dd, QObject *parent = 0);

    /+inline+/ QModelIndex createIndex(int row, int column, void *data = 0) const;
    /+inline+/ QModelIndex createIndex(int row, int column, quintptr id) const;

    void encodeData(ref const(QModelIndexList) indexes, QDataStream &stream) const;
    bool decodeData(int row, int column, ref const(QModelIndex) parent, QDataStream &stream);

    void beginInsertRows(ref const(QModelIndex) parent, int first, int last);
    void endInsertRows();

    void beginRemoveRows(ref const(QModelIndex) parent, int first, int last);
    void endRemoveRows();

    bool beginMoveRows(ref const(QModelIndex) sourceParent, int sourceFirst, int sourceLast, ref const(QModelIndex) destinationParent, int destinationRow);
    void endMoveRows();

    void beginInsertColumns(ref const(QModelIndex) parent, int first, int last);
    void endInsertColumns();

    void beginRemoveColumns(ref const(QModelIndex) parent, int first, int last);
    void endRemoveColumns();

    bool beginMoveColumns(ref const(QModelIndex) sourceParent, int sourceFirst, int sourceLast, ref const(QModelIndex) destinationParent, int destinationColumn);
    void endMoveColumns();


#if QT_DEPRECATED_SINCE(5,0)
    QT_DEPRECATED void reset()
    {
        beginResetModel();
        endResetModel();
    }
#endif

    void beginResetModel();
    void endResetModel();

    void changePersistentIndex(ref const(QModelIndex) from, ref const(QModelIndex) to);
    void changePersistentIndexList(ref const(QModelIndexList) from, ref const(QModelIndexList) to);
    QModelIndexList persistentIndexList() const;

#if QT_DEPRECATED_SINCE(5,0)
    QT_DEPRECATED void setRoleNames(ref const(QHash<int,QByteArray>) theRoleNames)
    {
        doSetRoleNames(theRoleNames);
    }
#endif

private:
    void doSetRoleNames(ref const(QHash<int,QByteArray>) roleNames);
    void doSetSupportedDragActions(Qt.DropActions actions);

    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
}

/+inline+/ bool QAbstractItemModel::insertRow(int arow, ref const(QModelIndex) aparent)
{ return insertRows(arow, 1, aparent); }
/+inline+/ bool QAbstractItemModel::insertColumn(int acolumn, ref const(QModelIndex) aparent)
{ return insertColumns(acolumn, 1, aparent); }
/+inline+/ bool QAbstractItemModel::removeRow(int arow, ref const(QModelIndex) aparent)
{ return removeRows(arow, 1, aparent); }
/+inline+/ bool QAbstractItemModel::removeColumn(int acolumn, ref const(QModelIndex) aparent)
{ return removeColumns(acolumn, 1, aparent); }
/+inline+/ bool QAbstractItemModel::moveRow(ref const(QModelIndex) sourceParent, int sourceRow,
                                        ref const(QModelIndex) destinationParent, int destinationChild)
{ return moveRows(sourceParent, sourceRow, 1, destinationParent, destinationChild); }
/+inline+/ bool QAbstractItemModel::moveColumn(ref const(QModelIndex) sourceParent, int sourceColumn,
                                           ref const(QModelIndex) destinationParent, int destinationChild)
{ return moveColumns(sourceParent, sourceColumn, 1, destinationParent, destinationChild); }
/+inline+/ QModelIndex QAbstractItemModel::createIndex(int arow, int acolumn, void *adata) const
{ return QModelIndex(arow, acolumn, adata, this); }
/+inline+/ QModelIndex QAbstractItemModel::createIndex(int arow, int acolumn, quintptr aid) const
{ return QModelIndex(arow, acolumn, aid, this); }

extern(C++) class export QAbstractTableModel : QAbstractItemModel
{
    mixin Q_OBJECT;

public:
    explicit QAbstractTableModel(QObject *parent = 0);
    ~QAbstractTableModel();

    QModelIndex index(int row, int column, ref const(QModelIndex) parent = QModelIndex()) const;
    bool dropMimeData(const(QMimeData)* data, Qt.DropAction action,
                      int row, int column, ref const(QModelIndex) parent);

    override Qt.ItemFlags flags(ref const(QModelIndex) index) const;

#ifdef Q_NO_USING_KEYWORD
#ifndef Q_QDOC
    /+inline+/ QObject *parent() const { return QAbstractItemModel::parent(); }
#endif
#else
    using QObject::parent;
#endif

protected:
    QAbstractTableModel(QAbstractItemModelPrivate &dd, QObject *parent);

private:
    mixin Q_DISABLE_COPY;
    QModelIndex parent(ref const(QModelIndex) child) const;
    bool hasChildren(ref const(QModelIndex) parent) const;
}

extern(C++) class export QAbstractListModel : QAbstractItemModel
{
    mixin Q_OBJECT;

public:
    explicit QAbstractListModel(QObject *parent = 0);
    ~QAbstractListModel();

    QModelIndex index(int row, int column = 0, ref const(QModelIndex) parent = QModelIndex()) const;
    bool dropMimeData(const(QMimeData)* data, Qt.DropAction action,
                      int row, int column, ref const(QModelIndex) parent);

    override Qt.ItemFlags flags(ref const(QModelIndex) index) const;

#ifdef Q_NO_USING_KEYWORD
#ifndef Q_QDOC
    /+inline+/ QObject *parent() const { return QAbstractItemModel::parent(); }
#endif
#else
    using QObject::parent;
#endif

protected:
    QAbstractListModel(QAbstractItemModelPrivate &dd, QObject *parent);

private:
    mixin Q_DISABLE_COPY;
    QModelIndex parent(ref const(QModelIndex) child) const;
    int columnCount(ref const(QModelIndex) parent) const;
    bool hasChildren(ref const(QModelIndex) parent) const;
}

// /+inline+/ implementations

/+inline+/ QModelIndex QModelIndex::parent() const
{ return m ? m->parent(*this) : QModelIndex(); }

/+inline+/ QModelIndex QModelIndex::sibling(int arow, int acolumn) const
{ return m ? (r == arow && c == acolumn) ? *this : m->sibling(arow, acolumn, *this) : QModelIndex(); }

/+inline+/ QModelIndex QModelIndex::child(int arow, int acolumn) const
{ return m ? m->index(arow, acolumn, *this) : QModelIndex(); }

/+inline+/ QVariant QModelIndex::data(int arole) const
{ return m ? m->data(*this, arole) : QVariant(); }

/+inline+/ Qt.ItemFlags QModelIndex::flags() const
{ return m ? m->flags(*this) : Qt.ItemFlags(0); }

/+inline+/ uint qHash(ref const(QModelIndex) index)
{ return uint((index.row() << 4) + index.column() + index.internalId()); }
