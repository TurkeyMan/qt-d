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

public import QtCore.qmap;
public import QtCore.qdebug;


/*
    ResultStore stores indexed results. Results can be added and retrieved
    either individually batched in a QVector. Retriveing results and checking
    which indexes are in the store can be done either by iterating or by random
    accees. In addition results kan be removed from the front of the store,
    either individually or in batches.
*/

#ifndef Q_QDOC

namespace QtPrivate {

extern(C++) class ResultItem
{
public:
    ResultItem(const(void)* _result, int _count) : m_count(_count), result(_result) { } // contruct with vector of results
    ResultItem(const(void)* _result) : m_count(0), result(_result) { } // construct with result
    ResultItem() : m_count(0), result(0) { }
    bool isValid() const { return result != 0; }
    bool isVector() const { return m_count != 0; }
    int count() const { return (m_count == 0) ?  1 : m_count; }
    int m_count;          // result is either a pointer to a result or to a vector of results,
    const(void)* result; // if count is 0 it's a result, otherwise it's a vector.
}

extern(C++) class export ResultIteratorBase
{
public:
    ResultIteratorBase();
    ResultIteratorBase(QMap<int, ResultItem>::const_iterator _mapIterator, int _vectorIndex = 0);
    int vectorIndex() const;
    int resultIndex() const;

    ResultIteratorBase operator++();
    int batchSize() const;
    void batchedAdvance();
    bool operator==(ref const(ResultIteratorBase) other) const;
    bool operator!=(ref const(ResultIteratorBase) other) const;
    bool isVector() const;
    bool canIncrementVectorIndex() const;
protected:
    QMap<int, ResultItem>::const_iterator mapIterator;
    int m_vectorIndex;
}

template <typename T>
extern(C++) class  ResultIterator : ResultIteratorBase
{
public:
    ResultIterator(ref const(ResultIteratorBase) base)
    : ResultIteratorBase(base) { }

    ref const(T) value() const
    {
        return *pointer();
    }

    const(T)* pointer() const
    {
        if (mapIterator.value().isVector())
            return &(reinterpret_cast<const QVector<T> *>(mapIterator.value().result)->at(m_vectorIndex));
        else
            return reinterpret_cast<const(T)* >(mapIterator.value().result);
    }
}

extern(C++) class export ResultStoreBase
{
public:
    ResultStoreBase();
    void setFilterMode(bool enable);
    bool filterMode() const;
    int addResult(int index, const(void)* result);
    int addResults(int index, const(void)* results, int vectorSize, int logicalCount);
    ResultIteratorBase begin() const;
    ResultIteratorBase end() const;
    bool hasNextResult() const;
    ResultIteratorBase resultAt(int index) const;
    bool contains(int index) const;
    int count() const;
    /+virtual+/ ~ResultStoreBase() { }

protected:
    int insertResultItem(int index, ResultItem &resultItem);
    void insertResultItemIfValid(int index, ResultItem &resultItem);
    void syncPendingResults();
    void syncResultCount();
    int updateInsertIndex(int index, int _count);

    QMap<int, ResultItem> m_results;
    int insertIndex;     // The index where the next results(s) will be inserted.
    int resultCount;     // The number of consecutive results stored, starting at index 0.

    bool m_filterMode;
    QMap<int, ResultItem> pendingResults;
    int filteredResults;

}

template <typename T>
extern(C++) class ResultStore : ResultStoreBase
{
public:
    ResultStore() { }

    ResultStore(ref const(ResultStoreBase) base)
    : ResultStoreBase(base) { }

    int addResult(int index, const T  *result)
    {
        if (result == 0)
            return ResultStoreBase::addResult(index, result);
        else
            return ResultStoreBase::addResult(index, new T(*result));
    }

    int addResults(int index, const QVector<T> *results)
    {
        return ResultStoreBase::addResults(index, new QVector<T>(*results), results->count(), results->count());
    }

    int addResults(int index, const QVector<T> *results, int totalCount)
    {
        if (m_filterMode == true && results->count() != totalCount && 0 == results->count())
            return ResultStoreBase::addResults(index, 0, 0, totalCount);
        else
            return ResultStoreBase::addResults(index, new QVector<T>(*results), results->count(), totalCount);
    }

    int addCanceledResult(int index)
    {
        return addResult(index, 0);
    }

    int addCanceledResults(int index, int _count)
    {
        QVector<T> empty;
        return addResults(index, &empty, _count);
    }

    ResultIterator<T> begin() const
    {
        return static_cast<ResultIterator<T> >(ResultStoreBase::begin());
    }

    ResultIterator<T> end() const
    {
        return static_cast<ResultIterator<T> >(ResultStoreBase::end());
    }

    ResultIterator<T> resultAt(int index) const
    {
        return static_cast<ResultIterator<T> >(ResultStoreBase::resultAt(index));
    }

    void clear()
    {
        QMap<int, ResultItem>::const_iterator mapIterator = m_results.constBegin();
        while (mapIterator != m_results.constEnd()) {
            if (mapIterator.value().isVector())
                delete reinterpret_cast<const QVector<T> *>(mapIterator.value().result);
            else
                delete reinterpret_cast<const(T)* >(mapIterator.value().result);
            ++mapIterator;
        }
        resultCount = 0;
        m_results.clear();
    }

    ~ResultStore()
    {
        clear();
    }

}

} // namespace QtPrivate

#endif //Q_QDOC

#endif // QT_NO_QFUTURE

#endif
