/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtGui module of the Qt Toolkit.
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

public import QtCore.qabstractitemmodel;
public import QtCore.qstringlist;


#ifndef QT_NO_STRINGLISTMODEL

extern(C++) class export QStringListModel : QAbstractListModel
{
    mixin Q_OBJECT;
public:
    explicit QStringListModel(QObject *parent = 0);
    explicit QStringListModel(ref const(QStringList) strings, QObject *parent = 0);

    int rowCount(ref const(QModelIndex) parent = QModelIndex()) const;
    QModelIndex sibling(int row, int column, ref const(QModelIndex) idx) const;

    QVariant data(ref const(QModelIndex) index, int role) const;
    bool setData(ref const(QModelIndex) index, ref const(QVariant) value, int role = Qt.EditRole);

    Qt.ItemFlags flags(ref const(QModelIndex) index) const;

    bool insertRows(int row, int count, ref const(QModelIndex) parent = QModelIndex());
    bool removeRows(int row, int count, ref const(QModelIndex) parent = QModelIndex());

    void sort(int column, Qt.SortOrder order = Qt.AscendingOrder);

    QStringList stringList() const;
    void setStringList(ref const(QStringList) strings);

    Qt.DropActions supportedDropActions() const;

private:
    mixin Q_DISABLE_COPY;
    QStringList lst;
}

#endif // QT_NO_STRINGLISTMODEL

#endif // QSTRINGLISTMODEL_H
