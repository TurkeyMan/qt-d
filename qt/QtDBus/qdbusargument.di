/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtDBus module of the Qt Toolkit.
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

#ifndef QDBUSARGUMENT_H
#define QDBUSARGUMENT_H

public import qt.QtCore.qbytearray;
public import qt.QtCore.qhash;
public import qt.QtCore.qglobal;
public import qt.QtCore.qlist;
public import qt.QtCore.qmap;
public import qt.QtCore.qstring;
public import qt.QtCore.qstringlist;
public import qt.QtCore.qvariant;
public import qt.QtDBus.qdbusextratypes;
public import qt.QtDBus.qdbusmacros;

#ifndef QT_NO_DBUS

QT_BEGIN_NAMESPACE


class QDBusUnixFileDescriptor;

class QDBusArgumentPrivate;
class QDBusDemarshaller;
class QDBusMarshaller;
class Q_DBUS_EXPORT QDBusArgument
{
public:
    enum ElementType {
        BasicType,
        VariantType,
        ArrayType,
        StructureType,
        MapType,
        MapEntryType,
        UnknownType = -1
    };

    QDBusArgument();
    QDBusArgument(ref const(QDBusArgument) other);
    QDBusArgument &operator=(ref const(QDBusArgument) other);
    ~QDBusArgument();

    // used for marshalling (Qt -> D-BUS)
    QDBusArgument &operator<<(uchar arg);
    QDBusArgument &operator<<(bool arg);
    QDBusArgument &operator<<(short arg);
    QDBusArgument &operator<<(ushort arg);
    QDBusArgument &operator<<(int arg);
    QDBusArgument &operator<<(uint arg);
    QDBusArgument &operator<<(qlonglong arg);
    QDBusArgument &operator<<(qulonglong arg);
    QDBusArgument &operator<<(double arg);
    QDBusArgument &operator<<(ref const(QString) arg);
    QDBusArgument &operator<<(ref const(QDBusVariant) arg);
    QDBusArgument &operator<<(ref const(QDBusObjectPath) arg);
    QDBusArgument &operator<<(ref const(QDBusSignature) arg);
    QDBusArgument &operator<<(ref const(QDBusUnixFileDescriptor) arg);
    QDBusArgument &operator<<(ref const(QStringList) arg);
    QDBusArgument &operator<<(ref const(QByteArray) arg);

    void beginStructure();
    void endStructure();
    void beginArray(int elementMetaTypeId);
    void endArray();
    void beginMap(int keyMetaTypeId, int valueMetaTypeId);
    void endMap();
    void beginMapEntry();
    void endMapEntry();

    void appendVariant(ref const(QVariant) v);

    // used for de-marshalling (D-BUS -> Qt)
    QString currentSignature() const;
    ElementType currentType() const;

    ref const(QDBusArgument) operator>>(uchar &arg) const;
    ref const(QDBusArgument) operator>>(bool &arg) const;
    ref const(QDBusArgument) operator>>(short &arg) const;
    ref const(QDBusArgument) operator>>(ushort &arg) const;
    ref const(QDBusArgument) operator>>(int &arg) const;
    ref const(QDBusArgument) operator>>(uint &arg) const;
    ref const(QDBusArgument) operator>>(qlonglong &arg) const;
    ref const(QDBusArgument) operator>>(qulonglong &arg) const;
    ref const(QDBusArgument) operator>>(double &arg) const;
    ref const(QDBusArgument) operator>>(QString &arg) const;
    ref const(QDBusArgument) operator>>(QDBusVariant &arg) const;
    ref const(QDBusArgument) operator>>(QDBusObjectPath &arg) const;
    ref const(QDBusArgument) operator>>(QDBusSignature &arg) const;
    ref const(QDBusArgument) operator>>(QDBusUnixFileDescriptor &arg) const;
    ref const(QDBusArgument) operator>>(QStringList &arg) const;
    ref const(QDBusArgument) operator>>(QByteArray &arg) const;

    void beginStructure() const;
    void endStructure() const;
    void beginArray() const;
    void endArray() const;
    void beginMap() const;
    void endMap() const;
    void beginMapEntry() const;
    void endMapEntry() const;
    bool atEnd() const;

    QVariant asVariant() const;

protected:
    QDBusArgument(QDBusArgumentPrivate *d);
    friend class QDBusArgumentPrivate;
    mutable QDBusArgumentPrivate *d;
};

