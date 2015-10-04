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

#ifndef QTCONCURRENT_FILTER_H
#define QTCONCURRENT_FILTER_H

public import qt.QtConcurrent.qtconcurrent_global;

#ifndef QT_NO_CONCURRENT

public import qt.QtConcurrent.qtconcurrentfilterkernel;
public import qt.QtConcurrent.qtconcurrentfunctionwrappers;

QT_BEGIN_NAMESPACE


#ifdef Q_QDOC

namespace QtConcurrent {

    QFuture<void> filter(Sequence &sequence, FilterFunction filterFunction);

    QFuture<T> filtered(T)(ref const(Sequence) sequence, FilterFunction filterFunction);
    QFuture<T> filtered(T)(ConstIterator begin, ConstIterator end, FilterFunction filterFunction);

    QFuture<T> filteredReduced(T)(ref const(Sequence) sequence,
                               FilterFunction filterFunction,
                               ReduceFunction reduceFunction,
                               QtConcurrent::ReduceOptions reduceOptions = UnorderedReduce | SequentialReduce);
    QFuture<T> filteredReduced(T)(ConstIterator begin,
                               ConstIterator end,
                               FilterFunction filterFunction,
                               ReduceFunction reduceFunction,
                               QtConcurrent::ReduceOptions reduceOptions = UnorderedReduce | SequentialReduce);

    void blockingFilter(Sequence &sequence, FilterFunction filterFunction);

    Sequence blockingFiltered(Sequence)(ref const(Sequence) sequence, FilterFunction filterFunction);
    Sequence blockingFiltered(Sequence)(ConstIterator begin, ConstIterator end, FilterFunction filterFunction);

    T blockingFilteredReduced(T)(ref const(Sequence) sequence,
                              FilterFunction filterFunction,
                              ReduceFunction reduceFunction,
                              QtConcurrent::ReduceOptions reduceOptions = UnorderedReduce | SequentialReduce);
    T blockingFilteredReduced(T)(ConstIterator begin,
                              ConstIterator end,
                              FilterFunction filterFunction,
                              ReduceFunction reduceFunction,
                              QtConcurrent::ReduceOptions reduceOptions = UnorderedReduce | SequentialReduce);

} // namespace QtConcurrent

#else

