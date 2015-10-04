/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt SVG module of the Qt Toolkit.
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

#ifndef QSVGGENERATOR_H
#define QSVGGENERATOR_H

public import qt.QtGui.qpaintdevice;

#ifndef QT_NO_SVGGENERATOR

public import qt.QtCore.qnamespace;
public import qt.QtCore.qiodevice;
public import qt.QtCore.qobjectdefs;
public import qt.QtCore.qscopedpointer;
public import qt.QtSvg.qtsvgglobal;

QT_BEGIN_NAMESPACE


class QSvgGeneratorPrivate;

class Q_SVG_EXPORT QSvgGenerator : public QPaintDevice
{
    mixin Q_DECLARE_PRIVATE;

    mixin Q_PROPERTY!(QSize, "size", "READ", "size", "WRITE", "setSize");
    mixin Q_PROPERTY!(QRectF, "viewBox", "READ", "viewBoxF", "WRITE", "setViewBox");
    mixin Q_PROPERTY!(QString, "title", "READ", "title", "WRITE", "setTitle");
    mixin Q_PROPERTY!(QString, "description", "READ", "description", "WRITE", "setDescription");
    mixin Q_PROPERTY!(QString, "fileName", "READ", "fileName", "WRITE", "setFileName");
    mixin Q_PROPERTY!(QIODevice*, "outputDevice", "READ", "outputDevice", "WRITE", "setOutputDevice");
    mixin Q_PROPERTY!(int, "resolution", "READ", "resolution", "WRITE", "setResolution");
public:
    QSvgGenerator();
    ~QSvgGenerator();

    QString title() const;
    void setTitle(ref const(QString) title);

    QString description() const;
    void setDescription(ref const(QString) description);

    QSize size() const;
    void setSize(ref const(QSize) size);

    QRect viewBox() const;
    QRectF viewBoxF() const;
    void setViewBox(ref const(QRect) viewBox);
    void setViewBox(ref const(QRectF) viewBox);

    QString fileName() const;
    void setFileName(ref const(QString) fileName);

    QIODevice *outputDevice() const;
    void setOutputDevice(QIODevice *outputDevice);

    void setResolution(int dpi);
    int resolution() const;
protected:
    QPaintEngine *paintEngine() const;
    int metric(QPaintDevice::PaintDeviceMetric metric) const;

private:
    QScopedPointer<QSvgGeneratorPrivate> d_ptr;
};

QT_END_NAMESPACE

#endif // QT_NO_SVGGENERATOR
#endif // QSVGGENERATOR_H
