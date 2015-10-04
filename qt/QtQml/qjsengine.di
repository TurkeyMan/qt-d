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

public import QtCore.qmetatype;

public import QtCore.qvariant;
public import QtCore.qsharedpointer;
public import QtCore.qobject;
public import QtQml.qjsvalue;


extern(C++) class QV8Engine;

template <typename T>
/+inline+/ T qjsvalue_cast(ref const(QJSValue) );

extern(C++) class QJSEnginePrivate;
extern(C++) class Q_QML_EXPORT QJSEngine
    : public QObject
{
    mixin Q_OBJECT;
public:
    QJSEngine();
    explicit QJSEngine(QObject *parent);
    /+virtual+/ ~QJSEngine();

    QJSValue globalObject() const;

    QJSValue evaluate(ref const(QString) program, ref const(QString) fileName = QString(), int lineNumber = 1);

    QJSValue newObject();
    QJSValue newArray(uint length = 0);

    QJSValue newQObject(QObject *object);

    template <typename T>
    /+inline+/ QJSValue toScriptValue(ref const(T) value)
    {
        return create(qMetaTypeId<T>(), &value);
    }
    template <typename T>
    /+inline+/ T fromScriptValue(ref const(QJSValue) value)
    {
        return qjsvalue_cast<T>(value);
    }

    void collectGarbage();

    void installTranslatorFunctions(ref const(QJSValue) object = QJSValue());

    QV8Engine *handle() const { return d; }

private:
    QJSValue create(int type, const(void)* ptr);

    static bool convertV2(ref const(QJSValue) value, int type, void *ptr);

    friend /+inline+/ bool qjsvalue_cast_helper(ref const(QJSValue) , int, void *);

protected:
    QJSEngine(QJSEnginePrivate &dd, QObject *parent = 0);

private:
    QV8Engine *d;
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
    friend extern(C++) class QV8Engine;
}

/+inline+/ bool qjsvalue_cast_helper(ref const(QJSValue) value, int type, void *ptr)
{
    return QJSEngine::convertV2(value, type, ptr);
}

template<typename T>
T qjsvalue_cast(ref const(QJSValue) value)
{
    T t;
    const int id = qMetaTypeId<T>();

    if (qjsvalue_cast_helper(value, id, &t))
        return t;
    else if (value.isVariant())
        return qvariant_cast<T>(value.toVariant());

    return T();
}

template <>
/+inline+/ QVariant qjsvalue_cast<QVariant>(ref const(QJSValue) value)
{
    return value.toVariant();
}

#endif // QJSENGINE_H
