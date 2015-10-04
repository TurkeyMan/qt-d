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

#ifndef QDBUSEXTRATYPES_H
#define QDBUSEXTRATYPES_H

// define some useful types for D-BUS

public import qt.QtCore.qvariant;
public import qt.QtCore.qstring;
public import qt.QtDBus.qdbusmacros;
public import qt.QtCore.qhash;

#ifndef QT_NO_DBUS

QT_BEGIN_NAMESPACE


class Q_DBUS_EXPORT QDBusObjectPath
{
    QString m_path;
public:
    /+inline+/ QDBusObjectPath() { }

    /+inline+/ explicit QDBusObjectPath(const(char)* path);
    /+inline+/ explicit QDBusObjectPath(QLatin1String path);
    /+inline+/ explicit QDBusObjectPath(ref const(QString) path);

    /+inline+/ void setPath(ref const(QString) path);

    /+inline+/ QString path() const
    { return m_path; }

private:
    void doCheck();
};

/+inline+/ QDBusObjectPath::QDBusObjectPath(const(char)* objectPath)
    : m_path(QString::fromLatin1(objectPath))
{ doCheck(); }

/+inline+/ QDBusObjectPath::QDBusObjectPath(QLatin1String objectPath)
    : m_path(objectPath)
{ doCheck(); }

/+inline+/ QDBusObjectPath::QDBusObjectPath(ref const(QString) objectPath)
    : m_path(objectPath)
{ doCheck(); }

/+inline+/ void QDBusObjectPath::setPath(ref const(QString) objectPath)
{ m_path = objectPath; doCheck(); }

/+inline+/ bool operator==(ref const(QDBusObjectPath) lhs, ref const(QDBusObjectPath) rhs)
{ return lhs.path() == rhs.path(); }

/+inline+/ bool operator!=(ref const(QDBusObjectPath) lhs, ref const(QDBusObjectPath) rhs)
{ return lhs.path() != rhs.path(); }

/+inline+/ bool operator<(ref const(QDBusObjectPath) lhs, ref const(QDBusObjectPath) rhs)
{ return lhs.path() < rhs.path(); }

/+inline+/ uint qHash(ref const(QDBusObjectPath) objectPath, uint seed)
{ return qHash(objectPath.path(), seed); }


class Q_DBUS_EXPORT QDBusSignature
{
    QString m_signature;
public:
    /+inline+/ QDBusSignature() { }

    /+inline+/ explicit QDBusSignature(const(char)* signature);
    /+inline+/ explicit QDBusSignature(QLatin1String signature);
    /+inline+/ explicit QDBusSignature(ref const(QString) signature);

    /+inline+/ void setSignature(ref const(QString) signature);

    /+inline+/ QString signature() const
    { return m_signature; }

private:
    void doCheck();
};

/+inline+/ QDBusSignature::QDBusSignature(const(char)* dBusSignature)
    : m_signature(QString::fromLatin1(dBusSignature))
{ doCheck(); }

/+inline+/ QDBusSignature::QDBusSignature(QLatin1String dBusSignature)
    : m_signature(dBusSignature)
{ doCheck(); }

/+inline+/ QDBusSignature::QDBusSignature(ref const(QString) dBusSignature)
    : m_signature(dBusSignature)
{ doCheck(); }

/+inline+/ void QDBusSignature::setSignature(ref const(QString) dBusSignature)
{ m_signature = dBusSignature; doCheck(); }

/+inline+/ bool operator==(ref const(QDBusSignature) lhs, ref const(QDBusSignature) rhs)
{ return lhs.signature() == rhs.signature(); }

/+inline+/ bool operator!=(ref const(QDBusSignature) lhs, ref const(QDBusSignature) rhs)
{ return lhs.signature() != rhs.signature(); }

/+inline+/ bool operator<(ref const(QDBusSignature) lhs, ref const(QDBusSignature) rhs)
{ return lhs.signature() < rhs.signature(); }

/+inline+/ uint qHash(ref const(QDBusSignature) signature, uint seed)
{ return qHash(signature.signature(), seed); }

class QDBusVariant
{
    QVariant m_variant;
public:
    /+inline+/ QDBusVariant() { }
    /+inline+/ explicit QDBusVariant(ref const(QVariant) variant);

    /+inline+/ void setVariant(ref const(QVariant) variant);

    /+inline+/ QVariant variant() const
    { return m_variant; }
};

/+inline+/  QDBusVariant::QDBusVariant(ref const(QVariant) dBusVariant)
    : m_variant(dBusVariant) { }

/+inline+/ void QDBusVariant::setVariant(ref const(QVariant) dBusVariant)
{ m_variant = dBusVariant; }

/+inline+/ bool operator==(ref const(QDBusVariant) v1, ref const(QDBusVariant) v2)
{ return v1.variant() == v2.variant(); }

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QDBusVariant)
Q_DECLARE_METATYPE(QDBusObjectPath)
Q_DECLARE_METATYPE(QDBusSignature)

#endif // QT_NO_DBUS
#endif
