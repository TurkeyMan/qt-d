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

public import QtCore.qfile;
public import QtCore.qlist;
public import QtCore.qshareddata;
public import QtCore.qmetatype;


extern(C++) class QDir;
extern(C++) class QDirIteratorPrivate;
extern(C++) class QDateTime;
extern(C++) class QFileInfoPrivate;

extern(C++) class export QFileInfo
{
    friend extern(C++) class QDirIteratorPrivate;
public:
    explicit QFileInfo(QFileInfoPrivate *d);

    QFileInfo();
    QFileInfo(ref const(QString) file);
    QFileInfo(ref const(QFile) file);
    QFileInfo(ref const(QDir) dir, ref const(QString) file);
    QFileInfo(ref const(QFileInfo) fileinfo);
    ~QFileInfo();

    QFileInfo &operator=(ref const(QFileInfo) fileinfo);
#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QFileInfo&operator=(QFileInfo &&other)
    { qSwap(d_ptr, other.d_ptr); return *this; }
#endif

    /+inline+/ void swap(QFileInfo &other)
    { qSwap(d_ptr, other.d_ptr); }

    bool operator==(ref const(QFileInfo) fileinfo) const;
    /+inline+/ bool operator!=(ref const(QFileInfo) fileinfo) const { return !(operator==(fileinfo)); }

    void setFile(ref const(QString) file);
    void setFile(ref const(QFile) file);
    void setFile(ref const(QDir) dir, ref const(QString) file);
    bool exists() const;
    static bool exists(ref const(QString) file);
    void refresh();

    QString filePath() const;
    QString absoluteFilePath() const;
    QString canonicalFilePath() const;
    QString fileName() const;
    QString baseName() const;
    QString completeBaseName() const;
    QString suffix() const;
    QString bundleName() const;
    QString completeSuffix() const;

    QString path() const;
    QString absolutePath() const;
    QString canonicalPath() const;
    QDir dir() const;
    QDir absoluteDir() const;

    bool isReadable() const;
    bool isWritable() const;
    bool isExecutable() const;
    bool isHidden() const;
    bool isNativePath() const;

    bool isRelative() const;
    /+inline+/ bool isAbsolute() const { return !isRelative(); }
    bool makeAbsolute();

    bool isFile() const;
    bool isDir() const;
    bool isSymLink() const;
    bool isRoot() const;
    bool isBundle() const;

    QString readLink() const;
    /+inline+/ QString symLinkTarget() const { return readLink(); }

    QString owner() const;
    uint ownerId() const;
    QString group() const;
    uint groupId() const;

    bool permission(QFile::Permissions permissions) const;
    QFile::Permissions permissions() const;

    qint64 size() const;

    QDateTime created() const;
    QDateTime lastModified() const;
    QDateTime lastRead() const;

    bool caching() const;
    void setCaching(bool on);

protected:
    QSharedDataPointer<QFileInfoPrivate> d_ptr;

private:
    QFileInfoPrivate* d_func();
    /+inline+/ const(QFileInfoPrivate)* d_func() const
    {
        return d_ptr.constData();
    }
}

Q_DECLARE_SHARED(QFileInfo)

typedef QList<QFileInfo> QFileInfoList;

Q_DECLARE_METATYPE(QFileInfo)

#endif // QFILEINFO_H
