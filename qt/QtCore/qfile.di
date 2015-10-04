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

public import QtCore.qfiledevice;
public import QtCore.qstring;
public import stdio;

#ifdef open
#error qfile.h must be included before any header file that defines open
#endif

extern(C++) class QTemporaryFile;
extern(C++) class QFilePrivate;

extern(C++) class export QFile : QFileDevice
{
#ifndef QT_NO_QOBJECT
    mixin Q_OBJECT;
#endif
    mixin Q_DECLARE_PRIVATE;

public:
    QFile();
    QFile(ref const(QString) name);
#ifndef QT_NO_QOBJECT
    explicit QFile(QObject *parent);
    QFile(ref const(QString) name, QObject *parent);
#endif
    ~QFile();

    QString fileName() const;
    void setFileName(ref const(QString) name);

#if defined(Q_OS_DARWIN)
    // Mac always expects filenames in UTF-8... and decomposed...
    static /+inline+/ QByteArray encodeName(ref const(QString) fileName)
    {
        return fileName.normalized(QString::NormalizationForm_D).toUtf8();
    }
    static QString decodeName(ref const(QByteArray) localFileName)
    {
        return QString::fromUtf8(localFileName).normalized(QString::NormalizationForm_C);
    }
#else
    static /+inline+/ QByteArray encodeName(ref const(QString) fileName)
    {
        return fileName.toLocal8Bit();
    }
    static QString decodeName(ref const(QByteArray) localFileName)
    {
        return QString::fromLocal8Bit(localFileName);
    }
#endif
    /+inline+/ static QString decodeName(const(char)* localFileName)
        { return decodeName(QByteArray(localFileName)); }

#if QT_DEPRECATED_SINCE(5,0)
    typedef QByteArray (*EncoderFn)(ref const(QString) fileName);
    typedef QString (*DecoderFn)(ref const(QByteArray) localfileName);
    QT_DEPRECATED static void setEncodingFunction(EncoderFn) {}
    QT_DEPRECATED static void setDecodingFunction(DecoderFn) {}
#endif

    bool exists() const;
    static bool exists(ref const(QString) fileName);

    QString readLink() const;
    static QString readLink(ref const(QString) fileName);
    /+inline+/ QString symLinkTarget() const { return readLink(); }
    /+inline+/ static QString symLinkTarget(ref const(QString) fileName) { return readLink(fileName); }

    bool remove();
    static bool remove(ref const(QString) fileName);

    bool rename(ref const(QString) newName);
    static bool rename(ref const(QString) oldName, ref const(QString) newName);

    bool link(ref const(QString) newName);
    static bool link(ref const(QString) oldname, ref const(QString) newName);

    bool copy(ref const(QString) newName);
    static bool copy(ref const(QString) fileName, ref const(QString) newName);

    bool open(OpenMode flags);
    bool open(FILE *f, OpenMode ioFlags, FileHandleFlags handleFlags=DontCloseHandle);
    bool open(int fd, OpenMode ioFlags, FileHandleFlags handleFlags=DontCloseHandle);

    qint64 size() const;

    bool resize(qint64 sz);
    static bool resize(ref const(QString) filename, qint64 sz);

    Permissions permissions() const;
    static Permissions permissions(ref const(QString) filename);
    bool setPermissions(Permissions permissionSpec);
    static bool setPermissions(ref const(QString) filename, Permissions permissionSpec);

protected:
#ifdef QT_NO_QOBJECT
    QFile(QFilePrivate &dd);
#else
    QFile(QFilePrivate &dd, QObject *parent = 0);
#endif

private:
    friend extern(C++) class QTemporaryFile;
    mixin Q_DISABLE_COPY;
}

#endif // QFILE_H
