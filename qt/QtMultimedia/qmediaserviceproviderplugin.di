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

#ifndef QMEDIASERVICEPROVIDERPLUGIN_H
#define QMEDIASERVICEPROVIDERPLUGIN_H

public import qt.QtCore.qstringlist;
public import qt.QtCore.qplugin;
public import qt.QtMultimedia.qmultimedia;
public import qt.QtMultimedia.qtmultimediadefs;
public import qt.QtMultimedia.qcamera;

#ifdef Q_MOC_RUN
# pragma Q_MOC_EXPAND_MACROS
#endif

QT_BEGIN_NAMESPACE

// Required for QDoc workaround
class QString;

class QMediaService;

class QMediaServiceProviderHintPrivate;
class Q_MULTIMEDIA_EXPORT QMediaServiceProviderHint
{
public:
    enum Type { Null, ContentType, Device, SupportedFeatures, CameraPosition };

    enum Feature {
        LowLatencyPlayback = 0x01,
        RecordingSupport = 0x02,
        StreamPlayback = 0x04,
        VideoSurface = 0x08
    };
    Q_DECLARE_FLAGS(Features, Feature)

    QMediaServiceProviderHint();
    QMediaServiceProviderHint(ref const(QString) mimeType, ref const(QStringList) codecs);
    QMediaServiceProviderHint(ref const(QByteArray) device);
    QMediaServiceProviderHint(QCamera::Position position);
    QMediaServiceProviderHint(Features features);
    QMediaServiceProviderHint(ref const(QMediaServiceProviderHint) other);
    ~QMediaServiceProviderHint();

    QMediaServiceProviderHint& operator=(ref const(QMediaServiceProviderHint) other);

    bool operator == (ref const(QMediaServiceProviderHint) other) const;
    bool operator != (ref const(QMediaServiceProviderHint) other) const;

    bool isNull() const;

    Type type() const;

    QString mimeType() const;
    QStringList codecs() const;

    QByteArray device() const;
    QCamera::Position cameraPosition() const;

    Features features() const;

    //to be extended, if necessary

private:
    QSharedDataPointer<QMediaServiceProviderHintPrivate> d;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QMediaServiceProviderHint::Features)

// Required for QDoc workaround
class QString;

struct Q_MULTIMEDIA_EXPORT QMediaServiceProviderFactoryInterface
{
    /+virtual+/ QMediaService* create(QString const& key) = 0;
    /+virtual+/ void release(QMediaService *service) = 0;
    /+virtual+/ ~QMediaServiceProviderFactoryInterface();
};

#define QMediaServiceProviderFactoryInterface_iid \
    "org.qt-project.qt.mediaserviceproviderfactory/5.0"
Q_DECLARE_INTERFACE(QMediaServiceProviderFactoryInterface, QMediaServiceProviderFactoryInterface_iid)

// Required for QDoc workaround
class QString;

struct Q_MULTIMEDIA_EXPORT QMediaServiceSupportedFormatsInterface
{
    /+virtual+/ ~QMediaServiceSupportedFormatsInterface() {}
    /+virtual+/ QMultimedia::SupportEstimate hasSupport(ref const(QString) mimeType, ref const(QStringList) codecs) const = 0;
    /+virtual+/ QStringList supportedMimeTypes() const = 0;
};

#define QMediaServiceSupportedFormatsInterface_iid \
    "org.qt-project.qt.mediaservicesupportedformats/5.0"
Q_DECLARE_INTERFACE(QMediaServiceSupportedFormatsInterface, QMediaServiceSupportedFormatsInterface_iid)

// Required for QDoc workaround
class QString;

struct Q_MULTIMEDIA_EXPORT QMediaServiceSupportedDevicesInterface
{
    /+virtual+/ ~QMediaServiceSupportedDevicesInterface() {}
    /+virtual+/ QList<QByteArray> devices(ref const(QByteArray) service) const = 0;
    /+virtual+/ QString deviceDescription(ref const(QByteArray) service, ref const(QByteArray) device) = 0;
};

#define QMediaServiceSupportedDevicesInterface_iid \
    "org.qt-project.qt.mediaservicesupporteddevices/5.0"
Q_DECLARE_INTERFACE(QMediaServiceSupportedDevicesInterface, QMediaServiceSupportedDevicesInterface_iid)

// This should be part of QMediaServiceSupportedDevicesInterface but it can't in order
// to preserve binary compatibility with 5.2 and earlier.
// The whole media service plugin API shouldn't even be public in the first place. It should
// be made private in Qt 6.0 and QMediaServiceDefaultDeviceInterface should be merged with
// QMediaServiceSupportedDevicesInterface
struct Q_MULTIMEDIA_EXPORT QMediaServiceDefaultDeviceInterface
{
    /+virtual+/ ~QMediaServiceDefaultDeviceInterface() {}
    /+virtual+/ QByteArray defaultDevice(ref const(QByteArray) service) const = 0;
};

