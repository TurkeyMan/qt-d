/****************************************************************************
**
** Copyright (C) 2013 John Layt <jlayt@kde.org>
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


public import QtCore.qsharedpointer;
public import QtCore.qlocale;
public import QtCore.qdatetime;

extern(C++) class QTimeZonePrivate;

extern(C++) class export QTimeZone
{
public:
    enum TimeType {
        StandardTime = 0,
        DaylightTime = 1,
        GenericTime = 2
    }

    enum NameType {
        DefaultName = 0,
        LongName = 1,
        ShortName = 2,
        OffsetName = 3
    }

    struct OffsetData {
        QString abbreviation;
        QDateTime atUtc;
        int offsetFromUtc;
        int standardTimeOffset;
        int daylightTimeOffset;
    }
    typedef QVector<OffsetData> OffsetDataList;

    QTimeZone();
    explicit QTimeZone(ref const(QByteArray) ianaId);
    explicit QTimeZone(int offsetSeconds);
    /*implicit*/ QTimeZone(ref const(QByteArray) zoneId, int offsetSeconds, ref const(QString) name,
              ref const(QString) abbreviation, QLocale::Country country = QLocale::AnyCountry,
              ref const(QString) comment = QString());
    QTimeZone(ref const(QTimeZone) other);
    ~QTimeZone();

    QTimeZone &operator=(ref const(QTimeZone) other);
 #ifdef Q_COMPILER_RVALUE_REFS
    QTimeZone &operator=(QTimeZone &&other) { swap(other); return *this; }
#endif

    void swap(QTimeZone &other)
    { d.swap(other.d); }

    bool operator==(ref const(QTimeZone) other) const;
    bool operator!=(ref const(QTimeZone) other) const;

    bool isValid() const;

    QByteArray id() const;
    QLocale::Country country() const;
    QString comment() const;

    QString displayName(ref const(QDateTime) atDateTime,
                        QTimeZone::NameType nameType = QTimeZone::DefaultName,
                        ref const(QLocale) locale = QLocale()) const;
    QString displayName(QTimeZone::TimeType timeType,
                        QTimeZone::NameType nameType = QTimeZone::DefaultName,
                        ref const(QLocale) locale = QLocale()) const;
    QString abbreviation(ref const(QDateTime) atDateTime) const;

    int offsetFromUtc(ref const(QDateTime) atDateTime) const;
    int standardTimeOffset(ref const(QDateTime) atDateTime) const;
    int daylightTimeOffset(ref const(QDateTime) atDateTime) const;

    bool hasDaylightTime() const;
    bool isDaylightTime(ref const(QDateTime) atDateTime) const;

    OffsetData offsetData(ref const(QDateTime) forDateTime) const;

    bool hasTransitions() const;
    OffsetData nextTransition(ref const(QDateTime) afterDateTime) const;
    OffsetData previousTransition(ref const(QDateTime) beforeDateTime) const;
    OffsetDataList transitions(ref const(QDateTime) fromDateTime, ref const(QDateTime) toDateTime) const;

    static QByteArray systemTimeZoneId();

    static bool isTimeZoneIdAvailable(ref const(QByteArray) ianaId);

    static QList<QByteArray> availableTimeZoneIds();
    static QList<QByteArray> availableTimeZoneIds(QLocale::Country country);
    static QList<QByteArray> availableTimeZoneIds(int offsetSeconds);

    static QByteArray ianaIdToWindowsId(ref const(QByteArray) ianaId);
    static QByteArray windowsIdToDefaultIanaId(ref const(QByteArray) windowsId);
    static QByteArray windowsIdToDefaultIanaId(ref const(QByteArray) windowsId,
                                                QLocale::Country country);
    static QList<QByteArray> windowsIdToIanaIds(ref const(QByteArray) windowsId);
    static QList<QByteArray> windowsIdToIanaIds(ref const(QByteArray) windowsId,
                                                 QLocale::Country country);

private:
    QTimeZone(QTimeZonePrivate &dd);
#ifndef QT_NO_DATASTREAM
    friend export QDataStream &operator<<(QDataStream &ds, ref const(QTimeZone) tz);
#endif
    friend extern(C++) class QTimeZonePrivate;
    friend extern(C++) class QDateTime;
    friend extern(C++) class QDateTimePrivate;
    QSharedDataPointer<QTimeZonePrivate> d;
}

Q_DECLARE_TYPEINFO(QTimeZone::OffsetData, Q_MOVABLE_TYPE);
Q_DECLARE_SHARED(QTimeZone)

#ifndef QT_NO_DATASTREAM
export QDataStream &operator<<(QDataStream &ds, ref const(QTimeZone) tz);
export QDataStream &operator>>(QDataStream &ds, QTimeZone &tz);
#endif

#ifndef QT_NO_DEBUG_STREAM
export QDebug operator<<(QDebug dbg, ref const(QTimeZone) tz);
#endif

#endif // QTIMEZONE_H
