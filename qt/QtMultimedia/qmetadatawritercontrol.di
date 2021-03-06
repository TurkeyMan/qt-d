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

#ifndef QMETADATAWRITERCONTROL_H
#define QMETADATAWRITERCONTROL_H

public import qt.QtMultimedia.qmediacontrol;
public import qt.QtMultimedia.qmediaobject;

public import qt.QtMultimedia.qmediaresource;

public import qt.QtMultimedia.qtmultimediadefs;
public import qt.QtMultimedia.qmultimedia;

QT_BEGIN_NAMESPACE

// Required for QDoc workaround
class QString;

class Q_MULTIMEDIA_EXPORT QMetaDataWriterControl : public QMediaControl
{
    mixin Q_OBJECT;
public:
    ~QMetaDataWriterControl();

    /+virtual+/ bool isWritable() const = 0;
    /+virtual+/ bool isMetaDataAvailable() const = 0;

    /+virtual+/ QVariant metaData(ref const(QString) key) const = 0;
    /+virtual+/ void setMetaData(ref const(QString) key, ref const(QVariant) value) = 0;
    /+virtual+/ QStringList availableMetaData() const = 0;

Q_SIGNALS:
    void metaDataChanged();
    void metaDataChanged(ref const(QString) key, ref const(QVariant) value);

    void writableChanged(bool writable);
    void metaDataAvailableChanged(bool available);

protected:
    QMetaDataWriterControl(QObject *parent = 0);
};

#define QMetaDataWriterControl_iid "org.qt-project.qt.metadatawritercontrol/5.0"
Q_MEDIA_DECLARE_CONTROL(QMetaDataWriterControl, QMetaDataWriterControl_iid)

QT_END_NAMESPACE


#endif
