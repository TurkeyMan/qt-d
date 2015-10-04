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

public import QtCore.qstring;
public import QtCore.qnamespace;
public import QtCore.qshareddata;

public import limits;

extern(C++) class QTimeZone;

extern(C++) class export QDate
{
public:
    enum MonthNameType {
        DateFormat = 0,
        StandaloneFormat
    }
public:
    QDate() { jd = nullJd(); }
    QDate(int y, int m, int d);

    bool isNull() const { return !isValid(); }
    bool isValid() const { return jd >= minJd() && jd <= maxJd(); }

    int year() const;
    int month() const;
    int day() const;
    int dayOfWeek() const;
    int dayOfYear() const;
    int daysInMonth() const;
    int daysInYear() const;
    int weekNumber(int *yearNum = 0) const;

#ifndef QT_NO_TEXTDATE
    static QString shortMonthName(int month, MonthNameType type = DateFormat);
    static QString shortDayName(int weekday, MonthNameType type = DateFormat);
    static QString longMonthName(int month, MonthNameType type = DateFormat);
    static QString longDayName(int weekday, MonthNameType type = DateFormat);
#endif // QT_NO_TEXTDATE
#ifndef QT_NO_DATESTRING
    QString toString(Qt.DateFormat f = Qt.TextDate) const;
    QString toString(ref const(QString) format) const;
#endif
#if QT_DEPRECATED_SINCE(5,0)
QT_DEPRECATED /+inline+/ bool setYMD(int y, int m, int d)
{ if (uint(y) <= 99) y += 1900; return setDate(y, m, d); }
#endif

    bool setDate(int year, int month, int day);

    void getDate(int *year, int *month, int *day);

    QDate addDays(qint64 days) const Q_REQUIRED_RESULT;
    QDate addMonths(int months) const Q_REQUIRED_RESULT;
    QDate addYears(int years) const Q_REQUIRED_RESULT;
    qint64 daysTo(ref const(QDate) ) const;

    bool operator==(ref const(QDate) other) const { return jd == other.jd; }
    bool operator!=(ref const(QDate) other) const { return jd != other.jd; }
    bool operator<(ref const(QDate) other) const { return jd < other.jd; }
    bool operator<=(ref const(QDate) other) const { return jd <= other.jd; }
    bool operator>(ref const(QDate) other) const { return jd > other.jd; }
    bool operator>=(ref const(QDate) other) const { return jd >= other.jd; }

    static QDate currentDate();
#ifndef QT_NO_DATESTRING
    static QDate fromString(ref const(QString) s, Qt.DateFormat f = Qt.TextDate);
    static QDate fromString(ref const(QString) s, ref const(QString) format);
#endif
    static bool isValid(int y, int m, int d);
    static bool isLeapYear(int year);

    static /+inline+/ QDate fromJulianDay(qint64 jd)
    { QDate d; if (jd >= minJd() && jd <= maxJd()) d.jd = jd; return d; }
    /+inline+/ qint64 toJulianDay() const { return jd; }

private:
    // using extra parentheses around min to avoid expanding it if it is a macro
    static /+inline+/ qint64 nullJd() { return (std::numeric_limits<qint64>::min)(); }
    static /+inline+/ qint64 minJd() { return Q_INT64_C(-784350574879); }
    static /+inline+/ qint64 maxJd() { return Q_INT64_C( 784354017364); }

    qint64 jd;

    friend extern(C++) class QDateTime;
    friend extern(C++) class QDateTimePrivate;
#ifndef QT_NO_DATASTREAM
    friend export QDataStream &operator<<(QDataStream &, ref const(QDate) );
    friend export QDataStream &operator>>(QDataStream &, QDate &);
#endif
}
Q_DECLARE_TYPEINFO(QDate, Q_MOVABLE_TYPE);

