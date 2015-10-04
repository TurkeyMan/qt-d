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

module qt.QtCore.qatomic_druntime;

public import qt.QtCore.qgenericatomic;
public import core.atomic;

version = Q_ATOMIC_INT_REFERENCE_COUNTING_IS_SOMETIMES_NATIVE;
version = Q_ATOMIC_INT_TEST_AND_SET_IS_SOMETIMES_NATIVE;
version = Q_ATOMIC_INT_FETCH_AND_STORE_IS_SOMETIMES_NATIVE;
version = Q_ATOMIC_INT_FETCH_AND_ADD_IS_SOMETIMES_NATIVE;

version = Q_ATOMIC_INT32_IS_SUPPORTED;
version = Q_ATOMIC_INT32_REFERENCE_COUNTING_IS_SOMETIMES_NATIVE;
version = Q_ATOMIC_INT32_TEST_AND_SET_IS_SOMETIMES_NATIVE;
version = Q_ATOMIC_INT32_FETCH_AND_STORE_IS_SOMETIMES_NATIVE;
version = Q_ATOMIC_INT32_FETCH_AND_ADD_IS_SOMETIMES_NATIVE;

version = Q_ATOMIC_POINTER_REFERENCE_COUNTING_IS_SOMETIMES_NATIVE;
version = Q_ATOMIC_POINTER_TEST_AND_SET_IS_SOMETIMES_NATIVE;
version = Q_ATOMIC_POINTER_FETCH_AND_STORE_IS_SOMETIMES_NATIVE;
version = Q_ATOMIC_POINTER_FETCH_AND_ADD_IS_SOMETIMES_NATIVE;

struct QAtomicOpsSupport(int size) if(size == 1 || size == 2 || size == 8) { enum IsSupported = true; }

version = Q_ATOMIC_INT8_IS_SUPPORTED;
version = Q_ATOMIC_INT8_REFERENCE_COUNTING_IS_ALWAYS_NATIVE;
version = Q_ATOMIC_INT8_TEST_AND_SET_IS_ALWAYS_NATIVE;
version = Q_ATOMIC_INT8_FETCH_AND_STORE_IS_ALWAYS_NATIVE;
version = Q_ATOMIC_INT8_FETCH_AND_ADD_IS_ALWAYS_NATIVE;

version = Q_ATOMIC_INT16_IS_SUPPORTED;
version = Q_ATOMIC_INT16_REFERENCE_COUNTING_IS_ALWAYS_NATIVE;
version = Q_ATOMIC_INT16_TEST_AND_SET_IS_ALWAYS_NATIVE;
version = Q_ATOMIC_INT16_FETCH_AND_STORE_IS_ALWAYS_NATIVE;
version = Q_ATOMIC_INT16_FETCH_AND_ADD_IS_ALWAYS_NATIVE;

version = Q_ATOMIC_INT64_IS_SUPPORTED;
version = Q_ATOMIC_INT64_REFERENCE_COUNTING_IS_ALWAYS_NATIVE;
version = Q_ATOMIC_INT64_TEST_AND_SET_IS_ALWAYS_NATIVE;
version = Q_ATOMIC_INT64_FETCH_AND_STORE_IS_ALWAYS_NATIVE;
version = Q_ATOMIC_INT64_FETCH_AND_ADD_IS_ALWAYS_NATIVE;

struct QAtomicOps(X)
{
//    typedef std::atomic<X> Type;
    alias Type = X;

    static /+inline+/ T load(T)(ref const shared T _q_value) nothrow
    {
        return atomicLoad!(MemoryOrder.raw)(_q_value);
    }

    static /+inline+/ T loadAcquire(T)(ref const shared T _q_value) nothrow
    {
        return atomicLoad!(MemoryOrder.acq)(_q_value);
    }

    static /+inline+/ void store(T)(ref shared T _q_value, T newValue) nothrow
    {
        atomicStore!(MemoryOrder.raw)(_q_value, newValue);
    }

    static /+inline+/ void storeRelease(T)(ref shared T _q_value, T newValue) nothrow
    {
        atomicStore!(MemoryOrder.rel)(_q_value, newValue);
    }

    static /+inline+/ bool isReferenceCountingNative() nothrow { return true; }
    static /+inline+/ bool isReferenceCountingWaitFree() nothrow { return false; }
    static /+inline+/ bool ref_(T)(ref shared T _q_value)
    {
        return atomicOp!("+")(_q_value, 1) != 0;
    }

    static /+inline+/ bool deref(T)(ref shared T _q_value) nothrow
    {
        return atomicOp!("-")(_q_value, 1) != 0;
    }

    static /+inline+/ bool isTestAndSetNative() nothrow { return false; }
    static /+inline+/ bool isTestAndSetWaitFree() nothrow { return false; }

    static bool testAndSetRelaxed(T)(ref shared T _q_value, T expectedValue, T newValue, T *currentValue = 0) nothrow
    {
        bool tmp = cas!()(_q_value, expectedValue, newValue); // TODO: this isn't done!!
        if (currentValue)
            *currentValue = expectedValue;
        return tmp;
/+
        bool tmp = _q_value.compare_exchange_strong(expectedValue, newValue, std::memory_order_relaxed);
        if (currentValue)
            *currentValue = expectedValue;
        return tmp;
+/
    }

