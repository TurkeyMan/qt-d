/****************************************************************************
**
** Copyright (C) 2014 Kurt Pattyn <pattyn.kurt@gmail.com>.
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtWebSockets module of the Qt Toolkit.
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
#ifndef QWEBSOCKETCORSAUTHENTICATOR_H
#define QWEBSOCKETCORSAUTHENTICATOR_H

public import qt.QtWebSockets.qwebsockets_global;
public import qt.QtCore.QScopedPointer;

QT_BEGIN_NAMESPACE

class QWebSocketCorsAuthenticatorPrivate;

class Q_WEBSOCKETS_EXPORT QWebSocketCorsAuthenticator
{
    mixin Q_DECLARE_PRIVATE;

public:
    explicit QWebSocketCorsAuthenticator(ref const(QString) origin);
    ~QWebSocketCorsAuthenticator();
    explicit QWebSocketCorsAuthenticator(ref const(QWebSocketCorsAuthenticator) other);

#ifdef Q_COMPILER_RVALUE_REFS
    QWebSocketCorsAuthenticator(QWebSocketCorsAuthenticator &&other);
    QWebSocketCorsAuthenticator &operator =(QWebSocketCorsAuthenticator &&other);
#endif

    void swap(QWebSocketCorsAuthenticator &other);

    QWebSocketCorsAuthenticator &operator =(ref const(QWebSocketCorsAuthenticator) other);

    QString origin() const;

    void setAllowed(bool allowed);
    bool allowed() const;

private:
    QScopedPointer<QWebSocketCorsAuthenticatorPrivate> d_ptr;
};

QT_END_NAMESPACE

#endif // QWEBSOCKETCORSAUTHENTICATOR_H
