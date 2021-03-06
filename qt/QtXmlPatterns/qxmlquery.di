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

#ifndef QXMLQUERY_H
#define QXMLQUERY_H

public import qt.QtCore.QUrl;
public import qt.QtXmlPatterns.QAbstractXmlNodeModel;
public import qt.QtXmlPatterns.QAbstractXmlReceiver;
public import qt.QtXmlPatterns.QXmlNamePool;

QT_BEGIN_NAMESPACE


class QAbstractMessageHandler;
class QAbstractUriResolver;
class QIODevice;
class QNetworkAccessManager;
class QXmlName;
class QXmlNodeIndex;
class QXmlQueryPrivate;
class QXmlResultItems;
class QXmlSerializer;

/* The members in the namespace QPatternistSDK are internal, not part of the public API, and
 * unsupported. Using them leads to undefined behavior. */
namespace QPatternistSDK
{
    class TestCase;
}

namespace QPatternist
{
    class XsdSchemaParser;
    class XsdValidatingInstanceReader;
    class VariableLoader;
}

class Q_XMLPATTERNS_EXPORT QXmlQuery
{
public:
    enum QueryLanguage
    {
        XQuery10                                = 1,
        XSLT20                                  = 2,
        XmlSchema11IdentityConstraintSelector   = 1024,
        XmlSchema11IdentityConstraintField      = 2048,
        XPath20                                 = 4096
    };

    QXmlQuery();
    QXmlQuery(ref const(QXmlQuery) other);
    QXmlQuery(ref const(QXmlNamePool) np);
    QXmlQuery(QueryLanguage queryLanguage,
              ref const(QXmlNamePool) np = QXmlNamePool());
    ~QXmlQuery();
    QXmlQuery &operator=(ref const(QXmlQuery) other);

    void setMessageHandler(QAbstractMessageHandler *messageHandler);
    QAbstractMessageHandler *messageHandler() const;

    void setQuery(ref const(QString) sourceCode, ref const(QUrl) documentURI = QUrl());
    void setQuery(QIODevice *sourceCode, ref const(QUrl) documentURI = QUrl());
    void setQuery(ref const(QUrl) queryURI, ref const(QUrl) baseURI = QUrl());

    QXmlNamePool namePool() const;

    void bindVariable(ref const(QXmlName) name, ref const(QXmlItem) value);
    void bindVariable(ref const(QString) localName, ref const(QXmlItem) value);

    void bindVariable(ref const(QXmlName) name, QIODevice *);
    void bindVariable(ref const(QString) localName, QIODevice *);
    void bindVariable(ref const(QXmlName) name, ref const(QXmlQuery) query);
    void bindVariable(ref const(QString) localName, ref const(QXmlQuery) query);

    bool isValid() const;

    void evaluateTo(QXmlResultItems *result) const;
    bool evaluateTo(QAbstractXmlReceiver *callback) const;
    bool evaluateTo(QStringList *target) const;
    bool evaluateTo(QIODevice *target) const;
    bool evaluateTo(QString *output) const;

    void setUriResolver(const(QAbstractUriResolver)* resolver);
    const(QAbstractUriResolver)* uriResolver() const;

    void setFocus(ref const(QXmlItem) item);
    bool setFocus(ref const(QUrl) documentURI);
    bool setFocus(QIODevice *document);
    bool setFocus(ref const(QString) focus);

    void setInitialTemplateName(ref const(QXmlName) name);
    void setInitialTemplateName(ref const(QString) name);
    QXmlName initialTemplateName() const;

    void setNetworkAccessManager(QNetworkAccessManager *newManager);
    QNetworkAccessManager *networkAccessManager() const;

    QueryLanguage queryLanguage() const;
private:
    friend class QXmlName;
    friend class QXmlSerializer;
    friend class QPatternistSDK::TestCase;
    friend class QPatternist::XsdSchemaParser;
    friend class QPatternist::XsdValidatingInstanceReader;
    friend class QPatternist::VariableLoader;
    template<typename TInputType> friend bool setFocusHelper(QXmlQuery *const queryInstance,
                                                             ref const(TInputType) focusValue);
    QXmlQueryPrivate *d;
};

QT_END_NAMESPACE

#endif
