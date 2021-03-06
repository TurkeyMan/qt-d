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

#ifndef QTCONCURRENT_MAP_H
#define QTCONCURRENT_MAP_H

public import qt.QtConcurrent.qtconcurrent_global;

#ifndef QT_NO_CONCURRENT

public import qt.QtConcurrent.qtconcurrentmapkernel;
public import qt.QtConcurrent.qtconcurrentreducekernel;
public import qt.QtConcurrent.qtconcurrentfunctionwrappers;
public import qt.QtCore.qstringlist;

QT_BEGIN_NAMESPACE


#ifdef Q_QDOC

namespace QtConcurrent {

    QFuture<void> map(Sequence &sequence, MapFunction function);
    QFuture<void> map(Iterator begin, Iterator end, MapFunction function);

    QFuture<T> mapped(T)(ref const(Sequence) sequence, MapFunction function);
    QFuture<T> mapped(T)(ConstIterator begin, ConstIterator end, MapFunction function);

    QFuture<T> mappedReduced(T)(ref const(Sequence) sequence,
                             MapFunction function,
                             ReduceFunction function,
                             QtConcurrent::ReduceOptions options = UnorderedReduce | SequentialReduce);
    QFuture<T> mappedReduced(T)(ConstIterator begin,
                             ConstIterator end,
                             MapFunction function,
                             ReduceFunction function,
                             QtConcurrent::ReduceOptions options = UnorderedReduce | SequentialReduce);

    void blockingMap(Sequence &sequence, MapFunction function);
    void blockingMap(Iterator begin, Iterator end, MapFunction function);

    T blockingMapped(T)(ref const(Sequence) sequence, MapFunction function);
    T blockingMapped(T)(ConstIterator begin, ConstIterator end, MapFunction function);

    T blockingMappedReduced(T)(ref const(Sequence) sequence,
                            MapFunction function,
                            ReduceFunction function,
                            QtConcurrent::ReduceOptions options = UnorderedReduce | SequentialReduce);
    T blockingMappedReduced(T)(ConstIterator begin,
                            ConstIterator end,
                            MapFunction function,
                            ReduceFunction function,
                            QtConcurrent::ReduceOptions options = UnorderedReduce | SequentialReduce);

} // namespace QtConcurrent

#else