extern(C++) class export QTime
{
public:
    QTime(): mds(NullTime)
#if defined(Q_OS_WINCE)
        , startTick(NullTime)
#endif
    {}
    QTime(int h, int m, int s = 0, int ms = 0);

    bool isNull() const { return mds == NullTime; }
    bool isValid() const;

    int hour() const;
    int minute() const;
    int second() const;
    int msec() const;
#ifndef QT_NO_DATESTRING
    QString toString(Qt.DateFormat f = Qt.TextDate) const;
    QString toString(ref const(QString) format) const;
#endif
    bool setHMS(int h, int m, int s, int ms = 0);

    QTime addSecs(int secs) const Q_REQUIRED_RESULT;
    int secsTo(ref const(QTime) ) const;
    QTime addMSecs(int ms) const Q_REQUIRED_RESULT;
    int msecsTo(ref const(QTime) ) const;

    bool operator==(ref const(QTime) other) const { return mds == other.mds; }
    bool operator!=(ref const(QTime) other) const { return mds != other.mds; }
    bool operator<(ref const(QTime) other) const { return mds < other.mds; }
    bool operator<=(ref const(QTime) other) const { return mds <= other.mds; }
    bool operator>(ref const(QTime) other) const { return mds > other.mds; }
    bool operator>=(ref const(QTime) other) const { return mds >= other.mds; }

    static /+inline+/ QTime fromMSecsSinceStartOfDay(int msecs) { QTime t; t.mds = msecs; return t; }
    /+inline+/ int msecsSinceStartOfDay() const { return mds == NullTime ? 0 : mds; }

    static QTime currentTime();
#ifndef QT_NO_DATESTRING
    static QTime fromString(ref const(QString) s, Qt.DateFormat f = Qt.TextDate);
    static QTime fromString(ref const(QString) s, ref const(QString) format);
#endif
    static bool isValid(int h, int m, int s, int ms = 0);

    void start();
    int restart();
    int elapsed() const;
private:
    enum TimeFlag { NullTime = -1 }
    /+inline+/ int ds() const { return mds == -1 ? 0 : mds; }
    int mds;
#if defined(Q_OS_WINCE)
    int startTick;
#endif

    friend extern(C++) class QDateTime;
    friend extern(C++) class QDateTimePrivate;
#ifndef QT_NO_DATASTREAM
    friend export QDataStream &operator<<(QDataStream &, ref const(QTime) );
    friend export QDataStream &operator>>(QDataStream &, QTime &);
#endif
}
Q_DECLARE_TYPEINFO(QTime, Q_MOVABLE_TYPE);

extern(C++) class QDateTimePrivate;

