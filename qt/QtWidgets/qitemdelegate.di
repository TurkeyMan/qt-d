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

#ifndef QITEMDELEGATE_H
#define QITEMDELEGATE_H

public import qt.QtWidgets.qabstractitemdelegate;
public import qt.QtCore.qstring;
public import qt.QtGui.qpixmap;
public import qt.QtCore.qvariant;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_ITEMVIEWS

class QItemDelegatePrivate;
class QItemEditorFactory;

class Q_WIDGETS_EXPORT QItemDelegate : public QAbstractItemDelegate
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(bool, "clipping", "READ", "hasClipping", "WRITE", "setClipping");

public:
    explicit QItemDelegate(QObject *parent = 0);
    ~QItemDelegate();

    bool hasClipping() const;
    void setClipping(bool clip);

    // painting
    void paint(QPainter *painter,
               ref const(QStyleOptionViewItem) option,
               ref const(QModelIndex) index) const;
    QSize sizeHint(ref const(QStyleOptionViewItem) option,
                   ref const(QModelIndex) index) const;

    // editing
    QWidget *createEditor(QWidget *parent,
                          ref const(QStyleOptionViewItem) option,
                          ref const(QModelIndex) index) const;

    void setEditorData(QWidget *editor, ref const(QModelIndex) index) const;
    void setModelData(QWidget *editor, QAbstractItemModel *model, ref const(QModelIndex) index) const;

    void updateEditorGeometry(QWidget *editor,
                              ref const(QStyleOptionViewItem) option,
                              ref const(QModelIndex) index) const;

    // editor factory
    QItemEditorFactory *itemEditorFactory() const;
    void setItemEditorFactory(QItemEditorFactory *factory);

protected:
    /+virtual+/ void drawDisplay(QPainter *painter, ref const(QStyleOptionViewItem) option,
                             ref const(QRect) rect, ref const(QString) text) const;
    /+virtual+/ void drawDecoration(QPainter *painter, ref const(QStyleOptionViewItem) option,
                                ref const(QRect) rect, ref const(QPixmap) pixmap) const;
    /+virtual+/ void drawFocus(QPainter *painter, ref const(QStyleOptionViewItem) option,
                           ref const(QRect) rect) const;
    /+virtual+/ void drawCheck(QPainter *painter, ref const(QStyleOptionViewItem) option,
                           ref const(QRect) rect, Qt.CheckState state) const;
    void drawBackground(QPainter *painter, ref const(QStyleOptionViewItem) option,
                        ref const(QModelIndex) index) const;

    void doLayout(ref const(QStyleOptionViewItem) option,
                  QRect *checkRect, QRect *iconRect, QRect *textRect, bool hint) const;

    QRect rect(ref const(QStyleOptionViewItem) option, ref const(QModelIndex) index, int role) const;

    bool eventFilter(QObject *object, QEvent *event);
    bool editorEvent(QEvent *event, QAbstractItemModel *model,
                     ref const(QStyleOptionViewItem) option, ref const(QModelIndex) index);

    QStyleOptionViewItem setOptions(ref const(QModelIndex) index,
                                    ref const(QStyleOptionViewItem) option) const;

    QPixmap decoration(ref const(QStyleOptionViewItem) option, ref const(QVariant) variant) const;
    QPixmap *selected(ref const(QPixmap) pixmap, ref const(QPalette) palette, bool enabled) const;

    QRect doCheck(ref const(QStyleOptionViewItem) option, ref const(QRect) bounding,
                ref const(QVariant) variant) const;
    QRect textRectangle(QPainter *painter, ref const(QRect) rect,
                        ref const(QFont) font, ref const(QString) text) const;

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    Q_PRIVATE_SLOT(d_func(), void _q_commitDataAndCloseEditor(QWidget*))
};

#endif // QT_NO_ITEMVIEWS

QT_END_NAMESPACE

#endif // QITEMDELEGATE_H
