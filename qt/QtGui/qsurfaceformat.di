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
#ifndef QSURFACEFORMAT_H
#define QSURFACEFORMAT_H

public import qt.QtCore.qglobal;
public import qt.QtCore.qpair;

QT_BEGIN_NAMESPACE


class QOpenGLContext;
class QSurfaceFormatPrivate;

class Q_GUI_EXPORT QSurfaceFormat
{
public:
    enum FormatOption {
        StereoBuffers            = 0x0001,
        DebugContext             = 0x0002,
        DeprecatedFunctions      = 0x0004
    };
    Q_DECLARE_FLAGS(FormatOptions, FormatOption)

    enum SwapBehavior {
        DefaultSwapBehavior,
        SingleBuffer,
        DoubleBuffer,
        TripleBuffer
    };

    enum RenderableType {
        DefaultRenderableType = 0x0,
        OpenGL                = 0x1,
        OpenGLES              = 0x2,
        OpenVG                = 0x4
    };

    enum OpenGLContextProfile {
        NoProfile,
        CoreProfile,
        CompatibilityProfile
    };

    QSurfaceFormat();
    /*implicit*/ QSurfaceFormat(FormatOptions options);
    QSurfaceFormat(ref const(QSurfaceFormat) other);
    QSurfaceFormat &operator=(ref const(QSurfaceFormat) other);
    ~QSurfaceFormat();

    void setDepthBufferSize(int size);
    int depthBufferSize() const;

    void setStencilBufferSize(int size);
    int stencilBufferSize() const;

    void setRedBufferSize(int size);
    int redBufferSize() const;
    void setGreenBufferSize(int size);
    int greenBufferSize() const;
    void setBlueBufferSize(int size);
    int blueBufferSize() const;
    void setAlphaBufferSize(int size);
    int alphaBufferSize() const;

    void setSamples(int numSamples);
    int samples() const;

    void setSwapBehavior(SwapBehavior behavior);
    SwapBehavior swapBehavior() const;

    bool hasAlpha() const;

    void setProfile(OpenGLContextProfile profile);
    OpenGLContextProfile profile() const;

    void setRenderableType(RenderableType type);
    RenderableType renderableType() const;

    void setMajorVersion(int majorVersion);
    int majorVersion() const;

    void setMinorVersion(int minorVersion);
    int minorVersion() const;

    QPair<int, int> version() const;
    void setVersion(int major, int minor);

    bool stereo() const;
    void setStereo(bool enable);

#if QT_DEPRECATED_SINCE(5, 2)
    QT_DEPRECATED void setOption(QSurfaceFormat::FormatOptions opt);
    QT_DEPRECATED bool testOption(QSurfaceFormat::FormatOptions opt) const;
#endif

    void setOptions(QSurfaceFormat::FormatOptions options);
    void setOption(FormatOption option, bool on = true);
    bool testOption(FormatOption option) const;
    QSurfaceFormat::FormatOptions options() const;

    int swapInterval() const;
    void setSwapInterval(int interval);

    static void setDefaultFormat(ref const(QSurfaceFormat) format);
    static QSurfaceFormat defaultFormat();

private:
    QSurfaceFormatPrivate *d;

    void detach();

    friend Q_GUI_EXPORT bool operator==(ref const(QSurfaceFormat), ref const(QSurfaceFormat));
    friend Q_GUI_EXPORT bool operator!=(ref const(QSurfaceFormat), ref const(QSurfaceFormat));
#ifndef QT_NO_DEBUG_STREAM
    friend Q_GUI_EXPORT QDebug operator<<(QDebug, ref const(QSurfaceFormat) );
#endif
};

Q_GUI_EXPORT bool operator==(ref const(QSurfaceFormat), ref const(QSurfaceFormat));
Q_GUI_EXPORT bool operator!=(ref const(QSurfaceFormat), ref const(QSurfaceFormat));

#ifndef QT_NO_DEBUG_STREAM
Q_GUI_EXPORT QDebug operator<<(QDebug, ref const(QSurfaceFormat) );
#endif

Q_DECLARE_OPERATORS_FOR_FLAGS(QSurfaceFormat::FormatOptions)

/+inline+/ bool QSurfaceFormat::stereo() const
{
    return testOption(QSurfaceFormat::StereoBuffers);
}

QT_END_NAMESPACE

#endif //QSURFACEFORMAT_H
