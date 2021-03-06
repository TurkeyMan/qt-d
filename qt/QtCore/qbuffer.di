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
public import QtCore.qbytearray;


extern(C++) class QObject;
extern(C++) class QBufferPrivate;

extern(C++) class export QBuffer : QIODevice
{
#ifndef QT_NO_QOBJECT
    mixin Q_OBJECT;
#endif

public:
#ifndef QT_NO_QOBJECT
     explicit QBuffer(QObject *parent = 0);
     QBuffer(QByteArray *buf, QObject *parent = 0);
#else
     QBuffer();
     explicit QBuffer(QByteArray *buf);
#endif
    ~QBuffer();

    QByteArray &buffer();
    ref const(QByteArray) buffer() const;
    void setBuffer(QByteArray *a);

    void setData(ref const(QByteArray) data);
    /+inline+/ void setData(const(char)* data, int len);
    ref const(QByteArray) data() const;

    bool open(OpenMode openMode);

    void close();
    qint64 size() const;
    qint64 pos() const;
    bool seek(qint64 off);
    bool atEnd() const;
    bool canReadLine() const;

protected:
#ifndef QT_NO_QOBJECT
    void connectNotify(ref const(QMetaMethod) );
    void disconnectNotify(ref const(QMetaMethod) );
#endif
    qint64 readData(char *data, qint64 maxlen);
    qint64 writeData(const(char)* data, qint64 len);

private:
    mixin Q_DECLARE_PRIVATE;
    mixin Q_DISABLE_COPY;

    Q_PRIVATE_SLOT(d_func(), void _q_emitSignals())
}

/+inline+/ void QBuffer::setData(const(char)* adata, int alen)
{ setData(QByteArray(adata, alen)); }

#endif // QBUFFER_H
