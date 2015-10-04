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


#ifndef QAUDIODEVICEINFO_H
#define QAUDIODEVICEINFO_H

public import qt.QtCore.qobject;
public import qt.QtCore.qbytearray;
public import qt.QtCore.qstring;
public import qt.QtCore.qstringlist;
public import qt.QtCore.qlist;

public import qt.QtMultimedia.qtmultimediadefs;
public import qt.QtMultimedia.qmultimedia;

public import qt.QtMultimedia.qaudio;
public import qt.QtMultimedia.qaudioformat;

QT_BEGIN_NAMESPACE


class QAudioDeviceFactory;

class QAudioDeviceInfoPrivate;
class Q_MULTIMEDIA_EXPORT QAudioDeviceInfo
{
    friend class QAudioDeviceFactory;

public:
    QAudioDeviceInfo();
    QAudioDeviceInfo(ref const(QAudioDeviceInfo) other);
    ~QAudioDeviceInfo();

    QAudioDeviceInfo& operator=(ref const(QAudioDeviceInfo) other);

    bool operator==(ref const(QAudioDeviceInfo) other) const;
    bool operator!=(ref const(QAudioDeviceInfo) other) const;

    bool isNull() const;

    QString deviceName() const;

    bool isFormatSupported(ref const(QAudioFormat) format) const;
    QAudioFormat preferredFormat() const;
    QAudioFormat nearestFormat(ref const(QAudioFormat) format) const;

    QStringList supportedCodecs() const;
    QList<int> supportedSampleRates() const;
    QList<int> supportedChannelCounts() const;
    QList<int> supportedSampleSizes() const;
    QList<QAudioFormat::Endian> supportedByteOrders() const;
    QList<QAudioFormat::SampleType> supportedSampleTypes() const;

    static QAudioDeviceInfo defaultInputDevice();
    static QAudioDeviceInfo defaultOutputDevice();

    static QList<QAudioDeviceInfo> availableDevices(QAudio::Mode mode);

private:
    QAudioDeviceInfo(ref const(QString) realm, ref const(QByteArray) handle, QAudio::Mode mode);
    QString realm() const;
    QByteArray handle() const;
    QAudio::Mode mode() const;

    QSharedDataPointer<QAudioDeviceInfoPrivate> d;
};

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QAudioDeviceInfo)

#endif // QAUDIODEVICEINFO_H
