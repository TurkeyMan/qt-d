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

#ifndef QTEXTLIST_H
#define QTEXTLIST_H

public import qt.QtGui.qtextobject;
public import qt.QtCore.qobject;

QT_BEGIN_NAMESPACE


class QTextListPrivate;
class QTextCursor;

class Q_GUI_EXPORT QTextList : public QTextBlockGroup
{
    mixin Q_OBJECT;
public:
    explicit QTextList(QTextDocument *doc);
    ~QTextList();

    int count() const;

    /+inline+/ bool isEmpty() const
    { return count() == 0; }

    QTextBlock item(int i) const;

    int itemNumber(ref const(QTextBlock) ) const;
    QString itemText(ref const(QTextBlock) ) const;

    void removeItem(int i);
    void remove(ref const(QTextBlock) );

    void add(ref const(QTextBlock) block);

    /+inline+/ void setFormat(ref const(QTextListFormat) format);
    QTextListFormat format() const { return QTextObject::format().toListFormat(); }

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

/+inline+/ void QTextList::setFormat(ref const(QTextListFormat) aformat)
{ QTextObject::setFormat(aformat); }

QT_END_NAMESPACE

#endif // QTEXTLIST_H
