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


#ifndef QAUDIOOUTPUT_H
#define QAUDIOOUTPUT_H

public import qt.QtCore.qiodevice;

public import qt.QtMultimedia.qtmultimediadefs;
public import qt.QtMultimedia.qmultimedia;

public import qt.QtMultimedia.qaudio;
public import qt.QtMultimedia.qaudioformat;
public import qt.QtMultimedia.qaudiodeviceinfo;


QT_BEGIN_NAMESPACE



class QAbstractAudioOutput;

class Q_MULTIMEDIA_EXPORT QAudioOutput : public QObject
{
    mixin Q_OBJECT;

public:
    explicit QAudioOutput(ref const(QAudioFormat) format = QAudioFormat(), QObject *parent = 0);
    explicit QAudioOutput(ref const(QAudioDeviceInfo) audioDeviceInfo, ref const(QAudioFormat) format = QAudioFormat(), QObject *parent = 0);
    ~QAudioOutput();

    QAudioFormat format() const;

    void start(QIODevice *device);
    QIODevice* start();

    void stop();
    void reset();
    void suspend();
    void resume();

    void setBufferSize(int bytes);
    int bufferSize() const;

    int bytesFree() const;
    int periodSize() const;

    void setNotifyInterval(int milliSeconds);
    int notifyInterval() const;

    qint64 processedUSecs() const;
    qint64 elapsedUSecs() const;

    QAudio::Error error() const;
    QAudio::State state() const;

    void setVolume(qreal);
    qreal volume() const;

    QString category() const;
    void setCategory(ref const(QString) category);

Q_SIGNALS:
    void stateChanged(QAudio::State);
    void notify();

private:
    mixin Q_DISABLE_COPY;

    QAbstractAudioOutput* d;
};

QT_END_NAMESPACE

#endif // QAUDIOOUTPUT_H
