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

#ifndef QCOLUMNVIEW_H
#define QCOLUMNVIEW_H

public import qt.QtWidgets.qabstractitemview;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_COLUMNVIEW

class QColumnViewPrivate;

class Q_WIDGETS_EXPORT QColumnView : public QAbstractItemView {

mixin Q_OBJECT;
    mixin Q_PROPERTY!(bool, "resizeGripsVisible", "READ", "resizeGripsVisible", "WRITE", "setResizeGripsVisible");

Q_SIGNALS:
    void updatePreviewWidget(ref const(QModelIndex) index);

public:
    explicit QColumnView(QWidget *parent = 0);
    ~QColumnView();

    // QAbstractItemView overloads
    QModelIndex indexAt(ref const(QPoint) point) const;
    void scrollTo(ref const(QModelIndex) index, ScrollHint hint = EnsureVisible);
    QSize sizeHint() const;
    QRect visualRect(ref const(QModelIndex) index) const;
    void setModel(QAbstractItemModel *model);
    void setSelectionModel(QItemSelectionModel * selectionModel);
    void setRootIndex(ref const(QModelIndex) index);
    void selectAll();

    // QColumnView functions
    void setResizeGripsVisible(bool visible);
    bool resizeGripsVisible() const;

    QWidget *previewWidget() const;
    void setPreviewWidget(QWidget *widget);

    void setColumnWidths(ref const(QList<int>) list);
    QList<int> columnWidths() const;

protected:
    QColumnView(QColumnViewPrivate &dd, QWidget *parent = 0);

    // QAbstractItemView overloads
    bool isIndexHidden(ref const(QModelIndex) index) const;
    QModelIndex moveCursor(CursorAction cursorAction, Qt.KeyboardModifiers modifiers);
    void resizeEvent(QResizeEvent *event);
    void setSelection(ref const(QRect)  rect, QItemSelectionModel::SelectionFlags command);
    QRegion visualRegionForSelection(ref const(QItemSelection) selection) const;
    int horizontalOffset() const;
    int verticalOffset() const;
    void rowsInserted(ref const(QModelIndex) parent, int start, int end);
    void currentChanged(ref const(QModelIndex) current, ref const(QModelIndex) previous);

    // QColumnView functions
    void scrollContentsBy(int dx, int dy);
    /+virtual+/ QAbstractItemView* createColumn(ref const(QModelIndex) rootIndex);
    void initializeColumn(QAbstractItemView *column) const;

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_gripMoved(int))
    Q_PRIVATE_SLOT(d_func(), void _q_changeCurrentColumn())
    Q_PRIVATE_SLOT(d_func(), void _q_clicked(ref const(QModelIndex) ))
};

#endif // QT_NO_COLUMNVIEW

QT_END_NAMESPACE

#endif // QCOLUMNVIEW_H

