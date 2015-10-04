/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtEnginio module of the Qt Toolkit.
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

#ifndef ENGINIOMODELBASE_H
#define ENGINIOMODELBASE_H

public import qt.QtCore.qabstractitemmodel;
public import qt.QtCore.qscopedpointer;

public import qt.Enginio.enginioclientconnection;

QT_BEGIN_NAMESPACE

class EnginioBaseModelPrivate;
class ENGINIOCLIENT_EXPORT EnginioBaseModel : public QAbstractListModel
{
    mixin Q_OBJECT;

protected:
    explicit EnginioBaseModel(EnginioBaseModelPrivate &dd, QObject *parent);
public:
    ~EnginioBaseModel();

    /+virtual+/ Qt.ItemFlags flags(ref const(QModelIndex) index) const Q_DECL_OVERRIDE;
    /+virtual+/ QVariant data(ref const(QModelIndex) index, int role = Qt.DisplayRole) const Q_DECL_OVERRIDE;
    /+virtual+/ int rowCount(ref const(QModelIndex) parent = QModelIndex()) const Q_DECL_OVERRIDE;
    /+virtual+/ bool setData(ref const(QModelIndex) index, ref const(QVariant) value, int role = Qt.EditRole) Q_DECL_OVERRIDE;

    /+virtual+/ void fetchMore(ref const(QModelIndex) parent) Q_DECL_OVERRIDE;
    /+virtual+/ bool canFetchMore(ref const(QModelIndex) parent) const Q_DECL_OVERRIDE;

    /+virtual+/ QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

    void disableNotifications();

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    friend class EnginioModelPrivate;
};


QT_END_NAMESPACE


#endif // ENGINIOMODELBASE_H
