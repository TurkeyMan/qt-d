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

public import QtCore.qabstractitemmodel;


#ifndef QT_NO_PROXYMODEL

extern(C++) class QAbstractProxyModelPrivate;
extern(C++) class QItemSelection;

extern(C++) class export QAbstractProxyModel : QAbstractItemModel
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QAbstractItemModel*, "sourceModel", "READ", "sourceModel", "WRITE", "setSourceModel", "NOTIFY", "sourceModelChanged");

public:
    explicit QAbstractProxyModel(QObject *parent = 0);
    ~QAbstractProxyModel();

    /+virtual+/ void setSourceModel(QAbstractItemModel *sourceModel);
    QAbstractItemModel *sourceModel() const;

    /+virtual+/ QModelIndex mapToSource(ref const(QModelIndex) proxyIndex) const = 0;
    /+virtual+/ QModelIndex mapFromSource(ref const(QModelIndex) sourceIndex) const = 0;

    /+virtual+/ QItemSelection mapSelectionToSource(ref const(QItemSelection) selection) const;
    /+virtual+/ QItemSelection mapSelectionFromSource(ref const(QItemSelection) selection) const;

    bool submit();
    void revert();

    QVariant data(ref const(QModelIndex) proxyIndex, int role = Qt.DisplayRole) const;
    QVariant headerData(int section, Qt.Orientation orientation, int role) const;
    QMap<int, QVariant> itemData(ref const(QModelIndex) index) const;
    Qt.ItemFlags flags(ref const(QModelIndex) index) const;

    bool setData(ref const(QModelIndex) index, ref const(QVariant) value, int role = Qt.EditRole);
    bool setItemData(ref const(QModelIndex) index, const QMap<int, QVariant> &roles);
    bool setHeaderData(int section, Qt.Orientation orientation, ref const(QVariant) value, int role = Qt.EditRole);

    QModelIndex buddy(ref const(QModelIndex) index) const;
    bool canFetchMore(ref const(QModelIndex) parent) const;
    void fetchMore(ref const(QModelIndex) parent);
    void sort(int column, Qt.SortOrder order = Qt.AscendingOrder);
    QSize span(ref const(QModelIndex) index) const;
    bool hasChildren(ref const(QModelIndex) parent = QModelIndex()) const;
    QModelIndex sibling(int row, int column, ref const(QModelIndex) idx) const;

    QMimeData* mimeData(ref const(QModelIndexList) indexes) const;
    bool canDropMimeData(const(QMimeData)* data, Qt.DropAction action,
                         override int row, int column, ref const(QModelIndex) parent) const;
    bool dropMimeData(const(QMimeData)* data, Qt.DropAction action,
                      override int row, int column, ref const(QModelIndex) parent);
    QStringList mimeTypes() const;
    Qt.DropActions supportedDragActions() const;
    Qt.DropActions supportedDropActions() const;

Q_SIGNALS:
    void sourceModelChanged(
#if !defined(qdoc)
        QPrivateSignal
#endif
    );

protected Q_SLOTS:
    void resetInternalData();

protected:
    QAbstractProxyModel(QAbstractProxyModelPrivate &, QObject *parent);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_sourceModelDestroyed())
}

#endif // QT_NO_PROXYMODEL