#define QMediaServiceDefaultDeviceInterface_iid \
    "org.qt-project.qt.mediaservicedefaultdevice/5.3"
Q_DECLARE_INTERFACE(QMediaServiceDefaultDeviceInterface, QMediaServiceDefaultDeviceInterface_iid)

struct Q_MULTIMEDIA_EXPORT QMediaServiceCameraInfoInterface
{
    /+virtual+/ ~QMediaServiceCameraInfoInterface() {}
    /+virtual+/ QCamera::Position cameraPosition(ref const(QByteArray) device) const = 0;
    /+virtual+/ int cameraOrientation(ref const(QByteArray) device) const = 0;
};

#define QMediaServiceCameraInfoInterface_iid \
    "org.qt-project.qt.mediaservicecamerainfo/5.3"
Q_DECLARE_INTERFACE(QMediaServiceCameraInfoInterface, QMediaServiceCameraInfoInterface_iid)

// Required for QDoc workaround
class QString;

struct Q_MULTIMEDIA_EXPORT QMediaServiceFeaturesInterface
{
    /+virtual+/ ~QMediaServiceFeaturesInterface() {}
    /+virtual+/ QMediaServiceProviderHint::Features supportedFeatures(ref const(QByteArray) service) const = 0;
};


#define QMediaServiceFeaturesInterface_iid \
    "org.qt-project.qt.mediaservicefeatures/5.0"
Q_DECLARE_INTERFACE(QMediaServiceFeaturesInterface, QMediaServiceFeaturesInterface_iid)

// Required for QDoc workaround
class QString;

class Q_MULTIMEDIA_EXPORT QMediaServiceProviderPlugin : public QObject, public QMediaServiceProviderFactoryInterface
{
    mixin Q_OBJECT;
    Q_INTERFACES(QMediaServiceProviderFactoryInterface)

public:
    /+virtual+/ QMediaService* create(ref const(QString) key) = 0;
    /+virtual+/ void release(QMediaService *service) = 0;
};

/*!
    Service with support for media playback
    Required Controls: QMediaPlayerControl
    Optional Controls: QMediaPlaylistControl, QAudioDeviceControl
    Video Output Controls (used by QWideoWidget and QGraphicsVideoItem):
                        Required: QVideoOutputControl
                        Optional: QVideoWindowControl, QVideoRendererControl, QVideoWidgetControl
*/
#define Q_MEDIASERVICE_MEDIAPLAYER "org.qt-project.qt.mediaplayer"

/*!
   Service with support for recording from audio sources
   Required Controls: QAudioDeviceControl
   Recording Controls (QMediaRecorder):
                        Required: QMediaRecorderControl
                        Recommended: QAudioEncoderSettingsControl
                        Optional: QMediaContainerControl
*/
#define Q_MEDIASERVICE_AUDIOSOURCE "org.qt-project.qt.audiosource"

/*!
    Service with support for camera use.
    Required Controls: QCameraControl
    Optional Controls: QCameraExposureControl, QCameraFocusControl, QCameraImageProcessingControl
    Still Capture Controls: QCameraImageCaptureControl
    Video Capture Controls (QMediaRecorder):
                        Required: QMediaRecorderControl
                        Recommended: QAudioEncoderSettingsControl, QVideoEncoderSettingsControl, QMediaContainerControl
    Viewfinder Video Output Controls (used by QCameraViewfinder and QGraphicsVideoItem):
                        Required: QVideoOutputControl
                        Optional: QVideoWindowControl, QVideoRendererControl, QVideoWidgetControl
*/
#define Q_MEDIASERVICE_CAMERA "org.qt-project.qt.camera"

/*!
    Service with support for radio tuning.
    Required Controls: QRadioTunerControl
    Recording Controls (Optional, used by QMediaRecorder):
                        Required: QMediaRecorderControl
                        Recommended: QAudioEncoderSettingsControl
                        Optional: QMediaContainerControl
*/
#define Q_MEDIASERVICE_RADIO "org.qt-project.qt.radio"

/*!
    Service with support for decoding audio.
    Required Controls: QAudioDecoderControl
    Optional: that streams control
*/
#define Q_MEDIASERVICE_AUDIODECODER "org.qt-project.qt.audiodecode"

QT_END_NAMESPACE

#endif  // QMEDIASERVICEPROVIDERPLUGIN_H