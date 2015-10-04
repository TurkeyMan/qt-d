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

module qt.QtCore.qgenericatomic;

public import qt.QtCore.qglobal;
public import qt.QtCore.qtypeinfo;

struct QAtomicOpsSupport(int size) { enum IsSupported = 0; }
struct QAtomicOpsSupport(int size) if(size == 4) { enum IsSupported = 1; }

struct QAtomicAdditiveType(T)
{
    alias AdditiveT = T;
    __gshared immutable int AddScale = 1;
}
struct QAtomicAdditiveType(T) if(isPointer!T)
{
    alias AdditiveT = qptrdiff;
    __gshared immutable int AddScale = T.sizeof;
}

// not really atomic...
struct QGenericAtomicOps(BaseClass)
{
    struct AtomicType(T) { alias Type = T; alias PointerType = T*; }

    static void acquireMemoryFence(T)(ref const T _q_value) nothrow
    {
        atomicFence();
        BaseClass.orderedMemoryFence(_q_value);
    }
    static void releaseMemoryFence(T)(ref const T _q_value) nothrow
    {
        atomicFence();
        BaseClass.orderedMemoryFence(_q_value);
    }
    static void orderedMemoryFence(T)(ref const T) nothrow
    {
    }

    static /+inline+/ /+always_inline+/ T load(T)(ref const T _q_value) nothrow
    {
        return _q_value;
    }

    static /+inline+/ /+always_inline+/ void store(T, X)(ref T _q_value, X newValue) nothrow
    {
        _q_value = newValue;
    }

    static /+inline+/ /+always_inline+/ T loadAcquire(T)(ref const T _q_value) nothrow
    {
        T tmp = _q_value;
        BaseClass.acquireMemoryFence(_q_value);
        return tmp;
    }

    static /+inline+/ /+always_inline+/ void storeRelease(T, X)(ref T _q_value, X newValue) nothrow
    {
        BaseClass.releaseMemoryFence(_q_value);
        _q_value = newValue;
    }

    static /+inline+/ bool isReferenceCountingNative() nothrow
    { return BaseClass.isFetchAndAddNative(); }
    static /+inline+/ bool isReferenceCountingWaitFree() nothrow
    { return BaseClass.isFetchAndAddWaitFree(); }
    static /+inline+/ /+always_inline+/ bool ref_(T)(ref T _q_value) nothrow
    {
        return BaseClass.fetchAndAddRelaxed(_q_value, 1) != T(-1);
    }

    static /+inline+/ /+always_inline+/ bool deref(T)(ref T _q_value) nothrow
    {
         return BaseClass.fetchAndAddRelaxed(_q_value, -1) != 1;
    }

version(none)
{
/+
    // These functions have no default implementation
    // Archictectures must implement them
    static /+inline+/ bool isTestAndSetNative() nothrow;
    static /+inline+/ bool isTestAndSetWaitFree() nothrow;
    static inline
    bool testAndSetRelaxed(T, X)(ref T _q_value, X expectedValue, X newValue) nothrow;
    static inline
    bool testAndSetRelaxed(T, X)(ref T _q_value, X expectedValue, X newValue, X *currentValue) nothrow;
+/
}

    static /+inline+/ /+always_inline+/ bool testAndSetAcquire(T, X)(ref T _q_value, X expectedValue, X newValue) nothrow
    {
        bool tmp = BaseClass.testAndSetRelaxed(_q_value, expectedValue, newValue);
        BaseClass.acquireMemoryFence(_q_value);
        return tmp;
    }

    static /+inline+/ /+always_inline+/ bool testAndSetRelease(T, X)(ref T _q_value, X expectedValue, X newValue) nothrow
    {
        BaseClass.releaseMemoryFence(_q_value);
        return BaseClass.testAndSetRelaxed(_q_value, expectedValue, newValue);
    }

    static /+inline+/ /+always_inline+/ bool testAndSetOrdered(T, X)(ref T _q_value, X expectedValue, X newValue) nothrow
    {
        BaseClass.orderedMemoryFence(_q_value);
        return BaseClass.testAndSetRelaxed(_q_value, expectedValue, newValue);
    }

