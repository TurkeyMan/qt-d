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

#ifndef QSCRIPTSTRING_H
#define QSCRIPTSTRING_H

public import qt.QtCore.qstring;

public import qt.QtCore.qsharedpointer;
public import qt.QtScript.qtscriptglobal;

QT_BEGIN_NAMESPACE


class QScriptStringPrivate;
class Q_SCRIPT_EXPORT QScriptString
{
public:
    QScriptString();
    QScriptString(ref const(QScriptString) other);
    ~QScriptString();

    QScriptString &operator=(ref const(QScriptString) other);

    bool isValid() const;

    bool operator==(ref const(QScriptString) other) const;
    bool operator!=(ref const(QScriptString) other) const;

    quint32 toArrayIndex(bool *ok = 0) const;

    QString toString() const;
    operator QString() const;

private:
    QExplicitlySharedDataPointer<QScriptStringPrivate> d_ptr;
    friend class QScriptValue;
    mixin Q_DECLARE_PRIVATE;
};

Q_SCRIPT_EXPORT uint qHash(ref const(QScriptString) key);

QT_END_NAMESPACE

#endif // QSCRIPTSTRING_H
