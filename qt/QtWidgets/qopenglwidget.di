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

public import qt.QtCore.qglobal;

version(QT_NO_OPENGL) {} else {

public import qt.QtWidgets.QWidget;
public import qt.QtGui.QSurfaceFormat;
public import qt.QtGui.qopengl;

extern(C++, Qt) {

class QOpenGLWidgetPrivate;

export class QOpenGLWidget : QWidget
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE!("QOpenGLWidget");

public:
    this(QWidget* parent = 0, Qt.WindowFlags f = 0);
    ~this();

    void setFormat(ref const QSurfaceFormat format);
    QSurfaceFormat format() const;

    bool isValid() const;

    void makeCurrent();
    void doneCurrent();

    QOpenGLContext *context() const;
    GLuint defaultFramebufferObject() const;

    QImage grabFramebuffer();

@signal {
    void aboutToCompose();
    void frameSwapped();
    void aboutToResize();
    void resized();
}
protected:
    /+virtual+/ void initializeGL();
    /+virtual+/ void resizeGL(int w, int h);
    /+virtual+/ void paintGL();

    override void paintEvent(QPaintEvent* e);
    override void resizeEvent(QResizeEvent* e);
    override bool event(QEvent* e);

    override int metric(QPaintDevice.PaintDeviceMetric metric) const;
    override QPaintDevice* redirected(QPoint *p) const;
    override QPaintEngine* paintEngine() const;

private:
    mixin Q_DISABLE_COPY;
}

} // QT_END_NAMESPACE

} // QT_NO_OPENGL
