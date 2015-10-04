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

#ifndef QMEDIARECORDER_H
#define QMEDIARECORDER_H

public import qt.QtMultimedia.qmultimedia;
public import qt.QtMultimedia.qmediaobject;
public import qt.QtMultimedia.qmediaencodersettings;
public import qt.QtMultimedia.qmediabindableinterface;
public import qt.QtMultimedia.qmediaenumdebug;

public import qt.QtCore.qpair;

QT_BEGIN_NAMESPACE

class QUrl;
class QSize;
class QAudioFormat;
QT_END_NAMESPACE

QT_BEGIN_NAMESPACE

class QMediaRecorderService;
class QAudioEncoderSettings;
class QVideoEncoderSettings;

class QMediaRecorderPrivate;
class Q_MULTIMEDIA_EXPORT QMediaRecorder : public QObject, public QMediaBindableInterface
{
    mixin Q_OBJECT;
    Q_INTERFACES(QMediaBindableInterface)
    Q_ENUMS(State)
    Q_ENUMS(Status)
    Q_ENUMS(Error)
    mixin Q_PROPERTY!(QMediaRecorder::State, "state", "READ", "state", "NOTIFY", "stateChanged");
    mixin Q_PROPERTY!(QMediaRecorder::Status, "status", "READ", "status", "NOTIFY", "statusChanged");
    mixin Q_PROPERTY!(qint64, "duration", "READ", "duration", "NOTIFY", "durationChanged");
    mixin Q_PROPERTY!(QUrl, "outputLocation", "READ", "outputLocation", "WRITE", "setOutputLocation");
    mixin Q_PROPERTY!(QUrl, "actualLocation", "READ", "actualLocation", "NOTIFY", "actualLocationChanged");
    mixin Q_PROPERTY!(bool, "muted", "READ", "isMuted", "WRITE", "setMuted", "NOTIFY", "mutedChanged");
    mixin Q_PROPERTY!(qreal, "volume", "READ", "volume", "WRITE", "setVolume", "NOTIFY", "volumeChanged");
    mixin Q_PROPERTY!(bool, "metaDataAvailable", "READ", "isMetaDataAvailable", "NOTIFY", "metaDataAvailableChanged");
    mixin Q_PROPERTY!(bool, "metaDataWritable", "READ", "isMetaDataWritable", "NOTIFY", "metaDataWritableChanged");
public:

    enum State
    {
        StoppedState,
        RecordingState,
        PausedState
    };

    enum Status {
        UnavailableStatus,
        UnloadedStatus,
        LoadingStatus,
        LoadedStatus,
        StartingStatus,
        RecordingStatus,
        PausedStatus,
        FinalizingStatus
    };

    enum Error
    {
        NoError,
        ResourceError,
        FormatError,
        OutOfSpaceError
    };

    QMediaRecorder(QMediaObject *mediaObject, QObject *parent = 0);
    ~QMediaRecorder();

    QMediaObject *mediaObject() const;

    bool isAvailable() const;
    QMultimedia::AvailabilityStatus availability() const;

    QUrl outputLocation() const;
    bool setOutputLocation(ref const(QUrl) location);

    QUrl actualLocation() const;

    State state() const;
    Status status() const;

    Error error() const;
    QString errorString() const;

    qint64 duration() const;

    bool isMuted() const;
    qreal volume() const;

    QStringList supportedContainers() const;
    QString containerDescription(ref const(QString) format) const;

    QStringList supportedAudioCodecs() const;
    QString audioCodecDescription(ref const(QString) codecName) const;

    QList<int> supportedAudioSampleRates(ref const(QAudioEncoderSettings) settings = QAudioEncoderSettings(),
                                         bool *continuous = 0) const;

    QStringList supportedVideoCodecs() const;
    QString videoCodecDescription(ref const(QString) codecName) const;

    QList<QSize> supportedResolutions(ref const(QVideoEncoderSettings) settings = QVideoEncoderSettings(),
                                      bool *continuous = 0) const;

    QList<qreal> supportedFrameRates(ref const(QVideoEncoderSettings) settings = QVideoEncoderSettings(),
                                     bool *continuous = 0) const;

    QAudioEncoderSettings audioSettings() const;
    QVideoEncoderSettings videoSettings() const;
    QString containerFormat() const;

    void setAudioSettings(ref const(QAudioEncoderSettings) audioSettings);
    void setVideoSettings(ref const(QVideoEncoderSettings) videoSettings);
    void setContainerFormat(ref const(QString) container);

    void setEncodingSettings(ref const(QAudioEncoderSettings) audioSettings,
                             ref const(QVideoEncoderSettings) videoSettings = QVideoEncoderSettings(),
                             ref const(QString) containerMimeType = QString());

    bool isMetaDataAvailable() const;
    bool isMetaDataWritable() const;

    QVariant metaData(ref const(QString) key) const;
    void setMetaData(ref const(QString) key, ref const(QVariant) value);
    QStringList availableMetaData() const;

public Q_SLOTS:
    void record();
    void pause();
    void stop();
    void setMuted(bool muted);
    void setVolume(qreal volume);

Q_SIGNALS:
    void stateChanged(QMediaRecorder::State state);
    void statusChanged(QMediaRecorder::Status status);
    void durationChanged(qint64 duration);
    void mutedChanged(bool muted);
    void volumeChanged(qreal volume);
    void actualLocationChanged(ref const(QUrl) location);

    void error(QMediaRecorder::Error error);

    void metaDataAvailableChanged(bool available);
    void metaDataWritableChanged(bool writable);
    void metaDataChanged();
    void metaDataChanged(ref const(QString) key, ref const(QVariant) value);

    void availabilityChanged(bool available);
    void availabilityChanged(QMultimedia::AvailabilityStatus availability);

protected:
    QMediaRecorder(QMediaRecorderPrivate &dd, QMediaObject *mediaObject, QObject *parent = 0);
    bool setMediaObject(QMediaObject *object);

    QMediaRecorderPrivate *d_ptr;
private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_stateChanged(QMediaRecorder::State))
    Q_PRIVATE_SLOT(d_func(), void _q_error(int, ref const(QString) ))
    Q_PRIVATE_SLOT(d_func(), void _q_serviceDestroyed())
    Q_PRIVATE_SLOT(d_func(), void _q_notify())
    Q_PRIVATE_SLOT(d_func(), void _q_updateActualLocation(ref const(QUrl) ))
    Q_PRIVATE_SLOT(d_func(), void _q_updateNotifyInterval(int))
    Q_PRIVATE_SLOT(d_func(), void _q_applySettings())
    Q_PRIVATE_SLOT(d_func(), void _q_availabilityChanged(QMultimedia::AvailabilityStatus))
};

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QMediaRecorder::State)
Q_DECLARE_METATYPE(QMediaRecorder::Status)
Q_DECLARE_METATYPE(QMediaRecorder::Error)

Q_MEDIA_ENUM_DEBUG(QMediaRecorder, State)
Q_MEDIA_ENUM_DEBUG(QMediaRecorder, Status)
Q_MEDIA_ENUM_DEBUG(QMediaRecorder, Error)

#endif  // QMEDIARECORDER_H
