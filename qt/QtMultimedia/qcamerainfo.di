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

#ifndef QCAMERAINFO_H
#define QCAMERAINFO_H

public import qt.QtMultimedia.qcamera;
public import qt.QtCore.qsharedpointer;

QT_BEGIN_NAMESPACE

class QCameraInfoPrivate;

class Q_MULTIMEDIA_EXPORT QCameraInfo
{
public:
    explicit QCameraInfo(ref const(QByteArray) name = QByteArray());
    explicit QCameraInfo(ref const(QCamera) camera);
    QCameraInfo(ref const(QCameraInfo) other);
    ~QCameraInfo();

    QCameraInfo& operator=(ref const(QCameraInfo) other);
    bool operator==(ref const(QCameraInfo) other) const;
    /+inline+/ bool operator!=(ref const(QCameraInfo) other) const;

    bool isNull() const;

    QString deviceName() const;
    QString description() const;
    QCamera::Position position() const;
    int orientation() const;

    static QCameraInfo defaultCamera();
    static QList<QCameraInfo> availableCameras(QCamera::Position position = QCamera::UnspecifiedPosition);

private:
    QSharedPointer<QCameraInfoPrivate> d;
};

bool QCameraInfo::operator!=(ref const(QCameraInfo) other) const { return !operator==(other); }

#ifndef QT_NO_DEBUG_STREAM
Q_MULTIMEDIA_EXPORT QDebug operator<<(QDebug, ref const(QCameraInfo));
#endif

QT_END_NAMESPACE

#endif // QCAMERAINFO_H
