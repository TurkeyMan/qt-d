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

#ifndef QHELPINDEXWIDGET_H
#define QHELPINDEXWIDGET_H

public import qt.QtHelp.qhelp_global;

public import qt.QtCore.QUrl;
public import qt.QtCore.QStringListModel;
public import qt.QtWidgets.QListView;

QT_BEGIN_NAMESPACE


class QHelpEnginePrivate;
class QHelpIndexModelPrivate;

class QHELP_EXPORT QHelpIndexModel : public QStringListModel
{
    mixin Q_OBJECT;

public:
    void createIndex(ref const(QString) customFilterName);
    QModelIndex filter(ref const(QString) filter,
        ref const(QString) wildcard = QString());

    QMap<QString, QUrl> linksForKeyword(ref const(QString) keyword) const;
    bool isCreatingIndex() const;

Q_SIGNALS:
    void indexCreationStarted();
    void indexCreated();

private Q_SLOTS:
    void insertIndices();
    void invalidateIndex(bool onShutDown = false);

private:
    QHelpIndexModel(QHelpEnginePrivate *helpEngine);
    ~QHelpIndexModel();

    QHelpIndexModelPrivate *d;
    friend class QHelpEnginePrivate;
};

class QHELP_EXPORT QHelpIndexWidget : public QListView
{
    mixin Q_OBJECT;

Q_SIGNALS:
    void linkActivated(ref const(QUrl) link, ref const(QString) keyword);
    void linksActivated(const QMap<QString, QUrl> &links,
        ref const(QString) keyword);

public Q_SLOTS:
    void filterIndices(ref const(QString) filter,
        ref const(QString) wildcard = QString());
    void activateCurrentItem();

private Q_SLOTS:
    void showLink(ref const(QModelIndex) index);

private:
    QHelpIndexWidget();
    friend class QHelpEngine;
};

QT_END_NAMESPACE

#endif
