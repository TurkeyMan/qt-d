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

public import QtQml.qqml;
public import QtQml.qqmlerror;

public import QtCore.qobject;
public import QtCore.qstring;
public import QtQml.qjsvalue;


extern(C++) class QByteArray;
extern(C++) class QQmlEngine;
extern(C++) class QQmlComponent;
extern(C++) class QQmlIncubator;
extern(C++) class QQmlV4Function;
extern(C++) class QQmlCompiledData;
extern(C++) class QQmlComponentPrivate;
extern(C++) class QQmlComponentAttached;

extern(C++) class Q_QML_EXPORT QQmlComponent : QObject
{
    mixin Q_OBJECT;
    mixin Q_DECLARE_PRIVATE;

    mixin Q_PROPERTY!(qreal, "progress", "READ", "progress", "NOTIFY", "progressChanged");
    mixin Q_PROPERTY!(Status, "status", "READ", "status", "NOTIFY", "statusChanged");
    Q_PROPERTY(QUrl url READ url CONSTANT)

public:
    Q_ENUMS(CompilationMode)
    enum CompilationMode { PreferSynchronous, Asynchronous }

    QQmlComponent(QObject *parent = 0);
    QQmlComponent(QQmlEngine *, QObject *parent=0);
    QQmlComponent(QQmlEngine *, ref const(QString) fileName, QObject *parent = 0);
    QQmlComponent(QQmlEngine *, ref const(QString) fileName, CompilationMode mode, QObject *parent = 0);
    QQmlComponent(QQmlEngine *, ref const(QUrl) url, QObject *parent = 0);
    QQmlComponent(QQmlEngine *, ref const(QUrl) url, CompilationMode mode, QObject *parent = 0);
    /+virtual+/ ~QQmlComponent();

    Q_ENUMS(Status)
    enum Status { Null, Ready, Loading, Error }
    Status status() const;

    bool isNull() const;
    bool isReady() const;
    bool isError() const;
    bool isLoading() const;

    QList<QQmlError> errors() const;
    Q_INVOKABLE QString errorString() const;

    qreal progress() const;

    QUrl url() const;

    /+virtual+/ QObject *create(QQmlContext *context = 0);
    /+virtual+/ QObject *beginCreate(QQmlContext *);
    /+virtual+/ void completeCreate();

    void create(QQmlIncubator &, QQmlContext *context = 0,
                QQmlContext *forContext = 0);

    QQmlContext *creationContext() const;

    static QQmlComponentAttached *qmlAttachedProperties(QObject *);

public Q_SLOTS:
    void loadUrl(ref const(QUrl) url);
    void loadUrl(ref const(QUrl) url, CompilationMode mode);
    void setData(ref const(QByteArray) , ref const(QUrl) baseUrl);

Q_SIGNALS:
    void statusChanged(QQmlComponent::Status);
    void progressChanged(qreal);

protected:
    QQmlComponent(QQmlComponentPrivate &dd, QObject* parent);
    Q_INVOKABLE void createObject(QQmlV4Function *);
    Q_INVOKABLE void incubateObject(QQmlV4Function *);

private:
    QQmlComponent(QQmlEngine *, QQmlCompiledData *, int, QObject *parent);

    mixin Q_DISABLE_COPY;
    friend extern(C++) class QQmlTypeData;
    friend extern(C++) class QQmlObjectCreator;
}

Q_DECLARE_METATYPE(QQmlComponent::Status)
QML_DECLARE_TYPE(QQmlComponent)
QML_DECLARE_TYPEINFO(QQmlComponent, QML_HAS_ATTACHED_PROPERTIES)

#endif // QQMLCOMPONENT_H
