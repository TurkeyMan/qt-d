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
public import QtCore.qstring;

extern(C++) class QDebug;
extern(C++) class QVariant;
extern(C++) class QJsonArray;
extern(C++) class QJsonObject;

namespace QJsonPrivate {
    extern(C++) class Data;
    extern(C++) class Base;
    extern(C++) class Object;
    extern(C++) class Header;
    extern(C++) class Array;
    extern(C++) class Value;
    extern(C++) class Entry;
}

extern(C++) class export QJsonValue
{
public:
    enum Type {
        Null =  0x0,
        Bool = 0x1,
        Double = 0x2,
        String = 0x3,
        Array = 0x4,
        Object = 0x5,
        Undefined = 0x80
    }

    QJsonValue(Type = Null);
    QJsonValue(bool b);
    QJsonValue(double n);
    QJsonValue(int n);
    QJsonValue(qint64 n);
    QJsonValue(ref const(QString) s);
    QJsonValue(QLatin1String s);
#ifndef QT_NO_CAST_FROM_ASCII
    /+inline+/ QT_ASCII_CAST_WARN QJsonValue(const(char)* s)
        : d(0), t(String) { stringDataFromQStringHelper(QString::fromUtf8(s)); }
#endif
    QJsonValue(ref const(QJsonArray) a);
    QJsonValue(ref const(QJsonObject) o);

    ~QJsonValue();

    QJsonValue(ref const(QJsonValue) other);
    QJsonValue &operator =(ref const(QJsonValue) other);

    static QJsonValue fromVariant(ref const(QVariant) variant);
    QVariant toVariant() const;

    Type type() const;
    /+inline+/ bool isNull() const { return type() == Null; }
    /+inline+/ bool isBool() const { return type() == Bool; }
    /+inline+/ bool isDouble() const { return type() == Double; }
    /+inline+/ bool isString() const { return type() == String; }
    /+inline+/ bool isArray() const { return type() == Array; }
    /+inline+/ bool isObject() const { return type() == Object; }
    /+inline+/ bool isUndefined() const { return type() == Undefined; }

    bool toBool(bool defaultValue = false) const;
    int toInt(int defaultValue = 0) const;
    double toDouble(double defaultValue = 0) const;
    QString toString(ref const(QString) defaultValue = QString()) const;
    QJsonArray toArray() const;
    QJsonArray toArray(ref const(QJsonArray) defaultValue) const;
    QJsonObject toObject() const;
    QJsonObject toObject(ref const(QJsonObject) defaultValue) const;

    bool operator==(ref const(QJsonValue) other) const;
    bool operator!=(ref const(QJsonValue) other) const;

private:
    // avoid implicit conversions from char * to bool
    /+inline+/ QJsonValue(const(void)* ) {}
    friend extern(C++) class QJsonPrivate::Value;
    friend extern(C++) class QJsonArray;
    friend extern(C++) class QJsonObject;
    friend export QDebug operator<<(QDebug, ref const(QJsonValue) );

    QJsonValue(QJsonPrivate::Data *d, QJsonPrivate::Base *b, ref const(QJsonPrivate::Value) v);
    void stringDataFromQStringHelper(ref const(QString) string);

    void detach();

    union {
        quint64 ui;
        bool b;
        double dbl;
        QStringData *stringData;
        QJsonPrivate::Base *base;
    }
    QJsonPrivate::Data *d; // needed for Objects and Arrays
    Type t;
}

extern(C++) class export QJsonValueRef
{
public:
    QJsonValueRef(QJsonArray *array, int idx)
        : a(array), is_object(false), index(idx) {}
    QJsonValueRef(QJsonObject *object, int idx)
        : o(object), is_object(true), index(idx) {}

    /+inline+/ operator QJsonValue() const { return toValue(); }
    QJsonValueRef &operator = (ref const(QJsonValue) val);
    QJsonValueRef &operator = (ref const(QJsonValueRef) val);

    /+inline+/ QJsonValue::Type type() const { return toValue().type(); }
    /+inline+/ bool isNull() const { return type() == QJsonValue::Null; }
    /+inline+/ bool isBool() const { return type() == QJsonValue::Bool; }
    /+inline+/ bool isDouble() const { return type() == QJsonValue::Double; }
    /+inline+/ bool isString() const { return type() == QJsonValue::String; }
    /+inline+/ bool isArray() const { return type() == QJsonValue::Array; }
    /+inline+/ bool isObject() const { return type() == QJsonValue::Object; }
    /+inline+/ bool isUndefined() const { return type() == QJsonValue::Undefined; }

    /+inline+/ bool toBool() const { return toValue().toBool(); }
    /+inline+/ int toInt() const { return toValue().toInt(); }
    /+inline+/ double toDouble() const { return toValue().toDouble(); }
    /+inline+/ QString toString() const { return toValue().toString(); }
    QJsonArray toArray() const;
    QJsonObject toObject() const;

    // ### Qt 6: Add default values
    /+inline+/ bool toBool(bool defaultValue) const { return toValue().toBool(defaultValue); }
    /+inline+/ int toInt(int defaultValue) const { return toValue().toInt(defaultValue); }
    /+inline+/ double toDouble(double defaultValue) const { return toValue().toDouble(defaultValue); }
    /+inline+/ QString toString(ref const(QString) defaultValue) const { return toValue().toString(defaultValue); }

    /+inline+/ bool operator==(ref const(QJsonValue) other) const { return toValue() == other; }
    /+inline+/ bool operator!=(ref const(QJsonValue) other) const { return toValue() != other; }

private:
    QJsonValue toValue() const;

    union {
        QJsonArray *a;
        QJsonObject *o;
    }
    uint is_object : 1;
    uint index : 31;
}

#ifndef Q_QDOC
// ### Qt 6: Get rid of these fake pointer classes
extern(C++) class QJsonValuePtr
{
    QJsonValue value;
public:
    explicit QJsonValuePtr(ref const(QJsonValue) val)
        : value(val) {}

    QJsonValue& operator*() { return value; }
    QJsonValue* operator->() { return &value; }
}

extern(C++) class QJsonValueRefPtr
{
    QJsonValueRef valueRef;
public:
    QJsonValueRefPtr(QJsonArray *array, int idx)
        : valueRef(array, idx) {}
    QJsonValueRefPtr(QJsonObject *object, int idx)
        : valueRef(object, idx)  {}

    QJsonValueRef& operator*() { return valueRef; }
    QJsonValueRef* operator->() { return &valueRef; }
}
#endif

#if !defined(QT_NO_DEBUG_STREAM) && !defined(QT_JSON_READONLY)
export QDebug operator<<(QDebug, ref const(QJsonValue) );
#endif

#endif // QJSONVALUE_H