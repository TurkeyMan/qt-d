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

#ifndef QMEDIARESOURCE_H
#define QMEDIARESOURCE_H

public import qt.QtCore.qmap;
public import qt.QtCore.qmetatype;
public import qt.QtNetwork.qnetworkrequest;

public import qt.QtMultimedia.qtmultimediadefs;

QT_BEGIN_NAMESPACE

// Class forward declaration required for QDoc bug
class QString;
class Q_MULTIMEDIA_EXPORT QMediaResource
{
public:
    QMediaResource();
    QMediaResource(ref const(QUrl) url, ref const(QString) mimeType = QString());
    QMediaResource(ref const(QNetworkRequest) request, ref const(QString) mimeType = QString());
    QMediaResource(ref const(QMediaResource) other);
    QMediaResource &operator =(ref const(QMediaResource) other);
    ~QMediaResource();

    bool isNull() const;

    bool operator ==(ref const(QMediaResource) other) const;
    bool operator !=(ref const(QMediaResource) other) const;

    QUrl url() const;
    QNetworkRequest request() const;
    QString mimeType() const;

    QString language() const;
    void setLanguage(ref const(QString) language);

    QString audioCodec() const;
    void setAudioCodec(ref const(QString) codec);

    QString videoCodec() const;
    void setVideoCodec(ref const(QString) codec);

    qint64 dataSize() const;
    void setDataSize(const qint64 size);

    int audioBitRate() const;
    void setAudioBitRate(int rate);

    int sampleRate() const;
    void setSampleRate(int frequency);

    int channelCount() const;
    void setChannelCount(int channels);

    int videoBitRate() const;
    void setVideoBitRate(int rate);

    QSize resolution() const;
    void setResolution(ref const(QSize) resolution);
    void setResolution(int width, int height);


private:
    enum Property
    {
        Url,
        Request,
        MimeType,
        Language,
        AudioCodec,
        VideoCodec,
        DataSize,
        AudioBitRate,
        VideoBitRate,
        SampleRate,
        ChannelCount,
        Resolution
    };
    QMap<int, QVariant> values;
};

typedef QList<QMediaResource> QMediaResourceList;

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QMediaResource)
Q_DECLARE_METATYPE(QMediaResourceList)

#endif
