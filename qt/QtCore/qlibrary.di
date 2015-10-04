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

public import QtCore.qobject;

#ifndef QT_NO_LIBRARY

extern(C++) class QLibraryPrivate;

extern(C++) class export QLibrary : QObject
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QString, "fileName", "READ", "fileName", "WRITE", "setFileName");
    mixin Q_PROPERTY!(LoadHints, "loadHints", "READ", "loadHints", "WRITE", "setLoadHints");
    Q_FLAGS(LoadHint LoadHints)
public:
    enum LoadHint {
        ResolveAllSymbolsHint = 0x01,
        ExportExternalSymbolsHint = 0x02,
        LoadArchiveMemberHint = 0x04,
        PreventUnloadHint = 0x08
    }
    Q_DECLARE_FLAGS(LoadHints, LoadHint)

    explicit QLibrary(QObject *parent = 0);
    explicit QLibrary(ref const(QString) fileName, QObject *parent = 0);
    explicit QLibrary(ref const(QString) fileName, int verNum, QObject *parent = 0);
    explicit QLibrary(ref const(QString) fileName, ref const(QString) version, QObject *parent = 0);
    ~QLibrary();

    QFunctionPointer resolve(const(char)* symbol);
    static QFunctionPointer resolve(ref const(QString) fileName, const(char)* symbol);
    static QFunctionPointer resolve(ref const(QString) fileName, int verNum, const(char)* symbol);
    static QFunctionPointer resolve(ref const(QString) fileName, ref const(QString) version, const(char)* symbol);

    bool load();
    bool unload();
    bool isLoaded() const;

    static bool isLibrary(ref const(QString) fileName);

    void setFileName(ref const(QString) fileName);
    QString fileName() const;

    void setFileNameAndVersion(ref const(QString) fileName, int verNum);
    void setFileNameAndVersion(ref const(QString) fileName, ref const(QString) version);
    QString errorString() const;

    void setLoadHints(LoadHints hints);
    LoadHints loadHints() const;
private:
    QLibraryPrivate *d;
    bool did_load;
    mixin Q_DISABLE_COPY;
}

Q_DECLARE_OPERATORS_FOR_FLAGS(QLibrary::LoadHints)

#endif //QT_NO_LIBRARY

#endif //QLIBRARY_H