namespace QtConcurrent {

// map() on sequences
template <typename Sequence, typename MapFunctor>
QFuture<void> map(Sequence &sequence, MapFunctor map)
{
    return startMap(sequence.begin(), sequence.end(), QtPrivate::createFunctionWrapper(map));
}

// map() on iterators
template <typename Iterator, typename MapFunctor>
QFuture<void> map(Iterator begin, Iterator end, MapFunctor map)
{
    return startMap(begin, end, QtPrivate::createFunctionWrapper(map));
}

// mappedReduced() for sequences.
template <typename ResultType, typename Sequence, typename MapFunctor, typename ReduceFunctor>
QFuture<ResultType> mappedReduced(ref const(Sequence) sequence,
                                  MapFunctor map,
                                  ReduceFunctor reduce,
                                  ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return startMappedReduced<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType, ResultType>
        (sequence,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::createFunctionWrapper(reduce),
         options);
}

template <typename Sequence, typename MapFunctor, typename ReduceFunctor>
QFuture<typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType> mappedReduced(ref const(Sequence) sequence,
                                  MapFunctor map,
                                  ReduceFunctor reduce,
                                  ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return startMappedReduced<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType, typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType>
        (sequence,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::createFunctionWrapper(reduce),
         options);
}

// mappedReduced() for iterators
template <typename ResultType, typename Iterator, typename MapFunctor, typename ReduceFunctor>
QFuture<ResultType> mappedReduced(Iterator begin,
                                  Iterator end,
                                  MapFunctor map,
                                  ReduceFunctor reduce,
                                  ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return startMappedReduced<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType, ResultType>
        (begin, end,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::createFunctionWrapper(reduce),
         options);
}

template <typename Iterator, typename MapFunctor, typename ReduceFunctor>
QFuture<typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType> mappedReduced(Iterator begin,
                                  Iterator end,
                                  MapFunctor map,
                                  ReduceFunctor reduce,
                                  ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return startMappedReduced<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType, typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType>
        (begin, end,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::createFunctionWrapper(reduce),
         options);
}

// mapped() for sequences
template <typename Sequence, typename MapFunctor>
QFuture<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType> mapped(ref const(Sequence) sequence, MapFunctor map)
{
    return startMapped<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType>(sequence, QtPrivate::createFunctionWrapper(map));
}

// mapped() for iterator ranges.
template <typename Iterator, typename MapFunctor>
QFuture<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType> mapped(Iterator begin, Iterator end, MapFunctor map)
{
    return startMapped<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType>(begin, end, QtPrivate::createFunctionWrapper(map));
}

// blockingMap() for sequences
template <typename Sequence, typename MapFunctor>
void blockingMap(Sequence &sequence, MapFunctor map)
{
    startMap(sequence.begin(), sequence.end(), QtPrivate::createFunctionWrapper(map)).startBlocking();
}

// blockingMap() for iterator ranges
template <typename Iterator, typename MapFunctor>
void blockingMap(Iterator begin, Iterator end, MapFunctor map)
{
    startMap(begin, end, QtPrivate::createFunctionWrapper(map)).startBlocking();
}

// blockingMappedReduced() for sequences
template <typename ResultType, typename Sequence, typename MapFunctor, typename ReduceFunctor>
ResultType blockingMappedReduced(ref const(Sequence) sequence,
                                 MapFunctor map,
                                 ReduceFunctor reduce,
                                 ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return QtConcurrent::startMappedReduced<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType, ResultType>
        (sequence,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::createFunctionWrapper(reduce),
         options)
        .startBlocking();
}

template <typename MapFunctor, typename ReduceFunctor, typename Sequence>
typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType blockingMappedReduced(ref const(Sequence) sequence,
                                 MapFunctor map,
                                 ReduceFunctor reduce,
                                 ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return QtConcurrent::startMappedReduced<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType, typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType>
        (sequence,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::createFunctionWrapper(reduce),
         options)
        .startBlocking();
}

// blockingMappedReduced() for iterator ranges
template <typename ResultType, typename Iterator, typename MapFunctor, typename ReduceFunctor>
ResultType blockingMappedReduced(Iterator begin,
                                 Iterator end,
                                 MapFunctor map,
                                 ReduceFunctor reduce,
                                 QtConcurrent::ReduceOptions options = QtConcurrent::ReduceOptions(QtConcurrent::UnorderedReduce | QtConcurrent::SequentialReduce))
{
    return QtConcurrent::startMappedReduced<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType, ResultType>
        (begin, end,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::createFunctionWrapper(reduce),
         options)
        .startBlocking();
}

template <typename Iterator, typename MapFunctor, typename ReduceFunctor>
typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType blockingMappedReduced(Iterator begin,
                                 Iterator end,
                                 MapFunctor map,
                                 ReduceFunctor reduce,
                                 QtConcurrent::ReduceOptions options = QtConcurrent::ReduceOptions(QtConcurrent::UnorderedReduce | QtConcurrent::SequentialReduce))
{
    return QtConcurrent::startMappedReduced<typename QtPrivate::MapResultType<void, MapFunctor>::ResultType, typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType>
        (begin, end,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::createFunctionWrapper(reduce),
         options)
        .startBlocking();
}

// mapped() for sequences with a different putput sequence type.
template <typename OutputSequence, typename InputSequence, typename MapFunctor>
OutputSequence blockingMapped(ref const(InputSequence) sequence, MapFunctor map)
{
    return blockingMappedReduced<OutputSequence>
        (sequence,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::PushBackWrapper(),
         QtConcurrent::OrderedReduce);
}

template <typename MapFunctor, typename InputSequence>
typename QtPrivate::MapResultType<InputSequence, MapFunctor>::ResultType blockingMapped(ref const(InputSequence) sequence, MapFunctor map)
{
    typedef typename QtPrivate::MapResultType<InputSequence, MapFunctor>::ResultType OutputSequence;
    return blockingMappedReduced<OutputSequence>
        (sequence,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::PushBackWrapper(),
         QtConcurrent::OrderedReduce);
}

// mapped()  for iterator ranges
template <typename Sequence, typename Iterator, typename MapFunctor>
Sequence blockingMapped(Iterator begin, Iterator end, MapFunctor map)
{
    return blockingMappedReduced<Sequence>
        (begin, end,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::PushBackWrapper(),
         QtConcurrent::OrderedReduce);
}

template <typename Iterator, typename MapFunctor>
typename QtPrivate::MapResultType<Iterator, MapFunctor>::ResultType blockingMapped(Iterator begin, Iterator end, MapFunctor map)
{
    typedef typename QtPrivate::MapResultType<Iterator, MapFunctor>::ResultType OutputSequence;
    return blockingMappedReduced<OutputSequence>
        (begin, end,
         QtPrivate::createFunctionWrapper(map),
         QtPrivate::PushBackWrapper(),
         QtConcurrent::OrderedReduce);
}

} // namespace QtConcurrent

#endif // Q_QDOC

QT_END_NAMESPACE

#endif // QT_NO_CONCURRENT

#endif
