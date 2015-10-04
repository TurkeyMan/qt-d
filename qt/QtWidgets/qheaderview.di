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

#ifndef QHEADERVIEW_H
#define QHEADERVIEW_H

public import qt.QtWidgets.qabstractitemview;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_ITEMVIEWS

class QHeaderViewPrivate;
class QStyleOptionHeader;

class Q_WIDGETS_EXPORT QHeaderView : public QAbstractItemView
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(bool, "showSortIndicator", "READ", "isSortIndicatorShown", "WRITE", "setSortIndicatorShown");
    mixin Q_PROPERTY!(bool, "highlightSections", "READ", "highlightSections", "WRITE", "setHighlightSections");
    mixin Q_PROPERTY!(bool, "stretchLastSection", "READ", "stretchLastSection", "WRITE", "setStretchLastSection");
    mixin Q_PROPERTY!(bool, "cascadingSectionResizes", "READ", "cascadingSectionResizes", "WRITE", "setCascadingSectionResizes");
    mixin Q_PROPERTY!(int, "defaultSectionSize", "READ", "defaultSectionSize", "WRITE", "setDefaultSectionSize");
    mixin Q_PROPERTY!(int, "minimumSectionSize", "READ", "minimumSectionSize", "WRITE", "setMinimumSectionSize");
    mixin Q_PROPERTY!(int, "maximumSectionSize", "READ", "maximumSectionSize", "WRITE", "setMaximumSectionSize");
    mixin Q_PROPERTY!(Qt.Alignment, "defaultAlignment", "READ", "defaultAlignment", "WRITE", "setDefaultAlignment");
    Q_ENUMS(ResizeMode)

public:

    enum ResizeMode
    {
        Interactive,
        Stretch,
        Fixed,
        ResizeToContents,
        Custom = Fixed
    };

    explicit QHeaderView(Qt.Orientation orientation, QWidget *parent = 0);
    /+virtual+/ ~QHeaderView();

    void setModel(QAbstractItemModel *model);

    Qt.Orientation orientation() const;
    int offset() const;
    int length() const;
    QSize sizeHint() const;
    void setVisible(bool v);
    int sectionSizeHint(int logicalIndex) const;

    int visualIndexAt(int position) const;
    int logicalIndexAt(int position) const;

    /+inline+/ int logicalIndexAt(int x, int y) const;
    /+inline+/ int logicalIndexAt(ref const(QPoint) pos) const;

    int sectionSize(int logicalIndex) const;
    int sectionPosition(int logicalIndex) const;
    int sectionViewportPosition(int logicalIndex) const;

    void moveSection(int from, int to);
    void swapSections(int first, int second);
    void resizeSection(int logicalIndex, int size);
    void resizeSections(QHeaderView::ResizeMode mode);

    bool isSectionHidden(int logicalIndex) const;
    void setSectionHidden(int logicalIndex, bool hide);
    int hiddenSectionCount() const;

    /+inline+/ void hideSection(int logicalIndex);
    /+inline+/ void showSection(int logicalIndex);

    int count() const;
    int visualIndex(int logicalIndex) const;
    int logicalIndex(int visualIndex) const;

    void setSectionsMovable(bool movable);
    bool sectionsMovable() const;
#if QT_DEPRECATED_SINCE(5, 0)
    /+inline+/ QT_DEPRECATED void setMovable(bool movable) { setSectionsMovable(movable); }
    /+inline+/ QT_DEPRECATED bool isMovable() const { return sectionsMovable(); }
#endif

    void setSectionsClickable(bool clickable);
    bool sectionsClickable() const;
#if QT_DEPRECATED_SINCE(5, 0)
    /+inline+/ QT_DEPRECATED void setClickable(bool clickable) { setSectionsClickable(clickable); }
    /+inline+/ QT_DEPRECATED bool isClickable() const { return sectionsClickable(); }
#endif

    void setHighlightSections(bool highlight);
    bool highlightSections() const;

    ResizeMode sectionResizeMode(int logicalIndex) const;
    void setSectionResizeMode(ResizeMode mode);
    void setSectionResizeMode(int logicalIndex, ResizeMode mode);

    void setResizeContentsPrecision(int precision);
    int  resizeContentsPrecision() const;

#if QT_DEPRECATED_SINCE(5, 0)
    /+inline+/ QT_DEPRECATED void setResizeMode(ResizeMode mode)
        { setSectionResizeMode(mode); }
    /+inline+/ QT_DEPRECATED void setResizeMode(int logicalindex, ResizeMode mode)
        { setSectionResizeMode(logicalindex, mode); }
    /+inline+/ QT_DEPRECATED ResizeMode resizeMode(int logicalindex) const
        { return sectionResizeMode(logicalindex); }
