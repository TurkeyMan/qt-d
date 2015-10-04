/****************************************************************************
**
** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QtXmlPatterns module of the Qt Toolkit.
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

#ifndef QXMLSCHEMA_H
#define QXMLSCHEMA_H

public import qt.QtCore.QSharedDataPointer;
public import qt.QtCore.QUrl;
public import qt.QtXmlPatterns.QXmlNamePool;

QT_BEGIN_NAMESPACE


class QAbstractMessageHandler;
class QAbstractUriResolver;
class QIODevice;
class QNetworkAccessManager;
class QUrl;
class QXmlNamePool;
class QXmlSchemaPrivate;

class Q_XMLPATTERNS_EXPORT QXmlSchema
{
    friend class QXmlSchemaValidatorPrivate;

    public:
        QXmlSchema();
        QXmlSchema(ref const(QXmlSchema) other);
        QXmlSchema &operator=(ref const(QXmlSchema) other);
        ~QXmlSchema();

        bool load(ref const(QUrl) source);
        bool load(QIODevice *source, ref const(QUrl) documentUri = QUrl());
        bool load(ref const(QByteArray) data, ref const(QUrl) documentUri = QUrl());

        bool isValid() const;

        QXmlNamePool namePool() const;
        QUrl documentUri() const;

        void setMessageHandler(QAbstractMessageHandler *handler);
        QAbstractMessageHandler *messageHandler() const;

        void setUriResolver(const(QAbstractUriResolver)* resolver);
        const(QAbstractUriResolver)* uriResolver() const;

        void setNetworkAccessManager(QNetworkAccessManager *networkmanager);
        QNetworkAccessManager *networkAccessManager() const;

    private:
        QSharedDataPointer<QXmlSchemaPrivate> d;
};

QT_END_NAMESPACE

#endif
