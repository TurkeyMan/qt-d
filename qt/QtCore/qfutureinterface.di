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

public import QtCore.qrunnable;

#ifndef QT_NO_QFUTURE

public import QtCore.qmutex;
public import QtCore.qexception;
public import QtCore.qresultstore;


template <typename T> extern(C++) class QFuture;
extern(C++) class QThreadPool;
extern(C++) class QFutureInterfaceBasePrivate;
extern(C++) class QFutureWatcherBase;
extern(C++) class QFutureWatcherBasePrivate;

extern(C++) class export QFutureInterfaceBase
{
public:
    enum State {
        NoState   = 0x00,
        Running   = 0x01,
        Started   = 0x02,
        Finished  = 0x04,
        Canceled  = 0x08,
        Paused    = 0x10,
        Throttled = 0x20
    }

    QFutureInterfaceBase(State initialState = NoState);
    QFutureInterfaceBase(ref const(QFutureInterfaceBase) other);
    /+virtual+/ ~QFutureInterfaceBase();

    // reporting functions available to the engine author:
    void reportStarted();
    void reportFinished();
    void reportCanceled();
#ifndef QT_NO_EXCEPTIONS
    void reportException(ref const(QException) e);
#endif
    void reportResultsReady(int beginIndex, int endIndex);

    void setRunnable(QRunnable *runnable);
    void setThreadPool(QThreadPool *pool);
    void setFilterMode(bool enable);
    void setProgressRange(int minimum, int maximum);
    int progressMinimum() const;
    int progressMaximum() const;
    bool isProgressUpdateNeeded() const;
    void setProgressValue(int progressValue);
    int progressValue() const;
    void setProgressValueAndText(int progressValue, ref const(QString) progressText);
    QString progressText() const;

    void setExpectedResultCount(int resultCount);
    int expectedResultCount();
    int resultCount() const;

    bool queryState(State state) const;
    bool isRunning() const;
    bool isStarted() const;
    bool isCanceled() const;
    bool isFinished() const;
    bool isPaused() const;
    bool isThrottled() const;
    bool isResultReadyAt(int index) const;

    void cancel();
    void setPaused(bool paused);
    void togglePaused();
    void setThrottled(bool enable);

    void waitForFinished();
    bool waitForNextResult();
    void waitForResult(int resultIndex);
    void waitForResume();

    QMutex *mutex() const;
    QtPrivate::ExceptionStore &exceptionStore();
    QtPrivate::ResultStoreBase &resultStoreBase();
    ref const(QtPrivate::ResultStoreBase) resultStoreBase() const;

    /+inline+/ bool operator==(ref const(QFutureInterfaceBase) other) const { return d == other.d; }
    /+inline+/ bool operator!=(ref const(QFutureInterfaceBase) other) const { return d != other.d; }
    QFutureInterfaceBase &operator=(ref const(QFutureInterfaceBase) other);

protected:
    bool refT() const;
    bool derefT() const;
public:

#ifndef QFUTURE_TEST
private:
#endif
    QFutureInterfaceBasePrivate *d;

private:
    friend extern(C++) class QFutureWatcherBase;
    friend extern(C++) class QFutureWatcherBasePrivate;
}

template <typename T>
extern(C++) class QFutureInterface : QFutureInterfaceBase
{
public:
    QFutureInterface(State initialState = NoState)
        : QFutureInterfaceBase(initialState)
    {
        refT();
    }
    QFutureInterface(ref const(QFutureInterface) other)
        : QFutureInterfaceBase(other)
    {
        refT();
    }
    ~QFutureInterface()
    {
        if (!derefT())
            resultStore().clear();
    }

    static QFutureInterface canceledResult()
    { return QFutureInterface(State(Started | Finished | Canceled)); }

    QFutureInterface &operator=(ref const(QFutureInterface) other)
    {
        other.refT();
        if (!derefT())
            resultStore().clear();
        QFutureInterfaceBase::operator=(other);
        return *this;
    }

    /+inline+/ QFuture<T> future(); // implemented in qfuture.h

    /+inline+/ void reportResult(const(T)* result, int index = -1);
    /+inline+/ void reportResult(ref const(T) result, int index = -1);
    /+inline+/ void reportResults(ref const(QVector<T>) results, int beginIndex = -1, int count = -1);
    /+inline+/ void reportFinished(const(T)* result = 0);

    /+inline+/ ref const(T) resultReference(int index) const;
    /+inline+/ const(T)* resultPointer(int index) const;
    /+inline+/ QList<T> results();
private:
    QtPrivate::ResultStore<T> &resultStore()
    { return static_cast<QtPrivate::ResultStore<T> &>(resultStoreBase()); }
    ref const(QtPrivate::ResultStore<T>) resultStore() const
    { return static_cast<ref const(QtPrivate::ResultStore<T>) >(resultStoreBase()); }
}

