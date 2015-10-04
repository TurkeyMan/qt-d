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
public import QtCore.qmetaobject;


extern(C++) class QObject;
extern(C++) class QVariant;
extern(C++) class QQmlContext;
extern(C++) class QQmlEngine;

extern(C++) class QQmlPropertyPrivate;
extern(C++) class Q_QML_EXPORT QQmlProperty
{
public:
    enum PropertyTypeCategory {
        InvalidCategory,
        List,
        Object,
        Normal
    }

    enum Type {
        Invalid,
        Property,
        SignalProperty
    }

    QQmlProperty();
    ~QQmlProperty();

    QQmlProperty(QObject *);
    QQmlProperty(QObject *, QQmlContext *);
    QQmlProperty(QObject *, QQmlEngine *);

    QQmlProperty(QObject *, ref const(QString) );
    QQmlProperty(QObject *, ref const(QString) , QQmlContext *);
    QQmlProperty(QObject *, ref const(QString) , QQmlEngine *);

    QQmlProperty(ref const(QQmlProperty) );
    QQmlProperty &operator=(ref const(QQmlProperty) );

    bool operator==(ref const(QQmlProperty) ) const;

    Type type() const;
    bool isValid() const;
    bool isProperty() const;
    bool isSignalProperty() const;

    int propertyType() const;
    PropertyTypeCategory propertyTypeCategory() const;
    const(char)* propertyTypeName() const;

    QString name() const;

    QVariant read() const;
    static QVariant read(const(QObject)* , ref const(QString) );
    static QVariant read(const(QObject)* , ref const(QString) , QQmlContext *);
    static QVariant read(const(QObject)* , ref const(QString) , QQmlEngine *);

    bool write(ref const(QVariant) ) const;
    static bool write(QObject *, ref const(QString) , ref const(QVariant) );
    static bool write(QObject *, ref const(QString) , ref const(QVariant) , QQmlContext *);
    static bool write(QObject *, ref const(QString) , ref const(QVariant) , QQmlEngine *);

    bool reset() const;

    bool hasNotifySignal() const;
    bool needsNotifySignal() const;
    bool connectNotifySignal(QObject *dest, const(char)* slot) const;
    bool connectNotifySignal(QObject *dest, int method) const;

    bool isWritable() const;
    bool isDesignable() const;
    bool isResettable() const;
    QObject *object() const;

    int index() const;
    QMetaProperty property() const;
    QMetaMethod method() const;

private:
    friend extern(C++) class QQmlPropertyPrivate;
    QQmlPropertyPrivate *d;
}
typedef QList<QQmlProperty> QQmlProperties;

/+inline+/ uint qHash (ref const(QQmlProperty) key)
{
    return qHash(key.object()) + qHash(key.name());
}

Q_DECLARE_TYPEINFO(QQmlProperty, Q_MOVABLE_TYPE);

#endif // QQMLPROPERTY_H
