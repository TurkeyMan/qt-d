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

#ifndef CONTAINER_H
#define CONTAINER_H

public import qt.QtDesigner.extension;
public import qt.QtCore.QObject;

QT_BEGIN_NAMESPACE

class QWidget;

class QDesignerContainerExtension
{
public:
    /+virtual+/ ~QDesignerContainerExtension() {}

    /+virtual+/ int count() const = 0;
    /+virtual+/ QWidget *widget(int index) const = 0;

    /+virtual+/ int currentIndex() const = 0;
    /+virtual+/ void setCurrentIndex(int index) = 0;

    /+virtual+/ void addWidget(QWidget *widget) = 0;
    /+virtual+/ void insertWidget(int index, QWidget *widget) = 0;
    /+virtual+/ void remove(int index) = 0;

    /+virtual+/ bool canAddWidget() const
    // ### Qt6 remove body, provided in Qt5 for source compatibility to Qt4.
         { return true; }
    /+virtual+/ bool canRemove(int index) const
    // ### Qt6 remove body, provided in Qt5 for source compatibility to Qt4.
         { Q_UNUSED(index); return true; }
};
Q_DECLARE_EXTENSION_INTERFACE(QDesignerContainerExtension, "org.qt-project.Qt.Designer.Container")

QT_END_NAMESPACE

#endif // CONTAINER_H
