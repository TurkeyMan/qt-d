/****************************************************************************
**
** Copyright (C) 2011 Thiago Macieira <thiago@kde.org>
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

module qt.QtCore.qbasicatomic;

public import qt.QtCore.qatomic;

public import qt.QtCore.qatomic_druntime;
/+
version(QT_BOOTSTRAPPED)
    import qt.QtCore.qatomic_bootstrap;

// Compiler dependent implementation
else version(Q_CC_MSVC)
    import qt.QtCore.qatomic_msvc;

// Processor dependent implementation
else version(Q_PROCESSOR_ARM_V7) && defined(Q_PROCESSOR_ARM_32)
    import qt.QtCore.qatomic_armv7;
else version(Q_PROCESSOR_ARM_V6) && defined(Q_PROCESSOR_ARM_32)
    import qt.QtCore.qatomic_armv6;
else version(Q_PROCESSOR_ARM_V5) && defined(Q_PROCESSOR_ARM_32)
    import qt.QtCore.qatomic_armv5;
else version(Q_PROCESSOR_IA64)
    import qt.QtCore.qatomic_ia64;
else version(Q_PROCESSOR_MIPS)
    import qt.QtCore.qatomic_mips;
else version(Q_PROCESSOR_X86)
    import qt.QtCore.qatomic_x86;

// Fallback compiler dependent implementation
else version(Q_COMPILER_ATOMICS) && defined(Q_COMPILER_CONSTEXPR)
    import qt.QtCore.qatomic_cxx11;
else version(Q_CC_GNU)
    import qt.QtCore.qatomic_gcc;

// Fallback operating system dependent implementation
else version(Q_OS_UNIX)
    import qt.QtCore.qatomic_unix;

// No fallback
else
    static assert(false, "Qt has not been ported to this platform");
+/

// New atomics
/+
version(Q_COMPILER_CONSTEXPR) && version(Q_COMPILER_DEFAULT_MEMBERS) && version(Q_COMPILER_DELETE_MEMBERS)
{
    version(Q_CC_CLANG) && Q_CC_CLANG < 303
    {
        /*
            Do not define QT_BASIC_ATOMIC_HAS_CONSTRUCTORS for Clang before version 3.3.
            For details about the bug: see http://llvm.org/bugs/show_bug.cgi?id=12670
         */
    }
    else
    {
        version = QT_BASIC_ATOMIC_HAS_CONSTRUCTORS;
    }
}
+/

