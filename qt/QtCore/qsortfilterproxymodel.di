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

public import QtCore.qabstractproxymodel;

#ifndef QT_NO_SORTFILTERPROXYMODEL

public import QtCore.qregexp;


extern(C++) class QSortFilterProxyModelPrivate;
extern(C++) class QSortFilterProxyModelLessThan;
extern(C++) class QSortFilterProxyModelGreaterThan;

extern(C++) class export QSortFilterProxyModel : QAbstractProxyModel
{
    friend extern(C++) class QSortFilterProxyModelLessThan;
    friend extern(C++) class QSortFilterProxyModelGreaterThan;

    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QRegExp, "filterRegExp", "READ", "filterRegExp", "WRITE", "setFilterRegExp");
    mixin Q_PROPERTY!(int, "filterKeyColumn", "READ", "filterKeyColumn", "WRITE", "setFilterKeyColumn");
    mixin Q_PROPERTY!(bool, "dynamicSortFilter", "READ", "dynamicSortFilter", "WRITE", "setDynamicSortFilter");
    mixin Q_PROPERTY!(Qt.CaseSensitivity, "filterCaseSensitivity", "READ", "filterCaseSensitivity", "WRITE", "setFilterCaseSensitivity");
    mixin Q_PROPERTY!(Qt.CaseSensitivity, "sortCaseSensitivity", "READ", "sortCaseSensitivity", "WRITE", "setSortCaseSensitivity");
    mixin Q_PROPERTY!(bool, "isSortLocaleAware", "READ", "isSortLocaleAware", "WRITE", "setSortLocaleAware");
    mixin Q_PROPERTY!(int, "sortRole", "READ", "sortRole", "WRITE", "setSortRole");
    mixin Q_PROPERTY!(int, "filterRole", "READ", "filterRole", "WRITE", "setFilterRole");

public:
    explicit QSortFilterProxyModel(QObject *parent = 0);
    ~QSortFilterProxyModel();

    void setSourceModel(QAbstractItemModel *sourceModel);

    QModelIndex mapToSource(ref const(QModelIndex) proxyIndex) const;
    QModelIndex mapFromSource(ref const(QModelIndex) sourceIndex) const;

    QItemSelection mapSelectionToSource(ref const(QItemSelection) proxySelection) const;
    QItemSelection mapSelectionFromSource(ref const(QItemSelection) sourceSelection) const;

    QRegExp filterRegExp() const;
    void setFilterRegExp(ref const(QRegExp) regExp);

    int filterKeyColumn() const;
    void setFilterKeyColumn(int column);

    Qt.CaseSensitivity filterCaseSensitivity() const;
    void setFilterCaseSensitivity(Qt.CaseSensitivity cs);

    Qt.CaseSensitivity sortCaseSensitivity() const;
    void setSortCaseSensitivity(Qt.CaseSensitivity cs);

    bool isSortLocaleAware() const;
    void setSortLocaleAware(bool on);

    int sortColumn() const;
    Qt.SortOrder sortOrder() const;

    bool dynamicSortFilter() const;
    void setDynamicSortFilter(bool enable);

    int sortRole() const;
    void setSortRole(int role);

    int filterRole() const;
    void setFilterRole(int role);

public Q_SLOTS:
    void setFilterRegExp(ref const(QString) pattern);
    void setFilterWildcard(ref const(QString) pattern);
    void setFilterFixedString(ref const(QString) pattern);
    void clear();
    void invalidate();

protected:
    /+virtual+/ bool filterAcceptsRow(int source_row, ref const(QModelIndex) source_parent) const;
    /+virtual+/ bool filterAcceptsColumn(int source_column, ref const(QModelIndex) source_parent) const;
    /+virtual+/ bool lessThan(ref const(QModelIndex) left, ref const(QModelIndex) right) const;

    void filterChanged();
    void invalidateFilter();

public:
#ifdef Q_NO_USING_KEYWORD
    /+inline+/ QObject *parent() const { return QObject::parent(); }
#else
    using QObject::parent;
