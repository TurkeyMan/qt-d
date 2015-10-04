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

#ifndef QSCRIPTENGINEAGENT_H
#define QSCRIPTENGINEAGENT_H

public import qt.QtCore.qobjectdefs;

public import qt.QtCore.qvariant;
public import qt.QtCore.qscopedpointer;
public import qt.QtScript.qtscriptglobal;

QT_BEGIN_NAMESPACE


class QScriptEngine;
class QScriptValue;

class QScriptEngineAgentPrivate;
class Q_SCRIPT_EXPORT QScriptEngineAgent
{
public:
    enum Extension {
        DebuggerInvocationRequest
    };

    QScriptEngineAgent(QScriptEngine *engine);
    /+virtual+/ ~QScriptEngineAgent();

    /+virtual+/ void scriptLoad(qint64 id, ref const(QString) program,
                            ref const(QString) fileName, int baseLineNumber);
    /+virtual+/ void scriptUnload(qint64 id);

    /+virtual+/ void contextPush();
    /+virtual+/ void contextPop();

    /+virtual+/ void functionEntry(qint64 scriptId);
    /+virtual+/ void functionExit(qint64 scriptId,
                              ref const(QScriptValue) returnValue);

    /+virtual+/ void positionChange(qint64 scriptId,
                                int lineNumber, int columnNumber);

    /+virtual+/ void exceptionThrow(qint64 scriptId,
                                ref const(QScriptValue) exception,
                                bool hasHandler);
    /+virtual+/ void exceptionCatch(qint64 scriptId,
                                ref const(QScriptValue) exception);

    /+virtual+/ bool supportsExtension(Extension extension) const;
    /+virtual+/ QVariant extension(Extension extension,
                               ref const(QVariant) argument = QVariant());

    QScriptEngine *engine() const;

protected:
    QScriptEngineAgent(QScriptEngineAgentPrivate &dd, QScriptEngine *engine);
    QScopedPointer<QScriptEngineAgentPrivate> d_ptr;

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

QT_END_NAMESPACE

#endif
