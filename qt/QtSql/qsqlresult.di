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

#ifndef QSQLRESULT_H
#define QSQLRESULT_H

public import qt.QtCore.qvariant;
public import qt.QtCore.qvector;
public import qt.QtSql.qsql;

QT_BEGIN_NAMESPACE


class QString;
class QSqlRecord;
template <typename T> class QVector;
class QVariant;
class QSqlDriver;
class QSqlError;
class QSqlResultPrivate;

class Q_SQL_EXPORT QSqlResult
{
    mixin Q_DECLARE_PRIVATE;
    friend class QSqlQuery;
    friend class QSqlTableModelPrivate;

public:
    /+virtual+/ ~QSqlResult();
    /+virtual+/ QVariant handle() const;

protected:
    enum BindingSyntax {
        PositionalBinding,
        NamedBinding
    };

    explicit QSqlResult(const(QSqlDriver)*  db);
    QSqlResult(QSqlResultPrivate &dd, const(QSqlDriver)* db);
    int at() const;
    QString lastQuery() const;
    QSqlError lastError() const;
    bool isValid() const;
    bool isActive() const;
    bool isSelect() const;
    bool isForwardOnly() const;
    const(QSqlDriver)* driver() const;
    /+virtual+/ void setAt(int at);
    /+virtual+/ void setActive(bool a);
    /+virtual+/ void setLastError(ref const(QSqlError) e);
    /+virtual+/ void setQuery(ref const(QString) query);
    /+virtual+/ void setSelect(bool s);
    /+virtual+/ void setForwardOnly(bool forward);

    // prepared query support
    /+virtual+/ bool exec();
    /+virtual+/ bool prepare(ref const(QString) query);
    /+virtual+/ bool savePrepare(ref const(QString) sqlquery);
    /+virtual+/ void bindValue(int pos, ref const(QVariant) val, QSql::ParamType type);
    /+virtual+/ void bindValue(ref const(QString) placeholder, ref const(QVariant) val,
                           QSql::ParamType type);
    void addBindValue(ref const(QVariant) val, QSql::ParamType type);
    QVariant boundValue(ref const(QString) placeholder) const;
    QVariant boundValue(int pos) const;
    QSql::ParamType bindValueType(ref const(QString) placeholder) const;
    QSql::ParamType bindValueType(int pos) const;
    int boundValueCount() const;
    QVector<QVariant>& boundValues() const;
    QString executedQuery() const;
    QString boundValueName(int pos) const;
    void clear();
    bool hasOutValues() const;

    BindingSyntax bindingSyntax() const;

    /+virtual+/ QVariant data(int i) = 0;
    /+virtual+/ bool isNull(int i) = 0;
    /+virtual+/ bool reset(ref const(QString) sqlquery) = 0;
    /+virtual+/ bool fetch(int i) = 0;
    /+virtual+/ bool fetchNext();
    /+virtual+/ bool fetchPrevious();
    /+virtual+/ bool fetchFirst() = 0;
    /+virtual+/ bool fetchLast() = 0;
    /+virtual+/ int size() = 0;
    /+virtual+/ int numRowsAffected() = 0;
    /+virtual+/ QSqlRecord record() const;
    /+virtual+/ QVariant lastInsertId() const;

    enum VirtualHookOperation { };
    /+virtual+/ void virtual_hook(int id, void *data);
    /+virtual+/ bool execBatch(bool arrayBind = false);
    /+virtual+/ void detachFromResultSet();
    /+virtual+/ void setNumericalPrecisionPolicy(QSql::NumericalPrecisionPolicy policy);
    QSql::NumericalPrecisionPolicy numericalPrecisionPolicy() const;
    /+virtual+/ bool nextResult();
    void resetBindCount(); // HACK

    QSqlResultPrivate *d_ptr;

private:
    mixin Q_DISABLE_COPY;
};

QT_END_NAMESPACE

#endif // QSQLRESULT_H