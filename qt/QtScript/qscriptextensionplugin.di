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

#ifndef QSCRIPTEXTENSIONPLUGIN_H
#define QSCRIPTEXTENSIONPLUGIN_H

public import qt.QtCore.qplugin;

public import qt.QtScript.qscriptextensioninterface;

QT_BEGIN_NAMESPACE


class QScriptValue;

class Q_SCRIPT_EXPORT QScriptExtensionPlugin : public QObject,
                                               public QScriptExtensionInterface
{
    mixin Q_OBJECT;
    Q_INTERFACES(QScriptExtensionInterface:QFactoryInterface)
public:
    explicit QScriptExtensionPlugin(QObject *parent = 0);
    ~QScriptExtensionPlugin();

    /+virtual+/ QStringList keys() const = 0;
    /+virtual+/ void initialize(ref const(QString) key, QScriptEngine *engine) = 0;

    QScriptValue setupPackage(ref const(QString) key, QScriptEngine *engine) const;
};

QT_END_NAMESPACE

#endif // QSCRIPTEXTENSIONPLUGIN_H