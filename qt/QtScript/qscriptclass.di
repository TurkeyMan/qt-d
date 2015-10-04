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

#ifndef QSCRIPTCLASS_H
#define QSCRIPTCLASS_H

public import qt.QtCore.qstring;

public import qt.QtCore.qvariant;
public import qt.QtCore.qscopedpointer;
public import qt.QtScript.qscriptvalue;

QT_BEGIN_NAMESPACE


class QScriptString;
class QScriptClassPropertyIterator;

class QScriptClassPrivate;
class Q_SCRIPT_EXPORT QScriptClass
{
public:
    enum QueryFlag {
        HandlesReadAccess = 0x01,
        HandlesWriteAccess = 0x02
    };
    Q_DECLARE_FLAGS(QueryFlags, QueryFlag)

    enum Extension {
        Callable,
        HasInstance
    };

    QScriptClass(QScriptEngine *engine);
    /+virtual+/ ~QScriptClass();

    QScriptEngine *engine() const;

    /+virtual+/ QueryFlags queryProperty(ref const(QScriptValue) object,
                                     ref const(QScriptString) name,
                                     QueryFlags flags, uint *id);

    /+virtual+/ QScriptValue property(ref const(QScriptValue) object,
                                  ref const(QScriptString) name, uint id);

    /+virtual+/ void setProperty(QScriptValue &object, ref const(QScriptString) name,
                             uint id, ref const(QScriptValue) value);

    /+virtual+/ QScriptValue::PropertyFlags propertyFlags(
        ref const(QScriptValue) object, ref const(QScriptString) name, uint id);

    /+virtual+/ QScriptClassPropertyIterator *newIterator(ref const(QScriptValue) object);

    /+virtual+/ QScriptValue prototype() const;

    /+virtual+/ QString name() const;

    /+virtual+/ bool supportsExtension(Extension extension) const;
    /+virtual+/ QVariant extension(Extension extension,
                               ref const(QVariant) argument = QVariant());

protected:
    QScriptClass(QScriptEngine *engine, QScriptClassPrivate &dd);
    QScopedPointer<QScriptClassPrivate> d_ptr;

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QScriptClass::QueryFlags)

QT_END_NAMESPACE

#endif
