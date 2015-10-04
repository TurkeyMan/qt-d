/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtWidgets module of the Qt Toolkit.
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

#ifndef QDIRMODEL_H
#define QDIRMODEL_H

public import qt.QtCore.qabstractitemmodel;
public import qt.QtCore.qdir;
public import qt.QtWidgets.qfileiconprovider;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_DIRMODEL

class QDirModelPrivate;

class Q_WIDGETS_EXPORT QDirModel : public QAbstractItemModel
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(bool, "resolveSymlinks", "READ", "resolveSymlinks", "WRITE", "setResolveSymlinks");
    mixin Q_PROPERTY!(bool, "readOnly", "READ", "isReadOnly", "WRITE", "setReadOnly");
    mixin Q_PROPERTY!(bool, "lazyChildCount", "READ", "lazyChildCount", "WRITE", "setLazyChildCount");

public:
    enum Roles {
        FileIconRole = Qt.DecorationRole,
        FilePathRole = Qt.UserRole + 1,
        FileNameRole
    };

    QDirModel(ref const(QStringList) nameFilters, QDir::Filters filters,
              QDir::SortFlags sort, QObject *parent = 0);
    explicit QDirModel(QObject *parent = 0);
    ~QDirModel();

    QModelIndex index(int row, int column, ref const(QModelIndex) parent = QModelIndex()) const;
    QModelIndex parent(ref const(QModelIndex) child) const;

    int rowCount(ref const(QModelIndex) parent = QModelIndex()) const;
    int columnCount(ref const(QModelIndex) parent = QModelIndex()) const;

    QVariant data(ref const(QModelIndex) index, int role = Qt.DisplayRole) const;
    bool setData(ref const(QModelIndex) index, ref const(QVariant) value, int role = Qt.EditRole);

    QVariant headerData(int section, Qt.Orientation orientation, int role = Qt.DisplayRole) const;

    bool hasChildren(ref const(QModelIndex) index = QModelIndex()) const;
    Qt.ItemFlags flags(ref const(QModelIndex) index) const;

    void sort(int column, Qt.SortOrder order = Qt.AscendingOrder);

    QStringList mimeTypes() const;
    QMimeData *mimeData(ref const(QModelIndexList) indexes) const;
    bool dropMimeData(const(QMimeData)* data, Qt.DropAction action,
                      int row, int column, ref const(QModelIndex) parent);
    Qt.DropActions supportedDropActions() const;

    // QDirModel specific API

    void setIconProvider(QFileIconProvider *provider);
    QFileIconProvider *iconProvider() const;

    void setNameFilters(ref const(QStringList) filters);
    QStringList nameFilters() const;

    void setFilter(QDir::Filters filters);
    QDir::Filters filter() const;

    void setSorting(QDir::SortFlags sort);
    QDir::SortFlags sorting() const;

    void setResolveSymlinks(bool enable);
    bool resolveSymlinks() const;

    void setReadOnly(bool enable);
    bool isReadOnly() const;

    void setLazyChildCount(bool enable);
    bool lazyChildCount() const;

    QModelIndex index(ref const(QString) path, int column = 0) const;

    bool isDir(ref const(QModelIndex) index) const;
    QModelIndex mkdir(ref const(QModelIndex) parent, ref const(QString) name);
    bool rmdir(ref const(QModelIndex) index);
    bool remove(ref const(QModelIndex) index);

    QString filePath(ref const(QModelIndex) index) const;
    QString fileName(ref const(QModelIndex) index) const;
    QIcon fileIcon(ref const(QModelIndex) index) const;
    QFileInfo fileInfo(ref const(QModelIndex) index) const;

#ifdef Q_NO_USING_KEYWORD
    /+inline+/ QObject *parent() const { return QObject::parent(); }
#else
    using QObject::parent;
#endif

public Q_SLOTS:
    void refresh(ref const(QModelIndex) parent = QModelIndex());

protected:
    QDirModel(QDirModelPrivate &, QObject *parent = 0);
    friend class QFileDialogPrivate;

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_refresh())
};

#endif // QT_NO_DIRMODEL

QT_END_NAMESPACE

#endif // QDIRMODEL_H
