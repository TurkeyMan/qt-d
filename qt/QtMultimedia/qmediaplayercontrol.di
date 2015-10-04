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

#ifndef QMEDIAPLAYERCONTROL_H
#define QMEDIAPLAYERCONTROL_H

public import qt.QtMultimedia.qmediacontrol;
public import qt.QtMultimedia.qmediaplayer;
public import qt.QtMultimedia.qmediatimerange;

public import qt.QtCore.qpair;

QT_BEGIN_NAMESPACE


class QMediaPlaylist;

class Q_MULTIMEDIA_EXPORT QMediaPlayerControl : public QMediaControl
{
    mixin Q_OBJECT;

public:
    ~QMediaPlayerControl();

    /+virtual+/ QMediaPlayer::State state() const = 0;

    /+virtual+/ QMediaPlayer::MediaStatus mediaStatus() const = 0;

    /+virtual+/ qint64 duration() const = 0;

    /+virtual+/ qint64 position() const = 0;
    /+virtual+/ void setPosition(qint64 position) = 0;

    /+virtual+/ int volume() const = 0;
    /+virtual+/ void setVolume(int volume) = 0;

    /+virtual+/ bool isMuted() const = 0;
    /+virtual+/ void setMuted(bool muted) = 0;

    /+virtual+/ int bufferStatus() const = 0;

    /+virtual+/ bool isAudioAvailable() const = 0;
    /+virtual+/ bool isVideoAvailable() const = 0;

    /+virtual+/ bool isSeekable() const = 0;

    /+virtual+/ QMediaTimeRange availablePlaybackRanges() const = 0;

    /+virtual+/ qreal playbackRate() const = 0;
    /+virtual+/ void setPlaybackRate(qreal rate) = 0;

    /+virtual+/ QMediaContent media() const = 0;
    /+virtual+/ const(QIODevice)* mediaStream() const = 0;
    /+virtual+/ void setMedia(ref const(QMediaContent) media, QIODevice *stream) = 0;

    /+virtual+/ void play() = 0;
    /+virtual+/ void pause() = 0;
    /+virtual+/ void stop() = 0;

Q_SIGNALS:
    void mediaChanged(ref const(QMediaContent) content);
    void durationChanged(qint64 duration);
    void positionChanged(qint64 position);
    void stateChanged(QMediaPlayer::State newState);
    void mediaStatusChanged(QMediaPlayer::MediaStatus status);
    void volumeChanged(int volume);
    void mutedChanged(bool muted);
    void audioAvailableChanged(bool audioAvailable);
    void videoAvailableChanged(bool videoAvailable);
    void bufferStatusChanged(int percentFilled);
    void seekableChanged(bool);
    void availablePlaybackRangesChanged(ref const(QMediaTimeRange));
    void playbackRateChanged(qreal rate);
    void error(int error, ref const(QString) errorString);

protected:
    QMediaPlayerControl(QObject* parent = 0);
};

#define QMediaPlayerControl_iid "org.qt-project.qt.mediaplayercontrol/5.0"
Q_MEDIA_DECLARE_CONTROL(QMediaPlayerControl, QMediaPlayerControl_iid)

QT_END_NAMESPACE


#endif  // QMEDIAPLAYERCONTROL_H
