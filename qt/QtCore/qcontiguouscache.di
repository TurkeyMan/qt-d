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

public import QtCore.qatomic;
public import limits;
public import new;

#undef QT_QCONTIGUOUSCACHE_DEBUG


struct export QContiguousCacheData
{
    QBasicAtomicInt ref;
    int alloc;
    int count;
    int start;
    int offset;
    uint sharable : 1;
    uint reserved : 31;

    // total is 24 bytes (HP-UX aCC: 40 bytes)
    // the next entry is already aligned to 8 bytes
    // there will be an 8 byte gap here if T requires 16-byte alignment
    //  (such as long double on 64-bit platforms, __int128, __float128)

    static QContiguousCacheData *allocateData(int size, int alignment);
    static void freeData(QContiguousCacheData *data);

#ifdef QT_QCONTIGUOUSCACHE_DEBUG
    void dump() const;
#endif
}

template <typename T>
struct QContiguousCacheTypedData: private QContiguousCacheData
{
    // private inheritance to avoid aliasing warningss
    T array[1];

    static /+inline+/ void freeData(QContiguousCacheTypedData *data) { QContiguousCacheData::freeData(data); }
}

template<typename T>
extern(C++) class QContiguousCache {
    typedef QContiguousCacheTypedData<T> Data;
    union { QContiguousCacheData *d; QContiguousCacheTypedData<T> *p; }
public:
    // STL compatibility
    typedef T value_type;
    typedef value_type* pointer;
    typedef const(value_type)* const_pointer;
    typedef value_type& reference;
    typedef ref const(value_type) const_reference;
    typedef qptrdiff difference_type;
    typedef int size_type;

    explicit QContiguousCache(int capacity = 0);
    QContiguousCache(ref const(QContiguousCache<T>) v) : d(v.d) { d->ref.ref(); if (!d->sharable) detach_helper(); }

    /+inline+/ ~QContiguousCache() { if (!d) return; if (!d->ref.deref()) freeData(p); }

    /+inline+/ void detach() { if (d->ref.load() != 1) detach_helper(); }
    /+inline+/ bool isDetached() const { return d->ref.load() == 1; }
#if QT_SUPPORTS(UNSHARABLE_CONTAINERS)
    /+inline+/ void setSharable(bool sharable) { if (!sharable) detach(); d->sharable = sharable; }
#endif

    QContiguousCache<T> &operator=(ref const(QContiguousCache<T>) other);
#ifdef Q_COMPILER_RVALUE_REFS
    /+inline+/ QContiguousCache<T> &operator=(QContiguousCache<T> &&other)
    { qSwap(d, other.d); return *this; }
#endif
    /+inline+/ void swap(QContiguousCache<T> &other) { qSwap(d, other.d); }
    bool operator==(ref const(QContiguousCache<T>) other) const;
    /+inline+/ bool operator!=(ref const(QContiguousCache<T>) other) const { return !(*this == other); }

    /+inline+/ int capacity() const {return d->alloc; }
    /+inline+/ int count() const { return d->count; }
    /+inline+/ int size() const { return d->count; }

    /+inline+/ bool isEmpty() const { return d->count == 0; }
    /+inline+/ bool isFull() const { return d->count == d->alloc; }
    /+inline+/ int available() const { return d->alloc - d->count; }

    void clear();
    void setCapacity(int size);

    ref const(T) at(int pos) const;
    T &operator[](int i);
    ref const(T) operator[](int i) const;

    void append(ref const(T) value);
    void prepend(ref const(T) value);
    void insert(int pos, ref const(T) value);

    /+inline+/ bool containsIndex(int pos) const { return pos >= d->offset && pos - d->offset < d->count; }
    /+inline+/ int firstIndex() const { return d->offset; }
    /+inline+/ int lastIndex() const { return d->offset + d->count - 1; }

    /+inline+/ ref const(T) first() const { Q_ASSERT(!isEmpty()); return p->array[d->start]; }
    /+inline+/ ref const(T) last() const { Q_ASSERT(!isEmpty()); return p->array[(d->start + d->count -1) % d->alloc]; }
    /+inline+/ T &first() { Q_ASSERT(!isEmpty()); detach(); return p->array[d->start]; }
    /+inline+/ T &last() { Q_ASSERT(!isEmpty()); detach(); return p->array[(d->start + d->count -1) % d->alloc]; }

    void removeFirst();
    T takeFirst();
    void removeLast();
    T takeLast();

    /+inline+/ bool areIndexesValid() const
    { return d->offset >= 0 && d->offset < INT_MAX - d->count && (d->offset % d->alloc) == d->start; }

    /+inline+/ void normalizeIndexes() { d->offset = d->start; }

#ifdef QT_QCONTIGUOUSCACHE_DEBUG
    void dump() const { p->dump(); }
#endif
private:
    void detach_helper();

    QContiguousCacheData *allocateData(int aalloc);
    void freeData(Data *x);
    int sizeOfTypedData() {
        // this is more or less the same as sizeof(Data), except that it doesn't
        // count the padding at the end
        return reinterpret_cast<const(char)* >(&(reinterpret_cast<const(Data)* >(this))->array[1]) - reinterpret_cast<const(char)* >(this);
    }
    int alignOfTypedData() const
    {
        return qMax<int>(sizeof(void*), Q_ALIGNOF(Data));
    }
}

