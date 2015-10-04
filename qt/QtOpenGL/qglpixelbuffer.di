/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtOpenGL module of the Qt Toolkit.
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

public import QtOpenGL.qgl;
public import QtGui.qpaintdevice;


extern(C++) class QGLPixelBufferPrivate;

extern(C++) class Q_OPENGL_EXPORT QGLPixelBuffer : QPaintDevice
{
    mixin Q_DECLARE_PRIVATE;
public:
    QGLPixelBuffer(ref const(QSize) size, ref const(QGLFormat) format = QGLFormat::defaultFormat(),
                   QGLWidget *shareWidget = 0);
    QGLPixelBuffer(int width, int height, ref const(QGLFormat) format = QGLFormat::defaultFormat(),
                   QGLWidget *shareWidget = 0);
    /+virtual+/ ~QGLPixelBuffer();

    bool isValid() const;
    bool makeCurrent();
    bool doneCurrent();

    QGLContext *context() const;

    GLuint generateDynamicTexture() const;
    bool bindToDynamicTexture(GLuint texture);
    void releaseFromDynamicTexture();
    void updateDynamicTexture(GLuint texture_id) const;

    GLuint bindTexture(ref const(QImage) image, GLenum target = GL_TEXTURE_2D);
    GLuint bindTexture(ref const(QPixmap) pixmap, GLenum target = GL_TEXTURE_2D);
    GLuint bindTexture(ref const(QString) fileName);
    void deleteTexture(GLuint texture_id);

    void drawTexture(ref const(QRectF) target, GLuint textureId, GLenum textureTarget = GL_TEXTURE_2D);
    void drawTexture(ref const(QPointF) point, GLuint textureId, GLenum textureTarget = GL_TEXTURE_2D);

    QSize size() const;
    Qt.HANDLE handle() const;
    QImage toImage() const;

    QPaintEngine *paintEngine() const;
    QGLFormat format() const;

    static bool hasOpenGLPbuffers();

protected:
    int metric(PaintDeviceMetric metric) const;
    int devType() const { return QInternal::Pbuffer; }

private:
    mixin Q_DISABLE_COPY;
    QScopedPointer<QGLPixelBufferPrivate> d_ptr;
    friend extern(C++) class QGLDrawable;
    friend extern(C++) class QGLPaintDevice;
    friend extern(C++) class QGLPBufferGLPaintDevice;
    friend extern(C++) class QGLContextPrivate;
}

#endif // QGLPIXELBUFFER_H
