/****************************************************************************
**
** Copyright (C) 2012 Intel Corporation
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

module qt.QtCore.qglobalstatic;

public import qt.QtCore.qglobal;

public import qt.QtCore.qatomic;

extern(C++, QtGlobalStatic) {
    enum GuardValues {
        Destroyed = -2,
        Initialized = -1,
        Uninitialized = 0,
        Initializing = 1
    }
}
/+
#if defined(QT_NO_THREAD) || defined(Q_COMPILER_THREADSAFE_STATICS)
// some compilers support thread-safe statics
// The IA-64 C++ ABI requires this, so we know that all GCC versions since 3.4
// support it. C++11 also requires this behavior.
// Clang and Intel CC masquerade as GCC when compiling on Linux.
//
// Apple's libc++abi however uses a global lock for initializing local statics,
// which will block other threads also trying to initialize a local static
// until the constructor returns ...
// We better avoid these kind of problems by using our own locked implementation.

mixin template Q_GLOBAL_STATIC_INTERNAL(ARGS)
{
    Type *innerFunction()
    {
        struct HolderBase {
            ~HolderBase() nothrow
            { if (guard.load() == QtGlobalStatic.Initialized)
                  guard.store(QtGlobalStatic.Destroyed); }
        }
        static struct Holder : public HolderBase {
            Type value;
            Holder()
                Q_DECL_NOEXCEPT_EXPR(noexcept(Type ARGS))
                : value ARGS
            { guard.store(QtGlobalStatic.Initialized); }
        } holder;
        return &holder.value;
    }
}
#else
// We don't know if this compiler supports thread-safe global statics
// so use our own locked implementation
public import QtCore.qmutex;
mixin template Q_GLOBAL_STATIC_INTERNAL(ARGS)
{
    /+inline+/ Type *innerFunction()
    {
        static Type *d;
        static QBasicMutex mutex;
        int x = guard.loadAcquire();
        if (Q_UNLIKELY(x >= QtGlobalStatic.Uninitialized)) {
            QMutexLocker locker(&mutex);
            if (guard.load() == QtGlobalStatic.Uninitialized) {
                d = new Type ARGS;
                static struct Cleanup {
                    ~Cleanup() {
                        delete d;
                        guard.store(QtGlobalStatic.Destroyed);
                    }
                } cleanup;
                guard.store(QtGlobalStatic.Initialized);
            }
        }
        return d;
    }
}
#endif

// this extern(C++) class must be POD, unless the compiler supports thread-safe statics
//template <typename T, T *(&innerFunction)(), QBasicAtomicInt &guard>
struct QGlobalStatic(T, alias T function() innerFunction, ref QBasicAtomicInt guard)
{
    typedef T Type;

    bool isDestroyed() const { return guard.load() <= QtGlobalStatic.Destroyed; }
    bool exists() const { return guard.load() == QtGlobalStatic.Initialized; }
    operator Type *() { if (isDestroyed()) return 0; return innerFunction(); }
    Type *operator()() { if (isDestroyed()) return 0; return innerFunction(); }
    Type *operator->()
    {
      Q_ASSERT_X(!isDestroyed(), "Q_GLOBAL_STATIC", "The global static was used after being destroyed");
      return innerFunction();
    }
    Type &operator*()
    {
      Q_ASSERT_X(!isDestroyed(), "Q_GLOBAL_STATIC", "The global static was used after being destroyed");
      return *innerFunction();
    }
}

mixin template Q_GLOBAL_STATIC_WITH_ARGS(TYPE, NAME, ARGS)
{
    namespace { namespace Q_QGS_ ## NAME {
        typedef TYPE Type;
        QBasicAtomicInt guard = Q_BASIC_ATOMIC_INITIALIZER(QtGlobalStatic.Uninitialized);
        Q_GLOBAL_STATIC_INTERNAL(ARGS)
    } }
    static QGlobalStatic<TYPE,
                         Q_QGS_ ## NAME::innerFunction,
                         Q_QGS_ ## NAME::guard> NAME;
}

mixin template Q_GLOBAL_STATIC(TYPE, NAME)
{
    mixin Q_GLOBAL_STATIC_WITH_ARGS!(TYPE, NAME, ());
}
+/
