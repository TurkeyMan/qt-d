/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtLocation module of the Qt Toolkit.
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

#ifndef QPLACEICON_H
#define QPLACEICON_H

public import qt.QtLocation.qlocationglobal;

public import qt.QtCore.QUrl;
public import qt.QtCore.QFlags;
public import qt.QtCore.QMetaType;
public import qt.QtCore.QSize;
public import qt.QtCore.QSharedDataPointer;

QT_BEGIN_NAMESPACE

class QPlaceManager;

class QPlaceIconPrivate;
class Q_LOCATION_EXPORT QPlaceIcon
{
public:
    static const QString SingleUrl;

    QPlaceIcon();
    QPlaceIcon(ref const(QPlaceIcon) other);

    ~QPlaceIcon();

    QPlaceIcon &operator=(ref const(QPlaceIcon) other);
    bool operator == (ref const(QPlaceIcon) other) const;
    bool operator != (ref const(QPlaceIcon) other) const {
        return !(*this == other);
    }

    QUrl url(ref const(QSize) size = QSize()) const;

    QPlaceManager *manager() const;
    void setManager(QPlaceManager *manager);

    QVariantMap parameters() const;
    void setParameters(ref const(QVariantMap) parameters);

    bool isEmpty() const;

private:
    QSharedDataPointer<QPlaceIconPrivate> d;
};

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QPlaceIcon)

#endif
