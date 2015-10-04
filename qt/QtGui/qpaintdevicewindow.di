/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtGui module of the Qt Toolkit.
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

#ifndef QPAINTDEVICEWINDOW_H
#define QPAINTDEVICEWINDOW_H

public import qt.QtGui.QWindow;
public import qt.QtGui.QPaintDevice;

QT_BEGIN_NAMESPACE

class QPaintDeviceWindowPrivate;
class QPaintEvent;

class Q_GUI_EXPORT QPaintDeviceWindow : public QWindow, public QPaintDevice
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

public:
    void update(ref const(QRect) rect);
    void update(ref const(QRegion) region);

    using QWindow::width;
    using QWindow::height;
    using QWindow::devicePixelRatio;

public Q_SLOTS:
    void update();

protected:
    /+virtual+/ void paintEvent(QPaintEvent *event);

    int metric(PaintDeviceMetric metric) const Q_DECL_OVERRIDE;
    void exposeEvent(QExposeEvent *) Q_DECL_OVERRIDE;
    bool event(QEvent *event) Q_DECL_OVERRIDE;

    QPaintDeviceWindow(QPaintDeviceWindowPrivate &dd, QWindow *parent);

private:
    QPaintEngine *paintEngine() const Q_DECL_OVERRIDE;
    mixin Q_DISABLE_COPY;
};

QT_END_NAMESPACE

#endif
