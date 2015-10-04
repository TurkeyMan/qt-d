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

#ifndef QMEDIAPLAYLIST_H
#define QMEDIAPLAYLIST_H

public import qt.QtCore.qobject;

public import qt.QtMultimedia.qmediacontent;
public import qt.QtMultimedia.qmediaobject;
public import qt.QtMultimedia.qmediabindableinterface;
public import qt.QtMultimedia.qmediaenumdebug;


QT_BEGIN_NAMESPACE


class QMediaPlaylistProvider;

class QMediaPlaylistPrivate;
class Q_MULTIMEDIA_EXPORT QMediaPlaylist : public QObject, public QMediaBindableInterface
{
    mixin Q_OBJECT;
    Q_INTERFACES(QMediaBindableInterface)
    mixin Q_PROPERTY!(QMediaPlaylist::PlaybackMode, "playbackMode", "READ", "playbackMode", "WRITE", "setPlaybackMode", "NOTIFY", "playbackModeChanged");
    mixin Q_PROPERTY!(QMediaContent, "currentMedia", "READ", "currentMedia", "NOTIFY", "currentMediaChanged");
    mixin Q_PROPERTY!(int, "currentIndex", "READ", "currentIndex", "WRITE", "setCurrentIndex", "NOTIFY", "currentIndexChanged");
    Q_ENUMS(PlaybackMode Error)

public:
    enum PlaybackMode { CurrentItemOnce, CurrentItemInLoop, Sequential, Loop, Random };
    enum Error { NoError, FormatError, FormatNotSupportedError, NetworkError, AccessDeniedError };

    QMediaPlaylist(QObject *parent = 0);
    /+virtual+/ ~QMediaPlaylist();

    QMediaObject *mediaObject() const;

    PlaybackMode playbackMode() const;
    void setPlaybackMode(PlaybackMode mode);

    int currentIndex() const;
    QMediaContent currentMedia() const;

    int nextIndex(int steps = 1) const;
    int previousIndex(int steps = 1) const;

    QMediaContent media(int index) const;

    int mediaCount() const;
    bool isEmpty() const;
    bool isReadOnly() const;

    bool addMedia(ref const(QMediaContent) content);
    bool addMedia(ref const(QList<QMediaContent>) items);
    bool insertMedia(int index, ref const(QMediaContent) content);
    bool insertMedia(int index, ref const(QList<QMediaContent>) items);
    bool removeMedia(int pos);
    bool removeMedia(int start, int end);
    bool clear();

    void load(ref const(QNetworkRequest) request, const(char)* format = 0);
    void load(ref const(QUrl) location, const(char)* format = 0);
    void load(QIODevice * device, const(char)* format = 0);

    bool save(ref const(QUrl) location, const(char)* format = 0);
    bool save(QIODevice * device, const(char)* format);

    Error error() const;
    QString errorString() const;

public Q_SLOTS:
    void shuffle();

    void next();
    void previous();

    void setCurrentIndex(int index);

Q_SIGNALS:
    void currentIndexChanged(int index);
    void playbackModeChanged(QMediaPlaylist::PlaybackMode mode);
    void currentMediaChanged(ref const(QMediaContent));

    void mediaAboutToBeInserted(int start, int end);
    void mediaInserted(int start, int end);
    void mediaAboutToBeRemoved(int start, int end);
    void mediaRemoved(int start, int end);
    void mediaChanged(int start, int end);

    void loaded();
    void loadFailed();

protected:
    bool setMediaObject(QMediaObject *object);
    QMediaPlaylistPrivate *d_ptr;

private:
    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_loadFailed(QMediaPlaylist::Error, ref const(QString) ))
};

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QMediaPlaylist::PlaybackMode)
Q_DECLARE_METATYPE(QMediaPlaylist::Error)

Q_MEDIA_ENUM_DEBUG(QMediaPlaylist, PlaybackMode)
Q_MEDIA_ENUM_DEBUG(QMediaPlaylist, Error)

#endif  // QMEDIAPLAYLIST_H
