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

#ifndef QMEDIAAUDIOPROBECONTROL_H
#define QMEDIAAUDIOPROBECONTROL_H

public import qt.QtMultimedia.qmediacontrol;

QT_BEGIN_NAMESPACE

class QAudioBuffer;
class Q_MULTIMEDIA_EXPORT QMediaAudioProbeControl : public QMediaControl
{
    mixin Q_OBJECT;
public:
    /+virtual+/ ~QMediaAudioProbeControl();

Q_SIGNALS:
    void audioBufferProbed(ref const(QAudioBuffer) buffer);
    void flush();

protected:
    explicit QMediaAudioProbeControl(QObject *parent = 0);
};

#define QMediaAudioProbeControl_iid "org.qt-project.qt.mediaaudioprobecontrol/5.0"
Q_MEDIA_DECLARE_CONTROL(QMediaAudioProbeControl, QMediaAudioProbeControl_iid)

QT_END_NAMESPACE


#endif // QMEDIAAUDIOPROBECONTROL_H
