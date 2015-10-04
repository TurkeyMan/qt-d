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

public import QtQml.qqmlerror;
public import QtQml.qqmlscriptstring;

public import QtCore.qobject;
public import QtCore.qvariant;


extern(C++) class QString;
extern(C++) class QQmlRefCount;
extern(C++) class QQmlEngine;
extern(C++) class QQmlContext;
extern(C++) class QQmlExpressionPrivate;
extern(C++) class QQmlContextData;
extern(C++) class Q_QML_EXPORT QQmlExpression : QObject
{
    mixin Q_OBJECT;
public:
    QQmlExpression();
    QQmlExpression(QQmlContext *, QObject *, ref const(QString) , QObject * = 0);
    explicit QQmlExpression(ref const(QQmlScriptString) , QQmlContext * = 0, QObject * = 0, QObject * = 0);
    /+virtual+/ ~QQmlExpression();

    QQmlEngine *engine() const;
    QQmlContext *context() const;

    QString expression() const;
    void setExpression(ref const(QString) );

    bool notifyOnValueChanged() const;
    void setNotifyOnValueChanged(bool);

    QString sourceFile() const;
    int lineNumber() const;
    int columnNumber() const;
    void setSourceLocation(ref const(QString) fileName, int line, int column = 0);

    QObject *scopeObject() const;

    bool hasError() const;
    void clearError();
    QQmlError error() const;

    QVariant evaluate(bool *valueIsUndefined = 0);

Q_SIGNALS:
    void valueChanged();

private:
    QQmlExpression(QQmlContextData *, QObject *, ref const(QString) );

    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    friend extern(C++) class QQmlDebugger;
    friend extern(C++) class QQmlContext;
}


