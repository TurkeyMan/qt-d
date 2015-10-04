/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtQml module of the Qt Toolkit.
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

public import QtQml.qtqmlglobal;
public import QtCore.qstring;
public import QtCore.qlist;
public import QtCore.qmetatype;


extern(C++) class QJSValue;
extern(C++) class QJSEngine;
extern(C++) class QVariant;
extern(C++) class QObject;
struct QMetaObject;
extern(C++) class QDateTime;

typedef QList<QJSValue> QJSValueList;
extern(C++) class QJSValuePrivate;

extern(C++) class Q_QML_EXPORT QJSValue
{
public:
    enum SpecialValue {
        NullValue,
        UndefinedValue
    }

public:
    QJSValue(SpecialValue value = UndefinedValue);
    ~QJSValue();
    QJSValue(ref const(QJSValue) other);

    QJSValue(bool value);
    QJSValue(int value);
    QJSValue(uint value);
    QJSValue(double value);
    QJSValue(ref const(QString) value);
    QJSValue(ref const(QLatin1String) value);
#ifndef QT_NO_CAST_FROM_ASCII
    QT_ASCII_CAST_WARN QJSValue(const(char)* str);
#endif

    QJSValue &operator=(ref const(QJSValue) other);

    bool isBool() const;
    bool isNumber() const;
    bool isNull() const;
    bool isString() const;
    bool isUndefined() const;
    bool isVariant() const;
    bool isQObject() const;
    bool isObject() const;
    bool isDate() const;
    bool isRegExp() const;
    bool isArray() const;
    bool isError() const;

    QString toString() const;
    double toNumber() const;
    qint32 toInt() const;
    quint32 toUInt() const;
    bool toBool() const;
    QVariant toVariant() const;
    QObject *toQObject() const;
    QDateTime toDateTime() const;

    bool equals(ref const(QJSValue) other) const;
    bool strictlyEquals(ref const(QJSValue) other) const;

    QJSValue prototype() const;
    void setPrototype(ref const(QJSValue) prototype);

    QJSValue property(ref const(QString) name) const;
    void setProperty(ref const(QString) name, ref const(QJSValue) value);

    bool hasProperty(ref const(QString) name) const;
    bool hasOwnProperty(ref const(QString) name) const;

    QJSValue property(quint32 arrayIndex) const;
    void setProperty(quint32 arrayIndex, ref const(QJSValue) value);

    bool deleteProperty(ref const(QString) name);

    bool isCallable() const;
    QJSValue call(ref const(QJSValueList) args = QJSValueList());
    QJSValue callWithInstance(ref const(QJSValue) instance, ref const(QJSValueList) args = QJSValueList());
    QJSValue callAsConstructor(ref const(QJSValueList) args = QJSValueList());

#ifdef QT_DEPRECATED
    QT_DEPRECATED QJSEngine *engine() const;
#endif

    QJSValue(QJSValuePrivate *dd);
private:
    friend extern(C++) class QJSValuePrivate;
    // force compile error, prevent QJSValue(bool) to be called
    QJSValue(void *) Q_DECL_EQ_DELETE;

    QJSValuePrivate *d;
}

Q_DECLARE_METATYPE(QJSValue)

#endif
