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

#ifndef QCAMERAVIEWFINDER_H
#define QCAMERAVIEWFINDER_H

public import qt.QtCore.qstringlist;
public import qt.QtCore.qpair;
public import qt.QtCore.qsize;
public import qt.QtCore.qpoint;
public import qt.QtCore.qrect;

public import qt.QtMultimedia.qmediacontrol;
public import qt.QtMultimedia.qmediaobject;
public import qt.QtMultimedia.qmediaservice;
public import qt.QtMultimediaWidgets.qvideowidget;

QT_BEGIN_NAMESPACE


class QCamera;

class QCameraViewfinderPrivate;
class Q_MULTIMEDIAWIDGETS_EXPORT QCameraViewfinder : public QVideoWidget
{
    mixin Q_OBJECT;
public:
    QCameraViewfinder(QWidget *parent = 0);
    ~QCameraViewfinder();

    QMediaObject *mediaObject() const;

protected:
    bool setMediaObject(QMediaObject *object);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

QT_END_NAMESPACE


#endif  // QCAMERA_H