#endif

    int stretchSectionCount() const;

    void setSortIndicatorShown(bool show);
    bool isSortIndicatorShown() const;

    void setSortIndicator(int logicalIndex, Qt.SortOrder order);
    int sortIndicatorSection() const;
    Qt.SortOrder sortIndicatorOrder() const;

    bool stretchLastSection() const;
    void setStretchLastSection(bool stretch);

    bool cascadingSectionResizes() const;
    void setCascadingSectionResizes(bool enable);

    int defaultSectionSize() const;
    void setDefaultSectionSize(int size);

    int minimumSectionSize() const;
    void setMinimumSectionSize(int size);
    int maximumSectionSize() const;
    void setMaximumSectionSize(int size);

    Qt.Alignment defaultAlignment() const;
    void setDefaultAlignment(Qt.Alignment alignment);

    void doItemsLayout();
    bool sectionsMoved() const;
    bool sectionsHidden() const;

#ifndef QT_NO_DATASTREAM
    QByteArray saveState() const;
    bool restoreState(ref const(QByteArray) state);
#endif

    void reset();

public Q_SLOTS:
    void setOffset(int offset);
    void setOffsetToSectionPosition(int visualIndex);
    void setOffsetToLastSection();
    void headerDataChanged(Qt.Orientation orientation, int logicalFirst, int logicalLast);

Q_SIGNALS:
    void sectionMoved(int logicalIndex, int oldVisualIndex, int newVisualIndex);
    void sectionResized(int logicalIndex, int oldSize, int newSize);
    void sectionPressed(int logicalIndex);
    void sectionClicked(int logicalIndex);
    void sectionEntered(int logicalIndex);
    void sectionDoubleClicked(int logicalIndex);
    void sectionCountChanged(int oldCount, int newCount);
    void sectionHandleDoubleClicked(int logicalIndex);
    void geometriesChanged();
    void sortIndicatorChanged(int logicalIndex, Qt.SortOrder order);

protected Q_SLOTS:
    void updateSection(int logicalIndex);
    void resizeSections();
    void sectionsInserted(ref const(QModelIndex) parent, int logicalFirst, int logicalLast);
    void sectionsAboutToBeRemoved(ref const(QModelIndex) parent, int logicalFirst, int logicalLast);

protected:
    QHeaderView(QHeaderViewPrivate &dd, Qt.Orientation orientation, QWidget *parent = 0);
    void initialize();

    void initializeSections();
    void initializeSections(int start, int end);
    void currentChanged(ref const(QModelIndex) current, ref const(QModelIndex) old);

    bool event(QEvent *e);
    void paintEvent(QPaintEvent *e);
    void mousePressEvent(QMouseEvent *e);
    void mouseMoveEvent(QMouseEvent *e);
    void mouseReleaseEvent(QMouseEvent *e);
    void mouseDoubleClickEvent(QMouseEvent *e);
    bool viewportEvent(QEvent *e);

    /+virtual+/ void paintSection(QPainter *painter, ref const(QRect) rect, int logicalIndex) const;
    /+virtual+/ QSize sectionSizeFromContents(int logicalIndex) const;

    int horizontalOffset() const;
    int verticalOffset() const;
    void updateGeometries();
    void scrollContentsBy(int dx, int dy);

    void dataChanged(ref const(QModelIndex) topLeft, ref const(QModelIndex) bottomRight, ref const(QVector<int>) roles = QVector<int>());
    void rowsInserted(ref const(QModelIndex) parent, int start, int end);

    QRect visualRect(ref const(QModelIndex) index) const;
    void scrollTo(ref const(QModelIndex) index, ScrollHint hint);

    QModelIndex indexAt(ref const(QPoint) p) const;
    bool isIndexHidden(ref const(QModelIndex) index) const;

    QModelIndex moveCursor(CursorAction, Qt.KeyboardModifiers);
    void setSelection(ref const(QRect) rect, QItemSelectionModel::SelectionFlags flags);
    QRegion visualRegionForSelection(ref const(QItemSelection) selection) const;
    void initStyleOption(QStyleOptionHeader *option) const;

    friend class QTableView;
    friend class QTreeView;

private:
    Q_PRIVATE_SLOT(d_func(), void _q_sectionsRemoved(ref const(QModelIndex) parent, int logicalFirst, int logicalLast))
    Q_PRIVATE_SLOT(d_func(), void _q_layoutAboutToBeChanged())
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
};

/+inline+/ int QHeaderView::logicalIndexAt(int ax, int ay) const
{ return orientation() == Qt.Horizontal ? logicalIndexAt(ax) : logicalIndexAt(ay); }
/+inline+/ int QHeaderView::logicalIndexAt(ref const(QPoint) apos) const
{ return logicalIndexAt(apos.x(), apos.y()); }
/+inline+/ void QHeaderView::hideSection(int alogicalIndex)
{ setSectionHidden(alogicalIndex, true); }
/+inline+/ void QHeaderView::showSection(int alogicalIndex)
{ setSectionHidden(alogicalIndex, false); }

#endif // QT_NO_ITEMVIEWS

QT_END_NAMESPACE

#endif // QHEADERVIEW_H