    static /+inline+/ /+always_inline+/ bool testAndSetAcquire(T, X)(ref T _q_value, X expectedValue, X newValue, X *currentValue) nothrow
    {
        bool tmp = BaseClass.testAndSetRelaxed(_q_value, expectedValue, newValue, currentValue);
        BaseClass.acquireMemoryFence(_q_value);
        return tmp;
    }

    static /+inline+/ /+always_inline+/ bool testAndSetRelease(T, X)(ref T _q_value, X expectedValue, X newValue, X *currentValue) nothrow
    {
        BaseClass.releaseMemoryFence(_q_value);
        return BaseClass.testAndSetRelaxed(_q_value, expectedValue, newValue, currentValue);
    }

    static /+inline+/ /+always_inline+/ bool testAndSetOrdered(T, X)(ref T _q_value, X expectedValue, X newValue, X *currentValue) nothrow
    {
        BaseClass.orderedMemoryFence(_q_value);
        return BaseClass.testAndSetRelaxed(_q_value, expectedValue, newValue, currentValue);
    }

    static /+inline+/ bool isFetchAndStoreNative() nothrow { return false; }
    static /+inline+/ bool isFetchAndStoreWaitFree() nothrow { return false; }

    static /+inline+/ /+always_inline+/ T fetchAndStoreRelaxed(T, X)(ref T _q_value, X newValue) nothrow
    {
        // implement fetchAndStore on top of testAndSet
        while(1) {
            T tmp = load(_q_value);
            if (BaseClass.testAndSetRelaxed(_q_value, tmp, newValue))
                return tmp;
        }
    }

    static /+inline+/ /+always_inline+/ T fetchAndStoreAcquire(T, X)(ref T _q_value, X newValue) nothrow
    {
        T tmp = BaseClass.fetchAndStoreRelaxed(_q_value, newValue);
        BaseClass.acquireMemoryFence(_q_value);
        return tmp;
    }

    static /+inline+/ /+always_inline+/ T fetchAndStoreRelease(T, X)(ref T _q_value, X newValue) nothrow
    {
        BaseClass.releaseMemoryFence(_q_value);
        return BaseClass.fetchAndStoreRelaxed(_q_value, newValue);
    }

    static /+inline+/ /+always_inline+/ T fetchAndStoreOrdered(T, X)(ref T _q_value, X newValue) nothrow
    {
        BaseClass.orderedMemoryFence(_q_value);
        return BaseClass.fetchAndStoreRelaxed(_q_value, newValue);
    }

    static /+inline+/ bool isFetchAndAddNative() nothrow { return false; }
    static /+inline+/ bool isFetchAndAddWaitFree() nothrow { return false; }
    static /+inline+/ /+always_inline+/ T fetchAndAddRelaxed(T)(ref T _q_value, QAtomicAdditiveType!T.AdditiveT valueToAdd) nothrow
    {
        // implement fetchAndAdd on top of testAndSet
        while(1) {
            T tmp = BaseClass.load(_q_value);
            if (BaseClass.testAndSetRelaxed(_q_value, tmp, T(tmp + valueToAdd)))
                return tmp;
        }
    }

    static /+inline+/ /+always_inline+/ T fetchAndAddAcquire(T)(ref T _q_value, QAtomicAdditiveType!T.AdditiveT valueToAdd) nothrow
    {
        T tmp = BaseClass.fetchAndAddRelaxed(_q_value, valueToAdd);
        BaseClass.acquireMemoryFence(_q_value);
        return tmp;
    }

    static /+inline+/ /+always_inline+/ T fetchAndAddRelease(T)(ref T _q_value, QAtomicAdditiveType!T.AdditiveT valueToAdd) nothrow
    {
        BaseClass.releaseMemoryFence(_q_value);
        return BaseClass.fetchAndAddRelaxed(_q_value, valueToAdd);
    }

    static /+inline+/ /+always_inline+/ T fetchAndAddOrdered(T)(ref T _q_value, QAtomicAdditiveType!T.AdditiveT valueToAdd) nothrow
    {
        BaseClass.orderedMemoryFence(_q_value);
        return BaseClass.fetchAndAddRelaxed(_q_value, valueToAdd);
    }

    static /+inline+/ /+always_inline+/ T fetchAndSubRelaxed(T)(ref T _q_value, QAtomicAdditiveType!T.AdditiveT operand) nothrow
    {
        // implement fetchAndSub on top of fetchAndAdd
        return fetchAndAddRelaxed(_q_value, -operand);
    }

