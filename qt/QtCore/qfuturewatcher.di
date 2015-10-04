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

public import QtCore.qfuture;

#ifndef QT_NO_QFUTURE

public import QtCore.qobject;


extern(C++) class QEvent;

extern(C++) class QFutureWatcherBasePrivate;
extern(C++) class export QFutureWatcherBase : QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

public:
    explicit QFutureWatcherBase(QObject *parent = 0);
    // de-/+inline+/ dtor

    int progressValue() const;
    int progressMinimum() const;
    int progressMaximum() const;
    QString progressText() const;

    bool isStarted() const;
    bool isFinished() const;
    bool isRunning() const;
    bool isCanceled() const;
    bool isPaused() const;

    void waitForFinished();

    void setPendingResultsLimit(int limit);

    bool event(QEvent *event);

Q_SIGNALS:
    void started();
    void finished();
    void canceled();
    void paused();
    void resumed();
    void resultReadyAt(int resultIndex);
    void resultsReadyAt(int beginIndex, int endIndex);
    void progressRangeChanged(int minimum, int maximum);
    void progressValueChanged(int progressValue);
    void progressTextChanged(ref const(QString) progressText);

public Q_SLOTS:
    void cancel();
    void setPaused(bool paused);
    void pause();
    void resume();
    void togglePaused();

protected:
    void connectNotify (ref const(QMetaMethod) signal);
    void disconnectNotify (ref const(QMetaMethod) signal);

    // called from setFuture() implemented in template sub-classes
    void connectOutputInterface();
    void disconnectOutputInterface(bool pendingAssignment = false);

private:
    // implemented in the template sub-classes
    /+virtual+/ ref const(QFutureInterfaceBase) futureInterface() const = 0;
    /+virtual+/ QFutureInterfaceBase &futureInterface() = 0;
}

template <typename T>
extern(C++) class QFutureWatcher : QFutureWatcherBase
{
public:
    explicit QFutureWatcher(QObject *_parent = 0)
        : QFutureWatcherBase(_parent)
    { }
    ~QFutureWatcher()
    { disconnectOutputInterface(); }

    void setFuture(ref const(QFuture<T>) future);
    QFuture<T> future() const
    { return m_future; }

    T result() const { return m_future.result(); }
    T resultAt(int index) const { return m_future.resultAt(index); }

#ifdef Q_QDOC
    int progressValue() const;
    int progressMinimum() const;
    int progressMaximum() const;
    QString progressText() const;

    bool isStarted() const;
    bool isFinished() const;
    bool isRunning() const;
    bool isCanceled() const;
    bool isPaused() const;

    void waitForFinished();

    void setPendingResultsLimit(int limit);

Q_SIGNALS:
    void started();
    void finished();
    void canceled();
    void paused();
    void resumed();
    void resultReadyAt(int resultIndex);
    void resultsReadyAt(int beginIndex, int endIndex);
    void progressRangeChanged(int minimum, int maximum);
    void progressValueChanged(int progressValue);
    void progressTextChanged(ref const(QString) progressText);

public Q_SLOTS:
    void cancel();
    void setPaused(bool paused);
    void pause();
    void resume();
    void togglePaused();
#endif

private:
    QFuture<T> m_future;
    ref const(QFutureInterfaceBase) futureInterface() const { return m_future.d; }
    QFutureInterfaceBase &futureInterface() { return m_future.d; }
}

Q_INLINE_TEMPLATE void QFutureWatcher<T>::setFuture(T)(ref const(QFuture<T>) _future)
{
    if (_future == m_future)
        return;

    disconnectOutputInterface(true);
    m_future = _future;
    connectOutputInterface();
}

template <>
extern(C++) class QFutureWatcher<void> : QFutureWatcherBase
{
public:
    explicit QFutureWatcher(QObject *_parent = 0)
        : QFutureWatcherBase(_parent)
    { }
    ~QFutureWatcher()
    { disconnectOutputInterface(); }

    void setFuture(ref const(QFuture<void>) future);
    QFuture<void> future() const
    { return m_future; }

private:
    QFuture<void> m_future;
    ref const(QFutureInterfaceBase) futureInterface() const { return m_future.d; }
    QFutureInterfaceBase &futureInterface() { return m_future.d; }
}

Q_INLINE_TEMPLATE void QFutureWatcher<void>::setFuture(ref const(QFuture<void>) _future)
{
    if (_future == m_future)
        return;

    disconnectOutputInterface(true);
    m_future = _future;
    connectOutputInterface();
}
#endif // QT_NO_QFUTURE

#endif // QFUTUREWATCHER_H