QT_END_NAMESPACE
Q_DECLARE_METATYPE(QDBusArgument)
QT_BEGIN_NAMESPACE

template<typename T> /+inline+/ T qdbus_cast(ref const(QDBusArgument) arg
#ifndef Q_QDOC
, T * = 0
#endif
    )
{
    T item;
    arg >> item;
    return item;
}

template<typename T> /+inline+/ T qdbus_cast(ref const(QVariant) v
#ifndef Q_QDOC
, T * = 0
#endif
    )
{
    int id = v.userType();
    if (id == qMetaTypeId<QDBusArgument>())
        return qdbus_cast<T>(qvariant_cast<QDBusArgument>(v));
    else
        return qvariant_cast<T>(v);
}

// specialize for QVariant, allowing it to be used in place of QDBusVariant
template<> /+inline+/ QVariant qdbus_cast<QVariant>(ref const(QDBusArgument) arg, QVariant *)
{
    QDBusVariant item;
    arg >> item;
    return item.variant();
}
template<> /+inline+/ QVariant qdbus_cast<QVariant>(ref const(QVariant) v, QVariant *)
{
    return qdbus_cast<QDBusVariant>(v).variant();
}

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QVariant &v);

// QVariant types
#ifndef QDBUS_NO_SPECIALTYPES

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QDate &date);
Q_DBUS_EXPORT QDBusArgument &operator<<(QDBusArgument &a, ref const(QDate) date);

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QTime &time);
Q_DBUS_EXPORT QDBusArgument &operator<<(QDBusArgument &a, ref const(QTime) time);

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QDateTime &dt);
Q_DBUS_EXPORT QDBusArgument &operator<<(QDBusArgument &a, ref const(QDateTime) dt);

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QRect &rect);
Q_DBUS_EXPORT QDBusArgument &operator<<(QDBusArgument &a, ref const(QRect) rect);

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QRectF &rect);
Q_DBUS_EXPORT QDBusArgument &operator<<(QDBusArgument &a, ref const(QRectF) rect);

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QSize &size);
Q_DBUS_EXPORT QDBusArgument &operator<<(QDBusArgument &a, ref const(QSize) size);

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QSizeF &size);
Q_DBUS_EXPORT QDBusArgument &operator<<(QDBusArgument &a, ref const(QSizeF) size);

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QPoint &pt);
Q_DBUS_EXPORT QDBusArgument &operator<<(QDBusArgument &a, ref const(QPoint) pt);

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QPointF &pt);
Q_DBUS_EXPORT QDBusArgument &operator<<(QDBusArgument &a, ref const(QPointF) pt);

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QLine &line);
Q_DBUS_EXPORT QDBusArgument &operator<<(QDBusArgument &a, ref const(QLine) line);

Q_DBUS_EXPORT ref const(QDBusArgument) operator>>(ref const(QDBusArgument) a, QLineF &line);
Q_DBUS_EXPORT QDBusArgument &operator<<(QDBusArgument &a, ref const(QLineF) line);
#endif

template<template <typename> class Container, typename T>
/+inline+/ QDBusArgument &operator<<(QDBusArgument &arg, ref const(Container<T>) list)
{
    int id = qMetaTypeId<T>();
    arg.beginArray(id);
    typename Container<T>::const_iterator it = list.begin();
    typename Container<T>::const_iterator end = list.end();
    for ( ; it != end; ++it)
        arg << *it;
    arg.endArray();
    return arg;
}

template<template <typename> class Container, typename T>
/+inline+/ ref const(QDBusArgument) operator>>(ref const(QDBusArgument) arg, Container<T> &list)
{
    arg.beginArray();
    list.clear();
    while (!arg.atEnd()) {
        T item;
        arg >> item;
        list.push_back(item);
    }

    arg.endArray();
    return arg;
}

// QList specializations
template<typename T>
/+inline+/ QDBusArgument &operator<<(QDBusArgument &arg, ref const(QList<T>) list)
{
    int id = qMetaTypeId<T>();
    arg.beginArray(id);
    typename QList<T>::ConstIterator it = list.constBegin();
    typename QList<T>::ConstIterator end = list.constEnd();
    for ( ; it != end; ++it)
        arg << *it;
    arg.endArray();
    return arg;
}

template<typename T>
/+inline+/ ref const(QDBusArgument) operator>>(ref const(QDBusArgument) arg, QList<T> &list)
{
    arg.beginArray();
    list.clear();
    while (!arg.atEnd()) {
        T item;
        arg >> item;
        list.push_back(item);
    }
    arg.endArray();

    return arg;
}

