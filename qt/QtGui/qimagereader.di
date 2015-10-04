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

#ifndef QIMAGEREADER_H
#define QIMAGEREADER_H

public import qt.QtCore.qbytearray;
public import qt.QtCore.qcoreapplication;
public import qt.QtGui.qimage;
public import qt.QtGui.qimageiohandler;

QT_BEGIN_NAMESPACE


class QColor;
class QIODevice;
class QRect;
class QSize;
class QStringList;

class QImageReaderPrivate;
class Q_GUI_EXPORT QImageReader
{
    Q_DECLARE_TR_FUNCTIONS(QImageReader)
public:
    enum ImageReaderError {
        UnknownError,
        FileNotFoundError,
        DeviceError,
        UnsupportedFormatError,
        InvalidDataError
    };

    QImageReader();
    explicit QImageReader(QIODevice *device, ref const(QByteArray) format = QByteArray());
    explicit QImageReader(ref const(QString) fileName, ref const(QByteArray) format = QByteArray());
    ~QImageReader();

    void setFormat(ref const(QByteArray) format);
    QByteArray format() const;

    void setAutoDetectImageFormat(bool enabled);
    bool autoDetectImageFormat() const;

    void setDecideFormatFromContent(bool ignored);
    bool decideFormatFromContent() const;

    void setDevice(QIODevice *device);
    QIODevice *device() const;

    void setFileName(ref const(QString) fileName);
    QString fileName() const;

    QSize size() const;

    QImage::Format imageFormat() const;

    QStringList textKeys() const;
    QString text(ref const(QString) key) const;

    void setClipRect(ref const(QRect) rect);
    QRect clipRect() const;

    void setScaledSize(ref const(QSize) size);
    QSize scaledSize() const;

    void setQuality(int quality);
    int quality() const;

    void setScaledClipRect(ref const(QRect) rect);
    QRect scaledClipRect() const;

    void setBackgroundColor(ref const(QColor) color);
    QColor backgroundColor() const;

    bool supportsAnimation() const;

    QByteArray subType() const;
    QList<QByteArray> supportedSubTypes() const;

    bool canRead() const;
    QImage read();
    bool read(QImage *image);

    bool jumpToNextImage();
    bool jumpToImage(int imageNumber);
    int loopCount() const;
    int imageCount() const;
    int nextImageDelay() const;
    int currentImageNumber() const;
    QRect currentImageRect() const;

    ImageReaderError error() const;
    QString errorString() const;

    bool supportsOption(QImageIOHandler::ImageOption option) const;

    static QByteArray imageFormat(ref const(QString) fileName);
    static QByteArray imageFormat(QIODevice *device);
    static QList<QByteArray> supportedImageFormats();
    static QList<QByteArray> supportedMimeTypes();

private:
    mixin Q_DISABLE_COPY;
    QImageReaderPrivate *d;
};

QT_END_NAMESPACE

#endif // QIMAGEREADER_H
