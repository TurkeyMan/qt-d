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

public import QtCore.qurl;
public import QtCore.qobject;
public import QtQml.qjsvalue;
public import QtCore.qmetatype;
public import QtCore.qvariant;


extern(C++) class QString;
extern(C++) class QQmlEngine;
extern(C++) class QQmlRefCount;
extern(C++) class QQmlContextPrivate;
extern(C++) class QQmlCompositeTypeData;
extern(C++) class QQmlContextData;

extern(C++) class Q_QML_EXPORT QQmlContext : QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

public:
    QQmlContext(QQmlEngine *parent, QObject *objParent=0);
    QQmlContext(QQmlContext *parent, QObject *objParent=0);
    /+virtual+/ ~QQmlContext();

    bool isValid() const;

    QQmlEngine *engine() const;
    QQmlContext *parentContext() const;

    QObject *contextObject() const;
    void setContextObject(QObject *);

    QVariant contextProperty(ref const(QString) ) const;
    void setContextProperty(ref const(QString) , QObject *);
    void setContextProperty(ref const(QString) , ref const(QVariant) );

    QString nameForObject(QObject *) const;

    QUrl resolvedUrl(ref const(QUrl) );

    void setBaseUrl(ref const(QUrl) );
    QUrl baseUrl() const;

private:
    friend extern(C++) class QQmlEngine;
    friend extern(C++) class QQmlEnginePrivate;
    friend extern(C++) class QQmlExpression;
    friend extern(C++) class QQmlExpressionPrivate;
    friend extern(C++) class QQmlComponent;
    friend extern(C++) class QQmlComponentPrivate;
    friend extern(C++) class QQmlScriptPrivate;
    friend extern(C++) class QQmlContextData;
    QQmlContext(QQmlContextData *);
    QQmlContext(QQmlEngine *, bool);
    mixin Q_DISABLE_COPY;
}
Q_DECLARE_METATYPE(QList<QObject*>)

#endif // QQMLCONTEXT_H
