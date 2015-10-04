/****************************************************************************
 **
 ** Copyright (C) 2013 Ivan Vizir <define-true-false@yandex.com>
 ** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
 ** Contact: http://www.qt-project.org/legal
 **
 ** This file is part of the QtWinExtras module of the Qt Toolkit.
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

#ifndef QWINJUMPLISTCATEGORY_H
#define QWINJUMPLISTCATEGORY_H

public import qt.QtGui.qicon;
public import qt.QtCore.qstring;
public import qt.QtCore.qstringlist;
public import qt.QtCore.qscopedpointer;
public import qt.QtWinExtras.qwinextrasglobal;

QT_BEGIN_NAMESPACE

class QWinJumpListItem;
class QWinJumpListCategoryPrivate;

class Q_WINEXTRAS_EXPORT QWinJumpListCategory
{
public:
    enum Type {
        Custom,
        Recent,
        Frequent,
        Tasks
    };

    explicit QWinJumpListCategory(ref const(QString) title = QString());
    ~QWinJumpListCategory();

    Type type() const;

    bool isVisible() const;
    void setVisible(bool visible);

    QString title() const;
    void setTitle(ref const(QString) title);

    int count() const;
    bool isEmpty() const;
    QList<QWinJumpListItem *> items() const;

    void addItem(QWinJumpListItem *item);
    QWinJumpListItem *addDestination(ref const(QString) filePath);
    QWinJumpListItem *addLink(ref const(QString) title, ref const(QString) executablePath, ref const(QStringList) arguments = QStringList());
    QWinJumpListItem *addLink(ref const(QIcon) icon, ref const(QString) title, ref const(QString) executablePath, ref const(QStringList) arguments = QStringList());
    QWinJumpListItem *addSeparator();

    void clear();

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    QScopedPointer<QWinJumpListCategoryPrivate> d_ptr;
};

QT_END_NAMESPACE

#endif // QWINJUMPLISTCATEGORY_H
