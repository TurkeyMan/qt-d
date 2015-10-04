/****************************************************************************
**
** Copyright (C) 2011 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com, author Stephen Kelly <stephen.kelly@kdab.com>
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

#ifndef QT_NO_IDENTITYPROXYMODEL


extern(C++) class QIdentityProxyModelPrivate;

extern(C++) class export QIdentityProxyModel : QAbstractProxyModel
{
    mixin Q_OBJECT;
public:
    explicit QIdentityProxyModel(QObject* parent = 0);
    ~QIdentityProxyModel();

    int columnCount(ref const(QModelIndex) parent = QModelIndex()) const;
    QModelIndex index(int row, int column, ref const(QModelIndex) parent = QModelIndex()) const;
    QModelIndex mapFromSource(ref const(QModelIndex) sourceIndex) const;
    QModelIndex mapToSource(ref const(QModelIndex) proxyIndex) const;
    QModelIndex parent(ref const(QModelIndex) child) const;
    int rowCount(ref const(QModelIndex) parent = QModelIndex()) const;
    QVariant headerData(int section, Qt.Orientation orientation, int role) const;
    bool dropMimeData(const(QMimeData)* data, Qt.DropAction action, int row, int column, ref const(QModelIndex) parent);
    QModelIndex sibling(int row, int column, ref const(QModelIndex) idx) const;

    QItemSelection mapSelectionFromSource(ref const(QItemSelection) selection) const;
    QItemSelection mapSelectionToSource(ref const(QItemSelection) selection) const;
    QModelIndexList match(ref const(QModelIndex) start, int role, ref const(QVariant) value, int hits = 1, Qt.MatchFlags flags = Qt.MatchFlags(Qt.MatchStartsWith|Qt.MatchWrap)) const;
    void setSourceModel(QAbstractItemModel* sourceModel);

    bool insertColumns(int column, int count, ref const(QModelIndex) parent = QModelIndex());
    bool insertRows(int row, int count, ref const(QModelIndex) parent = QModelIndex());
    bool removeColumns(int column, int count, ref const(QModelIndex) parent = QModelIndex());
    bool removeRows(int row, int count, ref const(QModelIndex) parent = QModelIndex());

protected:
    QIdentityProxyModel(QIdentityProxyModelPrivate &dd, QObject* parent);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsAboutToBeInserted(QModelIndex,int,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsInserted(QModelIndex,int,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsAboutToBeRemoved(QModelIndex,int,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsRemoved(QModelIndex,int,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsAboutToBeMoved(QModelIndex,int,int,QModelIndex,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceRowsMoved(QModelIndex,int,int,QModelIndex,int))

    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsAboutToBeInserted(QModelIndex,int,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsInserted(QModelIndex,int,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsAboutToBeRemoved(QModelIndex,int,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsRemoved(QModelIndex,int,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsAboutToBeMoved(QModelIndex,int,int,QModelIndex,int))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceColumnsMoved(QModelIndex,int,int,QModelIndex,int))

    Q_PRIVATE_SLOT(d_func(), void _q_sourceDataChanged(QModelIndex,QModelIndex,QVector<int>))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceHeaderDataChanged(Qt.Orientation orientation, int first, int last))

    Q_PRIVATE_SLOT(d_func(), void _q_sourceLayoutAboutToBeChanged(ref const(QList<QPersistentModelIndex>) sourceParents, QAbstractItemModel::LayoutChangeHint hint))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceLayoutChanged(ref const(QList<QPersistentModelIndex>) sourceParents, QAbstractItemModel::LayoutChangeHint hint))
    Q_PRIVATE_SLOT(d_func(), void _q_sourceModelAboutToBeReset())
    Q_PRIVATE_SLOT(d_func(), void _q_sourceModelReset())
}

#endif // QT_NO_IDENTITYPROXYMODEL


