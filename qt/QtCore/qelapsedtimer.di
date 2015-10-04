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


extern(C++) class export QElapsedTimer
{
public:
    enum ClockType {
        SystemTime,
        MonotonicClock,
        TickCounter,
        MachAbsoluteTime,
        PerformanceCounter
    }

    QElapsedTimer()
        : t1(Q_INT64_C(0x8000000000000000)),
          t2(Q_INT64_C(0x8000000000000000))
    {
    }

    static ClockType clockType() nothrow;
    static bool isMonotonic() nothrow;

    void start() nothrow;
    qint64 restart() nothrow;
    void invalidate() nothrow;
    bool isValid() const nothrow;

    qint64 nsecsElapsed() const nothrow;
    qint64 elapsed() const nothrow;
    bool hasExpired(qint64 timeout) const nothrow;

    qint64 msecsSinceReference() const nothrow;
    qint64 msecsTo(ref const(QElapsedTimer) other) const nothrow;
    qint64 secsTo(ref const(QElapsedTimer) other) const nothrow;

    bool operator==(ref const(QElapsedTimer) other) const nothrow
    { return t1 == other.t1 && t2 == other.t2; }
    bool operator!=(ref const(QElapsedTimer) other) const nothrow
    { return !(*this == other); }

    friend bool export operator<(ref const(QElapsedTimer) v1, ref const(QElapsedTimer) v2) nothrow;

private:
    qint64 t1;
    qint64 t2;
}

#endif // QELAPSEDTIMER_H
