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

#ifndef QSCRIPTVALUEITERATOR_H
#define QSCRIPTVALUEITERATOR_H

public import qt.QtScript.qscriptvalue;

public import qt.QtCore.qscopedpointer;

QT_BEGIN_NAMESPACE


class QString;
class QScriptString;

class QScriptValueIteratorPrivate;
class Q_SCRIPT_EXPORT QScriptValueIterator
{
public:
    QScriptValueIterator(ref const(QScriptValue) value);
    ~QScriptValueIterator();

    bool hasNext() const;
    void next();

    bool hasPrevious() const;
    void previous();

    QString name() const;
    QScriptString scriptName() const;

    QScriptValue value() const;
    void setValue(ref const(QScriptValue) value);

    QScriptValue::PropertyFlags flags() const;

    void remove();

    void toFront();
    void toBack();

    QScriptValueIterator& operator=(QScriptValue &value);

private:
    QScopedPointer<QScriptValueIteratorPrivate> d_ptr;

    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

QT_END_NAMESPACE

#endif // QSCRIPTVALUEITERATOR_H