namespace QtConcurrent {

template <typename Sequence, typename KeepFunctor, typename ReduceFunctor>
ThreadEngineStarter<void> filterInternal(Sequence &sequence, KeepFunctor keep, ReduceFunctor reduce)
{
    typedef FilterKernel<Sequence, KeepFunctor, ReduceFunctor> KernelType;
    return startThreadEngine(new KernelType(sequence, keep, reduce));
}

// filter() on sequences
template <typename Sequence, typename KeepFunctor>
QFuture<void> filter(Sequence &sequence, KeepFunctor keep)
{
    return filterInternal(sequence, QtPrivate::createFunctionWrapper(keep), QtPrivate::PushBackWrapper());
}

// filteredReduced() on sequences
template <typename ResultType, typename Sequence, typename KeepFunctor, typename ReduceFunctor>
QFuture<ResultType> filteredReduced(ref const(Sequence) sequence,
                                    KeepFunctor keep,
                                    ReduceFunctor reduce,
                                    ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return startFilteredReduced<ResultType>(sequence, QtPrivate::createFunctionWrapper(keep), QtPrivate::createFunctionWrapper(reduce), options);
}

template <typename Sequence, typename KeepFunctor, typename ReduceFunctor>
QFuture<typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType> filteredReduced(ref const(Sequence) sequence,
                                    KeepFunctor keep,
                                    ReduceFunctor reduce,
                                    ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return startFilteredReduced<typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType>
            (sequence,
             QtPrivate::createFunctionWrapper(keep),
             QtPrivate::createFunctionWrapper(reduce),
             options);
}

// filteredReduced() on iterators
template <typename ResultType, typename Iterator, typename KeepFunctor, typename ReduceFunctor>
QFuture<ResultType> filteredReduced(Iterator begin,
                                    Iterator end,
                                    KeepFunctor keep,
                                    ReduceFunctor reduce,
                                    ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
   return startFilteredReduced<ResultType>(begin, end, QtPrivate::createFunctionWrapper(keep), QtPrivate::createFunctionWrapper(reduce), options);
}

template <typename Iterator, typename KeepFunctor, typename ReduceFunctor>
QFuture<typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType> filteredReduced(Iterator begin,
                                    Iterator end,
                                    KeepFunctor keep,
                                    ReduceFunctor reduce,
                                    ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
   return startFilteredReduced<typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType>
           (begin, end,
            QtPrivate::createFunctionWrapper(keep),
            QtPrivate::createFunctionWrapper(reduce),
            options);
}

// filtered() on sequences
template <typename Sequence, typename KeepFunctor>
QFuture<typename Sequence::value_type> filtered(ref const(Sequence) sequence, KeepFunctor keep)
{
    return startFiltered(sequence, QtPrivate::createFunctionWrapper(keep));
}

// filtered() on iterators
template <typename Iterator, typename KeepFunctor>
QFuture<typename qValueType<Iterator>::value_type> filtered(Iterator begin, Iterator end, KeepFunctor keep)
{
    return startFiltered(begin, end, QtPrivate::createFunctionWrapper(keep));
}

// blocking filter() on sequences
template <typename Sequence, typename KeepFunctor>
void blockingFilter(Sequence &sequence, KeepFunctor keep)
{
    filterInternal(sequence, QtPrivate::createFunctionWrapper(keep), QtPrivate::PushBackWrapper()).startBlocking();
}

// blocking filteredReduced() on sequences
template <typename ResultType, typename Sequence, typename KeepFunctor, typename ReduceFunctor>
ResultType blockingFilteredReduced(ref const(Sequence) sequence,
                                   KeepFunctor keep,
                                   ReduceFunctor reduce,
                                   ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return startFilteredReduced<ResultType>(sequence, QtPrivate::createFunctionWrapper(keep), QtPrivate::createFunctionWrapper(reduce), options)
        .startBlocking();
}

template <typename Sequence, typename KeepFunctor, typename ReduceFunctor>
typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType blockingFilteredReduced(ref const(Sequence) sequence,
                                   KeepFunctor keep,
                                   ReduceFunctor reduce,
                                   ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return blockingFilteredReduced<typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType>
        (sequence,
         QtPrivate::createFunctionWrapper(keep),
         QtPrivate::createFunctionWrapper(reduce),
         options);
}

// blocking filteredReduced() on iterators
template <typename ResultType, typename Iterator, typename KeepFunctor, typename ReduceFunctor>
ResultType blockingFilteredReduced(Iterator begin,
                                   Iterator end,
                                   KeepFunctor keep,
                                   ReduceFunctor reduce,
                                   ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return startFilteredReduced<ResultType>
        (begin, end,
         QtPrivate::createFunctionWrapper(keep),
         QtPrivate::createFunctionWrapper(reduce),
         options)
        .startBlocking();
}

template <typename Iterator, typename KeepFunctor, typename ReduceFunctor>
typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType blockingFilteredReduced(Iterator begin,
                                   Iterator end,
                                   KeepFunctor keep,
                                   ReduceFunctor reduce,
                                   ReduceOptions options = ReduceOptions(UnorderedReduce | SequentialReduce))
{
    return startFilteredReduced<typename QtPrivate::ReduceResultType<ReduceFunctor>::ResultType>
        (begin, end,
         QtPrivate::createFunctionWrapper(keep),
         QtPrivate::createFunctionWrapper(reduce),
         options)
        .startBlocking();
}

// blocking filtered() on sequences
template <typename Sequence, typename KeepFunctor>
Sequence blockingFiltered(ref const(Sequence) sequence, KeepFunctor keep)
{
    return startFilteredReduced<Sequence>(sequence, QtPrivate::createFunctionWrapper(keep), QtPrivate::PushBackWrapper(), OrderedReduce).startBlocking();
}

// blocking filtered() on iterators
template <typename OutputSequence, typename Iterator, typename KeepFunctor>
OutputSequence blockingFiltered(Iterator begin, Iterator end, KeepFunctor keep)
{
    return startFilteredReduced<OutputSequence>(begin, end,
        QtPrivate::createFunctionWrapper(keep),
        QtPrivate::PushBackWrapper(),
        OrderedReduce).startBlocking();
}

} // namespace QtConcurrent

#endif // Q_QDOC

QT_END_NAMESPACE

#endif // QT_NO_CONCURRENT

#endif
