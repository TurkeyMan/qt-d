/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtDeclarative module of the Qt Toolkit.
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

#ifndef QDECLARATIVECOMPONENT_H
#define QDECLARATIVECOMPONENT_H

public import qt.QtDeclarative.qdeclarative;
public import qt.QtDeclarative.qdeclarativeerror;

public import qt.QtCore.qobject;
public import qt.QtCore.qstring;
public import qt.QtScript.qscriptvalue;

QT_BEGIN_NAMESPACE

QT_MODULE(Declarative)

class QDeclarativeCompiledData;
class QByteArray;
class QDeclarativeComponentPrivate;
class QDeclarativeEngine;
class QDeclarativeComponentAttached;
class Q_DECLARATIVE_EXPORT QDeclarativeComponent : public QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

    mixin Q_PROPERTY!(qreal, "progress", "READ", "progress", "NOTIFY", "progressChanged");
    mixin Q_PROPERTY!(Status, "status", "READ", "status", "NOTIFY", "statusChanged");
    Q_PROPERTY(QUrl url READ url CONSTANT)

public:
    QDeclarativeComponent(QObject *parent = 0);
    QDeclarativeComponent(QDeclarativeEngine *, QObject *parent=0);
    QDeclarativeComponent(QDeclarativeEngine *, ref const(QString) fileName, QObject *parent = 0);
    QDeclarativeComponent(QDeclarativeEngine *, ref const(QUrl) url, QObject *parent = 0);
    /+virtual+/ ~QDeclarativeComponent();

    Q_ENUMS(Status)
    enum Status { Null, Ready, Loading, Error };
    Status status() const;

    bool isNull() const;
    bool isReady() const;
    bool isError() const;
    bool isLoading() const;

    QList<QDeclarativeError> errors() const;
    Q_INVOKABLE QString errorString() const;

    qreal progress() const;

    QUrl url() const;

    /+virtual+/ QObject *create(QDeclarativeContext *context = 0);
    /+virtual+/ QObject *beginCreate(QDeclarativeContext *);
    /+virtual+/ void completeCreate();

    void loadUrl(ref const(QUrl) url);
    void setData(ref const(QByteArray) , ref const(QUrl) baseUrl);

    QDeclarativeContext *creationContext() const;

    static QDeclarativeComponentAttached *qmlAttachedProperties(QObject *);

Q_SIGNALS:
    void statusChanged(QDeclarativeComponent::Status);
    void progressChanged(qreal);

protected:
    QDeclarativeComponent(QDeclarativeComponentPrivate &dd, QObject* parent);
    Q_INVOKABLE QScriptValue createObject(QObject* parent);
    Q_INVOKABLE Q_REVISION(1) QScriptValue createObject(QObject* parent, ref const(QScriptValue) valuemap); //XXX Versioning

private:
    QDeclarativeComponent(QDeclarativeEngine *, QDeclarativeCompiledData *, int, int, QObject *parent);

    mixin Q_DISABLE_COPY;
    friend class QDeclarativeVME;
    friend class QDeclarativeCompositeTypeData;
    friend class QDeclarativeTypeData;
};

QT_END_NAMESPACE

Q_DECLARE_METATYPE(QDeclarativeComponent::Status)
QML_DECLARE_TYPE(QDeclarativeComponent)
QML_DECLARE_TYPEINFO(QDeclarativeComponent, QML_HAS_ATTACHED_PROPERTIES)

#endif // QDECLARATIVECOMPONENT_H