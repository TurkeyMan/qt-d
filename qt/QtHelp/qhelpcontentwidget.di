/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Assistant of the Qt Toolkit.
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

#ifndef QHELPCONTENTWIDGET_H
#define QHELPCONTENTWIDGET_H

public import qt.QtHelp.qhelp_global;

public import qt.QtCore.QQueue;
public import qt.QtCore.QString;
public import qt.QtWidgets.QTreeView;

QT_BEGIN_NAMESPACE


class QHelpEnginePrivate;
class QHelpDBReader;
class QHelpContentItemPrivate;
class QHelpContentModelPrivate;
class QHelpEngine;
class QHelpContentProvider;

class QHELP_EXPORT QHelpContentItem
{
public:
    ~QHelpContentItem();

    QHelpContentItem *child(int row) const;
    int childCount() const;
    QString title() const;
    QUrl url() const;
    int row() const;
    QHelpContentItem *parent() const;
    int childPosition(QHelpContentItem *child) const;

private:
    QHelpContentItem(ref const(QString) name, ref const(QString) link,
        QHelpDBReader *reader, QHelpContentItem *parent = 0);
    void appendChild(QHelpContentItem *child);

    QHelpContentItemPrivate *d;
    friend class QHelpContentProvider;
};

class QHELP_EXPORT QHelpContentModel : public QAbstractItemModel
{
    mixin Q_OBJECT;

public:
    ~QHelpContentModel();

    void createContents(ref const(QString) customFilterName);
    QHelpContentItem *contentItemAt(ref const(QModelIndex) index) const;

    QVariant data(ref const(QModelIndex) index, int role) const;
    QModelIndex index(int row, int column,
        ref const(QModelIndex) parent = QModelIndex()) const;
    QModelIndex parent(ref const(QModelIndex) index) const;
    int rowCount(ref const(QModelIndex) parent = QModelIndex()) const;
    int columnCount(ref const(QModelIndex) parent = QModelIndex()) const;
    bool isCreatingContents() const;

Q_SIGNALS:
    void contentsCreationStarted();
    void contentsCreated();

private Q_SLOTS:
    void insertContents();
    void invalidateContents(bool onShutDown = false);

private:
    QHelpContentModel(QHelpEnginePrivate *helpEngine);
    QHelpContentModelPrivate *d;
    friend class QHelpEnginePrivate;
};

class QHELP_EXPORT QHelpContentWidget : public QTreeView
{
    mixin Q_OBJECT;

public:
    QModelIndex indexOf(ref const(QUrl) link);

Q_SIGNALS:
    void linkActivated(ref const(QUrl) link);

private Q_SLOTS:
    void showLink(ref const(QModelIndex) index);

private:
    bool searchContentItem(QHelpContentModel *model,
        ref const(QModelIndex) parent, ref const(QString) path);
    QModelIndex m_syncIndex;

private:
    QHelpContentWidget();
    friend class QHelpEngine;
};

QT_END_NAMESPACE

#endif