/+inline+/ QDBusArgument &operator<<(QDBusArgument &arg, ref const(QVariantList) list)
{
    int id = qMetaTypeId<QDBusVariant>();
    arg.beginArray(id);
    QVariantList::ConstIterator it = list.constBegin();
    QVariantList::ConstIterator end = list.constEnd();
    for ( ; it != end; ++it)
        arg << QDBusVariant(*it);
    arg.endArray();
    return arg;
}

// QMap specializations
template<typename Key, typename T>
/+inline+/ QDBusArgument &operator<<(QDBusArgument &arg, const QMap<Key, T> &map)
{
    int kid = qMetaTypeId<Key>();
    int vid = qMetaTypeId<T>();
    arg.beginMap(kid, vid);
    typename QMap<Key, T>::ConstIterator it = map.constBegin();
    typename QMap<Key, T>::ConstIterator end = map.constEnd();
    for ( ; it != end; ++it) {
        arg.beginMapEntry();
        arg << it.key() << it.value();
        arg.endMapEntry();
    }
    arg.endMap();
    return arg;
}

template<typename Key, typename T>
/+inline+/ ref const(QDBusArgument) operator>>(ref const(QDBusArgument) arg, QMap<Key, T> &map)
{
    arg.beginMap();
    map.clear();
    while (!arg.atEnd()) {
        Key key;
        T value;
        arg.beginMapEntry();
        arg >> key >> value;
        map.insertMulti(key, value);
        arg.endMapEntry();
    }
    arg.endMap();
    return arg;
}

/+inline+/ QDBusArgument &operator<<(QDBusArgument &arg, ref const(QVariantMap) map)
{
    arg.beginMap(QVariant::String, qMetaTypeId<QDBusVariant>());
    QVariantMap::ConstIterator it = map.constBegin();
    QVariantMap::ConstIterator end = map.constEnd();
    for ( ; it != end; ++it) {
        arg.beginMapEntry();
        arg << it.key() << QDBusVariant(it.value());
        arg.endMapEntry();
    }
    arg.endMap();
    return arg;
}

// QHash specializations
template<typename Key, typename T>
/+inline+/ QDBusArgument &operator<<(QDBusArgument &arg, const QHash<Key, T> &map)
{
    int kid = qMetaTypeId<Key>();
    int vid = qMetaTypeId<T>();
    arg.beginMap(kid, vid);
    typename QHash<Key, T>::ConstIterator it = map.constBegin();
    typename QHash<Key, T>::ConstIterator end = map.constEnd();
    for ( ; it != end; ++it) {
        arg.beginMapEntry();
        arg << it.key() << it.value();
        arg.endMapEntry();
    }
    arg.endMap();
    return arg;
}

template<typename Key, typename T>
/+inline+/ ref const(QDBusArgument) operator>>(ref const(QDBusArgument) arg, QHash<Key, T> &map)
{
    arg.beginMap();
    map.clear();
    while (!arg.atEnd()) {
        Key key;
        T value;
        arg.beginMapEntry();
        arg >> key >> value;
        map.insertMulti(key, value);
        arg.endMapEntry();
    }
    arg.endMap();
    return arg;
}

/+inline+/ QDBusArgument &operator<<(QDBusArgument &arg, ref const(QVariantHash) map)
{
    arg.beginMap(QVariant::String, qMetaTypeId<QDBusVariant>());
    QVariantHash::ConstIterator it = map.constBegin();
    QVariantHash::ConstIterator end = map.constEnd();
    for ( ; it != end; ++it) {
        arg.beginMapEntry();
        arg << it.key() << QDBusVariant(it.value());
        arg.endMapEntry();
    }
    arg.endMap();
    return arg;
}

template <typename T1, typename T2>
/+inline+/ QDBusArgument &operator<<(QDBusArgument &arg, const QPair<T1, T2> &pair)
{
    arg.beginStructure();
    arg << pair.first << pair.second;
    arg.endStructure();
    return arg;
}

template <typename T1, typename T2>
/+inline+/ ref const(QDBusArgument) operator>>(ref const(QDBusArgument) arg, QPair<T1, T2> &pair)
{
    arg.beginStructure();
    arg >> pair.first >> pair.second;
    arg.endStructure();
    return arg;
}

QT_END_NAMESPACE

#endif // QT_NO_DBUS
#endif
