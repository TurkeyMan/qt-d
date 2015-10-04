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

#ifndef QMEDIAENCODERSETTINGS_H
#define QMEDIAENCODERSETTINGS_H

public import qt.QtCore.qsharedpointer;
public import qt.QtCore.qstring;
public import qt.QtCore.qsize;
public import qt.QtCore.qvariant;
public import qt.QtMultimedia.qtmultimediadefs;
public import qt.QtMultimedia.qmultimedia;

QT_BEGIN_NAMESPACE



class QAudioEncoderSettingsPrivate;
class Q_MULTIMEDIA_EXPORT QAudioEncoderSettings
{
public:
    QAudioEncoderSettings();
    QAudioEncoderSettings(ref const(QAudioEncoderSettings) other);

    ~QAudioEncoderSettings();

    QAudioEncoderSettings& operator=(ref const(QAudioEncoderSettings) other);
    bool operator==(ref const(QAudioEncoderSettings) other) const;
    bool operator!=(ref const(QAudioEncoderSettings) other) const;

    bool isNull() const;

    QMultimedia::EncodingMode encodingMode() const;
    void setEncodingMode(QMultimedia::EncodingMode);

    QString codec() const;
    void setCodec(ref const(QString) codec);

    int bitRate() const;
    void setBitRate(int bitrate);

    int channelCount() const;
    void setChannelCount(int channels);

    int sampleRate() const;
    void setSampleRate(int rate);

    QMultimedia::EncodingQuality quality() const;
    void setQuality(QMultimedia::EncodingQuality quality);

    QVariant encodingOption(ref const(QString) option) const;
    QVariantMap encodingOptions() const;
    void setEncodingOption(ref const(QString) option, ref const(QVariant) value);
    void setEncodingOptions(ref const(QVariantMap) options);

private:
    QSharedDataPointer<QAudioEncoderSettingsPrivate> d;
};

class QVideoEncoderSettingsPrivate;
class Q_MULTIMEDIA_EXPORT QVideoEncoderSettings
{
public:
    QVideoEncoderSettings();
    QVideoEncoderSettings(ref const(QVideoEncoderSettings) other);

    ~QVideoEncoderSettings();

    QVideoEncoderSettings& operator=(ref const(QVideoEncoderSettings) other);
    bool operator==(ref const(QVideoEncoderSettings) other) const;
    bool operator!=(ref const(QVideoEncoderSettings) other) const;

    bool isNull() const;

    QMultimedia::EncodingMode encodingMode() const;
    void setEncodingMode(QMultimedia::EncodingMode);

    QString codec() const;
    void setCodec(ref const(QString) );

    QSize resolution() const;
    void setResolution(ref const(QSize) );
    void setResolution(int width, int height);

    qreal frameRate() const;
    void setFrameRate(qreal rate);

    int bitRate() const;
    void setBitRate(int bitrate);

    QMultimedia::EncodingQuality quality() const;
    void setQuality(QMultimedia::EncodingQuality quality);

    QVariant encodingOption(ref const(QString) option) const;
    QVariantMap encodingOptions() const;
    void setEncodingOption(ref const(QString) option, ref const(QVariant) value);
    void setEncodingOptions(ref const(QVariantMap) options);

private:
    QSharedDataPointer<QVideoEncoderSettingsPrivate> d;
};

class QImageEncoderSettingsPrivate;
class Q_MULTIMEDIA_EXPORT QImageEncoderSettings
{
public:
    QImageEncoderSettings();
    QImageEncoderSettings(ref const(QImageEncoderSettings) other);

    ~QImageEncoderSettings();

    QImageEncoderSettings& operator=(ref const(QImageEncoderSettings) other);
    bool operator==(ref const(QImageEncoderSettings) other) const;
    bool operator!=(ref const(QImageEncoderSettings) other) const;

    bool isNull() const;

    QString codec() const;
    void setCodec(ref const(QString) );

    QSize resolution() const;
    void setResolution(ref const(QSize) );
    void setResolution(int width, int height);

    QMultimedia::EncodingQuality quality() const;
    void setQuality(QMultimedia::EncodingQuality quality);

    QVariant encodingOption(ref const(QString) option) const;
    QVariantMap encodingOptions() const;
    void setEncodingOption(ref const(QString) option, ref const(QVariant) value);
    void setEncodingOptions(ref const(QVariantMap) options);

private:
    QSharedDataPointer<QImageEncoderSettingsPrivate> d;
};

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QAudioEncoderSettings)
Q_DECLARE_METATYPE(QVideoEncoderSettings)
Q_DECLARE_METATYPE(QImageEncoderSettings)


#endif
