/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtCore module of the Qt Toolkit.
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

public import QtCore.qshareddata;
public import QtCore.qstring;

extern(C++) class QMimeTypePrivate;
extern(C++) class QFileinfo;
extern(C++) class QStringList;

extern(C++) class export QMimeType
{
public:
    QMimeType();
    QMimeType(ref const(QMimeType) other);
    QMimeType &operator=(ref const(QMimeType) other);
#ifdef Q_COMPILER_RVALUE_REFS
    QMimeType &operator=(QMimeType &&other)
    {
        qSwap(d, other.d);
        return *this;
    }
#endif
    void swap(QMimeType &other)
    {
        qSwap(d, other.d);
    }
    explicit QMimeType(ref const(QMimeTypePrivate) dd);
    ~QMimeType();

    bool operator==(ref const(QMimeType) other) const;

    /+inline+/ bool operator!=(ref const(QMimeType) other) const
    {
        return !operator==(other);
    }

    bool isValid() const;

    bool isDefault() const;

    QString name() const;
    QString comment() const;
    QString genericIconName() const;
    QString iconName() const;
    QStringList globPatterns() const;
    QStringList parentMimeTypes() const;
    QStringList allAncestors() const;
    QStringList aliases() const;
    QStringList suffixes() const;
    QString preferredSuffix() const;

    bool inherits(ref const(QString) mimeTypeName) const;

    QString filterString() const;

protected:
    friend extern(C++) class QMimeTypeParserBase;
    friend extern(C++) class MimeTypeMapEntry;
    friend extern(C++) class QMimeDatabasePrivate;
    friend extern(C++) class QMimeXMLProvider;
    friend extern(C++) class QMimeBinaryProvider;
    friend extern(C++) class QMimeTypePrivate;

    QExplicitlySharedDataPointer<QMimeTypePrivate> d;
}

Q_DECLARE_SHARED(QMimeType)

#ifndef QT_NO_DEBUG_STREAM
extern(C++) class QDebug;
export QDebug operator<<(QDebug debug, ref const(QMimeType) mime);
#endif
#endif   // QMIMETYPE_H
