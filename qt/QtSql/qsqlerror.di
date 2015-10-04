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

#ifndef QSQLERROR_H
#define QSQLERROR_H

public import qt.QtCore.qstring;
public import qt.QtSql.qsql;

QT_BEGIN_NAMESPACE

class QSqlErrorPrivate;

class Q_SQL_EXPORT QSqlError
{
public:
    enum ErrorType {
        NoError,
        ConnectionError,
        StatementError,
        TransactionError,
        UnknownError
    };
#if QT_DEPRECATED_SINCE(5, 3)
    QT_DEPRECATED QSqlError(ref const(QString) driverText, ref const(QString) databaseText,
                            ErrorType type, int number);
#endif
    QSqlError(ref const(QString) driverText = QString(),
              ref const(QString) databaseText = QString(),
              ErrorType type = NoError,
              ref const(QString) errorCode = QString());
    QSqlError(ref const(QSqlError) other);
    QSqlError& operator=(ref const(QSqlError) other);
    bool operator==(ref const(QSqlError) other) const;
    bool operator!=(ref const(QSqlError) other) const;
    ~QSqlError();

    QString driverText() const;
    QString databaseText() const;
    ErrorType type() const;
#if QT_DEPRECATED_SINCE(5, 3)
    QT_DEPRECATED int number() const;
#endif
    QString nativeErrorCode() const;
    QString text() const;
    bool isValid() const;

#if QT_DEPRECATED_SINCE(5, 1)
    QT_DEPRECATED void setDriverText(ref const(QString) driverText);
    QT_DEPRECATED void setDatabaseText(ref const(QString) databaseText);
    QT_DEPRECATED void setType(ErrorType type);
    QT_DEPRECATED void setNumber(int number);
#endif

private:
    // ### Qt6: Keep the pointer and remove the rest.
    QString unused1;
    QString unused2;
    struct Unused {
        ErrorType unused3;
        int unused4;
    };
    union {
        QSqlErrorPrivate *d;
        Unused unused5;
    };
};

#ifndef QT_NO_DEBUG_STREAM
Q_SQL_EXPORT QDebug operator<<(QDebug, ref const(QSqlError) );
#endif

QT_END_NAMESPACE

#endif // QSQLERROR_H
