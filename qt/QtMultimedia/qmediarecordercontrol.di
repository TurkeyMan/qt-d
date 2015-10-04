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

#ifndef QMEDIARECORDERCONTROL_H
#define QMEDIARECORDERCONTROL_H

public import qt.QtMultimedia.qmediacontrol;
public import qt.QtMultimedia.qmediarecorder;

QT_BEGIN_NAMESPACE

class QUrl;
QT_END_NAMESPACE

QT_BEGIN_NAMESPACE

// Required for QDoc workaround
class QString;

class Q_MULTIMEDIA_EXPORT QMediaRecorderControl : public QMediaControl
{
    mixin Q_OBJECT;

public:
    /+virtual+/ ~QMediaRecorderControl();

    /+virtual+/ QUrl outputLocation() const = 0;
    /+virtual+/ bool setOutputLocation(ref const(QUrl) location) = 0;

    /+virtual+/ QMediaRecorder::State state() const = 0;
    /+virtual+/ QMediaRecorder::Status status() const = 0;

    /+virtual+/ qint64 duration() const = 0;

    /+virtual+/ bool isMuted() const = 0;
    /+virtual+/ qreal volume() const = 0;

    /+virtual+/ void applySettings() = 0;

Q_SIGNALS:
    void stateChanged(QMediaRecorder::State state);
    void statusChanged(QMediaRecorder::Status status);
    void durationChanged(qint64 position);
    void mutedChanged(bool muted);
    void volumeChanged(qreal volume);
    void actualLocationChanged(ref const(QUrl) location);
    void error(int error, ref const(QString) errorString);

public Q_SLOTS:
    /+virtual+/ void setState(QMediaRecorder::State state) = 0;
    /+virtual+/ void setMuted(bool muted) = 0;
    /+virtual+/ void setVolume(qreal volume) = 0;

protected:
    QMediaRecorderControl(QObject* parent = 0);
};

#define QMediaRecorderControl_iid "org.qt-project.qt.mediarecordercontrol/5.0"
Q_MEDIA_DECLARE_CONTROL(QMediaRecorderControl, QMediaRecorderControl_iid)

QT_END_NAMESPACE


#endif
