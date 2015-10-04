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

public import QtCore.qmimetype;
public import QtCore.qstringlist;

extern(C++) class QByteArray;
extern(C++) class QFileInfo;
extern(C++) class QIODevice;
extern(C++) class QUrl;

extern(C++) class QMimeDatabasePrivate;
extern(C++) class export QMimeDatabase
{
    mixin Q_DISABLE_COPY;

public:
    QMimeDatabase();
    ~QMimeDatabase();

    QMimeType mimeTypeForName(ref const(QString) nameOrAlias) const;

    enum MatchMode {
        MatchDefault = 0x0,
        MatchExtension = 0x1,
        MatchContent = 0x2
    }

    QMimeType mimeTypeForFile(ref const(QString) fileName, MatchMode mode = MatchDefault) const;
    QMimeType mimeTypeForFile(ref const(QFileInfo) fileInfo, MatchMode mode = MatchDefault) const;
    QList<QMimeType> mimeTypesForFileName(ref const(QString) fileName) const;

    QMimeType mimeTypeForData(ref const(QByteArray) data) const;
    QMimeType mimeTypeForData(QIODevice *device) const;

    QMimeType mimeTypeForUrl(ref const(QUrl) url) const;
    QMimeType mimeTypeForFileNameAndData(ref const(QString) fileName, QIODevice *device) const;
    QMimeType mimeTypeForFileNameAndData(ref const(QString) fileName, ref const(QByteArray) data) const;

    QString suffixForFileName(ref const(QString) fileName) const;

    QList<QMimeType> allMimeTypes() const;

private:
    QMimeDatabasePrivate *d;
}
#endif   // QMIMEDATABASE_H