    static /+inline+/ /+always_inline+/ T fetchAndSubAcquire(T)(ref T _q_value, QAtomicAdditiveType!T.AdditiveT operand) nothrow
    {
        T tmp = BaseClass.fetchAndSubRelaxed(_q_value, operand);
        BaseClass.acquireMemoryFence(_q_value);
        return tmp;
    }

    static /+inline+/ /+always_inline+/ T fetchAndSubRelease(T)(ref T _q_value, QAtomicAdditiveType!T.AdditiveT operand) nothrow
    {
        BaseClass.releaseMemoryFence(_q_value);
        return BaseClass.fetchAndSubRelaxed(_q_value, operand);
    }

    static /+inline+/ /+always_inline+/ T fetchAndSubOrdered(T)(ref T _q_value, QAtomicAdditiveType!T.AdditiveT operand) nothrow
    {
        BaseClass.orderedMemoryFence(_q_value);
        return BaseClass.fetchAndSubRelaxed(_q_value, operand);
    }
/+ TODO...
    static /+inline+/ /+always_inline+/
    T fetchAndAndRelaxed(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        // implement fetchAndAnd on top of testAndSet
        T tmp = BaseClass.load(_q_value);
        while(1) {
            if (BaseClass.testAndSetRelaxed(_q_value, tmp, T(tmp & operand), &tmp))
                return tmp;
        }
    }

    static /+inline+/ /+always_inline+/
    T fetchAndAndAcquire(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        T tmp = BaseClass.fetchAndAndRelaxed(_q_value, operand);
        BaseClass.acquireMemoryFence(_q_value);
        return tmp;
    }

    static /+inline+/ /+always_inline+/
    T fetchAndAndRelease(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        BaseClass.releaseMemoryFence(_q_value);
        return BaseClass.fetchAndAndRelaxed(_q_value, operand);
    }

    static /+inline+/ /+always_inline+/
    T fetchAndAndOrdered(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        BaseClass.orderedMemoryFence(_q_value);
        return BaseClass.fetchAndAndRelaxed(_q_value, operand);
    }

    static /+inline+/ /+always_inline+/
    T fetchAndOrRelaxed(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        // implement fetchAndOr on top of testAndSet
        T tmp = BaseClass.load(_q_value);
        while(1) {
            if (BaseClass.testAndSetRelaxed(_q_value, tmp, T(tmp | operand), &tmp))
                return tmp;
        }
    }

    static /+inline+/ /+always_inline+/
    T fetchAndOrAcquire(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        T tmp = BaseClass.fetchAndOrRelaxed(_q_value, operand);
        BaseClass.acquireMemoryFence(_q_value);
        return tmp;
    }

    static /+inline+/ /+always_inline+/
    T fetchAndOrRelease(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        BaseClass.releaseMemoryFence(_q_value);
        return BaseClass.fetchAndOrRelaxed(_q_value, operand);
    }

    static /+inline+/ /+always_inline+/
    T fetchAndOrOrdered(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        BaseClass.orderedMemoryFence(_q_value);
        return BaseClass.fetchAndOrRelaxed(_q_value, operand);
    }

    static /+inline+/ /+always_inline+/
    T fetchAndXorRelaxed(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        // implement fetchAndXor on top of testAndSet
        T tmp = BaseClass.load(_q_value);
        while(1) {
            if (BaseClass.testAndSetRelaxed(_q_value, tmp, T(tmp ^ operand), &tmp))
                return tmp;
        }
    }

    static /+inline+/ /+always_inline+/
    T fetchAndXorAcquire(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        T tmp = BaseClass.fetchAndXorRelaxed(_q_value, operand);
        BaseClass.acquireMemoryFence(_q_value);
        return tmp;
    }

    static /+inline+/ /+always_inline+/
    T fetchAndXorRelease(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        BaseClass.releaseMemoryFence(_q_value);
        return BaseClass.fetchAndXorRelaxed(_q_value, operand);
    }

    static /+inline+/ /+always_inline+/
    T fetchAndXorOrdered(T)(ref T _q_value, QtPrivate::QEnableIf<QTypeInfo!T.isIntegral, T>::Type operand) nothrow
    {
        BaseClass.orderedMemoryFence(_q_value);
        return BaseClass.fetchAndXorRelaxed(_q_value, operand);
    }
+/
}
