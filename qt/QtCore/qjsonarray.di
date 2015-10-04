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

public import QtCore.qjsonvalue;
public import QtCore.qiterator;
#if defined(Q_COMPILER_INITIALIZER_LISTS)
public import initializer_list;
#endif

extern(C++) class QDebug;
extern(C++) class QStringList;
template <typename T> extern(C++) class QList;
typedef QList<QVariant> QVariantList;

extern(C++) class export QJsonArray
{
public:
    QJsonArray();

#if defined(Q_COMPILER_INITIALIZER_LISTS) || defined(Q_QDOC)
    QJsonArray(std::initializer_list<QJsonValue> args)
    {
        initialize();
        for (std::initializer_list<QJsonValue>::const_iterator i = args.begin(); i != args.end(); ++i)
            append(*i);
    }
#endif

    ~QJsonArray();

    QJsonArray(ref const(QJsonArray) other);
    QJsonArray &operator =(ref const(QJsonArray) other);

    static QJsonArray fromStringList(ref const(QStringList) list);
    static QJsonArray fromVariantList(ref const(QVariantList) list);
    QVariantList toVariantList() const;

    int size() const;
    /+inline+/ int count() const { return size(); }

    bool isEmpty() const;
    QJsonValue at(int i) const;
    QJsonValue first() const;
    QJsonValue last() const;

    void prepend(ref const(QJsonValue) value);
    void append(ref const(QJsonValue) value);
    void removeAt(int i);
    QJsonValue takeAt(int i);
    /+inline+/ void removeFirst() { removeAt(0); }
    /+inline+/ void removeLast() { removeAt(size() - 1); }

    void insert(int i, ref const(QJsonValue) value);
    void replace(int i, ref const(QJsonValue) value);

    bool contains(ref const(QJsonValue) element) const;
    QJsonValueRef operator[](int i);
    QJsonValue operator[](int i) const;

    bool operator==(ref const(QJsonArray) other) const;
    bool operator!=(ref const(QJsonArray) other) const;

    extern(C++) class const_iterator;

    extern(C++) class iterator {
    public:
        QJsonArray *a;
        int i;
        typedef std::random_access_iterator_tag  iterator_category;
        typedef int difference_type;
        typedef QJsonValue value_type;
        typedef QJsonValueRef reference;
        typedef QJsonValueRefPtr pointer;

        /+inline+/ iterator() : a(0), i(0) { }
        explicit /+inline+/ iterator(QJsonArray *array, int index) : a(array), i(index) { }

        /+inline+/ QJsonValueRef operator*() const { return QJsonValueRef(a, i); }
#ifdef Q_QDOC
        /+inline+/ QJsonValueRef* operator->() const;
#else
        /+inline+/ QJsonValueRefPtr operator->() const { return QJsonValueRefPtr(a, i); }
#endif
        /+inline+/ QJsonValueRef operator[](int j) const { return QJsonValueRef(a, i + j); }

        /+inline+/ bool operator==(ref const(iterator) o) const { return i == o.i; }
        /+inline+/ bool operator!=(ref const(iterator) o) const { return i != o.i; }
        /+inline+/ bool operator<(ref const(iterator) other) const { return i < other.i; }
        /+inline+/ bool operator<=(ref const(iterator) other) const { return i <= other.i; }
        /+inline+/ bool operator>(ref const(iterator) other) const { return i > other.i; }
        /+inline+/ bool operator>=(ref const(iterator) other) const { return i >= other.i; }
        /+inline+/ bool operator==(ref const(const_iterator) o) const { return i == o.i; }
        /+inline+/ bool operator!=(ref const(const_iterator) o) const { return i != o.i; }
        /+inline+/ bool operator<(ref const(const_iterator) other) const { return i < other.i; }
        /+inline+/ bool operator<=(ref const(const_iterator) other) const { return i <= other.i; }
        /+inline+/ bool operator>(ref const(const_iterator) other) const { return i > other.i; }
        /+inline+/ bool operator>=(ref const(const_iterator) other) const { return i >= other.i; }
        /+inline+/ iterator &operator++() { ++i; return *this; }
        /+inline+/ iterator operator++(int) { iterator n = *this; ++i; return n; }
        /+inline+/ iterator &operator--() { i--; return *this; }
        /+inline+/ iterator operator--(int) { iterator n = *this; i--; return n; }
        /+inline+/ iterator &operator+=(int j) { i+=j; return *this; }
        /+inline+/ iterator &operator-=(int j) { i-=j; return *this; }
        /+inline+/ iterator operator+(int j) const { return iterator(a, i+j); }
        /+inline+/ iterator operator-(int j) const { return iterator(a, i-j); }
        /+inline+/ int operator-(iterator j) const { return i - j.i; }
    }
    friend extern(C++) class iterator;

    extern(C++) class const_iterator {
    public:
        const(QJsonArray)* a;
        int i;
        typedef std::random_access_iterator_tag  iterator_category;
        typedef qptrdiff difference_type;
        typedef QJsonValue value_type;
        typedef QJsonValue reference;
        typedef QJsonValuePtr pointer;

        /+inline+/ const_iterator() : a(0), i(0) { }
        explicit /+inline+/ const_iterator(const(QJsonArray)* array, int index) : a(array), i(index) { }
        /+inline+/ const_iterator(ref const(const_iterator) o) : a(o.a), i(o.i) {}
        /+inline+/ const_iterator(ref const(iterator) o) : a(o.a), i(o.i) {}

        /+inline+/ QJsonValue operator*() const { return a->at(i); }
#ifdef Q_QDOC
        /+inline+/ QJsonValue* operator->() const;
#else
        /+inline+/ QJsonValuePtr operator->() const { return QJsonValuePtr(a->at(i)); }
#endif
        /+inline+/ QJsonValue operator[](int j) const { return a->at(i+j); }
        /+inline+/ bool operator==(ref const(const_iterator) o) const { return i == o.i; }
        /+inline+/ bool operator!=(ref const(const_iterator) o) const { return i != o.i; }
        /+inline+/ bool operator<(ref const(const_iterator) other) const { return i < other.i; }
        /+inline+/ bool operator<=(ref const(const_iterator) other) const { return i <= other.i; }
        /+inline+/ bool operator>(ref const(const_iterator) other) const { return i > other.i; }
        /+inline+/ bool operator>=(ref const(const_iterator) other) const { return i >= other.i; }
        /+inline+/ const_iterator &operator++() { ++i; return *this; }
        /+inline+/ const_iterator operator++(int) { const_iterator n = *this; ++i; return n; }
        /+inline+/ const_iterator &operator--() { i--; return *this; }
        /+inline+/ const_iterator operator--(int) { const_iterator n = *this; i--; return n; }
        /+inline+/ const_iterator &operator+=(int j) { i+=j; return *this; }
        /+inline+/ const_iterator &operator-=(int j) { i-=j; return *this; }
        /+inline+/ const_iterator operator+(int j) const { return const_iterator(a, i+j); }
        /+inline+/ const_iterator operator-(int j) const { return const_iterator(a, i-j); }
        /+inline+/ int operator-(const_iterator j) const { return i - j.i; }
    }
    friend extern(C++) class const_iterator;

    // stl style
    /+inline+/ iterator begin() { detach(); return iterator(this, 0); }
    /+inline+/ const_iterator begin() const { return const_iterator(this, 0); }
    /+inline+/ const_iterator constBegin() const { return const_iterator(this, 0); }
    /+inline+/ iterator end() { detach(); return iterator(this, size()); }
    /+inline+/ const_iterator end() const { return const_iterator(this, size()); }
    /+inline+/ const_iterator constEnd() const { return const_iterator(this, size()); }
    iterator insert(iterator before, ref const(QJsonValue) value) { insert(before.i, value); return before; }
    iterator erase(iterator it) { removeAt(it.i); return it; }

    // more Qt
    typedef iterator Iterator;
    typedef const_iterator ConstIterator;

    // convenience
    /+inline+/ QJsonArray operator+(ref const(QJsonValue) v) const
    { QJsonArray n = *this; n += v; return n; }
    /+inline+/ QJsonArray &operator+=(ref const(QJsonValue) v)
    { append(v); return *this; }
    /+inline+/ QJsonArray &operator<< (ref const(QJsonValue) v)
    { append(v); return *this; }

    // stl compatibility
    /+inline+/ void push_back(ref const(QJsonValue) t) { append(t); }
    /+inline+/ void push_front(ref const(QJsonValue) t) { prepend(t); }
    /+inline+/ void pop_front() { removeFirst(); }
    /+inline+/ void pop_back() { removeLast(); }
    /+inline+/ bool empty() const { return isEmpty(); }
    typedef int size_type;
    typedef QJsonValue value_type;
    typedef value_type *pointer;
    typedef const(value_type)* const_pointer;
    typedef QJsonValueRef reference;
    typedef QJsonValue const_reference;
    typedef int difference_type;

private:
    friend extern(C++) class QJsonPrivate::Data;
    friend extern(C++) class QJsonValue;
    friend extern(C++) class QJsonDocument;
    friend export QDebug operator<<(QDebug, ref const(QJsonArray) );

    QJsonArray(QJsonPrivate::Data *data, QJsonPrivate::Array *array);
    void initialize();
    void compact();
    void detach(uint reserve = 0);

    QJsonPrivate::Data *d;
    QJsonPrivate::Array *a;
}

#if !defined(QT_NO_DEBUG_STREAM) && !defined(QT_JSON_READONLY)
export QDebug operator<<(QDebug, ref const(QJsonArray) );
#endif

#endif // QJSONARRAY_H