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
public import QtCore.qatomic;
public import QtCore.qshareddata;

#ifndef Q_QDOC
public import qt.QtCore.qsharedpointer_impl;
#else


// These classes are here to fool qdoc into generating a better documentation

template <class T>
extern(C++) class QSharedPointer
{
public:
    // basic accessor functions
    T *data() const;
    bool isNull() const;
    operator bool() const;
    bool operator!() const;
    T &operator*() const;
    T *operator ->() const;

    // constructors
    QSharedPointer();
    explicit QSharedPointer(T *ptr);
    QSharedPointer(T *ptr, Deleter d);
    QSharedPointer(ref const(QSharedPointer<T>) other);
    QSharedPointer(ref const(QWeakPointer<T>) other);

    ~QSharedPointer() { }

    QSharedPointer<T> &operator=(ref const(QSharedPointer<T>) other);
    QSharedPointer<T> &operator=(ref const(QWeakPointer<T>) other);

    void swap(QSharedPointer<T> &other);

    QWeakPointer<T> toWeakRef() const;

    void clear();

    void reset();
    void reset(T *t);
    template <typename Deleter>
    void reset(T *t, Deleter deleter);

    // casts:
    template <class X> QSharedPointer<X> staticCast() const;
    template <class X> QSharedPointer<X> dynamicCast() const;
    template <class X> QSharedPointer<X> constCast() const;
    template <class X> QSharedPointer<X> objectCast() const;

    static /+inline+/ QSharedPointer<T> create();
    static /+inline+/ QSharedPointer<T> create(...);
}

template <class T>
extern(C++) class QWeakPointer
{
public:
    // basic accessor functions
    bool isNull() const;
    operator bool() const;
    bool operator!() const;

    // constructors:
    QWeakPointer();
    QWeakPointer(ref const(QWeakPointer<T>) other);
    QWeakPointer(ref const(QSharedPointer<T>) other);

    ~QWeakPointer();

    QWeakPointer<T> operator=(ref const(QWeakPointer<T>) other);
    QWeakPointer<T> operator=(ref const(QSharedPointer<T>) other);

    QWeakPointer(const(QObject)* other);
    QWeakPointer<T> operator=(const(QObject)* other);

    void swap(QWeakPointer<T> &other);

    T *data() const;
    void clear();

    QSharedPointer<T> toStrongRef() const;
    QSharedPointer<T> lock() const;
}

template <class T>
extern(C++) class QEnableSharedFromThis
{
public:
    QSharedPointer<T> sharedFromThis();
    QSharedPointer<const T> sharedFromThis() const;
}

template<class T, extern(C++) class X> bool operator==(ref const(QSharedPointer<T>) ptr1, ref const(QSharedPointer<X>) ptr2);
template<class T, extern(C++) class X> bool operator!=(ref const(QSharedPointer<T>) ptr1, ref const(QSharedPointer<X>) ptr2);
template<class T, extern(C++) class X> bool operator==(ref const(QSharedPointer<T>) ptr1, const(X)* ptr2);
template<class T, extern(C++) class X> bool operator!=(ref const(QSharedPointer<T>) ptr1, const(X)* ptr2);
template<class T, extern(C++) class X> bool operator==(const(T)* ptr1, ref const(QSharedPointer<X>) ptr2);
template<class T, extern(C++) class X> bool operator!=(const(T)* ptr1, ref const(QSharedPointer<X>) ptr2);
template<class T, extern(C++) class X> bool operator==(ref const(QWeakPointer<T>) ptr1, ref const(QSharedPointer<X>) ptr2);
template<class T, extern(C++) class X> bool operator!=(ref const(QWeakPointer<T>) ptr1, ref const(QSharedPointer<X>) ptr2);
template<class T, extern(C++) class X> bool operator==(ref const(QSharedPointer<T>) ptr1, ref const(QWeakPointer<X>) ptr2);
template<class T, extern(C++) class X> bool operator!=(ref const(QSharedPointer<T>) ptr1, ref const(QWeakPointer<X>) ptr2);

template <class X, extern(C++) class T> QSharedPointer<X> qSharedPointerCast(ref const(QSharedPointer<T>) other);
template <class X, extern(C++) class T> QSharedPointer<X> qSharedPointerCast(ref const(QWeakPointer<T>) other);
template <class X, extern(C++) class T> QSharedPointer<X> qSharedPointerDynamicCast(ref const(QSharedPointer<T>) src);
template <class X, extern(C++) class T> QSharedPointer<X> qSharedPointerDynamicCast(ref const(QWeakPointer<T>) src);
template <class X, extern(C++) class T> QSharedPointer<X> qSharedPointerConstCast(ref const(QSharedPointer<T>) src);
template <class X, extern(C++) class T> QSharedPointer<X> qSharedPointerConstCast(ref const(QWeakPointer<T>) src);
template <class X, extern(C++) class T> QSharedPointer<X> qSharedPointerObjectCast(ref const(QSharedPointer<T>) src);
template <class X, extern(C++) class T> QSharedPointer<X> qSharedPointerObjectCast(ref const(QWeakPointer<T>) src);

template <class X, extern(C++) class T> QWeakPointer<X> qWeakPointerCast(ref const(QWeakPointer<T>) src);

#endif // Q_QDOC

#endif // QSHAREDPOINTER_H
