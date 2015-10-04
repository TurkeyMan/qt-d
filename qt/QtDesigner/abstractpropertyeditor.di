/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Designer of the Qt Toolkit.
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

#ifndef ABSTRACTPROPERTYEDITOR_H
#define ABSTRACTPROPERTYEDITOR_H

public import qt.QtDesigner.sdk_global;

public import qt.QtWidgets.QWidget;

QT_BEGIN_NAMESPACE

class QDesignerFormEditorInterface;
class QString;
class QVariant;

class QDESIGNER_SDK_EXPORT QDesignerPropertyEditorInterface: public QWidget
{
    mixin Q_OBJECT;
public:
    QDesignerPropertyEditorInterface(QWidget *parent, Qt.WindowFlags flags = 0);
    /+virtual+/ ~QDesignerPropertyEditorInterface();

    /+virtual+/ QDesignerFormEditorInterface *core() const;

    /+virtual+/ bool isReadOnly() const = 0;
    /+virtual+/ QObject *object() const = 0;

    /+virtual+/ QString currentPropertyName() const = 0;

Q_SIGNALS:
    void propertyChanged(ref const(QString) name, ref const(QVariant) value);

public Q_SLOTS:
    /+virtual+/ void setObject(QObject *object) = 0;
    /+virtual+/ void setPropertyValue(ref const(QString) name, ref const(QVariant) value, bool changed = true) = 0;
    /+virtual+/ void setReadOnly(bool readOnly) = 0;
};

QT_END_NAMESPACE

#endif // ABSTRACTPROPERTYEDITOR_H