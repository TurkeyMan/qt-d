/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtNetwork module of the Qt Toolkit.
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

#ifndef QTCPSERVER_H
#define QTCPSERVER_H

public import qt.QtCore.qobject;
public import qt.QtNetwork.qabstractsocket;
public import qt.QtNetwork.qhostaddress;

QT_BEGIN_NAMESPACE


class QTcpServerPrivate;
#ifndef QT_NO_NETWORKPROXY
class QNetworkProxy;
#endif
class QTcpSocket;

class Q_NETWORK_EXPORT QTcpServer : public QObject
{
    mixin Q_OBJECT;
public:
    explicit QTcpServer(QObject *parent = 0);
    /+virtual+/ ~QTcpServer();

    bool listen(ref const(QHostAddress) address = QHostAddress::Any, quint16 port = 0);
    void close();

    bool isListening() const;

    void setMaxPendingConnections(int numConnections);
    int maxPendingConnections() const;

    quint16 serverPort() const;
    QHostAddress serverAddress() const;

    qintptr socketDescriptor() const;
    bool setSocketDescriptor(qintptr socketDescriptor);

    bool waitForNewConnection(int msec = 0, bool *timedOut = 0);
    /+virtual+/ bool hasPendingConnections() const;
    /+virtual+/ QTcpSocket *nextPendingConnection();

    QAbstractSocket::SocketError serverError() const;
    QString errorString() const;

    void pauseAccepting();
    void resumeAccepting();

#ifndef QT_NO_NETWORKPROXY
    void setProxy(ref const(QNetworkProxy) networkProxy);
    QNetworkProxy proxy() const;
#endif

protected:
    /+virtual+/ void incomingConnection(qintptr handle);
    void addPendingConnection(QTcpSocket* socket);

Q_SIGNALS:
    void newConnection();
    void acceptError(QAbstractSocket::SocketError socketError);

private:
    mixin Q_DISABLE_COPY;
    mixin Q_DECLARE_PRIVATE;
};

QT_END_NAMESPACE

#endif // QTCPSERVER_H
