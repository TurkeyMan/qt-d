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

#ifndef QABSTRACTITEMDELEGATE_H
#define QABSTRACTITEMDELEGATE_H

public import qt.QtCore.qobject;
public import qt.QtWidgets.qstyleoption;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_ITEMVIEWS

class QPainter;
class QModelIndex;
class QAbstractItemModel;
class QAbstractItemView;
class QHelpEvent;

class Q_WIDGETS_EXPORT QAbstractItemDelegate : public QObject
{
    mixin Q_OBJECT;

public:

    enum EndEditHint {
        NoHint,
        EditNextItem,
        EditPreviousItem,
        SubmitModelCache,
        RevertModelCache
    };

    explicit QAbstractItemDelegate(QObject *parent = 0);
    /+virtual+/ ~QAbstractItemDelegate();

    // painting
    /+virtual+/ void paint(QPainter *painter,
                       ref const(QStyleOptionViewItem) option,
                       ref const(QModelIndex) index) const = 0;

    /+virtual+/ QSize sizeHint(ref const(QStyleOptionViewItem) option,
                           ref const(QModelIndex) index) const = 0;

    // editing
    /+virtual+/ QWidget *createEditor(QWidget *parent,
                                  ref const(QStyleOptionViewItem) option,
                                  ref const(QModelIndex) index) const;

    /+virtual+/ void destroyEditor(QWidget *editor, ref const(QModelIndex) index) const;

    /+virtual+/ void setEditorData(QWidget *editor, ref const(QModelIndex) index) const;

    /+virtual+/ void setModelData(QWidget *editor,
                              QAbstractItemModel *model,
                              ref const(QModelIndex) index) const;

    /+virtual+/ void updateEditorGeometry(QWidget *editor,
                                      ref const(QStyleOptionViewItem) option,
                                      ref const(QModelIndex) index) const;

    // for non-widget editors
    /+virtual+/ bool editorEvent(QEvent *event,
                             QAbstractItemModel *model,
                             ref const(QStyleOptionViewItem) option,
                             ref const(QModelIndex) index);

    static QString elidedText(ref const(QFontMetrics) fontMetrics, int width,
                              Qt.TextElideMode mode, ref const(QString) text);

    /+virtual+/ bool helpEvent(QHelpEvent *event,
                           QAbstractItemView *view,
                           ref const(QStyleOptionViewItem) option,
                           ref const(QModelIndex) index);

    /+virtual+/ QVector<int> paintingRoles() const;

Q_SIGNALS:
    void commitData(QWidget *editor);
    void closeEditor(QWidget *editor, QAbstractItemDelegate::EndEditHint hint = NoHint);
    void sizeHintChanged(ref const(QModelIndex) );

protected:
    QAbstractItemDelegate(QObjectPrivate &, QObject *parent = 0);
private:
    mixin Q_DISABLE_COPY;
};

#endif // QT_NO_ITEMVIEWS

QT_END_NAMESPACE

#endif // QABSTRACTITEMDELEGATE_H
