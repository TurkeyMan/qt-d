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

#ifndef QMDIAREA_H
#define QMDIAREA_H

public import qt.QtWidgets.qabstractscrollarea;
public import qt.QtWidgets.qtabwidget;

QT_BEGIN_NAMESPACE


#ifndef QT_NO_MDIAREA

class QMdiSubWindow;

class QMdiAreaPrivate;
class Q_WIDGETS_EXPORT QMdiArea : public QAbstractScrollArea
{
    mixin Q_OBJECT;
    Q_ENUMS(ViewMode)
    mixin Q_PROPERTY!(QBrush, "background", "READ", "background", "WRITE", "setBackground");
    mixin Q_PROPERTY!(WindowOrder, "activationOrder", "READ", "activationOrder", "WRITE", "setActivationOrder");
    mixin Q_PROPERTY!(ViewMode, "viewMode", "READ", "viewMode", "WRITE", "setViewMode");
#ifndef QT_NO_TABBAR
    mixin Q_PROPERTY!(bool, "documentMode", "READ", "documentMode", "WRITE", "setDocumentMode");
    mixin Q_PROPERTY!(bool, "tabsClosable", "READ", "tabsClosable", "WRITE", "setTabsClosable");
    mixin Q_PROPERTY!(bool, "tabsMovable", "READ", "tabsMovable", "WRITE", "setTabsMovable");
#endif
#ifndef QT_NO_TABWIDGET
    mixin Q_PROPERTY!(QTabWidget::TabShape, "tabShape", "READ", "tabShape", "WRITE", "setTabShape");
    mixin Q_PROPERTY!(QTabWidget::TabPosition, "tabPosition", "READ", "tabPosition", "WRITE", "setTabPosition");
#endif
    Q_ENUMS(WindowOrder)
public:
    enum AreaOption {
        DontMaximizeSubWindowOnActivation = 0x1
    };
    Q_DECLARE_FLAGS(AreaOptions, AreaOption)

    enum WindowOrder {
        CreationOrder,
        StackingOrder,
        ActivationHistoryOrder
    };

    enum ViewMode {
        SubWindowView,
        TabbedView
    };

    QMdiArea(QWidget *parent = 0);
    ~QMdiArea();

    QSize sizeHint() const;
    QSize minimumSizeHint() const;

    QMdiSubWindow *currentSubWindow() const;
    QMdiSubWindow *activeSubWindow() const;
    QList<QMdiSubWindow *> subWindowList(WindowOrder order = CreationOrder) const;

    QMdiSubWindow *addSubWindow(QWidget *widget, Qt.WindowFlags flags = 0);
    void removeSubWindow(QWidget *widget);

    QBrush background() const;
    void setBackground(ref const(QBrush) background);

    WindowOrder activationOrder() const;
    void setActivationOrder(WindowOrder order);

    void setOption(AreaOption option, bool on = true);
    bool testOption(AreaOption opton) const;

    void setViewMode(ViewMode mode);
    ViewMode viewMode() const;

#ifndef QT_NO_TABBAR
    bool documentMode() const;
    void setDocumentMode(bool enabled);

    void setTabsClosable(bool closable);
    bool tabsClosable() const;

    void setTabsMovable(bool movable);
    bool tabsMovable() const;
#endif
#ifndef QT_NO_TABWIDGET
    void setTabShape(QTabWidget::TabShape shape);
    QTabWidget::TabShape tabShape() const;

    void setTabPosition(QTabWidget::TabPosition position);
    QTabWidget::TabPosition tabPosition() const;
#endif

Q_SIGNALS:
    void subWindowActivated(QMdiSubWindow *);

public Q_SLOTS:
    void setActiveSubWindow(QMdiSubWindow *window);
    void tileSubWindows();
    void cascadeSubWindows();
    void closeActiveSubWindow();
    void closeAllSubWindows();
    void activateNextSubWindow();
    void activatePreviousSubWindow();

protected Q_SLOTS:
    void setupViewport(QWidget *viewport);

protected:
    bool event(QEvent *event);
    bool eventFilter(QObject *object, QEvent *event);
    void paintEvent(QPaintEvent *paintEvent);
    void childEvent(QChildEvent *childEvent);
    void resizeEvent(QResizeEvent *resizeEvent);
    void timerEvent(QTimerEvent *timerEvent);
    void showEvent(QShowEvent *showEvent);
    bool viewportEvent(QEvent *event);
    void scrollContentsBy(int dx, int dy);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_deactivateAllWindows())
    Q_PRIVATE_SLOT(d_func(), void _q_processWindowStateChanged(Qt.WindowStates, Qt.WindowStates))
    Q_PRIVATE_SLOT(d_func(), void _q_currentTabChanged(int))
    Q_PRIVATE_SLOT(d_func(), void _q_closeTab(int))
    Q_PRIVATE_SLOT(d_func(), void _q_moveTab(int, int))
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QMdiArea::AreaOptions)

QT_END_NAMESPACE

#endif // QT_NO_MDIAREA
#endif // QMDIAREA_H