#endif

    QModelIndex index(int row, int column, ref const(QModelIndex) parent = QModelIndex()) const;
    QModelIndex parent(ref const(QModelIndex) child) const;
    QModelIndex sibling(int row, int column, ref const(QModelIndex) idx) const;

    int rowCount(ref const(QModelIndex) parent = QModelIndex()) const;
    int columnCount(ref const(QModelIndex) parent = QModelIndex()) const;
    bool hasChildren(ref const(QModelIndex) parent = QModelIndex()) const;

    QVariant data(ref const(QModelIndex) index, int role = Qt.DisplayRole) const;
    bool setData(ref const(QModelIndex) index, ref const(QVariant) value, int role = Qt.EditRole);

    QVariant headerData(int section, Qt.Orientation orientation, int role = Qt.DisplayRole) const;
    bool setHeaderData(int section, Qt.Orientation orientation,
            ref const(QVariant) value, int role = Qt.EditRole);

    QMimeData *mimeData(ref const(QModelIndexList) indexes) const;
    bool dropMimeData(const(QMimeData)* data, Qt.DropAction action,
                      int row, int column, ref const(QModelIndex) parent);

    bool insertRows(int row, int count, ref const(QModelIndex) parent = QModelIndex());
    bool insertColumns(int column, int count, ref const(QModelIndex) parent = QModelIndex());
    bool removeRows(int row, int count, ref const(QModelIndex) parent = QModelIndex());
    bool removeColumns(int column, int count, ref const(QModelIndex) parent = QModelIndex());

    void fetchMore(ref const(QModelIndex) parent);
    bool canFetchMore(ref const(QModelIndex) parent) const;
    Qt.ItemFlags flags(ref const(QModelIndex) index) const;

    QModelIndex buddy(ref const(QModelIndex) index) const;
    QModelIndexList match(ref const(QModelIndex) start, int role,
                          ref const(QVariant) value, int hits = 1,
                          Qt.MatchFlags flags =
                          Qt.MatchFlags(Qt.MatchStartsWith|Qt.MatchWrap)) const;
    QSize span(ref const(QModelIndex) index) const;
    void sort(int column, Qt.SortOrder order = Qt.AscendingOrder);

    QStringList mimeTypes() const;
    Qt.DropActions supportedDropActions() const;
private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    Q_PRIVATE_SLOT(d_func(), void _q_sourceDataChanged(ref const(QModelIndex) source_top_left, ref const(QModelIndex) source_bottom_right))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceHeaderDataChanged(Qt.Orientation orientation, int start, int end))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceAboutToBeReset())
    Q_PRIVATE_SLOT(d_func(), void _q_sourceReset())
    Q_PRIVATE_SLOT(d_func(), void _q_sourceLayoutAboutToBeChanged(ref const(QList<QPersistentModelIndex>) sourceParents, QAbstractItemModel::LayoutChangeHint hint))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceLayoutChanged(ref const(QList<QPersistentModelIndex>) sourceParents, QAbstractItemModel::LayoutChangeHint hint))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsAboutToBeInserted(ref const(QModelIndex) source_parent, int start, int end))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsInserted(ref const(QModelIndex) source_parent, int start, int end))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsAboutToBeRemoved(ref const(QModelIndex) source_parent, int start, int end))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsRemoved(ref const(QModelIndex) source_parent, int start, int end))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsAboutToBeMoved(QModelIndex,int,int,QModelIndex,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsMoved(QModelIndex,int,int,QModelIndex,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsAboutToBeInserted(ref const(QModelIndex) source_parent, int start, int end))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsInserted(ref const(QModelIndex) source_parent, int start, int end))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsAboutToBeRemoved(ref const(QModelIndex) source_parent, int start, int end))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsRemoved(ref const(QModelIndex) source_parent, int start, int end))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsAboutToBeMoved(QModelIndex,int,int,QModelIndex,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsMoved(QModelIndex,int,int,QModelIndex,int))
    Q_PRIVATE_SLOT(d_func(), void _q_clearMapping())
}

#endif // QT_NO_SORTFILTERPROXYMODEL

#endif // QSORTFILTERPROXYMODEL_H
