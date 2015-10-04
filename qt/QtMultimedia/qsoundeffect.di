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

#ifndef QSOUNDEFFECT_H
#define QSOUNDEFFECT_H

public import qt.QtMultimedia.qtmultimediadefs;
public import qt.QtCore.qobject;
public import qt.QtCore.qurl;
public import qt.QtCore.qstringlist;


QT_BEGIN_NAMESPACE


class QSoundEffectPrivate;

class Q_MULTIMEDIA_EXPORT QSoundEffect : public QObject
{
    mixin Q_OBJECT;
    Q_CLASSINFO("DefaultMethod", "play()")
    mixin Q_PROPERTY!(QUrl, "source", "READ", "source", "WRITE", "setSource", "NOTIFY", "sourceChanged");
    mixin Q_PROPERTY!(int, "loops", "READ", "loopCount", "WRITE", "setLoopCount", "NOTIFY", "loopCountChanged");
    mixin Q_PROPERTY!(int, "loopsRemaining", "READ", "loopsRemaining", "NOTIFY", "loopsRemainingChanged");
    mixin Q_PROPERTY!(qreal, "volume", "READ", "volume", "WRITE", "setVolume", "NOTIFY", "volumeChanged");
    mixin Q_PROPERTY!(bool, "muted", "READ", "isMuted", "WRITE", "setMuted", "NOTIFY", "mutedChanged");
    mixin Q_PROPERTY!(bool, "playing", "READ", "isPlaying", "NOTIFY", "playingChanged");
    mixin Q_PROPERTY!(Status, "status", "READ", "status", "NOTIFY", "statusChanged");
    mixin Q_PROPERTY!(QString, "category", "READ", "category", "WRITE", "setCategory", "NOTIFY", "categoryChanged");
    Q_ENUMS(Loop)
    Q_ENUMS(Status)

public:
    enum Loop
    {
        Infinite = -2
    };

    enum Status
    {
        Null,
        Loading,
        Ready,
        Error
    };

    explicit QSoundEffect(QObject *parent = 0);
    ~QSoundEffect();

    static QStringList supportedMimeTypes();

    QUrl source() const;
    void setSource(ref const(QUrl) url);

    int loopCount() const;
    int loopsRemaining() const;
    void setLoopCount(int loopCount);

    qreal volume() const;
    void setVolume(qreal volume);

    bool isMuted() const;
    void setMuted(bool muted);

    bool isLoaded() const;

    bool isPlaying() const;
    Status status() const;

    QString category() const;
    void setCategory(ref const(QString) category);

Q_SIGNALS:
    void sourceChanged();
    void loopCountChanged();
    void loopsRemainingChanged();
    void volumeChanged();
    void mutedChanged();
    void loadedChanged();
    void playingChanged();
    void statusChanged();
    void categoryChanged();

public Q_SLOTS:
    void play();
    void stop();

private:
    mixin Q_DISABLE_COPY;
    QSoundEffectPrivate* d;
};

QT_END_NAMESPACE


#endif // QSOUNDEFFECT_H
