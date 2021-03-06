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

#ifndef QSCRIPTPROGRAM_H
#define QSCRIPTPROGRAM_H

public import qt.QtCore.qsharedpointer;

public import qt.QtCore.qstring;
public import qt.QtScript.qtscriptglobal;

QT_BEGIN_NAMESPACE


class QScriptProgramPrivate;
class Q_SCRIPT_EXPORT QScriptProgram
{
public:
    QScriptProgram();
    QScriptProgram(ref const(QString) sourceCode,
                   const QString fileName = QString(),
                   int firstLineNumber = 1);
    QScriptProgram(ref const(QScriptProgram) other);
    ~QScriptProgram();

    QScriptProgram &operator=(ref const(QScriptProgram) other);

    bool isNull() const;

    QString sourceCode() const;
    QString fileName() const;
    int firstLineNumber() const;

    bool operator==(ref const(QScriptProgram) other) const;
    bool operator!=(ref const(QScriptProgram) other) const;

private:
    QExplicitlySharedDataPointer<QScriptProgramPrivate> d_ptr;
    mixin Q_DECLARE_PRIVATE;
};

QT_END_NAMESPACE

#endif // QSCRIPTPROGRAM_H
