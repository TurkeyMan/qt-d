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

#ifndef QSQLTABLEMODEL_H
#define QSQLTABLEMODEL_H

public import qt.QtSql.qsqldatabase;
public import qt.QtSql.qsqlquerymodel;

QT_BEGIN_NAMESPACE


class QSqlTableModelPrivate;
class QSqlRecord;
class QSqlField;
class QSqlIndex;

class Q_SQL_EXPORT QSqlTableModel: public QSqlQueryModel
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

public:
    enum EditStrategy {OnFieldChange, OnRowChange, OnManualSubmit};

    explicit QSqlTableModel(QObject *parent = 0, QSqlDatabase db = QSqlDatabase());
    /+virtual+/ ~QSqlTableModel();

    /+virtual+/ void setTable(ref const(QString) tableName);
    QString tableName() const;

    Qt.ItemFlags flags(ref const(QModelIndex) index) const;

    QSqlRecord record() const;
    QSqlRecord record(int row) const;
    QVariant data(ref const(QModelIndex) idx, int role = Qt.DisplayRole) const;
    bool setData(ref const(QModelIndex) index, ref const(QVariant) value, int role = Qt.EditRole);

    QVariant headerData(int section, Qt.Orientation orientation, int role = Qt.DisplayRole) const;

    bool isDirty() const;
    bool isDirty(ref const(QModelIndex) index) const;

    void clear();

    /+virtual+/ void setEditStrategy(EditStrategy strategy);
    EditStrategy editStrategy() const;

    QSqlIndex primaryKey() const;
    QSqlDatabase database() const;
    int fieldIndex(ref const(QString) fieldName) const;

    void sort(int column, Qt.SortOrder order);
    /+virtual+/ void setSort(int column, Qt.SortOrder order);

    QString filter() const;
    /+virtual+/ void setFilter(ref const(QString) filter);

    int rowCount(ref const(QModelIndex) parent = QModelIndex()) const;

    bool removeColumns(int column, int count, ref const(QModelIndex) parent = QModelIndex());
    bool removeRows(int row, int count, ref const(QModelIndex) parent = QModelIndex());
    bool insertRows(int row, int count, ref const(QModelIndex) parent = QModelIndex());

    bool insertRecord(int row, ref const(QSqlRecord) record);
    bool setRecord(int row, ref const(QSqlRecord) record);

    /+virtual+/ void revertRow(int row);

public Q_SLOTS:
    /+virtual+/ bool select();
    /+virtual+/ bool selectRow(int row);

    bool submit();
    void revert();

    bool submitAll();
    void revertAll();

Q_SIGNALS:
    void primeInsert(int row, QSqlRecord &record);

    void beforeInsert(QSqlRecord &record);
    void beforeUpdate(int row, QSqlRecord &record);
    void beforeDelete(int row);

protected:
    QSqlTableModel(QSqlTableModelPrivate &dd, QObject *parent = 0, QSqlDatabase db = QSqlDatabase());

    /+virtual+/ bool updateRowInTable(int row, ref const(QSqlRecord) values);
    /+virtual+/ bool insertRowIntoTable(ref const(QSqlRecord) values);
    /+virtual+/ bool deleteRowFromTable(int row);
    /+virtual+/ QString orderByClause() const;
    /+virtual+/ QString selectStatement() const;

    void setPrimaryKey(ref const(QSqlIndex) key);
    void setQuery(ref const(QSqlQuery) query);
    QModelIndex indexInQuery(ref const(QModelIndex) item) const;
    QSqlRecord primaryValues(int row) const;
};

QT_END_NAMESPACE

#endif // QSQLTABLEMODEL_H
