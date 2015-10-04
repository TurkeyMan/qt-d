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
public import QtCore.qfileinfo;
public import QtCore.qstringlist;
public import QtCore.qshareddata;


extern(C++) class QDirIterator;
extern(C++) class QDirPrivate;

extern(C++) class export QDir
{
public:
    enum Filter { Dirs        = 0x001,
                  Files       = 0x002,
                  Drives      = 0x004,
                  NoSymLinks  = 0x008,
                  AllEntries  = Dirs | Files | Drives,
                  TypeMask    = 0x00f,

                  Readable    = 0x010,
                  Writable    = 0x020,
                  Executable  = 0x040,
                  PermissionMask    = 0x070,

                  Modified    = 0x080,
                  Hidden      = 0x100,
                  System      = 0x200,

                  AccessMask  = 0x3F0,

                  AllDirs       = 0x400,
                  CaseSensitive = 0x800,
                  NoDot         = 0x2000,
                  NoDotDot      = 0x4000,
                  NoDotAndDotDot = NoDot | NoDotDot,

                  NoFilter = -1
    }
    Q_DECLARE_FLAGS(Filters, Filter)

    enum SortFlag { Name        = 0x00,
                    Time        = 0x01,
                    Size        = 0x02,
                    Unsorted    = 0x03,
                    SortByMask  = 0x03,

                    DirsFirst   = 0x04,
                    Reversed    = 0x08,
                    IgnoreCase  = 0x10,
                    DirsLast    = 0x20,
                    LocaleAware = 0x40,
                    Type        = 0x80,
                    NoSort = -1
    }
    Q_DECLARE_FLAGS(SortFlags, SortFlag)

    QDir(ref const(QDir) );
    QDir(ref const(QString) path = QString());
    QDir(ref const(QString) path, ref const(QString) nameFilter,
         SortFlags sort = SortFlags(Name | IgnoreCase), Filters filter = AllEntries);
    ~QDir();

    QDir &operator=(ref const(QDir) );
    QDir &operator=(ref const(QString) path);
#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QDir &operator=(QDir &&other)
    { qSwap(d_ptr, other.d_ptr); return *this; }
#endif

    /+inline+/ void swap(QDir &other)
    { qSwap(d_ptr, other.d_ptr); }

    void setPath(ref const(QString) path);
    QString path() const;
    QString absolutePath() const;
    QString canonicalPath() const;

    static void addResourceSearchPath(ref const(QString) path);

    static void setSearchPaths(ref const(QString) prefix, ref const(QStringList) searchPaths);
    static void addSearchPath(ref const(QString) prefix, ref const(QString) path);
    static QStringList searchPaths(ref const(QString) prefix);

    QString dirName() const;
    QString filePath(ref const(QString) fileName) const;
    QString absoluteFilePath(ref const(QString) fileName) const;
    QString relativeFilePath(ref const(QString) fileName) const;

    static QString toNativeSeparators(ref const(QString) pathName);
    static QString fromNativeSeparators(ref const(QString) pathName);

    bool cd(ref const(QString) dirName);
    bool cdUp();

    QStringList nameFilters() const;
    void setNameFilters(ref const(QStringList) nameFilters);

    Filters filter() const;
    void setFilter(Filters filter);
    SortFlags sorting() const;
    void setSorting(SortFlags sort);

    uint count() const;
    QString operator[](int) const;

    static QStringList nameFiltersFromString(ref const(QString) nameFilter);

    QStringList entryList(Filters filters = NoFilter, SortFlags sort = NoSort) const;
    QStringList entryList(ref const(QStringList) nameFilters, Filters filters = NoFilter,
                          SortFlags sort = NoSort) const;

    QFileInfoList entryInfoList(Filters filters = NoFilter, SortFlags sort = NoSort) const;
    QFileInfoList entryInfoList(ref const(QStringList) nameFilters, Filters filters = NoFilter,
                                SortFlags sort = NoSort) const;

    bool mkdir(ref const(QString) dirName) const;
    bool rmdir(ref const(QString) dirName) const;
    bool mkpath(ref const(QString) dirPath) const;
    bool rmpath(ref const(QString) dirPath) const;

    bool removeRecursively();

    bool isReadable() const;
    bool exists() const;
    bool isRoot() const;

    static bool isRelativePath(ref const(QString) path);
    /+inline+/ static bool isAbsolutePath(ref const(QString) path) { return !isRelativePath(path); }
    bool isRelative() const;
    /+inline+/ bool isAbsolute() const { return !isRelative(); }
    bool makeAbsolute();

    bool operator==(ref const(QDir) dir) const;
    /+inline+/ bool operator!=(ref const(QDir) dir) const {  return !operator==(dir); }

    bool remove(ref const(QString) fileName);
    bool rename(ref const(QString) oldName, ref const(QString) newName);
    bool exists(ref const(QString) name) const;

    static QFileInfoList drives();

    static QChar separator();

    static bool setCurrent(ref const(QString) path);
    static /+inline+/ QDir current() { return QDir(currentPath()); }
    static QString currentPath();

    static /+inline+/ QDir home() { return QDir(homePath()); }
    static QString homePath();
    static /+inline+/ QDir root() { return QDir(rootPath()); }
    static QString rootPath();
    static /+inline+/ QDir temp() { return QDir(tempPath()); }
    static QString tempPath();

#ifndef QT_NO_REGEXP
    static bool match(ref const(QStringList) filters, ref const(QString) fileName);
    static bool match(ref const(QString) filter, ref const(QString) fileName);
#endif

    static QString cleanPath(ref const(QString) path);
    void refresh() const;

protected:
    explicit QDir(QDirPrivate &d);

    QSharedDataPointer<QDirPrivate> d_ptr;

private:
    friend extern(C++) class QDirIterator;
    // Q_DECLARE_PRIVATE equivalent for shared data pointers
    QDirPrivate* d_func();
    /+inline+/ const(QDirPrivate)* d_func() const
    {
        return d_ptr.constData();
    }

}

Q_DECLARE_SHARED(QDir)
Q_DECLARE_OPERATORS_FOR_FLAGS(QDir::Filters)
Q_DECLARE_OPERATORS_FOR_FLAGS(QDir::SortFlags)

#ifndef QT_NO_DEBUG_STREAM
extern(C++) class QDebug;
export QDebug operator<<(QDebug debug, QDir::Filters filters);
export QDebug operator<<(QDebug debug, ref const(QDir) dir);
#endif

#endif // QDIR_H
