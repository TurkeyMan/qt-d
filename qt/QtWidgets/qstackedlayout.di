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

#ifndef QSTACKEDLAYOUT_H
#define QSTACKEDLAYOUT_H

public import qt.QtWidgets.qlayout;

QT_BEGIN_NAMESPACE


class QStackedLayoutPrivate;

class Q_WIDGETS_EXPORT QStackedLayout : public QLayout
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;
    Q_ENUMS(StackingMode)
    mixin Q_PROPERTY!(int, "currentIndex", "READ", "currentIndex", "WRITE", "setCurrentIndex", "NOTIFY", "currentChanged");
    mixin Q_PROPERTY!(StackingMode, "stackingMode", "READ", "stackingMode", "WRITE", "setStackingMode");
    QDOC_PROPERTY(int count READ count)

public:
    enum StackingMode {
        StackOne,
        StackAll
    };

    QStackedLayout();
    explicit QStackedLayout(QWidget *parent);
    explicit QStackedLayout(QLayout *parentLayout);
    ~QStackedLayout();

    int addWidget(QWidget *w);
    int insertWidget(int index, QWidget *w);

    QWidget *currentWidget() const;
    int currentIndex() const;
#ifdef Q_NO_USING_KEYWORD
    /+inline+/ QWidget *widget() { return QLayout::widget(); }
#else
    using QLayout::widget;
#endif
    QWidget *widget(int) const;
    int count() const;

    StackingMode stackingMode() const;
    void setStackingMode(StackingMode stackingMode);

    // abstract /+virtual+/ functions:
    void addItem(QLayoutItem *item);
    QSize sizeHint() const;
    QSize minimumSize() const;
    QLayoutItem *itemAt(int) const;
    QLayoutItem *takeAt(int);
    void setGeometry(ref const(QRect) rect);
    bool hasHeightForWidth() const;
    int heightForWidth(int width) const;

Q_SIGNALS:
    void widgetRemoved(int index);
    void currentChanged(int index);

public Q_SLOTS:
    void setCurrentIndex(int index);
    void setCurrentWidget(QWidget *w);

private:
    mixin Q_DISABLE_COPY;
};

QT_END_NAMESPACE

#endif // QSTACKEDLAYOUT_H
