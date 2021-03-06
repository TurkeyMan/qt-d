/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtEnginio module of the Qt Toolkit.
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

#ifndef ENGINIOREPLY_H
#define ENGINIOREPLY_H

public import qt.QtCore.qjsonobject;

public import qt.Enginio.enginioclient_global;
public import qt.Enginio.enginioreplystate;

QT_BEGIN_NAMESPACE

class EnginioClient;
class EnginioReplyPrivate;
class EnginioClientConnectionPrivate;

class ENGINIOCLIENT_EXPORT EnginioReply
#ifdef Q_QDOC
        : public QObject
#else
        : public EnginioReplyState
#endif
{
    mixin Q_OBJECT;
    mixin Q_PROPERTY!(QJsonObject, "data", "READ", "data", "NOTIFY", "dataChanged");
    Q_ENUMS(Enginio::ErrorType)
public:

    explicit EnginioReply(EnginioClientConnectionPrivate *parent, QNetworkReply *reply);
    /+virtual+/ ~EnginioReply();

    QJsonObject data() const Q_REQUIRED_RESULT;

Q_SIGNALS:
    void finished(EnginioReply *reply);
    void dataChanged();

#ifdef Q_QDOC
public:
    mixin Q_PROPERTY!(ErrorType, "errorType", "READ", "errorType", "NOTIFY", "dataChanged");
    mixin Q_PROPERTY!(QNetworkReply::NetworkError, "networkError", "READ", "networkError", "NOTIFY", "dataChanged");
    mixin Q_PROPERTY!(QString, "errorString", "READ", "errorString", "NOTIFY", "dataChanged");
    mixin Q_PROPERTY!(int, "backendStatus", "READ", "backendStatus", "NOTIFY", "dataChanged");
    Q_PROPERTY(QString requestId READ requestId CONSTANT)

    ErrorType errorType() const Q_REQUIRED_RESULT;
    QNetworkReply::NetworkError networkError() const Q_REQUIRED_RESULT;
    QString errorString() const Q_REQUIRED_RESULT;
    int backendStatus() const Q_REQUIRED_RESULT;

    bool isError() const Q_REQUIRED_RESULT;
    bool isFinished() const Q_REQUIRED_RESULT;

Q_SIGNALS:
    void progress(qint64 bytesSent, qint64 bytesTotal);

#endif

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

Q_DECLARE_TYPEINFO(const EnginioReply*, Q_PRIMITIVE_TYPE);

#ifndef QT_NO_DEBUG_STREAM
class QDebug;
ENGINIOCLIENT_EXPORT QDebug operator<<(QDebug d, const(EnginioReply)* reply);
#endif

QT_END_NAMESPACE
Q_DECLARE_METATYPE(const EnginioReply*)

#endif // ENGINIOREPLY_H
