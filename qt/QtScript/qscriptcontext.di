/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtScript module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL-ONLY$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** If you have questions regarding the use of this file, please contact
** us via http://www.qt-project.org/.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QSCRIPTCONTEXT_H
#define QSCRIPTCONTEXT_H

public import qt.QtCore.qobjectdefs;

public import qt.QtScript.qscriptvalue;

QT_BEGIN_NAMESPACE


class QScriptContextPrivate;

class Q_SCRIPT_EXPORT QScriptContext
{
public:
    enum ExecutionState {
        NormalState,
        ExceptionState
    };

    enum Error {
        UnknownError,
        ReferenceError,
        SyntaxError,
        TypeError,
        RangeError,
        URIError
    };

    ~QScriptContext();

    QScriptContext *parentContext() const;
    QScriptEngine *engine() const;

    ExecutionState state() const;
    QScriptValue callee() const;

    int argumentCount() const;
    QScriptValue argument(int index) const;
    QScriptValue argumentsObject() const;

    QScriptValueList scopeChain() const;
    void pushScope(ref const(QScriptValue) object);
    QScriptValue popScope();

    QScriptValue returnValue() const;
    void setReturnValue(ref const(QScriptValue) result);

    QScriptValue activationObject() const;
    void setActivationObject(ref const(QScriptValue) activation);

    QScriptValue thisObject() const;
    void setThisObject(ref const(QScriptValue) thisObject);

    bool isCalledAsConstructor() const;

    QScriptValue throwValue(ref const(QScriptValue) value);
    QScriptValue throwError(Error error, ref const(QString) text);
    QScriptValue throwError(ref const(QString) text);

    QStringList backtrace() const;

    QString toString() const;

private:
    QScriptContext();

    QScriptContextPrivate *d_ptr;

    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

QT_END_NAMESPACE

#endif
