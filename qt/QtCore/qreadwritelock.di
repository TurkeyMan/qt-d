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


#ifndef QT_NO_THREAD

struct QReadWriteLockPrivate;

extern(C++) class export QReadWriteLock
{
public:
    enum RecursionMode { NonRecursive, Recursive }

    explicit QReadWriteLock(RecursionMode recursionMode = NonRecursive);
    ~QReadWriteLock();

    void lockForRead();
    bool tryLockForRead();
    bool tryLockForRead(int timeout);

    void lockForWrite();
    bool tryLockForWrite();
    bool tryLockForWrite(int timeout);

    void unlock();

private:
    mixin Q_DISABLE_COPY;
    QReadWriteLockPrivate *d;

    friend extern(C++) class QWaitCondition;
}

#if defined(Q_CC_MSVC)
#pragma warning( push )
#pragma warning( disable : 4312 ) // ignoring the warning from /Wp64
#endif

extern(C++) class export QReadLocker
{
public:
    /+inline+/ QReadLocker(QReadWriteLock *readWriteLock);

    /+inline+/ ~QReadLocker()
    { unlock(); }

    /+inline+/ void unlock()
    {
        if (q_val) {
            if ((q_val & quintptr(1u)) == quintptr(1u)) {
                q_val &= ~quintptr(1u);
                readWriteLock()->unlock();
            }
        }
    }

    /+inline+/ void relock()
    {
        if (q_val) {
            if ((q_val & quintptr(1u)) == quintptr(0u)) {
                readWriteLock()->lockForRead();
                q_val |= quintptr(1u);
            }
        }
    }

    /+inline+/ QReadWriteLock *readWriteLock() const
    { return reinterpret_cast<QReadWriteLock *>(q_val & ~quintptr(1u)); }

private:
    mixin Q_DISABLE_COPY;
    quintptr q_val;
}

/+inline+/ QReadLocker::QReadLocker(QReadWriteLock *areadWriteLock)
    : q_val(reinterpret_cast<quintptr>(areadWriteLock))
{
    Q_ASSERT_X((q_val & quintptr(1u)) == quintptr(0),
               "QReadLocker", "QReadWriteLock pointer is misaligned");
    relock();
}

extern(C++) class export QWriteLocker
{
public:
    /+inline+/ QWriteLocker(QReadWriteLock *readWriteLock);

    /+inline+/ ~QWriteLocker()
    { unlock(); }

    /+inline+/ void unlock()
    {
        if (q_val) {
            if ((q_val & quintptr(1u)) == quintptr(1u)) {
                q_val &= ~quintptr(1u);
                readWriteLock()->unlock();
            }
        }
    }

    /+inline+/ void relock()
    {
        if (q_val) {
            if ((q_val & quintptr(1u)) == quintptr(0u)) {
                readWriteLock()->lockForWrite();
                q_val |= quintptr(1u);
            }
        }
    }

    /+inline+/ QReadWriteLock *readWriteLock() const
    { return reinterpret_cast<QReadWriteLock *>(q_val & ~quintptr(1u)); }


private:
    mixin Q_DISABLE_COPY;
    quintptr q_val;
}

/+inline+/ QWriteLocker::QWriteLocker(QReadWriteLock *areadWriteLock)
    : q_val(reinterpret_cast<quintptr>(areadWriteLock))
{
    Q_ASSERT_X((q_val & quintptr(1u)) == quintptr(0),
               "QWriteLocker", "QReadWriteLock pointer is misaligned");
    relock();
}

#if defined(Q_CC_MSVC)
#pragma warning( pop )
#endif

#else // QT_NO_THREAD

extern(C++) class export QReadWriteLock
{
public:
    enum RecursionMode { NonRecursive, Recursive }
    /+inline+/ explicit QReadWriteLock(RecursionMode = NonRecursive) { }
    /+inline+/ ~QReadWriteLock() { }

    static /+inline+/ void lockForRead() { }
    static /+inline+/ bool tryLockForRead() { return true; }
    static /+inline+/ bool tryLockForRead(int timeout) { Q_UNUSED(timeout); return true; }

    static /+inline+/ void lockForWrite() { }
    static /+inline+/ bool tryLockForWrite() { return true; }
    static /+inline+/ bool tryLockForWrite(int timeout) { Q_UNUSED(timeout); return true; }

    static /+inline+/ void unlock() { }

private:
    mixin Q_DISABLE_COPY;
}

extern(C++) class export QReadLocker
{
public:
    /+inline+/ QReadLocker(QReadWriteLock *) { }
    /+inline+/ ~QReadLocker() { }

    static /+inline+/ void unlock() { }
    static /+inline+/ void relock() { }
    static /+inline+/ QReadWriteLock *readWriteLock() { return 0; }

private:
    mixin Q_DISABLE_COPY;
}

extern(C++) class export QWriteLocker
{
public:
    /+inline+/ explicit QWriteLocker(QReadWriteLock *) { }
    /+inline+/ ~QWriteLocker() { }

    static /+inline+/ void unlock() { }
    static /+inline+/ void relock() { }
    static /+inline+/ QReadWriteLock *readWriteLock() { return 0; }

private:
    mixin Q_DISABLE_COPY;
}

#endif // QT_NO_THREAD

#endif // QREADWRITELOCK_H