    static bool testAndSetAcquire(T)(ref shared T _q_value, T expectedValue, T newValue, T *currentValue = 0) nothrow
    {
        bool tmp = cas!()(_q_value, expectedValue, newValue); // TODO: this isn't done!!
        if (currentValue)
            *currentValue = expectedValue;
        return tmp;
/+
        bool tmp = _q_value.compare_exchange_strong(expectedValue, newValue, std::memory_order_acquire);
        if (currentValue)
            *currentValue = expectedValue;
        return tmp;
+/
    }

    static bool testAndSetRelease(T)(ref shared T _q_value, T expectedValue, T newValue, T *currentValue = 0) nothrow
    {
        bool tmp = cas!()(_q_value, expectedValue, newValue); // TODO: this isn't done!!
        if (currentValue)
            *currentValue = expectedValue;
        return tmp;
/+
        bool tmp = _q_value.compare_exchange_strong(expectedValue, newValue, std::memory_order_release);
        if (currentValue)
            *currentValue = expectedValue;
        return tmp;
+/
    }

    static bool testAndSetOrdered(T)(ref shared T _q_value, T expectedValue, T newValue, T *currentValue = 0) nothrow
    {
        bool tmp = cas!()(_q_value, expectedValue, newValue); // TODO: this isn't done!!
        if (currentValue)
            *currentValue = expectedValue;
        return tmp;
/+
        bool tmp = _q_value.compare_exchange_strong(expectedValue, newValue, std::memory_order_acq_rel);
        if (currentValue)
            *currentValue = expectedValue;
        return tmp;
+/
    }

    static /+inline+/ bool isFetchAndStoreNative() nothrow { return false; }
    static /+inline+/ bool isFetchAndStoreWaitFree() nothrow { return false; }

    static T fetchAndStoreRelaxed(T)(ref shared T _q_value, T newValue) nothrow
    {
        T t;
        do {
            t = atomicLoad!(MemoryOrder.raw)(_q_value); // TODO: no idea if this is right!
        } while(cas(_q_value, t, newValue));
        return t;
//        return _q_value.exchange(newValue, std::memory_order_relaxed);
    }

    static T fetchAndStoreAcquire(T)(ref shared T _q_value, T newValue) nothrow
    {
        T t;
        do {
            t = atomicLoad!(MemoryOrder.acq)(_q_value); // TODO: no idea if this is right!
        } while(cas(_q_value, t, newValue));
        return t;
//        return _q_value.exchange(newValue, std::memory_order_acquire);
    }

    static T fetchAndStoreRelease(T)(ref shared T _q_value, T newValue) nothrow
    {
        T t;
        do {
            t = atomicLoad!(MemoryOrder.rel)(_q_value); // TODO: no idea if this is right!
        } while(cas(_q_value, t, newValue));
        return t;
//        return _q_value.exchange(newValue, std::memory_order_release);
    }

    static T fetchAndStoreOrdered(T)(ref shared T _q_value, T newValue) nothrow
    {
        T t;
        do {
            t = atomicLoad!(MemoryOrder.seq)(_q_value); // TODO: no idea if this is right!
        } while(cas(_q_value, t, newValue));
        return t;
//        return _q_value.exchange(newValue, std::memory_order_acq_rel);
    }

    static /+inline+/ bool isFetchAndAddNative() nothrow { return false; }
    static /+inline+/ bool isFetchAndAddWaitFree() nothrow { return false; }

    static /+inline+/ T fetchAndAddRelaxed(T)(ref shared T _q_value, QAtomicAdditiveType!T.AdditiveT valueToAdd) nothrow
    {
        return atomicOp!(MemoryOrder.raw)(_q_value, valueToAdd);
//        return _q_value.fetch_add(valueToAdd, std::memory_order_relaxed);
    }

    static /+inline+/ T fetchAndAddAcquire(T)(ref shared T _q_value, QAtomicAdditiveType!T.AdditiveT valueToAdd) nothrow
    {
        return atomicOp!(MemoryOrder.acq)(_q_value, valueToAdd);
//        return _q_value.fetch_add(valueToAdd, std::memory_order_acquire);
    }

    static /+inline+/ T fetchAndAddRelease(T)(ref shared T _q_value, QAtomicAdditiveType!T.AdditiveT valueToAdd) nothrow
    {
        return atomicOp!(MemoryOrder.rel)(_q_value, valueToAdd);
//        return _q_value.fetch_add(valueToAdd, std::memory_order_release);
    }

    static /+inline+/ T fetchAndAddOrdered(T)(ref shared T _q_value, QAtomicAdditiveType!T.AdditiveT valueToAdd) nothrow
    {
        return atomicOp!(MemoryOrder.seq)(_q_value, valueToAdd);
//        return _q_value.fetch_add(valueToAdd, std::memory_order_acq_rel);
    }
}
/+
#ifdef ATOMIC_VAR_INIT
# define Q_BASIC_ATOMIC_INITIALIZER(a)   { ATOMIC_VAR_INIT(a) }
#else
# define Q_BASIC_ATOMIC_INITIALIZER(a)   { {a} }
#endif
+/
