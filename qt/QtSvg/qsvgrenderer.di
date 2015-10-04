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

#ifndef QSVGRENDERER_H
#define QSVGRENDERER_H

public import qt.QtGui.qmatrix;

#ifndef QT_NO_SVGRENDERER

public import qt.QtCore.qobject;
public import qt.QtCore.qsize;
public import qt.QtCore.qrect;
public import qt.QtCore.qxmlstream;
public import qt.QtSvg.qtsvgglobal;

QT_BEGIN_NAMESPACE


class QSvgRendererPrivate;
class QPainter;
class QByteArray;

class Q_SVG_EXPORT QSvgRenderer : public QObject
{
    mixin Q_OBJECT;

    mixin Q_PROPERTY!(QRectF, "viewBox", "READ", "viewBoxF", "WRITE", "setViewBox");
    mixin Q_PROPERTY!(int, "framesPerSecond", "READ", "framesPerSecond", "WRITE", "setFramesPerSecond");
    mixin Q_PROPERTY!(int, "currentFrame", "READ", "currentFrame", "WRITE", "setCurrentFrame");
public:
    QSvgRenderer(QObject *parent=0);
    QSvgRenderer(ref const(QString) filename, QObject *parent=0);
    QSvgRenderer(ref const(QByteArray) contents, QObject *parent=0);
    QSvgRenderer(QXmlStreamReader *contents, QObject *parent=0);
    ~QSvgRenderer();

    bool isValid() const;

    QSize defaultSize() const;

    QRect viewBox() const;
    QRectF viewBoxF() const;
    void setViewBox(ref const(QRect) viewbox);
    void setViewBox(ref const(QRectF) viewbox);

    bool animated() const;
    int framesPerSecond() const;
    void setFramesPerSecond(int num);
    int currentFrame() const;
    void setCurrentFrame(int);
    int animationDuration() const;//in seconds

    QRectF boundsOnElement(ref const(QString) id) const;
    bool elementExists(ref const(QString) id) const;
    QMatrix matrixForElement(ref const(QString) id) const;

public Q_SLOTS:
    bool load(ref const(QString) filename);
    bool load(ref const(QByteArray) contents);
    bool load(QXmlStreamReader *contents);
    void render(QPainter *p);
    void render(QPainter *p, ref const(QRectF) bounds);

    void render(QPainter *p, ref const(QString) elementId,
                ref const(QRectF) bounds=QRectF());

Q_SIGNALS:
    void repaintNeeded();

private:
    mixin Q_DECLARE_PRIVATE;
};

QT_END_NAMESPACE

#endif // QT_NO_SVGRENDERER
#endif // QSVGRENDERER_H
