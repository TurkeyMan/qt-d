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

#ifndef QHELPSEARCHQUERYWIDGET_H
#define QHELPSEARCHQUERYWIDGET_H

public import qt.QtHelp.qhelp_global;
public import qt.QtHelp.qhelpsearchengine;

public import qt.QtCore.QMap;
public import qt.QtCore.QString;
public import qt.QtCore.QStringList;

public import qt.QtWidgets.QWidget;

QT_BEGIN_NAMESPACE


class QFocusEvent;
class QHelpSearchQueryWidgetPrivate;

class QHELP_EXPORT QHelpSearchQueryWidget : public QWidget
{
    mixin Q_OBJECT;

public:
    QHelpSearchQueryWidget(QWidget *parent = 0);
    ~QHelpSearchQueryWidget();

    void expandExtendedSearch();
    void collapseExtendedSearch();

    QList<QHelpSearchQuery> query() const;
    void setQuery(ref const(QList<QHelpSearchQuery>) queryList);

    bool isCompactMode() const;
    Q_SLOT void setCompactMode(bool on);

Q_SIGNALS:
    void search();

private:
    /+virtual+/ void focusInEvent(QFocusEvent *focusEvent);
    /+virtual+/ void changeEvent(QEvent *event);

private:
    QHelpSearchQueryWidgetPrivate *d;
};

QT_END_NAMESPACE

#endif  // QHELPSEARCHQUERYWIDGET_H
