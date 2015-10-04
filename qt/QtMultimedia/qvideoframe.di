/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Toolkit.
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

#ifndef QVIDEOFRAME_H
#define QVIDEOFRAME_H

public import qt.QtCore.qmetatype;
public import qt.QtCore.qshareddata;
public import qt.QtGui.qimage;
public import qt.QtMultimedia.qabstractvideobuffer;
public import qt.QtCore.qvariant;

QT_BEGIN_NAMESPACE

class QSize;

class QVideoFramePrivate;

class Q_MULTIMEDIA_EXPORT QVideoFrame
{
public:
    enum FieldType
    {
        ProgressiveFrame,
        TopField,
        BottomField,
        InterlacedFrame
    };

    enum PixelFormat
    {
        Format_Invalid,
        Format_ARGB32,
        Format_ARGB32_Premultiplied,
        Format_RGB32,
        Format_RGB24,
        Format_RGB565,
        Format_RGB555,
        Format_ARGB8565_Premultiplied,
        Format_BGRA32,
        Format_BGRA32_Premultiplied,
        Format_BGR32,
        Format_BGR24,
        Format_BGR565,
        Format_BGR555,
        Format_BGRA5658_Premultiplied,

        Format_AYUV444,
        Format_AYUV444_Premultiplied,
        Format_YUV444,
        Format_YUV420P,
        Format_YV12,
        Format_UYVY,
        Format_YUYV,
        Format_NV12,
        Format_NV21,
        Format_IMC1,
        Format_IMC2,
        Format_IMC3,
        Format_IMC4,
        Format_Y8,
        Format_Y16,

        Format_Jpeg,

        Format_CameraRaw,
        Format_AdobeDng,

        Format_User = 1000
    };

    QVideoFrame();
    QVideoFrame(QAbstractVideoBuffer *buffer, ref const(QSize) size, PixelFormat format);
    QVideoFrame(int bytes, ref const(QSize) size, int bytesPerLine, PixelFormat format);
    QVideoFrame(ref const(QImage) image);
    QVideoFrame(ref const(QVideoFrame) other);
    ~QVideoFrame();

    QVideoFrame &operator =(ref const(QVideoFrame) other);

    bool isValid() const;

    PixelFormat pixelFormat() const;

    QAbstractVideoBuffer::HandleType handleType() const;

    QSize size() const;
    int width() const;
    int height() const;

    FieldType fieldType() const;
    void setFieldType(FieldType);

    bool isMapped() const;
    bool isReadable() const;
    bool isWritable() const;

    QAbstractVideoBuffer::MapMode mapMode() const;

    bool map(QAbstractVideoBuffer::MapMode mode);
    void unmap();

    int bytesPerLine() const;
    int bytesPerLine(int plane) const;

    uchar *bits();
    uchar *bits(int plane);
    const(uchar)* bits() const;
    const(uchar)* bits(int plane) const;
    int mappedBytes() const;
    int planeCount() const;

    QVariant handle() const;

    qint64 startTime() const;
    void setStartTime(qint64 time);

    qint64 endTime() const;
    void setEndTime(qint64 time);

    QVariantMap availableMetaData() const;
    QVariant metaData(ref const(QString) key) const;
    void setMetaData(ref const(QString) key, ref const(QVariant) value);

    static PixelFormat pixelFormatFromImageFormat(QImage::Format format);
    static QImage::Format imageFormatFromPixelFormat(PixelFormat format);

private:
    QExplicitlySharedDataPointer<QVideoFramePrivate> d;
};

#ifndef QT_NO_DEBUG_STREAM
Q_MULTIMEDIA_EXPORT QDebug operator<<(QDebug, ref const(QVideoFrame));
Q_MULTIMEDIA_EXPORT QDebug operator<<(QDebug, QVideoFrame::FieldType);
Q_MULTIMEDIA_EXPORT QDebug operator<<(QDebug, QVideoFrame::PixelFormat);
#endif

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QVideoFrame)
Q_DECLARE_METATYPE(QVideoFrame::FieldType)
Q_DECLARE_METATYPE(QVideoFrame::PixelFormat)

#endif