template <typename T>
/+inline+/ void QFutureInterface<T>::reportResult(const(T)* result, int index)
{
    QMutexLocker locker(mutex());
    if (this->queryState(Canceled) || this->queryState(Finished)) {
        return;
    }

    QtPrivate::ResultStore<T> &store = resultStore();


    if (store.filterMode()) {
        const int resultCountBefore = store.count();
        store.addResult(index, result);
        this->reportResultsReady(resultCountBefore, resultCountBefore + store.count());
    } else {
        const int insertIndex = store.addResult(index, result);
        this->reportResultsReady(insertIndex, insertIndex + 1);
    }
}

template <typename T>
/+inline+/ void QFutureInterface<T>::reportResult(ref const(T) result, int index)
{
    reportResult(&result, index);
}

template <typename T>
/+inline+/ void QFutureInterface<T>::reportResults(ref const(QVector<T>) _results, int beginIndex, int count)
{
    QMutexLocker locker(mutex());
    if (this->queryState(Canceled) || this->queryState(Finished)) {
        return;
    }

    QtPrivate::ResultStore<T> &store = resultStore();

    if (store.filterMode()) {
        const int resultCountBefore = store.count();
        store.addResults(beginIndex, &_results, count);
        this->reportResultsReady(resultCountBefore, store.count());
    } else {
        const int insertIndex = store.addResults(beginIndex, &_results, count);
        this->reportResultsReady(insertIndex, insertIndex + _results.count());
    }
}

template <typename T>
/+inline+/ void QFutureInterface<T>::reportFinished(const(T)* result)
{
    if (result)
        reportResult(result);
    QFutureInterfaceBase::reportFinished();
}

template <typename T>
/+inline+/ ref const(T) QFutureInterface<T>::resultReference(int index) const
{
    QMutexLocker lock(mutex());
    return resultStore().resultAt(index).value();
}

template <typename T>
/+inline+/ const(T)* QFutureInterface<T>::resultPointer(int index) const
{
    QMutexLocker lock(mutex());
    return resultStore().resultAt(index).pointer();
}

template <typename T>
/+inline+/ QList<T> QFutureInterface<T>::results()
{
    if (this->isCanceled()) {
        exceptionStore().throwPossibleException();
        return QList<T>();
    }
    QFutureInterfaceBase::waitForResult(-1);

    QList<T> res;
    QMutexLocker lock(mutex());

    QtPrivate::ResultIterator<T> it = resultStore().begin();
    while (it != resultStore().end()) {
        res.append(it.value());
        ++it;
    }

    return res;
}

template <>
extern(C++) class QFutureInterface<void> : QFutureInterfaceBase
{
public:
    QFutureInterface<void>(State initialState = NoState)
        : QFutureInterfaceBase(initialState)
    { }
    QFutureInterface<void>(ref const(QFutureInterface<void>) other)
        : QFutureInterfaceBase(other)
    { }

    static QFutureInterface<void> canceledResult()
    { return QFutureInterface(State(Started | Finished | Canceled)); }

    QFutureInterface<void> &operator=(ref const(QFutureInterface<void>) other)
    {
        QFutureInterfaceBase::operator=(other);
        return *this;
    }

    /+inline+/ QFuture<void> future(); // implemented in qfuture.h

    void reportResult(const(void)* , int) { }
    void reportResults(ref const(QVector<void>) , int) { }
    void reportFinished(const(void)*  = 0) { QFutureInterfaceBase::reportFinished(); }
}
#endif // QT_NO_QFUTURE

#endif // QFUTUREINTERFACE_H