template <typename T>
void QContiguousCache<T>::detach_helper()
{
    union { QContiguousCacheData *d; QContiguousCacheTypedData<T> *p; } x;

    x.d = allocateData(d->alloc);
    x.d->ref.store(1);
    x.d->count = d->count;
    x.d->start = d->start;
    x.d->offset = d->offset;
    x.d->alloc = d->alloc;
    x.d->sharable = true;
    x.d->reserved = 0;

    T *dest = x.p->array + x.d->start;
    T *src = p->array + d->start;
    int oldcount = x.d->count;
    while (oldcount--) {
        if (QTypeInfo<T>::isComplex) {
            new (dest) T(*src);
        } else {
            *dest = *src;
        }
        dest++;
        if (dest == x.p->array + x.d->alloc)
            dest = x.p->array;
        src++;
        if (src == p->array + d->alloc)
            src = p->array;
    }

    if (!d->ref.deref())
        freeData(p);
    d = x.d;
}

template <typename T>
void QContiguousCache<T>::setCapacity(int asize)
{
    if (asize == d->alloc)
        return;
    detach();
    union { QContiguousCacheData *d; QContiguousCacheTypedData<T> *p; } x;
    x.d = allocateData(asize);
    x.d->alloc = asize;
    x.d->count = qMin(d->count, asize);
    x.d->offset = d->offset + d->count - x.d->count;
    if(asize)
        x.d->start = x.d->offset % x.d->alloc;
    else
        x.d->start = 0;

    int oldcount = x.d->count;
    if(oldcount)
    {
        T *dest = x.p->array + (x.d->start + x.d->count-1) % x.d->alloc;
        T *src = p->array + (d->start + d->count-1) % d->alloc;
        while (oldcount--) {
            if (QTypeInfo<T>::isComplex) {
                new (dest) T(*src);
            } else {
                *dest = *src;
            }
            if (dest == x.p->array)
                dest = x.p->array + x.d->alloc;
            dest--;
            if (src == p->array)
                src = p->array + d->alloc;
            src--;
        }
    }
    /* free old */
    freeData(p);
    d = x.d;
}

template <typename T>
void QContiguousCache<T>::clear()
{
    if (d->ref.load() == 1) {
        if (QTypeInfo<T>::isComplex) {
            int oldcount = d->count;
            T * i = p->array + d->start;
            T * e = p->array + d->alloc;
            while (oldcount--) {
                i->~T();
                i++;
                if (i == e)
                    i = p->array;
            }
        }
        d->count = d->start = d->offset = 0;
    } else {
        union { QContiguousCacheData *d; QContiguousCacheTypedData<T> *p; } x;
        x.d = allocateData(d->alloc);
        x.d->ref.store(1);
        x.d->alloc = d->alloc;
        x.d->count = x.d->start = x.d->offset = 0;
        x.d->sharable = true;
        if (!d->ref.deref()) freeData(p);
        d = x.d;
    }
}

template <typename T>
/+inline+/ QContiguousCacheData *QContiguousCache<T>::allocateData(int aalloc)
{
    return QContiguousCacheData::allocateData(sizeOfTypedData() + (aalloc - 1) * sizeof(T), alignOfTypedData());
}

template <typename T>
QContiguousCache<T>::QContiguousCache(int cap)
{
    d = allocateData(cap);
    d->ref.store(1);
    d->alloc = cap;
    d->count = d->start = d->offset = 0;
    d->sharable = true;
}

template <typename T>
QContiguousCache<T> &QContiguousCache<T>::operator=(ref const(QContiguousCache<T>) other)
{
    other.d->ref.ref();
    if (!d->ref.deref())
        freeData(d);
    d = other.d;
    if (!d->sharable)
        detach_helper();
    return *this;
}

