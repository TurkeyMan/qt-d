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


#ifndef QAUDIOSYSTEMPLUGIN_H
#define QAUDIOSYSTEMPLUGIN_H

public import qt.QtCore.qstring;
public import qt.QtCore.qplugin;

public import qt.QtMultimedia.qtmultimediadefs;
public import qt.QtMultimedia.qmultimedia;

public import qt.QtMultimedia.qaudioformat;
public import qt.QtMultimedia.qaudiodeviceinfo;
public import qt.QtMultimedia.qaudiosystem;

QT_BEGIN_NAMESPACE

// Required for QDoc workaround
class QString;

struct Q_MULTIMEDIA_EXPORT QAudioSystemFactoryInterface
{
    /+virtual+/ QList<QByteArray> availableDevices(QAudio::Mode) const = 0;
    /+virtual+/ QAbstractAudioInput* createInput(ref const(QByteArray) device) = 0;
    /+virtual+/ QAbstractAudioOutput* createOutput(ref const(QByteArray) device) = 0;
    /+virtual+/ QAbstractAudioDeviceInfo* createDeviceInfo(ref const(QByteArray) device, QAudio::Mode mode) = 0;
    /+virtual+/ ~QAudioSystemFactoryInterface();
};

#define QAudioSystemFactoryInterface_iid \
    "org.qt-project.qt.audiosystemfactory/5.0"
Q_DECLARE_INTERFACE(QAudioSystemFactoryInterface, QAudioSystemFactoryInterface_iid)

// Required for QDoc workaround
class QString;

class Q_MULTIMEDIA_EXPORT QAudioSystemPlugin : public QObject, public QAudioSystemFactoryInterface
{
    mixin Q_OBJECT;
    Q_INTERFACES(QAudioSystemFactoryInterface)

public:
    QAudioSystemPlugin(QObject *parent = 0);
    ~QAudioSystemPlugin();

    /+virtual+/ QList<QByteArray> availableDevices(QAudio::Mode) const = 0;
    /+virtual+/ QAbstractAudioInput* createInput(ref const(QByteArray) device) = 0;
    /+virtual+/ QAbstractAudioOutput* createOutput(ref const(QByteArray) device) = 0;
    /+virtual+/ QAbstractAudioDeviceInfo* createDeviceInfo(ref const(QByteArray) device, QAudio::Mode mode) = 0;
};

QT_END_NAMESPACE

#endif // QAUDIOSYSTEMPLUGIN_H
