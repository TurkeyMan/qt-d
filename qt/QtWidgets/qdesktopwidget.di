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

#ifndef QDESKTOPWIDGET_H
#define QDESKTOPWIDGET_H

public import qt.QtWidgets.qwidget;

QT_BEGIN_NAMESPACE


class QApplication;
class QDesktopWidgetPrivate;

class Q_WIDGETS_EXPORT QDesktopWidget : public QWidget
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(bool, "virtualDesktop", "READ", "isVirtualDesktop");
    mixin Q_PROPERTY!(int, "screenCount", "READ", "screenCount", "NOTIFY", "screenCountChanged");
    mixin Q_PROPERTY!(int, "primaryScreen", "READ", "primaryScreen");
public:
    QDesktopWidget();
    ~QDesktopWidget();

    bool isVirtualDesktop() const;

    int numScreens() const;
    int screenCount() const;
    int primaryScreen() const;

    int screenNumber(const(QWidget)* widget = 0) const;
    int screenNumber(ref const(QPoint) ) const;

    QWidget *screen(int screen = -1);

    const QRect screenGeometry(int screen = -1) const;
    const QRect screenGeometry(const(QWidget)* widget) const;
    const QRect screenGeometry(ref const(QPoint) point) const
    { return screenGeometry(screenNumber(point)); }

    const QRect availableGeometry(int screen = -1) const;
    const QRect availableGeometry(const(QWidget)* widget) const;
    const QRect availableGeometry(ref const(QPoint) point) const
    { return availableGeometry(screenNumber(point)); }

Q_SIGNALS:
    void resized(int);
    void workAreaResized(int);
    void screenCountChanged(int);

protected:
    void resizeEvent(QResizeEvent *e);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_updateScreens())
    Q_PRIVATE_SLOT(d_func(), void _q_availableGeometryChanged())

    friend class QApplication;
    friend class QApplicationPrivate;
};

/+inline+/ int QDesktopWidget::screenCount() const
{ return numScreens(); }

QT_END_NAMESPACE

#endif // QDESKTOPWIDGET_H
