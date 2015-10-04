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

#ifndef QSQLDRIVER_H
#define QSQLDRIVER_H

public import qt.QtCore.qobject;
public import qt.QtCore.qstring;
public import qt.QtCore.qstringlist;
public import qt.QtSql.qsql;

QT_BEGIN_NAMESPACE


class QSqlDatabase;
class QSqlDriverPrivate;
class QSqlError;
class QSqlField;
class QSqlIndex;
class QSqlRecord;
class QSqlResult;
class QVariant;

class Q_SQL_EXPORT QSqlDriver : public QObject
{
    friend class QSqlDatabase;
    friend class QSqlResultPrivate;
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

public:
    enum DriverFeature { Transactions, QuerySize, BLOB, Unicode, PreparedQueries,
                         NamedPlaceholders, PositionalPlaceholders, LastInsertId,
                         BatchOperations, SimpleLocking, LowPrecisionNumbers,
                         EventNotifications, FinishQuery, MultipleResultSets, CancelQuery };

    enum StatementType { WhereStatement, SelectStatement, UpdateStatement,
                         InsertStatement, DeleteStatement };

    enum IdentifierType { FieldName, TableName };

    enum NotificationSource { UnknownSource, SelfSource, OtherSource };

    enum DbmsType {
        UnknownDbms,
        MSSqlServer,
        MySqlServer,
        PostgreSQL,
        Oracle,
        Sybase,
        SQLite,
        Interbase,
        DB2
    };

    explicit QSqlDriver(QObject *parent=0);
    ~QSqlDriver();
    /+virtual+/ bool isOpen() const;
    bool isOpenError() const;

    /+virtual+/ bool beginTransaction();
    /+virtual+/ bool commitTransaction();
    /+virtual+/ bool rollbackTransaction();
    /+virtual+/ QStringList tables(QSql::TableType tableType) const;
    /+virtual+/ QSqlIndex primaryIndex(ref const(QString) tableName) const;
    /+virtual+/ QSqlRecord record(ref const(QString) tableName) const;
    /+virtual+/ QString formatValue(ref const(QSqlField) field, bool trimStrings = false) const;

    /+virtual+/ QString escapeIdentifier(ref const(QString) identifier, IdentifierType type) const;
    /+virtual+/ QString sqlStatement(StatementType type, ref const(QString) tableName,
                                 ref const(QSqlRecord) rec, bool preparedStatement) const;

    QSqlError lastError() const;

    /+virtual+/ QVariant handle() const;
    /+virtual+/ bool hasFeature(DriverFeature f) const = 0;
    /+virtual+/ void close() = 0;
    /+virtual+/ QSqlResult *createResult() const = 0;

    /+virtual+/ bool open(ref const(QString) db,
                      ref const(QString) user = QString(),
                      ref const(QString) password = QString(),
                      ref const(QString) host = QString(),
                      int port = -1,
                      ref const(QString) connOpts = QString()) = 0;
    /+virtual+/ bool subscribeToNotification(ref const(QString) name);
    /+virtual+/ bool unsubscribeFromNotification(ref const(QString) name);
    /+virtual+/ QStringList subscribedToNotifications() const;

    /+virtual+/ bool isIdentifierEscaped(ref const(QString) identifier, IdentifierType type) const;
    /+virtual+/ QString stripDelimiters(ref const(QString) identifier, IdentifierType type) const;

    void setNumericalPrecisionPolicy(QSql::NumericalPrecisionPolicy precisionPolicy);
    QSql::NumericalPrecisionPolicy numericalPrecisionPolicy() const;

    DbmsType dbmsType() const;

public Q_SLOTS:
    /+virtual+/ bool cancelQuery();

Q_SIGNALS:
    void notification(ref const(QString) name);
    void notification(ref const(QString) name, QSqlDriver::NotificationSource source, ref const(QVariant) payload);

protected:
    QSqlDriver(QSqlDriverPrivate &dd, QObject *parent = 0);
    /+virtual+/ void setOpen(bool o);
    /+virtual+/ void setOpenError(bool e);
    /+virtual+/ void setLastError(ref const(QSqlError) e);


private:
    mixin Q_DISABLE_COPY;
};

QT_END_NAMESPACE

#endif // QSQLDRIVER_H
