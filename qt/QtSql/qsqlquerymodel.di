/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtSql module of the Qt Toolkit.
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

#ifndef QSQLQUERYMODEL_H
#define QSQLQUERYMODEL_H

public import qt.QtCore.qabstractitemmodel;
public import qt.QtSql.qsqldatabase;

QT_BEGIN_NAMESPACE


class QSqlQueryModelPrivate;
class QSqlError;
class QSqlRecord;
class QSqlQuery;

class Q_SQL_EXPORT QSqlQueryModel: public QAbstractTableModel
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

public:
    explicit QSqlQueryModel(QObject *parent = 0);
    /+virtual+/ ~QSqlQueryModel();

    int rowCount(ref const(QModelIndex) parent = QModelIndex()) const;
    int columnCount(ref const(QModelIndex) parent = QModelIndex()) const;
    QSqlRecord record(int row) const;
    QSqlRecord record() const;

    QVariant data(ref const(QModelIndex) item, int role = Qt.DisplayRole) const;
    QVariant headerData(int section, Qt.Orientation orientation,
                        int role = Qt.DisplayRole) const;
    bool setHeaderData(int section, Qt.Orientation orientation, ref const(QVariant) value,
                       int role = Qt.EditRole);

    bool insertColumns(int column, int count, ref const(QModelIndex) parent = QModelIndex());
    bool removeColumns(int column, int count, ref const(QModelIndex) parent = QModelIndex());

    void setQuery(ref const(QSqlQuery) query);
    void setQuery(ref const(QString) query, ref const(QSqlDatabase) db = QSqlDatabase());
    QSqlQuery query() const;

    /+virtual+/ void clear();

    QSqlError lastError() const;

    void fetchMore(ref const(QModelIndex) parent = QModelIndex());
    bool canFetchMore(ref const(QModelIndex) parent = QModelIndex()) const;

protected:
    void beginInsertRows(ref const(QModelIndex) parent, int first, int last);
    void endInsertRows();

    void beginRemoveRows(ref const(QModelIndex) parent, int first, int last);
    void endRemoveRows();

    void beginInsertColumns(ref const(QModelIndex) parent, int first, int last);
    void endInsertColumns();

    void beginRemoveColumns(ref const(QModelIndex) parent, int first, int last);
    void endRemoveColumns();

    void beginResetModel();
    void endResetModel();
    /+virtual+/ void queryChange();

    /+virtual+/ QModelIndex indexInQuery(ref const(QModelIndex) item) const;
    void setLastError(ref const(QSqlError) error);
    QSqlQueryModel(QSqlQueryModelPrivate &dd, QObject *parent = 0);
};

QT_END_NAMESPACE

#endif // QSQLQUERYMODEL_H
