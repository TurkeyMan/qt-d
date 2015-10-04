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

#ifndef QGRAPHICSGRIDLAYOUT_H
#define QGRAPHICSGRIDLAYOUT_H

public import qt.QtWidgets.qgraphicsitem;
public import qt.QtWidgets.qgraphicslayout;

QT_BEGIN_NAMESPACE


#if !defined(QT_NO_GRAPHICSVIEW)

class QGraphicsGridLayoutPrivate;

class Q_WIDGETS_EXPORT QGraphicsGridLayout : public QGraphicsLayout
{
public:
    QGraphicsGridLayout(QGraphicsLayoutItem *parent = 0);
    /+virtual+/ ~QGraphicsGridLayout();

    void addItem(QGraphicsLayoutItem *item, int row, int column, int rowSpan, int columnSpan,
                   Qt.Alignment alignment = 0);
    /+inline+/ void addItem(QGraphicsLayoutItem *item, int row, int column, Qt.Alignment alignment = 0);

    void setHorizontalSpacing(qreal spacing);
    qreal horizontalSpacing() const;
    void setVerticalSpacing(qreal spacing);
    qreal verticalSpacing() const;
    void setSpacing(qreal spacing);

    void setRowSpacing(int row, qreal spacing);
    qreal rowSpacing(int row) const;
    void setColumnSpacing(int column, qreal spacing);
    qreal columnSpacing(int column) const;

    void setRowStretchFactor(int row, int stretch);
    int rowStretchFactor(int row) const;
    void setColumnStretchFactor(int column, int stretch);
    int columnStretchFactor(int column) const;

    void setRowMinimumHeight(int row, qreal height);
    qreal rowMinimumHeight(int row) const;
    void setRowPreferredHeight(int row, qreal height);
    qreal rowPreferredHeight(int row) const;
    void setRowMaximumHeight(int row, qreal height);
    qreal rowMaximumHeight(int row) const;
    void setRowFixedHeight(int row, qreal height);

    void setColumnMinimumWidth(int column, qreal width);
    qreal columnMinimumWidth(int column) const;
    void setColumnPreferredWidth(int column, qreal width);
    qreal columnPreferredWidth(int column) const;
    void setColumnMaximumWidth(int column, qreal width);
    qreal columnMaximumWidth(int column) const;
    void setColumnFixedWidth(int column, qreal width);

    void setRowAlignment(int row, Qt.Alignment alignment);
    Qt.Alignment rowAlignment(int row) const;
    void setColumnAlignment(int column, Qt.Alignment alignment);
    Qt.Alignment columnAlignment(int column) const;

    void setAlignment(QGraphicsLayoutItem *item, Qt.Alignment alignment);
    Qt.Alignment alignment(QGraphicsLayoutItem *item) const;

    int rowCount() const;
    int columnCount() const;

    QGraphicsLayoutItem *itemAt(int row, int column) const;

    // inherited from QGraphicsLayout
    int count() const;
    QGraphicsLayoutItem *itemAt(int index) const;
    void removeAt(int index);
    void removeItem(QGraphicsLayoutItem *item);

    void invalidate();

    // inherited from QGraphicsLayoutItem
    void setGeometry(ref const(QRectF) rect);
    QSizeF sizeHint(Qt.SizeHint which, ref const(QSizeF) constraint = QSizeF()) const;

    // ####
    //QRect cellRect(int row, int column, int rowSpan = 1, int columnSpan = 1) const;
    //QSizePolicy::ControlTypes controlTypes(LayoutSide side) const;

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

/+inline+/ void QGraphicsGridLayout::addItem(QGraphicsLayoutItem *aitem, int arow, int acolumn, Qt.Alignment aalignment)
{ addItem(aitem, arow, acolumn, 1, 1, aalignment); }

#endif

QT_END_NAMESPACE

#endif
