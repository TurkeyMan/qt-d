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

#ifndef QTABWIDGET_H
#define QTABWIDGET_H

public import qt.QtWidgets.qwidget;
public import qt.QtGui.qicon;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_TABWIDGET

class QTabBar;
class QTabWidgetPrivate;
class QStyleOptionTabWidgetFrame;

class Q_WIDGETS_EXPORT QTabWidget : public QWidget
{
    mixin Q_OBJECT;
    Q_ENUMS(TabPosition TabShape)
    mixin Q_PROPERTY!(TabPosition, "tabPosition", "READ", "tabPosition", "WRITE", "setTabPosition");
    mixin Q_PROPERTY!(TabShape, "tabShape", "READ", "tabShape", "WRITE", "setTabShape");
    mixin Q_PROPERTY!(int, "currentIndex", "READ", "currentIndex", "WRITE", "setCurrentIndex", "NOTIFY", "currentChanged");
    mixin Q_PROPERTY!(int, "count", "READ", "count");
    mixin Q_PROPERTY!(QSize, "iconSize", "READ", "iconSize", "WRITE", "setIconSize");
    mixin Q_PROPERTY!(Qt.TextElideMode, "elideMode", "READ", "elideMode", "WRITE", "setElideMode");
    mixin Q_PROPERTY!(bool, "usesScrollButtons", "READ", "usesScrollButtons", "WRITE", "setUsesScrollButtons");
    mixin Q_PROPERTY!(bool, "documentMode", "READ", "documentMode", "WRITE", "setDocumentMode");
    mixin Q_PROPERTY!(bool, "tabsClosable", "READ", "tabsClosable", "WRITE", "setTabsClosable");
    mixin Q_PROPERTY!(bool, "movable", "READ", "isMovable", "WRITE", "setMovable");
    mixin Q_PROPERTY!(bool, "tabBarAutoHide", "READ", "tabBarAutoHide", "WRITE", "setTabBarAutoHide");

public:
    explicit QTabWidget(QWidget *parent = 0);
    ~QTabWidget();

    int addTab(QWidget *widget, ref const(QString) );
    int addTab(QWidget *widget, ref const(QIcon) icon, ref const(QString) label);

    int insertTab(int index, QWidget *widget, ref const(QString) );
    int insertTab(int index, QWidget *widget, ref const(QIcon) icon, ref const(QString) label);

    void removeTab(int index);

    bool isTabEnabled(int index) const;
    void setTabEnabled(int index, bool);

    QString tabText(int index) const;
    void setTabText(int index, ref const(QString) );

    QIcon tabIcon(int index) const;
    void setTabIcon(int index, ref const(QIcon)  icon);

#ifndef QT_NO_TOOLTIP
    void setTabToolTip(int index, ref const(QString)  tip);
    QString tabToolTip(int index) const;
#endif

#ifndef QT_NO_WHATSTHIS
    void setTabWhatsThis(int index, ref const(QString) text);
    QString tabWhatsThis(int index) const;
#endif

    int currentIndex() const;
    QWidget *currentWidget() const;
    QWidget *widget(int index) const;
    int indexOf(QWidget *widget) const;
    int count() const;

    enum TabPosition { North, South, West, East };
    TabPosition tabPosition() const;
    void setTabPosition(TabPosition);

    bool tabsClosable() const;
    void setTabsClosable(bool closeable);

    bool isMovable() const;
    void setMovable(bool movable);

    enum TabShape { Rounded, Triangular };
    TabShape tabShape() const;
    void setTabShape(TabShape s);

    QSize sizeHint() const;
    QSize minimumSizeHint() const;
    int heightForWidth(int width) const;
    bool hasHeightForWidth() const;

    void setCornerWidget(QWidget * w, Qt.Corner corner = Qt.TopRightCorner);
    QWidget * cornerWidget(Qt.Corner corner = Qt.TopRightCorner) const;

    Qt.TextElideMode elideMode() const;
    void setElideMode(Qt.TextElideMode);

    QSize iconSize() const;
    void setIconSize(ref const(QSize) size);

    bool usesScrollButtons() const;
    void setUsesScrollButtons(bool useButtons);

    bool documentMode() const;
    void setDocumentMode(bool set);

    bool tabBarAutoHide() const;
    void setTabBarAutoHide(bool enabled);

    void clear();

    QTabBar* tabBar() const;

public Q_SLOTS:
    void setCurrentIndex(int index);
    void setCurrentWidget(QWidget *widget);

Q_SIGNALS:
    void currentChanged(int index);
    void tabCloseRequested(int index);
    void tabBarClicked(int index);
    void tabBarDoubleClicked(int index);

protected:
    /+virtual+/ void tabInserted(int index);
    /+virtual+/ void tabRemoved(int index);

    void showEvent(QShowEvent *);
    void resizeEvent(QResizeEvent *);
    void keyPressEvent(QKeyEvent *);
    void paintEvent(QPaintEvent *);
    void setTabBar(QTabBar *);
    void changeEvent(QEvent *);
    bool event(QEvent *);
    void initStyleOption(QStyleOptionTabWidgetFrame *option) const;


private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
    Q_PRIVATE_SLOT(d_func(), void _q_showTab(int))
    Q_PRIVATE_SLOT(d_func(), void _q_removeTab(int))
    Q_PRIVATE_SLOT(d_func(), void _q_tabMoved(int, int))
    void setUpLayout(bool = false);
};

#endif // QT_NO_TABWIDGET

QT_END_NAMESPACE

#endif // QTABWIDGET_H