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

#ifndef QT_NO_QFUTURE

public import QtCore.qfutureinterface;
public import QtCore.qstring;


template <typename T>
extern(C++) class QFutureWatcher;
template <>
extern(C++) class QFutureWatcher<void>;

template <typename T>
extern(C++) class QFuture
{
public:
    QFuture()
        : d(QFutureInterface<T>::canceledResult())
    { }
    explicit QFuture(QFutureInterface<T> *p) // internal
        : d(*p)
    { }
    QFuture(ref const(QFuture) other)
        : d(other.d)
    { }
    ~QFuture()
    { }

    /+inline+/ QFuture &operator=(ref const(QFuture) other);
    bool operator==(ref const(QFuture) other) const { return (d == other.d); }
    bool operator!=(ref const(QFuture) other) const { return (d != other.d); }

    void cancel() { d.cancel(); }
    bool isCanceled() const { return d.isCanceled(); }

    void setPaused(bool paused) { d.setPaused(paused); }
    bool isPaused() const { return d.isPaused(); }
    void pause() { setPaused(true); }
    void resume() { setPaused(false); }
    void togglePaused() { d.togglePaused(); }

    bool isStarted() const { return d.isStarted(); }
    bool isFinished() const { return d.isFinished(); }
    bool isRunning() const { return d.isRunning(); }

    int resultCount() const { return d.resultCount(); }
    int progressValue() const { return d.progressValue(); }
    int progressMinimum() const { return d.progressMinimum(); }
    int progressMaximum() const { return d.progressMaximum(); }
    QString progressText() const { return d.progressText(); }
    void waitForFinished() { d.waitForFinished(); }

    /+inline+/ T result() const;
    /+inline+/ T resultAt(int index) const;
    bool isResultReadyAt(int resultIndex) const { return d.isResultReadyAt(resultIndex); }

    operator T() const { return result(); }
    QList<T> results() const { return d.results(); }

    extern(C++) class const_iterator
    {
    public:
        typedef std::bidirectional_iterator_tag iterator_category;
        typedef qptrdiff difference_type;
        typedef T value_type;
        typedef const(T)* pointer;
        typedef ref const(T) reference;

        /+inline+/ const_iterator() {}
        /+inline+/ const_iterator(QFuture const * const _future, int _index) : future(_future), index(_index) {}
        /+inline+/ const_iterator(ref const(const_iterator) o) : future(o.future), index(o.index)  {}
        /+inline+/ const_iterator &operator=(ref const(const_iterator) o)
        { future = o.future; index = o.index; return *this; }
        /+inline+/ ref const(T) operator*() const { return future->d.resultReference(index); }
        /+inline+/ const(T)* operator->() const { return future->d.resultPointer(index); }

        /+inline+/ bool operator!=(ref const(const_iterator) other) const
        {
            if (index == -1 && other.index == -1) // comparing end != end?
                return false;
            if (other.index == -1)
                return (future->isRunning() || (index < future->resultCount()));
            return (index != other.index);
        }

        /+inline+/ bool operator==(ref const(const_iterator) o) const { return !operator!=(o); }
        /+inline+/ const_iterator &operator++() { ++index; return *this; }
        /+inline+/ const_iterator operator++(int) { const_iterator r = *this; ++index; return r; }
        /+inline+/ const_iterator &operator--() { --index; return *this; }
        /+inline+/ const_iterator operator--(int) { const_iterator r = *this; --index; return r; }
        /+inline+/ const_iterator operator+(int j) const { return const_iterator(future, index + j); }
        /+inline+/ const_iterator operator-(int j) const { return const_iterator(future, index - j); }
        /+inline+/ const_iterator &operator+=(int j) { index += j; return *this; }
        /+inline+/ const_iterator &operator-=(int j) { index -= j; return *this; }
    private:
        QFuture const * future;
        int index;
    }
    friend extern(C++) class const_iterator;
    typedef const_iterator ConstIterator;

    const_iterator begin() const { return  const_iterator(this, 0); }
    const_iterator constBegin() const { return  const_iterator(this, 0); }
    const_iterator end() const { return const_iterator(this, -1); }
    const_iterator constEnd() const { return const_iterator(this, -1); }

private:
    friend extern(C++) class QFutureWatcher<T>;

public: // Warning: the d pointer is not documented and is considered private.
    mutable QFutureInterface<T> d;
}

template <typename T>
/+inline+/ QFuture<T> &QFuture<T>::operator=(ref const(QFuture<T>) other)
{
    d = other.d;
    return *this;
}

template <typename T>
/+inline+/ T QFuture<T>::result() const
{
    d.waitForResult(0);
    return d.resultReference(0);
}

template <typename T>
/+inline+/ T QFuture<T>::resultAt(int index) const
{
    d.waitForResult(index);
    return d.resultReference(index);
}

template <typename T>
/+inline+/ QFuture<T> QFutureInterface<T>::future()
{
    return QFuture<T>(this);
}

Q_DECLARE_SEQUENTIAL_ITERATOR(Future)

template <>
extern(C++) class QFuture<void>
{
public:
    QFuture()
        : d(QFutureInterface<void>::canceledResult())
    { }
    explicit QFuture(QFutureInterfaceBase *p) // internal
        : d(*p)
    { }
    QFuture(ref const(QFuture) other)
        : d(other.d)
    { }
    ~QFuture()
    { }

    QFuture &operator=(ref const(QFuture) other);
    bool operator==(ref const(QFuture) other) const { return (d == other.d); }
    bool operator!=(ref const(QFuture) other) const { return (d != other.d); }

#if !defined(Q_CC_XLC)
    template <typename T>
    QFuture(ref const(QFuture<T>) other)
        : d(other.d)
    { }

    template <typename T>
    QFuture<void> &operator=(ref const(QFuture<T>) other)
    {
        d = other.d;
        return *this;
    }
#endif

    void cancel() { d.cancel(); }
    bool isCanceled() const { return d.isCanceled(); }

    void setPaused(bool paused) { d.setPaused(paused); }
    bool isPaused() const { return d.isPaused(); }
    void pause() { setPaused(true); }
    void resume() { setPaused(false); }
    void togglePaused() { d.togglePaused(); }

    bool isStarted() const { return d.isStarted(); }
    bool isFinished() const { return d.isFinished(); }
    bool isRunning() const { return d.isRunning(); }

    int resultCount() const { return d.resultCount(); }
    int progressValue() const { return d.progressValue(); }
    int progressMinimum() const { return d.progressMinimum(); }
    int progressMaximum() const { return d.progressMaximum(); }
    QString progressText() const { return d.progressText(); }
    void waitForFinished() { d.waitForFinished(); }

private:
    friend extern(C++) class QFutureWatcher<void>;

#ifdef QFUTURE_TEST
public:
#endif
    mutable QFutureInterfaceBase d;
}

/+inline+/ QFuture<void> &QFuture<void>::operator=(ref const(QFuture<void>) other)
{
    d = other.d;
    return *this;
}

/+inline+/ QFuture<void> QFutureInterface<void>::future()
{
    return QFuture<void>(this);
}

template <typename T>
QFuture<void> qToVoidFuture(ref const(QFuture<T>) future)
{
    return QFuture<void>(future.d);
}

#endif // QT_NO_QFUTURE

#endif // QFUTURE_H
