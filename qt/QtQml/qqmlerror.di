/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtQml module of the Qt Toolkit.
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

public import QtQml.qtqmlglobal;

public import QtCore.qurl;
public import QtCore.qstring;

extern(C++) class QDebug;
extern(C++) class QQmlErrorPrivate;
extern(C++) class Q_QML_EXPORT QQmlError
{
public:
    QQmlError();
    QQmlError(ref const(QQmlError) );
    QQmlError &operator=(ref const(QQmlError) );
    ~QQmlError();

    bool isValid() const;

    QUrl url() const;
    void setUrl(ref const(QUrl) );
    QString description() const;
    void setDescription(ref const(QString) );
    int line() const;
    void setLine(int);
    int column() const;
    void setColumn(int);
    QObject *object() const;
    void setObject(QObject *);

    QString toString() const;
private:
    QQmlErrorPrivate *d;
}

QDebug Q_QML_EXPORT operator<<(QDebug debug, ref const(QQmlError) error);

Q_DECLARE_TYPEINFO(QQmlError, Q_MOVABLE_TYPE);

#endif // QQMLERROR_H
