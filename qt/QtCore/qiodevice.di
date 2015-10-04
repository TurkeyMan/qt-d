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

public import QtCore.qglobal;
#ifndef QT_NO_QOBJECT
public import QtCore.qobject;
#else
public import QtCore.qobjectdefs;
public import QtCore.qscopedpointer;
#endif
public import QtCore.qstring;

#ifdef open
#error qiodevice.h must be included before any header file that defines open
#endif


extern(C++) class QByteArray;
extern(C++) class QIODevicePrivate;

extern(C++) class export QIODevice
#ifndef QT_NO_QOBJECT
    : public QObject
#endif
{
#ifndef QT_NO_QOBJECT
    mixin Q_OBJECT;
#endif
public:
    enum OpenModeFlag {
        NotOpen = 0x0000,
        ReadOnly = 0x0001,
        WriteOnly = 0x0002,
        ReadWrite = ReadOnly | WriteOnly,
        Append = 0x0004,
        Truncate = 0x0008,
        Text = 0x0010,
        Unbuffered = 0x0020
    }
    Q_DECLARE_FLAGS(OpenMode, OpenModeFlag)

    QIODevice();
#ifndef QT_NO_QOBJECT
    explicit QIODevice(QObject *parent);
#endif
    /+virtual+/ ~QIODevice();

    OpenMode openMode() const;

    void setTextModeEnabled(bool enabled);
    bool isTextModeEnabled() const;

    bool isOpen() const;
    bool isReadable() const;
    bool isWritable() const;
    /+virtual+/ bool isSequential() const;

    /+virtual+/ bool open(OpenMode mode);
    /+virtual+/ void close();

    // ### Qt 6: pos() and seek() should not be virtual, and
    // ### seek() should call a /+virtual+/ seekData() function.
    /+virtual+/ qint64 pos() const;
    /+virtual+/ qint64 size() const;
    /+virtual+/ bool seek(qint64 pos);
    /+virtual+/ bool atEnd() const;
    /+virtual+/ bool reset();

    /+virtual+/ qint64 bytesAvailable() const;
    /+virtual+/ qint64 bytesToWrite() const;

    qint64 read(char *data, qint64 maxlen);
    QByteArray read(qint64 maxlen);
    QByteArray readAll();
    qint64 readLine(char *data, qint64 maxlen);
    QByteArray readLine(qint64 maxlen = 0);
    /+virtual+/ bool canReadLine() const;

    qint64 write(const(char)* data, qint64 len);
    qint64 write(const(char)* data);
    /+inline+/ qint64 write(ref const(QByteArray) data)
    { return write(data.constData(), data.size()); }

    qint64 peek(char *data, qint64 maxlen);
    QByteArray peek(qint64 maxlen);

    /+virtual+/ bool waitForReadyRead(int msecs);
    /+virtual+/ bool waitForBytesWritten(int msecs);

    void ungetChar(char c);
    bool putChar(char c);
    bool getChar(char *c);

    QString errorString() const;

#ifndef QT_NO_QOBJECT
Q_SIGNALS:
    void readyRead();
    void bytesWritten(qint64 bytes);
    void aboutToClose();
    void readChannelFinished();
#endif

protected:
#ifdef QT_NO_QOBJECT
    QIODevice(QIODevicePrivate &dd);
#else
    QIODevice(QIODevicePrivate &dd, QObject *parent = 0);
#endif
    /+virtual+/ qint64 readData(char *data, qint64 maxlen) = 0;
    /+virtual+/ qint64 readLineData(char *data, qint64 maxlen);
    /+virtual+/ qint64 writeData(const(char)* data, qint64 len) = 0;

    void setOpenMode(OpenMode openMode);

    void setErrorString(ref const(QString) errorString);

#ifdef QT_NO_QOBJECT
    QScopedPointer<QIODevicePrivate> d_ptr;
#endif

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;
}

Q_DECLARE_OPERATORS_FOR_FLAGS(QIODevice::OpenMode)

#if !defined(QT_NO_DEBUG_STREAM)
extern(C++) class QDebug;
export QDebug operator<<(QDebug debug, QIODevice::OpenMode modes);
#endif

#endif // QIODEVICE_H
