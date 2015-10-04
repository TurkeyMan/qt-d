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

#ifndef QSCREEN_H
#define QSCREEN_H

public import qt.QtCore.QList;
public import qt.QtCore.QObject;
public import qt.QtCore.QRect;
public import qt.QtCore.QSize;
public import qt.QtCore.QSizeF;

public import qt.QtGui.QTransform;

public import qt.QtCore.qnamespace;

QT_BEGIN_NAMESPACE


class QPlatformScreen;
class QScreenPrivate;
class QWindow;
class QRect;
class QPixmap;

class Q_GUI_EXPORT QScreen : public QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(int depth READ depth CONSTANT)
    mixin Q_PROPERTY!(QSize, "size", "READ", "size", "NOTIFY", "geometryChanged");
    mixin Q_PROPERTY!(QSize, "availableSize", "READ", "availableSize", "NOTIFY", "availableGeometryChanged");
    mixin Q_PROPERTY!(QSize, "virtualSize", "READ", "virtualSize", "NOTIFY", "virtualGeometryChanged");
    mixin Q_PROPERTY!(QSize, "availableVirtualSize", "READ", "availableVirtualSize", "NOTIFY", "virtualGeometryChanged");
    mixin Q_PROPERTY!(QRect, "geometry", "READ", "geometry", "NOTIFY", "geometryChanged");
    mixin Q_PROPERTY!(QRect, "availableGeometry", "READ", "availableGeometry", "NOTIFY", "availableGeometryChanged");
    mixin Q_PROPERTY!(QRect, "virtualGeometry", "READ", "virtualGeometry", "NOTIFY", "virtualGeometryChanged");
    mixin Q_PROPERTY!(QRect, "availableVirtualGeometry", "READ", "availableVirtualGeometry", "NOTIFY", "virtualGeometryChanged");
    mixin Q_PROPERTY!(QSizeF, "physicalSize", "READ", "physicalSize", "NOTIFY", "physicalSizeChanged");
    mixin Q_PROPERTY!(qreal, "physicalDotsPerInchX", "READ", "physicalDotsPerInchX", "NOTIFY", "physicalDotsPerInchChanged");
    mixin Q_PROPERTY!(qreal, "physicalDotsPerInchY", "READ", "physicalDotsPerInchY", "NOTIFY", "physicalDotsPerInchChanged");
    mixin Q_PROPERTY!(qreal, "physicalDotsPerInch", "READ", "physicalDotsPerInch", "NOTIFY", "physicalDotsPerInchChanged");
    mixin Q_PROPERTY!(qreal, "logicalDotsPerInchX", "READ", "logicalDotsPerInchX", "NOTIFY", "logicalDotsPerInchChanged");
    mixin Q_PROPERTY!(qreal, "logicalDotsPerInchY", "READ", "logicalDotsPerInchY", "NOTIFY", "logicalDotsPerInchChanged");
    mixin Q_PROPERTY!(qreal, "logicalDotsPerInch", "READ", "logicalDotsPerInch", "NOTIFY", "logicalDotsPerInchChanged");
    mixin Q_PROPERTY!(Qt.ScreenOrientation, "primaryOrientation", "READ", "primaryOrientation", "NOTIFY", "primaryOrientationChanged");
    mixin Q_PROPERTY!(Qt.ScreenOrientation, "orientation", "READ", "orientation", "NOTIFY", "orientationChanged");
    mixin Q_PROPERTY!(Qt.ScreenOrientation, "nativeOrientation", "READ", "nativeOrientation");
    mixin Q_PROPERTY!(qreal, "refreshRate", "READ", "refreshRate", "NOTIFY", "refreshRateChanged");

public:
    ~QScreen();
    QPlatformScreen *handle() const;

    QString name() const;

    int depth() const;

    QSize size() const;
    QRect geometry() const;

    QSizeF physicalSize() const;

    qreal physicalDotsPerInchX() const;
    qreal physicalDotsPerInchY() const;
    qreal physicalDotsPerInch() const;

    qreal logicalDotsPerInchX() const;
    qreal logicalDotsPerInchY() const;
    qreal logicalDotsPerInch() const;

    qreal devicePixelRatio() const;

    QSize availableSize() const;
    QRect availableGeometry() const;

    QList<QScreen *> virtualSiblings() const;

    QSize virtualSize() const;
    QRect virtualGeometry() const;

    QSize availableVirtualSize() const;
    QRect availableVirtualGeometry() const;

    Qt.ScreenOrientation primaryOrientation() const;
    Qt.ScreenOrientation orientation() const;
    Qt.ScreenOrientation nativeOrientation() const;

    Qt.ScreenOrientations orientationUpdateMask() const;
    void setOrientationUpdateMask(Qt.ScreenOrientations mask);

    int angleBetween(Qt.ScreenOrientation a, Qt.ScreenOrientation b) const;
    QTransform transformBetween(Qt.ScreenOrientation a, Qt.ScreenOrientation b, ref const(QRect) target) const;
    QRect mapBetween(Qt.ScreenOrientation a, Qt.ScreenOrientation b, ref const(QRect) rect) const;

    bool isPortrait(Qt.ScreenOrientation orientation) const;
    bool isLandscape(Qt.ScreenOrientation orientation) const;

    QPixmap grabWindow(WId window, int x = 0, int y = 0, int w = -1, int h = -1);

    qreal refreshRate() const;

Q_SIGNALS:
    void geometryChanged(ref const(QRect) geometry);
    void availableGeometryChanged(ref const(QRect) geometry);
    void physicalSizeChanged(ref const(QSizeF) size);
    void physicalDotsPerInchChanged(qreal dpi);
    void logicalDotsPerInchChanged(qreal dpi);
    void virtualGeometryChanged(ref const(QRect) rect);
    void primaryOrientationChanged(Qt.ScreenOrientation orientation);
    void orientationChanged(Qt.ScreenOrientation orientation);
    void refreshRateChanged(qreal refreshRate);

private:
    explicit QScreen(QPlatformScreen *screen);

    mixin Q_DISABLE_COPY;
    friend class QGuiApplicationPrivate;
    friend class QPlatformIntegration;
    friend class QPlatformScreen;
};

QT_END_NAMESPACE

#endif // QSCREEN_H

