/****************************************************************************
**
** Copyright (C) 2014 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com, author Milian Wolff <milian.wolff@kdab.com>
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtWebChannel module of the Qt Toolkit.
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

#ifndef QQMLWEBCHANNEL_H
#define QQMLWEBCHANNEL_H

public import qt.QtWebChannel.QWebChannel;
public import qt.QtWebChannel.qwebchannelglobal;

public import qt.QtQml.qqml;
public import qt.QtQml.QQmlListProperty;

QT_BEGIN_NAMESPACE

class QQmlWebChannelPrivate;
class QQmlWebChannelAttached;
class Q_WEBCHANNEL_EXPORT QQmlWebChannel : public QWebChannel
{
    mixin Q_OBJECT;
    mixin Q_DISABLE_COPY;

    Q_PROPERTY( QQmlListProperty<QObject> transports READ transports )
    Q_PROPERTY( QQmlListProperty<QObject> registeredObjects READ registeredObjects )

public:
    explicit QQmlWebChannel(QObject *parent = 0);
    /+virtual+/ ~QQmlWebChannel();

    Q_INVOKABLE void registerObjects(ref const(QVariantMap) objects);
    QQmlListProperty<QObject> registeredObjects();

    QQmlListProperty<QObject> transports();

    static QQmlWebChannelAttached *qmlAttachedProperties(QObject *obj);

    Q_INVOKABLE void connectTo(QObject *transport);
    Q_INVOKABLE void disconnectFrom(QObject *transport);

private:
    mixin Q_DECLARE_PRIVATE;
    Q_PRIVATE_SLOT(d_func(), void _q_objectIdChanged(ref const(QString) newId))

    static void registeredObjects_append(QQmlListProperty<QObject> *prop, QObject *item);
    static int registeredObjects_count(QQmlListProperty<QObject> *prop);
    static QObject *registeredObjects_at(QQmlListProperty<QObject> *prop, int index);
    static void registeredObjects_clear(QQmlListProperty<QObject> *prop);

    static void transports_append(QQmlListProperty<QObject> *prop, QObject *item);
    static int transports_count(QQmlListProperty<QObject> *prop);
    static QObject *transports_at(QQmlListProperty<QObject> *prop, int index);
    static void transports_clear(QQmlListProperty<QObject> *prop);
};

QT_END_NAMESPACE

QML_DECLARE_TYPE( QQmlWebChannel )
QML_DECLARE_TYPEINFO( QQmlWebChannel, QML_HAS_ATTACHED_PROPERTIES )

#endif // QQMLWEBCHANNEL_H