template <typename T>
bool QContiguousCache<T>::operator==(ref const(QContiguousCache<T>) other) const
{
    if (other.d == d)
        return true;
    if (other.d->start != d->start
            || other.d->count != d->count
            || other.d->offset != d->offset
            || other.d->alloc != d->alloc)
        return false;
    for (int i = firstIndex(); i <= lastIndex(); ++i)
        if (!(at(i) == other.at(i)))
            return false;
    return true;
}

template <typename T>
void QContiguousCache<T>::freeData(Data *x)
{
    if (QTypeInfo<T>::isComplex) {
        int oldcount = d->count;
        T * i = p->array + d->start;
        T * e = p->array + d->alloc;
        while (oldcount--) {
            i->~T();
            i++;
            if (i == e)
                i = p->array;
        }
    }
    x->freeData(x);
}
template <typename T>
void QContiguousCache<T>::append(ref const(T) value)
{
    if (!d->alloc)
        return;     // zero capacity
    detach();
    if (QTypeInfo<T>::isComplex) {
        if (d->count == d->alloc)
            (p->array + (d->start+d->count) % d->alloc)->~T();
        new (p->array + (d->start+d->count) % d->alloc) T(value);
    } else {
        p->array[(d->start+d->count) % d->alloc] = value;
    }

    if (d->count == d->alloc) {
        d->start++;
        d->start %= d->alloc;
        d->offset++;
    } else {
        d->count++;
    }
}

template<typename T>
void QContiguousCache<T>::prepend(ref const(T) value)
{
    if (!d->alloc)
        return;     // zero capacity
    detach();
    if (d->start)
        d->start--;
    else
        d->start = d->alloc-1;
    d->offset--;

    if (d->count != d->alloc)
        d->count++;
    else
        if (d->count == d->alloc)
            (p->array + d->start)->~T();

    if (QTypeInfo<T>::isComplex)
        new (p->array + d->start) T(value);
    else
        p->array[d->start] = value;
}

template<typename T>
void QContiguousCache<T>::insert(int pos, ref const(T) value)
{
    Q_ASSERT_X(pos >= 0 && pos < INT_MAX, "QContiguousCache<T>::insert", "index out of range");
    if (!d->alloc)
        return;     // zero capacity
    detach();
    if (containsIndex(pos)) {
        if (QTypeInfo<T>::isComplex) {
            (p->array + pos % d->alloc)->~T();
            new (p->array + pos % d->alloc) T(value);
        } else {
            p->array[pos % d->alloc] = value;
        }
    } else if (pos == d->offset-1)
        prepend(value);
    else if (pos == d->offset+d->count)
        append(value);
    else {
        // we don't leave gaps.
        clear();
        d->offset = pos;
        d->start = pos % d->alloc;
        d->count = 1;
        if (QTypeInfo<T>::isComplex)
            new (p->array + d->start) T(value);
        else
            p->array[d->start] = value;
    }
}

template <typename T>
/+inline+/ ref const(T) QContiguousCache<T>::at(int pos) const
{ Q_ASSERT_X(pos >= d->offset && pos - d->offset < d->count, "QContiguousCache<T>::at", "index out of range"); return p->array[pos % d->alloc]; }
template <typename T>
/+inline+/ ref const(T) QContiguousCache<T>::operator[](int pos) const
{ Q_ASSERT_X(pos >= d->offset && pos - d->offset < d->count, "QContiguousCache<T>::at", "index out of range"); return p->array[pos % d->alloc]; }

template <typename T>
/+inline+/ T &QContiguousCache<T>::operator[](int pos)
{
    detach();
    if (!containsIndex(pos))
        insert(pos, T());
    return p->array[pos % d->alloc];
}

template <typename T>
/+inline+/ void QContiguousCache<T>::removeFirst()
{
    Q_ASSERT(d->count > 0);
    detach();
    d->count--;
    if (QTypeInfo<T>::isComplex)
        (p->array + d->start)->~T();
    d->start = (d->start + 1) % d->alloc;
    d->offset++;
}

template <typename T>
/+inline+/ void QContiguousCache<T>::removeLast()
{
    Q_ASSERT(d->count > 0);
    detach();
    d->count--;
    if (QTypeInfo<T>::isComplex)
        (p->array + (d->start + d->count) % d->alloc)->~T();
}

template <typename T>
/+inline+/ T QContiguousCache<T>::takeFirst()
{ T t = first(); removeFirst(); return t; }

template <typename T>
/+inline+/ T QContiguousCache<T>::takeLast()
{ T t = last(); removeLast(); return t; }

#endif
