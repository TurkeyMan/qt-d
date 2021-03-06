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

#ifndef QCAMERAFOCUS_H
#define QCAMERAFOCUS_H

public import qt.QtCore.qstringlist;
public import qt.QtCore.qpair;
public import qt.QtCore.qsize;
public import qt.QtCore.qpoint;
public import qt.QtCore.qrect;
public import qt.QtCore.qshareddata;

public import qt.QtMultimedia.qmediaobject;
public import qt.QtMultimedia.qmediaenumdebug;

QT_BEGIN_NAMESPACE


class QCamera;

class QCameraFocusZoneData;

class Q_MULTIMEDIA_EXPORT QCameraFocusZone {
public:
    enum FocusZoneStatus {
        Invalid,
        Unused,
        Selected,
        Focused
    };

    QCameraFocusZone();
    QCameraFocusZone(ref const(QRectF) area, FocusZoneStatus status = Selected);
    QCameraFocusZone(ref const(QCameraFocusZone) other);

    QCameraFocusZone& operator=(ref const(QCameraFocusZone) other);
    bool operator==(ref const(QCameraFocusZone) other) const;
    bool operator!=(ref const(QCameraFocusZone) other) const;

    ~QCameraFocusZone();

    bool isValid() const;

    QRectF area() const;

    FocusZoneStatus status() const;
    void setStatus(FocusZoneStatus status);

private:
     QSharedDataPointer<QCameraFocusZoneData> d;
};

typedef QList<QCameraFocusZone> QCameraFocusZoneList;


class QCameraFocusPrivate;
class Q_MULTIMEDIA_EXPORT QCameraFocus : public QObject
{
    mixin Q_OBJECT;

    mixin Q_PROPERTY!(FocusModes, "focusMode", "READ", "focusMode", "WRITE", "setFocusMode");
    mixin Q_PROPERTY!(FocusPointMode, "focusPointMode", "READ", "focusPointMode", "WRITE", "setFocusPointMode");
    mixin Q_PROPERTY!(QPointF, "customFocusPoint", "READ", "customFocusPoint", "WRITE", "setCustomFocusPoint");
    mixin Q_PROPERTY!(QCameraFocusZoneList, "focusZones", "READ", "focusZones", "NOTIFY", "focusZonesChanged");
    mixin Q_PROPERTY!(qreal, "opticalZoom", "READ", "opticalZoom", "NOTIFY", "opticalZoomChanged");
    mixin Q_PROPERTY!(qreal, "digitalZoom", "READ", "digitalZoom", "NOTIFY", "digitalZoomChanged");

    Q_ENUMS(FocusMode)
    Q_ENUMS(FocusPointMode)
public:
    enum FocusMode {
        ManualFocus = 0x1,
        HyperfocalFocus = 0x02,
        InfinityFocus = 0x04,
        AutoFocus = 0x8,
        ContinuousFocus = 0x10,
        MacroFocus = 0x20
    };
    Q_DECLARE_FLAGS(FocusModes, FocusMode)

    enum FocusPointMode {
        FocusPointAuto,
        FocusPointCenter,
        FocusPointFaceDetection,
        FocusPointCustom
    };

    bool isAvailable() const;

    FocusModes focusMode() const;
    void setFocusMode(FocusModes mode);
    bool isFocusModeSupported(FocusModes mode) const;

    FocusPointMode focusPointMode() const;
    void setFocusPointMode(FocusPointMode mode);
    bool isFocusPointModeSupported(FocusPointMode) const;
    QPointF customFocusPoint() const;
    void setCustomFocusPoint(ref const(QPointF) point);

    QCameraFocusZoneList focusZones() const;

    qreal maximumOpticalZoom() const;
    qreal maximumDigitalZoom() const;
    qreal opticalZoom() const;
    qreal digitalZoom() const;

    void zoomTo(qreal opticalZoom, qreal digitalZoom);

Q_SIGNALS:
    void opticalZoomChanged(qreal);
    void digitalZoomChanged(qreal);

    void focusZonesChanged();

    void maximumOpticalZoomChanged(qreal);
    void maximumDigitalZoomChanged(qreal);

private:
    friend class QCamera;
    friend class QCameraPrivate;
    QCameraFocus(QCamera *camera);
    ~QCameraFocus();

    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    QCameraFocusPrivate *d_ptr;
};

Q_DECLARE_OPERATORS_FOR_FLAGS(QCameraFocus::FocusModes)

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QCameraFocus::FocusModes)
Q_DECLARE_METATYPE(QCameraFocus::FocusPointMode)

Q_MEDIA_ENUM_DEBUG(QCameraFocus, FocusMode)
Q_MEDIA_ENUM_DEBUG(QCameraFocus, FocusPointMode)

#endif  // QCAMERAFOCUS_H