extern(C++) class QBasicAtomicInteger(T)
{
public:
    alias Ops = QAtomicOps!T;
    // static check that this is a valid integer
    static assert(QTypeInfo!T.isIntegral, "template parameter is not an integral type");
    static assert(QAtomicOpsSupport!(T.sizeof).IsSupported, "template parameter is an integral of a size not supported on this platform");

    Ops.Type _q_value;

    // Everything below is either implemented in ../arch/qatomic_XXX.h or (as fallback) in qgenericatomic.h

    T load() const nothrow { return Ops.load(_q_value); }
    void store(T newValue) nothrow { Ops.store(_q_value, newValue); }

    T loadAcquire() const nothrow { return Ops.loadAcquire(_q_value); }
    void storeRelease(T newValue) nothrow { Ops.storeRelease(_q_value, newValue); }
//    operator T() const nothrow { return loadAcquire(); }
    alias loadAcquire this;
    T opAssign(T newValue) nothrow { storeRelease(newValue); return newValue; }

    static bool isReferenceCountingNative() nothrow { return Ops.isReferenceCountingNative(); }
    static bool isReferenceCountingWaitFree() nothrow { return Ops.isReferenceCountingWaitFree(); }

    bool ref_() nothrow { return Ops.ref_(_q_value); }
    bool deref() nothrow { return Ops.deref(_q_value); }

    static bool isTestAndSetNative() nothrow { return Ops.isTestAndSetNative(); }
    static bool isTestAndSetWaitFree() nothrow { return Ops.isTestAndSetWaitFree(); }

    bool testAndSetRelaxed(T expectedValue, T newValue) nothrow
    { return Ops.testAndSetRelaxed(_q_value, expectedValue, newValue); }
    bool testAndSetAcquire(T expectedValue, T newValue) nothrow
    { return Ops.testAndSetAcquire(_q_value, expectedValue, newValue); }
    bool testAndSetRelease(T expectedValue, T newValue) nothrow
    { return Ops.testAndSetRelease(_q_value, expectedValue, newValue); }
    bool testAndSetOrdered(T expectedValue, T newValue) nothrow
    { return Ops.testAndSetOrdered(_q_value, expectedValue, newValue); }

    bool testAndSetRelaxed(T expectedValue, T newValue, ref T currentValue) nothrow
    { return Ops.testAndSetRelaxed(_q_value, expectedValue, newValue, &currentValue); }
    bool testAndSetAcquire(T expectedValue, T newValue, ref T currentValue) nothrow
    { return Ops.testAndSetAcquire(_q_value, expectedValue, newValue, &currentValue); }
    bool testAndSetRelease(T expectedValue, T newValue, ref T currentValue) nothrow
    { return Ops.testAndSetRelease(_q_value, expectedValue, newValue, &currentValue); }
    bool testAndSetOrdered(T expectedValue, T newValue, ref T currentValue) nothrow
    { return Ops.testAndSetOrdered(_q_value, expectedValue, newValue, &currentValue); }

    static bool isFetchAndStoreNative() nothrow { return Ops.isFetchAndStoreNative(); }
    static bool isFetchAndStoreWaitFree() nothrow { return Ops.isFetchAndStoreWaitFree(); }

    T fetchAndStoreRelaxed(T newValue) nothrow
    { return Ops.fetchAndStoreRelaxed(_q_value, newValue); }
    T fetchAndStoreAcquire(T newValue) nothrow
    { return Ops.fetchAndStoreAcquire(_q_value, newValue); }
    T fetchAndStoreRelease(T newValue) nothrow
    { return Ops.fetchAndStoreRelease(_q_value, newValue); }
    T fetchAndStoreOrdered(T newValue) nothrow
    { return Ops.fetchAndStoreOrdered(_q_value, newValue); }

    static bool isFetchAndAddNative() nothrow { return Ops.isFetchAndAddNative(); }
    static bool isFetchAndAddWaitFree() nothrow { return Ops.isFetchAndAddWaitFree(); }

    T fetchAndAddRelaxed(T valueToAdd) nothrow
    { return Ops.fetchAndAddRelaxed(_q_value, valueToAdd); }
    T fetchAndAddAcquire(T valueToAdd) nothrow
    { return Ops.fetchAndAddAcquire(_q_value, valueToAdd); }
    T fetchAndAddRelease(T valueToAdd) nothrow
    { return Ops.fetchAndAddRelease(_q_value, valueToAdd); }
    T fetchAndAddOrdered(T valueToAdd) nothrow
    { return Ops.fetchAndAddOrdered(_q_value, valueToAdd); }

    T fetchAndSubRelaxed(T valueToAdd) nothrow
    { return Ops.fetchAndSubRelaxed(_q_value, valueToAdd); }
    T fetchAndSubAcquire(T valueToAdd) nothrow
    { return Ops.fetchAndSubAcquire(_q_value, valueToAdd); }
    T fetchAndSubRelease(T valueToAdd) nothrow
    { return Ops.fetchAndSubRelease(_q_value, valueToAdd); }
    T fetchAndSubOrdered(T valueToAdd) nothrow
    { return Ops.fetchAndSubOrdered(_q_value, valueToAdd); }

    T fetchAndAndRelaxed(T valueToAdd) nothrow
    { return Ops.fetchAndAndRelaxed(_q_value, valueToAdd); }
    T fetchAndAndAcquire(T valueToAdd) nothrow
    { return Ops.fetchAndAndAcquire(_q_value, valueToAdd); }
    T fetchAndAndRelease(T valueToAdd) nothrow
    { return Ops.fetchAndAndRelease(_q_value, valueToAdd); }
    T fetchAndAndOrdered(T valueToAdd) nothrow
    { return Ops.fetchAndAndOrdered(_q_value, valueToAdd); }

    T fetchAndOrRelaxed(T valueToAdd) nothrow
    { return Ops.fetchAndOrRelaxed(_q_value, valueToAdd); }
    T fetchAndOrAcquire(T valueToAdd) nothrow
    { return Ops.fetchAndOrAcquire(_q_value, valueToAdd); }
    T fetchAndOrRelease(T valueToAdd) nothrow
    { return Ops.fetchAndOrRelease(_q_value, valueToAdd); }
    T fetchAndOrOrdered(T valueToAdd) nothrow
    { return Ops.fetchAndOrOrdered(_q_value, valueToAdd); }

    T fetchAndXorRelaxed(T valueToAdd) nothrow
    { return Ops.fetchAndXorRelaxed(_q_value, valueToAdd); }
    T fetchAndXorAcquire(T valueToAdd) nothrow
    { return Ops.fetchAndXorAcquire(_q_value, valueToAdd); }
    T fetchAndXorRelease(T valueToAdd) nothrow
    { return Ops.fetchAndXorRelease(_q_value, valueToAdd); }
    T fetchAndXorOrdered(T valueToAdd) nothrow
    { return Ops.fetchAndXorOrdered(_q_value, valueToAdd); }

    T opUnary(string op)() nothrow if(op == "++")
    { return fetchAndAddOrdered(1) + 1; }
//    T operator++(int) nothrow
//    { return fetchAndAddOrdered(1); }
    T opUnary(string op)() nothrow if(op == "--")
    { return fetchAndSubOrdered(1) - 1; }
//    T operator--(int) nothrow
//    { return fetchAndSubOrdered(1); }

    T opOpAssign(string op)(T v) nothrow if(op == "+")
    { return fetchAndAddOrdered(v) + v; }
    T opOpAssign(string op)(T v) nothrow if(op == "-")
    { return fetchAndSubOrdered(v) - v; }
    T opOpAssign(string op)(T v) nothrow if(op == "&")
    { return fetchAndAndOrdered(v) & v; }
    T opOpAssign(string op)(T v) nothrow if(op == "|")
    { return fetchAndOrOrdered(v) | v; }
    T opOpAssign(string op)(T v) nothrow if(op == "^")
    { return fetchAndXorOrdered(v) ^ v; }


    version(QT_BASIC_ATOMIC_HAS_CONSTRUCTORS)
    {
/+
        QBasicAtomicInteger() = default;
        constexpr QBasicAtomicInteger(T value) nothrow : _q_value(value) {}
        QBasicAtomicInteger(ref const(QBasicAtomicInteger) ) = delete;
        QBasicAtomicInteger &operator=(ref const(QBasicAtomicInteger) ) = delete;
        QBasicAtomicInteger &operator=(ref const(QBasicAtomicInteger) ) volatile = delete;
+/
    }
}
alias QBasicAtomicInt = QBasicAtomicInteger!int;

