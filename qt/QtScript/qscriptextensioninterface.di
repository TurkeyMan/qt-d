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

#ifndef QSCRIPTEXTENSIONINTERFACE_H
#define QSCRIPTEXTENSIONINTERFACE_H

public import qt.QtCore.qfactoryinterface;

public import qt.QtCore.qobject;
public import qt.QtScript.qtscriptglobal;

QT_BEGIN_NAMESPACE


class QScriptEngine;

struct Q_SCRIPT_EXPORT QScriptExtensionInterface
    : public QFactoryInterface
{
    /+virtual+/ void initialize(ref const(QString) key, QScriptEngine *engine) = 0;
};

#define QScriptExtensionInterface_iid "org.qt-project.Qt.QScriptExtensionInterface"

Q_DECLARE_INTERFACE(QScriptExtensionInterface, QScriptExtensionInterface_iid)

QT_END_NAMESPACE

#endif // QSCRIPTEXTENSIONINTERFACE_H
