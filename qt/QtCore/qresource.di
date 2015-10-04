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

public import QtCore.qstring;
public import QtCore.qlocale;
public import QtCore.qstringlist;
public import QtCore.qlist;


extern(C++) class QResourcePrivate;

extern(C++) class export QResource
{
public:
    QResource(ref const(QString) file=QString(), ref const(QLocale) locale=QLocale());
    ~QResource();

    void setFileName(ref const(QString) file);
    QString fileName() const;
    QString absoluteFilePath() const;

    void setLocale(ref const(QLocale) locale);
    QLocale locale() const;

    bool isValid() const;

    bool isCompressed() const;
    qint64 size() const;
    const(uchar)* data() const;

    static void addSearchPath(ref const(QString) path);
    static QStringList searchPaths();

    static bool registerResource(ref const(QString) rccFilename, ref const(QString) resourceRoot=QString());
    static bool unregisterResource(ref const(QString) rccFilename, ref const(QString) resourceRoot=QString());

    static bool registerResource(const(uchar)* rccData, ref const(QString) resourceRoot=QString());
    static bool unregisterResource(const(uchar)* rccData, ref const(QString) resourceRoot=QString());

protected:
    friend extern(C++) class QResourceFileEngine;
    friend extern(C++) class QResourceFileEngineIterator;
    bool isDir() const;
    /+inline+/ bool isFile() const { return !isDir(); }
    QStringList children() const;

protected:
    QScopedPointer<QResourcePrivate> d_ptr;

private:
    mixin Q_DECLARE_PRIVATE;
}

#endif // QRESOURCE_H