extern(C++) class QBasicAtomicPointer(X)
{
public:
    alias Type = X*;
    alias Ops = QAtomicOps!Type;
    alias AtomicType = Ops.Type;

    AtomicType _q_value;

    Type load() const nothrow { return _q_value; }
    void store(Type newValue) nothrow { _q_value = newValue; }
//    operator Type() const nothrow { return loadAcquire(); }
    alias loadAcquire this;
    Type opAssign(Type newValue) nothrow { storeRelease(newValue); return newValue; }

    // Atomic API, implemented in qatomic_XXX.h
    Type loadAcquire() const nothrow { return Ops.loadAcquire(_q_value); }
    void storeRelease(Type newValue) nothrow { Ops.storeRelease(_q_value, newValue); }

    static bool isTestAndSetNative() nothrow { return Ops.isTestAndSetNative(); }
    static bool isTestAndSetWaitFree() nothrow { return Ops.isTestAndSetWaitFree(); }

    bool testAndSetRelaxed(Type expectedValue, Type newValue) nothrow
    { return Ops.testAndSetRelaxed(_q_value, expectedValue, newValue); }
    bool testAndSetAcquire(Type expectedValue, Type newValue) nothrow
    { return Ops.testAndSetAcquire(_q_value, expectedValue, newValue); }
    bool testAndSetRelease(Type expectedValue, Type newValue) nothrow
    { return Ops.testAndSetRelease(_q_value, expectedValue, newValue); }
    bool testAndSetOrdered(Type expectedValue, Type newValue) nothrow
    { return Ops.testAndSetOrdered(_q_value, expectedValue, newValue); }

    bool testAndSetRelaxed(Type expectedValue, Type newValue, ref Type currentValue) nothrow
    { return Ops.testAndSetRelaxed(_q_value, expectedValue, newValue, &currentValue); }
    bool testAndSetAcquire(Type expectedValue, Type newValue, ref Type currentValue) nothrow
    { return Ops.testAndSetAcquire(_q_value, expectedValue, newValue, &currentValue); }
    bool testAndSetRelease(Type expectedValue, Type newValue, ref Type currentValue) nothrow
    { return Ops.testAndSetRelease(_q_value, expectedValue, newValue, &currentValue); }
    bool testAndSetOrdered(Type expectedValue, Type newValue, ref Type currentValue) nothrow
    { return Ops.testAndSetOrdered(_q_value, expectedValue, newValue, &currentValue); }

    static bool isFetchAndStoreNative() nothrow { return Ops.isFetchAndStoreNative(); }
    static bool isFetchAndStoreWaitFree() nothrow { return Ops.isFetchAndStoreWaitFree(); }

    Type fetchAndStoreRelaxed(Type newValue) nothrow
    { return Ops.fetchAndStoreRelaxed(_q_value, newValue); }
    Type fetchAndStoreAcquire(Type newValue) nothrow
    { return Ops.fetchAndStoreAcquire(_q_value, newValue); }
    Type fetchAndStoreRelease(Type newValue) nothrow
    { return Ops.fetchAndStoreRelease(_q_value, newValue); }
    Type fetchAndStoreOrdered(Type newValue) nothrow
    { return Ops.fetchAndStoreOrdered(_q_value, newValue); }

    static bool isFetchAndAddNative() nothrow { return Ops.isFetchAndAddNative(); }
    static bool isFetchAndAddWaitFree() nothrow { return Ops.isFetchAndAddWaitFree(); }

    Type fetchAndAddRelaxed(qptrdiff valueToAdd) nothrow
    { return Ops.fetchAndAddRelaxed(_q_value, valueToAdd); }
    Type fetchAndAddAcquire(qptrdiff valueToAdd) nothrow
    { return Ops.fetchAndAddAcquire(_q_value, valueToAdd); }
    Type fetchAndAddRelease(qptrdiff valueToAdd) nothrow
    { return Ops.fetchAndAddRelease(_q_value, valueToAdd); }
    Type fetchAndAddOrdered(qptrdiff valueToAdd) nothrow
    { return Ops.fetchAndAddOrdered(_q_value, valueToAdd); }

    Type fetchAndSubRelaxed(qptrdiff valueToAdd) nothrow
    { return Ops.fetchAndSubRelaxed(_q_value, valueToAdd); }
    Type fetchAndSubAcquire(qptrdiff valueToAdd) nothrow
    { return Ops.fetchAndSubAcquire(_q_value, valueToAdd); }
    Type fetchAndSubRelease(qptrdiff valueToAdd) nothrow
    { return Ops.fetchAndSubRelease(_q_value, valueToAdd); }
    Type fetchAndSubOrdered(qptrdiff valueToAdd) nothrow
    { return Ops.fetchAndSubOrdered(_q_value, valueToAdd); }

    Type opUnary(string op)() nothrow if(op == "++")
    { return fetchAndAddOrdered(1) + 1; }
//    Type operator++(int) nothrow
//    { return fetchAndAddOrdered(1); }
    Type opUnary(string op)() nothrow if(op == "--")
    { return fetchAndSubOrdered(1) - 1; }
//    Type operator--(int) nothrow
//    { return fetchAndSubOrdered(1); }
    Type opOpAssign(string op)(qptrdiff valueToAdd) nothrow if(op == "+")
    { return fetchAndAddOrdered(valueToAdd) + valueToAdd; }
    Type opOpAssign(string op)(qptrdiff valueToSub) nothrow if(op == "-")
    { return fetchAndSubOrdered(valueToSub) - valueToSub; }

    version(QT_BASIC_ATOMIC_HAS_CONSTRUCTORS)
    {
/+
        QBasicAtomicPointer() = default;
        constexpr QBasicAtomicPointer(Type value) nothrow : _q_value(value) {}
        QBasicAtomicPointer(ref const(QBasicAtomicPointer) ) = delete;
        QBasicAtomicPointer &operator=(ref const(QBasicAtomicPointer) ) = delete;
        QBasicAtomicPointer &operator=(ref const(QBasicAtomicPointer) ) volatile = delete;
+/
    }
}
/+
#ifndef Q_BASIC_ATOMIC_INITIALIZER
#  define Q_BASIC_ATOMIC_INITIALIZER(a) { (a) }
#endif
+/
