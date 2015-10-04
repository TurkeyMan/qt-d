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

public import QtCore.qiodevice;
public import QtCore.qfile;

#ifdef open
#error qtemporaryfile.h must be included before any header file that defines open
#endif


#ifndef QT_NO_TEMPORARYFILE

extern(C++) class QTemporaryFilePrivate;
extern(C++) class QLockFilePrivate;

extern(C++) class export QTemporaryFile : QFile
{
#ifndef QT_NO_QOBJECT
    mixin Q_OBJECT;
#endif
    mixin Q_DECLARE_PRIVATE;

public:
    QTemporaryFile();
    explicit QTemporaryFile(ref const(QString) templateName);
#ifndef QT_NO_QOBJECT
    explicit QTemporaryFile(QObject *parent);
    QTemporaryFile(ref const(QString) templateName, QObject *parent);
#endif
    ~QTemporaryFile();

    bool autoRemove() const;
    void setAutoRemove(bool b);

    // ### Hides open(flags)
    bool open() { return open(QIODevice::ReadWrite); }

    QString fileName() const;
    QString fileTemplate() const;
    void setFileTemplate(ref const(QString) name);
#if QT_DEPRECATED_SINCE(5,1)
    QT_DEPRECATED /+inline+/ static QTemporaryFile *createLocalFile(ref const(QString) fileName)
        { return createNativeFile(fileName); }
    QT_DEPRECATED /+inline+/ static QTemporaryFile *createLocalFile(QFile &file)
        { return createNativeFile(file); }
#endif
    /+inline+/ static QTemporaryFile *createNativeFile(ref const(QString) fileName)
        { QFile file(fileName); return createNativeFile(file); }
    static QTemporaryFile *createNativeFile(QFile &file);

protected:
    bool open(OpenMode flags);

private:
    friend extern(C++) class QFile;
    friend extern(C++) class QLockFilePrivate;
    mixin Q_DISABLE_COPY;
}

#endif // QT_NO_TEMPORARYFILE

#endif // QTEMPORARYFILE_H
