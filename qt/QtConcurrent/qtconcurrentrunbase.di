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

#ifndef QTCONCURRENT_RUNBASE_H
#define QTCONCURRENT_RUNBASE_H

public import qt.QtConcurrent.qtconcurrent_global;

#ifndef QT_NO_CONCURRENT

public import qt.QtCore.qfuture;
public import qt.QtCore.qrunnable;
public import qt.QtCore.qthreadpool;

QT_BEGIN_NAMESPACE


#ifndef Q_QDOC

namespace QtConcurrent {

template <typename T>
struct SelectSpecialization
{
    template <class Normal, class Void>
    struct Type { typedef Normal type; };
};

template <>
struct SelectSpecialization<void>
{
    template <class Normal, class Void>
    struct Type { typedef Void type; };
};

template <typename T>
class RunFunctionTaskBase : public QFutureInterface<T> , public QRunnable
{
public:
    QFuture<T> start()
    {
        return start(QThreadPool::globalInstance());
    }

    QFuture<T> start(QThreadPool *pool)
    {
        this->setThreadPool(pool);
        this->setRunnable(this);
        this->reportStarted();
        QFuture<T> theFuture = this->future();
        pool->start(this, /*m_priority*/ 0);
        return theFuture;
    }

    void run() {}
    /+virtual+/ void runFunctor() = 0;
};

template <typename T>
class RunFunctionTask : public RunFunctionTaskBase<T>
{
public:
    void run()
    {
        if (this->isCanceled()) {
            this->reportFinished();
            return;
        }
#ifndef QT_NO_EXCEPTIONS
        try {
#endif
            this->runFunctor();
#ifndef QT_NO_EXCEPTIONS
        } catch (QException &e) {
            QFutureInterface<T>::reportException(e);
        } catch (...) {
            QFutureInterface<T>::reportException(QUnhandledException());
        }
#endif

        this->reportResult(result);
        this->reportFinished();
    }
    T result;
};

template <>
class RunFunctionTask<void> : public RunFunctionTaskBase<void>
{
public:
    void run()
    {
        if (this->isCanceled()) {
            this->reportFinished();
            return;
        }
#ifndef QT_NO_EXCEPTIONS
        try {
#endif
            this->runFunctor();
#ifndef QT_NO_EXCEPTIONS
        } catch (QException &e) {
            QFutureInterface<void>::reportException(e);
        } catch (...) {
            QFutureInterface<void>::reportException(QUnhandledException());
        }
#endif
        this->reportFinished();
    }
};

} //namespace QtConcurrent

#endif //Q_QDOC

QT_END_NAMESPACE

#endif // QT_NO_CONCURRENT

#endif