extern(C++) class export QDateTime
{
public:
    QDateTime();
    explicit QDateTime(ref const(QDate) );
    QDateTime(ref const(QDate) , ref const(QTime) , Qt.TimeSpec spec = Qt.LocalTime);
    // ### Qt 6: Merge with above with default offsetSeconds = 0
    QDateTime(ref const(QDate) date, ref const(QTime) time, Qt.TimeSpec spec, int offsetSeconds);
#ifndef QT_BOOTSTRAPPED
    QDateTime(ref const(QDate) date, ref const(QTime) time, ref const(QTimeZone) timeZone);
#endif // QT_BOOTSTRAPPED
    QDateTime(ref const(QDateTime) other);
    ~QDateTime();

    QDateTime &operator=(ref const(QDateTime) other);

    /+inline+/ void swap(QDateTime &other) { qSwap(d, other.d); }

    bool isNull() const;
    bool isValid() const;

    QDate date() const;
    QTime time() const;
    Qt.TimeSpec timeSpec() const;
    int offsetFromUtc() const;
#ifndef QT_BOOTSTRAPPED
    QTimeZone timeZone() const;
#endif // QT_BOOTSTRAPPED
    QString timeZoneAbbreviation() const;
    bool isDaylightTime() const;

    qint64 toMSecsSinceEpoch() const;
    // ### Qt 6: use quint64 instead of uint
    uint toTime_t() const;

    void setDate(ref const(QDate) date);
    void setTime(ref const(QTime) time);
    void setTimeSpec(Qt.TimeSpec spec);
    void setOffsetFromUtc(int offsetSeconds);
#ifndef QT_BOOTSTRAPPED
    void setTimeZone(ref const(QTimeZone) toZone);
#endif // QT_BOOTSTRAPPED
    void setMSecsSinceEpoch(qint64 msecs);
    // ### Qt 6: use quint64 instead of uint
    void setTime_t(uint secsSince1Jan1970UTC);

#ifndef QT_NO_DATESTRING
    QString toString(Qt.DateFormat f = Qt.TextDate) const;
    QString toString(ref const(QString) format) const;
#endif
    QDateTime addDays(qint64 days) const Q_REQUIRED_RESULT;
    QDateTime addMonths(int months) const Q_REQUIRED_RESULT;
    QDateTime addYears(int years) const Q_REQUIRED_RESULT;
    QDateTime addSecs(qint64 secs) const Q_REQUIRED_RESULT;
    QDateTime addMSecs(qint64 msecs) const Q_REQUIRED_RESULT;

    QDateTime toTimeSpec(Qt.TimeSpec spec) const;
    /+inline+/ QDateTime toLocalTime() const { return toTimeSpec(Qt.LocalTime); }
    /+inline+/ QDateTime toUTC() const { return toTimeSpec(Qt.UTC); }
    QDateTime toOffsetFromUtc(int offsetSeconds) const;
#ifndef QT_BOOTSTRAPPED
    QDateTime toTimeZone(ref const(QTimeZone) toZone) const;
#endif // QT_BOOTSTRAPPED

    qint64 daysTo(ref const(QDateTime) ) const;
    qint64 secsTo(ref const(QDateTime) ) const;
    qint64 msecsTo(ref const(QDateTime) ) const;

    bool operator==(ref const(QDateTime) other) const;
    /+inline+/ bool operator!=(ref const(QDateTime) other) const { return !(*this == other); }
    bool operator<(ref const(QDateTime) other) const;
    /+inline+/ bool operator<=(ref const(QDateTime) other) const { return !(other < *this); }
    /+inline+/ bool operator>(ref const(QDateTime) other) const { return other < *this; }
    /+inline+/ bool operator>=(ref const(QDateTime) other) const { return !(*this < other); }

#if QT_DEPRECATED_SINCE(5, 2)
    QT_DEPRECATED void setUtcOffset(int seconds);
    QT_DEPRECATED int utcOffset() const;
#endif // QT_DEPRECATED_SINCE

    static QDateTime currentDateTime();
    static QDateTime currentDateTimeUtc();
#ifndef QT_NO_DATESTRING
    static QDateTime fromString(ref const(QString) s, Qt.DateFormat f = Qt.TextDate);
    static QDateTime fromString(ref const(QString) s, ref const(QString) format);
#endif
    // ### Qt 6: use quint64 instead of uint
    static QDateTime fromTime_t(uint secsSince1Jan1970UTC);
    // ### Qt 6: Merge with above with default spec = Qt.LocalTime
    static QDateTime fromTime_t(uint secsSince1Jan1970UTC, Qt.TimeSpec spec,
                                int offsetFromUtc = 0);
#ifndef QT_BOOTSTRAPPED
    static QDateTime fromTime_t(uint secsSince1Jan1970UTC, ref const(QTimeZone) timeZone);
#endif
    static QDateTime fromMSecsSinceEpoch(qint64 msecs);
    // ### Qt 6: Merge with above with default spec = Qt.LocalTime
    static QDateTime fromMSecsSinceEpoch(qint64 msecs, Qt.TimeSpec spec, int offsetFromUtc = 0);
#ifndef QT_BOOTSTRAPPED
    static QDateTime fromMSecsSinceEpoch(qint64 msecs, ref const(QTimeZone) timeZone);
#endif
    static qint64 currentMSecsSinceEpoch() nothrow;

private:
    friend extern(C++) class QDateTimePrivate;
    void detach();

    // ### Qt6: Using a private here has high impact on runtime
    // on users such as QFileInfo. In Qt 6, the data members
    // should be inlined.
    QExplicitlySharedDataPointer<QDateTimePrivate> d;

#ifndef QT_NO_DATASTREAM
    friend export QDataStream &operator<<(QDataStream &, ref const(QDateTime) );
    friend export QDataStream &operator>>(QDataStream &, QDateTime &);
#endif

#if !defined(QT_NO_DEBUG_STREAM) && !defined(QT_NO_DATESTRING)
    friend export QDebug operator<<(QDebug, ref const(QDateTime) );
#endif
}
Q_DECLARE_SHARED(QDateTime)

#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &, ref const(QDate) );
export QDataStream &operator>>(QDataStream &, QDate &);
export QDataStream &operator<<(QDataStream &, ref const(QTime) );
export QDataStream &operator>>(QDataStream &, QTime &);
export QDataStream &operator<<(QDataStream &, ref const(QDateTime) );
export QDataStream &operator>>(QDataStream &, QDateTime &);
#endif // QT_NO_DATASTREAM

#if !defined(QT_NO_DEBUG_STREAM) && !defined(QT_NO_DATESTRING)
export QDebug operator<<(QDebug, ref const(QDate) );
export QDebug operator<<(QDebug, ref const(QTime) );
export QDebug operator<<(QDebug, ref const(QDateTime) );
#endif

// QDateTime is not noexcept for now -- to be revised once
// timezone and calendaring support is added
export uint qHash(ref const(QDateTime) key, uint seed = 0);
export uint qHash(ref const(QDate) key, uint seed = 0) nothrow;
export uint qHash(ref const(QTime) key, uint seed = 0) nothrow;

#endif // QDATETIME_H
