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

#ifndef QFILESYSTEMMODEL_H
#define QFILESYSTEMMODEL_H

public import qt.QtCore.qabstractitemmodel;
public import qt.QtCore.qpair;
public import qt.QtCore.qdir;
public import qt.QtGui.qicon;
public import qt.QtCore.qdiriterator;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_FILESYSTEMMODEL

class ExtendedInformation;
class QFileSystemModelPrivate;
class QFileIconProvider;

class Q_WIDGETS_EXPORT QFileSystemModel : public QAbstractItemModel
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(bool, "resolveSymlinks", "READ", "resolveSymlinks", "WRITE", "setResolveSymlinks");
    mixin Q_PROPERTY!(bool, "readOnly", "READ", "isReadOnly", "WRITE", "setReadOnly");
    mixin Q_PROPERTY!(bool, "nameFilterDisables", "READ", "nameFilterDisables", "WRITE", "setNameFilterDisables");

Q_SIGNALS:
    void rootPathChanged(ref const(QString) newPath);
    void fileRenamed(ref const(QString) path, ref const(QString) oldName, ref const(QString) newName);
    void directoryLoaded(ref const(QString) path);

public:
    enum Roles {
        FileIconRole = Qt.DecorationRole,
        FilePathRole = Qt.UserRole + 1,
        FileNameRole = Qt.UserRole + 2,
        FilePermissions = Qt.UserRole + 3
    };

    explicit QFileSystemModel(QObject *parent = 0);
    ~QFileSystemModel();

    QModelIndex index(int row, int column, ref const(QModelIndex) parent = QModelIndex()) const;
    QModelIndex index(ref const(QString) path, int column = 0) const;
    QModelIndex parent(ref const(QModelIndex) child) const;
    bool hasChildren(ref const(QModelIndex) parent = QModelIndex()) const;
    bool canFetchMore(ref const(QModelIndex) parent) const;
    void fetchMore(ref const(QModelIndex) parent);

    int rowCount(ref const(QModelIndex) parent = QModelIndex()) const;
    int columnCount(ref const(QModelIndex) parent = QModelIndex()) const;

    QVariant myComputer(int role = Qt.DisplayRole) const;
    QVariant data(ref const(QModelIndex) index, int role = Qt.DisplayRole) const;
    bool setData(ref const(QModelIndex) index, ref const(QVariant) value, int role = Qt.EditRole);

    QVariant headerData(int section, Qt.Orientation orientation, int role = Qt.DisplayRole) const;

    Qt.ItemFlags flags(ref const(QModelIndex) index) const;

    void sort(int column, Qt.SortOrder order = Qt.AscendingOrder);

    QStringList mimeTypes() const;
    QMimeData *mimeData(ref const(QModelIndexList) indexes) const;
    bool dropMimeData(const(QMimeData)* data, Qt.DropAction action,
                      int row, int column, ref const(QModelIndex) parent);
    Qt.DropActions supportedDropActions() const;

    // QFileSystemModel specific API
    QModelIndex setRootPath(ref const(QString) path);
    QString rootPath() const;
    QDir rootDirectory() const;

    void setIconProvider(QFileIconProvider *provider);
    QFileIconProvider *iconProvider() const;

    void setFilter(QDir::Filters filters);
    QDir::Filters filter() const;

    void setResolveSymlinks(bool enable);
    bool resolveSymlinks() const;

    void setReadOnly(bool enable);
    bool isReadOnly() const;

    void setNameFilterDisables(bool enable);
    bool nameFilterDisables() const;

    void setNameFilters(ref const(QStringList) filters);
    QStringList nameFilters() const;

    QString filePath(ref const(QModelIndex) index) const;
    bool isDir(ref const(QModelIndex) index) const;
    qint64 size(ref const(QModelIndex) index) const;
    QString type(ref const(QModelIndex) index) const;
    QDateTime lastModified(ref const(QModelIndex) index) const;

    QModelIndex mkdir(ref const(QModelIndex) parent, ref const(QString) name);
    bool rmdir(ref const(QModelIndex) index);
    /+inline+/ QString fileName(ref const(QModelIndex) index) const;
    /+inline+/ QIcon fileIcon(ref const(QModelIndex) index) const;
    QFile::Permissions permissions(ref const(QModelIndex) index) const;
    /+inline+/ QFileInfo fileInfo(ref const(QModelIndex) index) const;
    bool remove(ref const(QModelIndex) index);

protected:
    QFileSystemModel(QFileSystemModelPrivate &, QObject *parent = 0);
    void timerEvent(QTimerEvent *event);
    bool event(QEvent *event);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    Q_PRIVATE_SLOT(d_func(), void _q_directoryChanged(ref const(QString) directory, ref const(QStringList) list))
    Q_PRIVATE_SLOT(d_func(), void _q_performDelayedSort())
    Q_PRIVATE_SLOT(d_func(), void _q_fileSystemChanged(ref const(QString) path, const QList<QPair<QString, QFileInfo> > &))
    Q_PRIVATE_SLOT(d_func(), void _q_resolvedName(ref const(QString) fileName, ref const(QString) resolvedName))

    friend class QFileDialogPrivate;
};

/+inline+/ QString QFileSystemModel::fileName(ref const(QModelIndex) aindex) const
{ return aindex.data(Qt.DisplayRole).toString(); }
/+inline+/ QIcon QFileSystemModel::fileIcon(ref const(QModelIndex) aindex) const
{ return qvariant_cast<QIcon>(aindex.data(Qt.DecorationRole)); }
/+inline+/ QFileInfo QFileSystemModel::fileInfo(ref const(QModelIndex) aindex) const
{ return QFileInfo(filePath(aindex)); }

#endif // QT_NO_FILESYSTEMMODEL

QT_END_NAMESPACE

#endif // QFILESYSTEMMODEL_H

