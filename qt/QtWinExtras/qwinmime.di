/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtWinExtras module of the Qt Toolkit.
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

#ifndef QWINMIME_H
#define QWINMIME_H

public import qt.QtWinExtras.qwinextrasglobal;

public import qt.QtCore.qt_windows;
public import qt.QtCore.QVector;
public import qt.QtCore.QList;
public import qt.QtCore.QVariant;

QT_BEGIN_NAMESPACE

class QMimeData;

class Q_WINEXTRAS_EXPORT QWinMime // Keep in sync with QWindowsMime in the Windows platform plugin.
{
    mixin Q_DISABLE_COPY;
public:
    QWinMime();
    /+virtual+/ ~QWinMime();

    // for converting from Qt
    /+virtual+/ bool canConvertFromMime(ref const(FORMATETC) formatetc, const(QMimeData)* mimeData) const = 0;
    /+virtual+/ bool convertFromMime(ref const(FORMATETC) formatetc, const(QMimeData)* mimeData, STGMEDIUM * pmedium) const = 0;
    /+virtual+/ QVector<FORMATETC> formatsForMime(ref const(QString) mimeType, const(QMimeData)* mimeData) const = 0;

    // for converting to Qt
    /+virtual+/ bool canConvertToMime(ref const(QString) mimeType, IDataObject *pDataObj) const = 0;
    /+virtual+/ QVariant convertToMime(ref const(QString) mimeType, IDataObject *pDataObj, QVariant::Type preferredType) const = 0;
    /+virtual+/ QString mimeForFormat(ref const(FORMATETC) formatetc) const = 0;

    static int registerMimeType(ref const(QString) mime);
};

QT_END_NAMESPACE

#endif // QWINMIME_H
