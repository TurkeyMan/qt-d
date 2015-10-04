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

#ifndef QTABBAR_H
#define QTABBAR_H

public import qt.QtWidgets.qwidget;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_TABBAR

class QIcon;
class QTabBarPrivate;
class QStyleOptionTab;

class Q_WIDGETS_EXPORT QTabBar: public QWidget
{
    mixin Q_OBJECT;

    Q_ENUMS(Shape)
    mixin Q_PROPERTY!(Shape, "shape", "READ", "shape", "WRITE", "setShape");
    mixin Q_PROPERTY!(int, "currentIndex", "READ", "currentIndex", "WRITE", "setCurrentIndex", "NOTIFY", "currentChanged");
    mixin Q_PROPERTY!(int, "count", "READ", "count");
    mixin Q_PROPERTY!(bool, "drawBase", "READ", "drawBase", "WRITE", "setDrawBase");
    mixin Q_PROPERTY!(QSize, "iconSize", "READ", "iconSize", "WRITE", "setIconSize");
    mixin Q_PROPERTY!(Qt.TextElideMode, "elideMode", "READ", "elideMode", "WRITE", "setElideMode");
    mixin Q_PROPERTY!(bool, "usesScrollButtons", "READ", "usesScrollButtons", "WRITE", "setUsesScrollButtons");
    mixin Q_PROPERTY!(bool, "tabsClosable", "READ", "tabsClosable", "WRITE", "setTabsClosable");
    mixin Q_PROPERTY!(SelectionBehavior, "selectionBehaviorOnRemove", "READ", "selectionBehaviorOnRemove", "WRITE", "setSelectionBehaviorOnRemove");
    mixin Q_PROPERTY!(bool, "expanding", "READ", "expanding", "WRITE", "setExpanding");
    mixin Q_PROPERTY!(bool, "movable", "READ", "isMovable", "WRITE", "setMovable");
    mixin Q_PROPERTY!(bool, "documentMode", "READ", "documentMode", "WRITE", "setDocumentMode");
    mixin Q_PROPERTY!(bool, "autoHide", "READ", "autoHide", "WRITE", "setAutoHide");
    mixin Q_PROPERTY!(bool, "changeCurrentOnDrag", "READ", "changeCurrentOnDrag", "WRITE", "setChangeCurrentOnDrag");

public:
    explicit QTabBar(QWidget* parent=0);
    ~QTabBar();

    enum Shape { RoundedNorth, RoundedSouth, RoundedWest, RoundedEast,
                 TriangularNorth, TriangularSouth, TriangularWest, TriangularEast
    };

    enum ButtonPosition {
        LeftSide,
        RightSide
    };

    enum SelectionBehavior {
        SelectLeftTab,
        SelectRightTab,
        SelectPreviousTab
    };

    Shape shape() const;
    void setShape(Shape shape);

    int addTab(ref const(QString) text);
    int addTab(ref const(QIcon) icon, ref const(QString) text);

    int insertTab(int index, ref const(QString) text);
    int insertTab(int index, ref const(QIcon)icon, ref const(QString) text);

    void removeTab(int index);
    void moveTab(int from, int to);

    bool isTabEnabled(int index) const;
    void setTabEnabled(int index, bool);

    QString tabText(int index) const;
    void setTabText(int index, ref const(QString) text);

    QColor tabTextColor(int index) const;
    void setTabTextColor(int index, ref const(QColor) color);

    QIcon tabIcon(int index) const;
    void setTabIcon(int index, ref const(QIcon) icon);

    Qt.TextElideMode elideMode() const;
    void setElideMode(Qt.TextElideMode);

#ifndef QT_NO_TOOLTIP
    void setTabToolTip(int index, ref const(QString) tip);
    QString tabToolTip(int index) const;
#endif

#ifndef QT_NO_WHATSTHIS
    void setTabWhatsThis(int index, ref const(QString) text);
    QString tabWhatsThis(int index) const;
#endif

    void setTabData(int index, ref const(QVariant) data);
    QVariant tabData(int index) const;

    QRect tabRect(int index) const;
    int tabAt(ref const(QPoint) pos) const;

    int currentIndex() const;
    int count() const;

    QSize sizeHint() const;
    QSize minimumSizeHint() const;

    void setDrawBase(bool drawTheBase);
    bool drawBase() const;

    QSize iconSize() const;
    void setIconSize(ref const(QSize) size);

    bool usesScrollButtons() const;
    void setUsesScrollButtons(bool useButtons);

    bool tabsClosable() const;
    void setTabsClosable(bool closable);

    void setTabButton(int index, ButtonPosition position, QWidget *widget);
    QWidget *tabButton(int index, ButtonPosition position) const;

    SelectionBehavior selectionBehaviorOnRemove() const;
    void setSelectionBehaviorOnRemove(SelectionBehavior behavior);

    bool expanding() const;
    void setExpanding(bool enabled);

    bool isMovable() const;
    void setMovable(bool movable);

    bool documentMode() const;
    void setDocumentMode(bool set);

    bool autoHide() const;
    void setAutoHide(bool hide);

    bool changeCurrentOnDrag() const;
    void setChangeCurrentOnDrag(bool change);

public Q_SLOTS:
    void setCurrentIndex(int index);

Q_SIGNALS:
    void currentChanged(int index);
    void tabCloseRequested(int index);
    void tabMoved(int from, int to);
    void tabBarClicked(int index);
    void tabBarDoubleClicked(int index);

protected:
    /+virtual+/ QSize tabSizeHint(int index) const;
    /+virtual+/ QSize minimumTabSizeHint(int index) const;
    /+virtual+/ void tabInserted(int index);
    /+virtual+/ void tabRemoved(int index);
    /+virtual+/ void tabLayoutChange();

    bool event(QEvent *);
    void resizeEvent(QResizeEvent *);
    void showEvent(QShowEvent *);
    void hideEvent(QHideEvent *);
    void paintEvent(QPaintEvent *);
    void mousePressEvent (QMouseEvent *);
    void mouseMoveEvent (QMouseEvent *);
    void mouseReleaseEvent (QMouseEvent *);
#ifndef QT_NO_WHEELEVENT
    void wheelEvent(QWheelEvent *event);
#endif
    void keyPressEvent(QKeyEvent *);
    void changeEvent(QEvent *);
    void timerEvent(QTimerEvent *event);
    void initStyleOption(QStyleOptionTab *option, int tabIndex) const;

#ifndef QT_NO_ACCESSIBILITY
    friend class QAccessibleTabBar;
#endif
private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_scrollTabs())
    Q_PRIVATE_SLOT(d_func(), void _q_closeTab())
};

#endif // QT_NO_TABBAR

QT_END_NAMESPACE

#endif // QTABBAR_H
